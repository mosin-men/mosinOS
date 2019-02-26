.section .text
.global _semaphore_dec
_semaphore_dec:
    li t0, -1
    amoadd.w.rl a0, t0, (a0)
    ret
