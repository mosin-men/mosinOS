add-symbol-file start.elf 0x40400000
target remote | qemu-system-riscv32 -s -nographic -machine sifive_e -kernel start.elf
