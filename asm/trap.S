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
  csrr a0, mcause
  csrr a1, mepc
  csrr a2, mtval
  call handle_trap
  csrw mepc, a0

# restore t6 register 
#restore other registers
  la t6, GLOBAL_CTX
  .set i, 0
  .rept 32
    lv %i
    .set i, i+1
  .endr

  mret

.align 4
.global _UMODE_SWITCH
_UMODE_SWITCH:
  li t5, 0x1800
  csrrc zero, mstatus, t5
  ret

.align 4
.global _MMODE_SWITCH
_MMODE_SWITCH:
  li t5, 0x1800
  csrrs zero, mstatus, t5
  ret
