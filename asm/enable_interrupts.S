.section .text
.global _enable_interrupts
_enable_interrupts:
    li t0, 0x80
    csrs mie, t0
    li t0, 8
    csrs mstatus, t0
    ret
