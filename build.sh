#!/bin/bash

# Compile the static Rust library
xargo build --target=riscv32imac-unknown-none-elf

# Assemble our boot code
riscv64-unknown-linux-gnu-as -march=rv32imac -mabi=ilp32 asm/start.S -o start.o

# Link
riscv64-unknown-linux-gnu-ld -melf32lriscv_ilp32 -T start.lds -o start.elf start.o target/riscv32imac-unknown-none-elf/debug/libmosin_os.a
