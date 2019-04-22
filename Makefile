NAME=mosin_os
QEMU=qemu-system-riscv32
CROSS=riscv64-unknown-linux-gnu
CC=$(CROSS)-gcc
CXX=$(CROSS)-g++
AS=$(CROSS)-as
GDB=$(CROSS)-gdb

LDSFILE=lds/qemu.lds
LDS_E31_FILE=lds/q_e31.lds
ASFLAGS=-march=rv32ima -mabi=ilp32 -O0 -g
LDFLAGS=-march=rv32ima -mabi=ilp32 -O0 -g -nostartfiles -nostdinc -ffreestanding -nostdlib -L.
OUT=$(NAME).elf
E31_OUT=$(NAME)_e31.elf

QEMUARGS=-machine sifive_e -nographic -serial mon:stdio -kernel $(OUT)

ASM_SOURCES=$(wildcard asm/*.S)
ASM_OBJECTS=$(patsubst %.S,%.o,$(ASM_SOURCES))

BJOU_OBJECT=build/$(NAME).o
BJOU_E31_OBJECT=build/$(NAME)_e31.o

LIBS=-lgcc

all: q e31

q: $(OUT)

e31: $(E31_OUT)

$(OUT): Makefile $(ASM_OBJECTS) $(BJOU_OBJECT) $(LDSFILE)
	$(CC) -T$(LDSFILE) $(LDFLAGS) -o $(OUT) $(ASM_OBJECTS) $(BJOU_OBJECT) $(LIBS)

$(E31_OUT): Makefile $(ASM_OBJECTS) $(BJOU_E31_OBJECT) $(LDS_E31_FILE)
	$(CC) -T$(LDS_E31_FILE) $(LDFLAGS) -o $(E31_OUT) $(ASM_OBJECTS) $(BJOU_E31_OBJECT) $(LIBS)

%.o: %.S Makefile
	$(CC) $(ASFLAGS) -c $< -o $@

$(BJOU_OBJECT):
	bjou make.bjou

$(BJOU_E31_OBJECT):
	bjou make_e31.bjou

qemu: $(OUT)
	$(QEMU) $(QEMUARGS)

qdb: $(OUT)
	$(QEMU) $(QEMUARGS) -S -s&

gdb: $(OUT)
	#$(QEMU) $(QEMUARGS) -S -s &
	$(GDB) $(OUT) -ex "target remote localhost:1234"

.PHONY: clean

clean: 
	rm -rf build
	rm -fr $(OUT) $(E31_OUT) $(ASM_OBJECTS)
