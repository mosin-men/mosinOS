.option norvc
.section .bss
.global GLOBAL_CTX
.lcomm GLOBAL_CTX, 128


.altmacro
.macro sv z, target=t6
  sw x\z, ((\z)*4)(\target)
.endm

.macro lv z, target=t6
  lw x\z, ((\z)*4)(\target)
.endm


.section .text
.align 4
.global _trap_handler
_trap_handler:
#save t6 to mscratch
  csrw mscratch, t6
#set t6 to global context
  la t6, GLOBAL_CTX

#store all registers 0-30
  .set i, 0
  .rept 31
    sv %i
    .set i, i+1
  .endr

#store t6 register
  la t5, GLOBAL_CTX
  csrr t6, mscratch
  sv 31, t5
#jump to trap_handler in rust
  call trap_handler

# restore t6 register 
# and save to mscratch
  la t5, GLOBAL_CTX
  lv 31, t5
  csrw mscratch, t6

#restore other registers
  la t6, GLOBAL_CTX
  .set i, 0
  .rept 31
    lv %i
    .set i, i+1
  .endr

#restore t6 from mscratch
  csrr t6, mscratch

#DO RETURN STUFF HERE
