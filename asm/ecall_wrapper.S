.section .text
.global ecall_wrapper
ecall_wrapper:
    ecall
    ret
