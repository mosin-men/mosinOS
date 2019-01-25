#!/bin/bash

qemu-system-riscv32 -nographic -machine sifive_e -kernel start.elf
