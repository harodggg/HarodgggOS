DIR = .
NASM = nasm
DD = dd
RM = rm 

BOCH = bochs 
BOCHSRC = ./bochsrc
NBIN = ndisasm
BIN_FILE = ./boot.bin



IMG = a.img

all: build run 

build:
	@echo "开始构建img"
	$(NASM)  $(DIR)/boot.asm -o $(DIR)/boot.bin
	$(DD) if=/dev/zero of=$(IMG) seek=1 bs=512 count=2879
	$(DD) if=boot.bin of=$(IMG)
	cat boot.bin ./kernel/kernel.bin > $(IMG)


	
build_kernel:
	@echo "在镜像里加入内核"
	cat boot.bin ./kernel/kernel.bin > $(IMG)

# Build the kernel binary
kernel.bin: kernel_entry.o kernel.o
	ld -m elf_i386 -no-PIE -o ./kernel/kernel.bin -Ttext 0x1000 ./kernel_entry.o ./kernel/kernel.o   --oformat binary

# Build the kernel object file 
kernel.o: ./kernel/kernel.c
	gcc -m32  -fno-PIC -ffreestanding -c ./kernel/kernel.c -o ./kernel/kernel.o

# Build the kernel entry object file.
kernel_entry.o:	kernel_entry.asm 
	nasm kernel_entry.asm -f elf  -o kernel_entry.o
	

run: 
	@echo "bochs运行img镜像"
	$(BOCH) -q -f $(BOCHSRC)

clean:
	$(RM) $(IMG)
	`
nbin:
	$(NBIN) -o 0x7c00 $(BIN_FILE)

build_kernel_entry:
	nasm kernel_entry.asm -f elf  -o kernel_entry.o
ld:
	ld -m elf_i386 -o ./kernel/kernel.bin -Ttext 0x1000 ./kernel_entry.o ./kernel/kernel.o   --oformat binary






