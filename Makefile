NAME=mosin_os
QEMU=qemu-system-riscv32
CROSS=riscv64-unknown-linux-gnu
CC=$(CROSS)-gcc
CXX=$(CROSS)-g++
AS=$(CROSS)-as
GDB=$(CROSS)-gdb

LDSFILE=lds/qemu.lds
ASFLAGS=-march=rv32ima -mabi=ilp32 -O0 -g
LDFLAGS=-T$(LDSFILE) -march=rv32ima -mabi=ilp32 -O0 -g -nostartfiles -nostdinc -ffreestanding -nostdlib -L.
OUT=$(NAME).elf

QEMUARGS=-machine sifive_e -nographic -serial mon:stdio -kernel $(OUT)

ASM_SOURCES=$(wildcard asm/*.S)
ASM_OBJECTS=$(patsubst %.S,%.o,$(ASM_SOURCES))

BJOU_OBJECT=build/$(NAME).o

LIBS=-lgcc

all: $(OUT)

$(OUT): Makefile $(ASM_OBJECTS) $(BJOU_OBJECT) $(LDSFILE)
	$(CC) $(LDFLAGS) -o $(OUT) $(ASM_OBJECTS) $(BJOU_OBJECT) $(LIBS)

%.o: %.S Makefile
	$(CC) $(ASFLAGS) -c $< -o $@

$(BJOU_OBJECT):
	./bjou make.bjou

qemu: $(OUT)
	$(QEMU) $(QEMUARGS)

gdb: $(OUT)
	#$(QEMU) $(QEMUARGS) -S -s &
	$(GDB) $(OUT) -ex "target remote localhost:1234"

.PHONY: clean

clean: 
	rm -rf build
	rm -fr $(OUT) $(ASM_OBJECTS)
