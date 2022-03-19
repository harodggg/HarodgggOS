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
	
run: 
	@echo "bochs运行img镜像"
	$(BOCH) -q -f $(BOCHSRC)

clean:
	$(RM) $(IMG)
	`
nbin:
	$(NBIN) -o 0x7c00 $(BIN_FILE)







