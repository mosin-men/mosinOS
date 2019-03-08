.section .text
.global _mmode_switch
_mmode_switch:
  li t5, 0x1800
  csrrs zero, mstatus, t5
  ret
