.section .text
.global _semaphore_inc
_semaphore_inc:
    li t0, 1
    amoadd.w.aqrl a0, t0, (a0)
    ret
