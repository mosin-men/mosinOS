.option norvc
.section .text.init
.global _start
_start:
	# Clear interrupts
	li 	t1, 0xb
	csrrc	zero, mstatus, t1
	# Now, check to see what CPU is running. We check
	# the mhartid (machine hardware thread ID)
	csrr	t0, mhartid
	# We are going to use CPU 0, everything else will go
	# into a sleep loop
	bnez	t0, park

	# Just CPU 0 gets to this point
	la	gp, __global_pointer_mine$
	la	sp, _sp

	# Copy data section from the flash memory into RAM.
	la	a0, _data_lma
	la	a1, _data
	la	a2, _edata
	bgeu	a1, a2, 2f
1:
	lw	t0, 0(a0)
	sw	t0, 0(a1)
	addi	a0, a0, 4
	addi	a1, a1, 4
	bltu	a1, a2, 1b

2:
	# Clear the BSS. The BSS section must be all 0s.
	# Otherwise global uninitialized or set to 0.
	# will not get a proper value.
	la	a0, __bss_start
	la	a1, __bss_end
	bgeu	a0, a1, 2f
1:
	sw	zero, (a0)
	addi	a0, a0, 4
	bltu	a0, a1, 1b
2:
	auipc 	ra, 0
	addi	sp, sp, -16
	sw	ra, 8(sp)
	li	a0, 0
	li	a1, 0

  #set the mvec to the trap handler
  la t0, _trap_handler
  csrw mtvec, t0

	# Go into machine mode
	# Put mepc into main and return to jump to it.
	# This sets MPP to 3 (machine mode).
	li	t5, 0x1800
	csrrs	zero, mstatus, t5
	# Main is written in Rust (lib.rs).
	la	t1, main
	csrrw	zero, mepc, t1
	mret

park:
	# All HARTs that are != 0 will go here and
	# spin in a wait loop.
	wfi # Wait for Interrupt
	j	park

#.macro	save_register reg:req
