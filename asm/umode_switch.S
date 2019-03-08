.section .text
.global _umode_switch
_umode_switch:
  li t5, 0x1800
  csrrc zero, mstatus, t5
  ret
