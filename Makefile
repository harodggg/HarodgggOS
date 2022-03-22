# Automatically expand to a list of existing files that 
# match the patterns 

C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# TODO: Make sources dep on allheader files.


# Create a list of object filesto build, simple by replacing 
# the '.c' extension of filenames in C_SOURCES with '.o'
OBJ = ${C_SOURCES:.c=.o}

IMG = HarodgggOS.img
DD = dd

# Link kernel object files into one binary, making sure the 
# entry code is right at the start of the binary .
create_img:
	$(DD) if=/dev/zero of=$(IMG) seek=1 bs=512 count=2879


# Generic rule for building 'somefile.o' from 'somefile.c'
%.o : %.c ${HEADERS}
	gcc -m32  -fno-PIC -ffreestanding -c $< -o $@

# Defaul build target 
all: HarodgggOS.img 

# Run bochs to simulate booting of our code . 
run: all 
	bochs -f bochsrc
		
	
# This builds the binary of our kernel from two object files:
# - the kernel_entry, which jumps to main() in our kernel
# - the compiled C kernel
kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

# This is the actual disk image that the computer loads 
# which is the combination of our compiled bootsector and kernel
HarodgggOS.img: boot/boot_sect.bin kernel.bin
	cat $^ > os-image


# Assemble the kernel_entry .
%.o : %.asm
	nasm $< -f elf  -o $@ 

%.bin : %.asm 
	nasm $< -f bin -I 'boot/' -o $@
	

