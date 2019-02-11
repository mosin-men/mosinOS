
mosin_os.elf:     file format elf32-littleriscv


Disassembly of section .text:

20400000 <_start>:
20400000:	00b00313          	li	t1,11
20400004:	30033073          	csrc	mstatus,t1
20400008:	f14022f3          	csrr	t0,mhartid
2040000c:	08029663          	bnez	t0,20400098 <park>
20400010:	00018193          	mv	gp,gp
20400014:	5fc04117          	auipc	sp,0x5fc04
20400018:	fec10113          	addi	sp,sp,-20 # 80004000 <_sp>
2040001c:	00002517          	auipc	a0,0x2
20400020:	aa050513          	addi	a0,a0,-1376 # 20401abc <_data_lma>
20400024:	5fc00597          	auipc	a1,0x5fc00
20400028:	fdc58593          	addi	a1,a1,-36 # 80000000 <_data>
2040002c:	5fc00617          	auipc	a2,0x5fc00
20400030:	fdc60613          	addi	a2,a2,-36 # 80000008 <__bss_start>
20400034:	00c5fc63          	bgeu	a1,a2,2040004c <_start+0x4c>
20400038:	00052283          	lw	t0,0(a0)
2040003c:	0055a023          	sw	t0,0(a1)
20400040:	00450513          	addi	a0,a0,4
20400044:	00458593          	addi	a1,a1,4
20400048:	fec5e8e3          	bltu	a1,a2,20400038 <_start+0x38>
2040004c:	5fc00517          	auipc	a0,0x5fc00
20400050:	fbc50513          	addi	a0,a0,-68 # 80000008 <__bss_start>
20400054:	80818593          	addi	a1,gp,-2040 # 80000010 <__bss_end>
20400058:	00b57863          	bgeu	a0,a1,20400068 <_start+0x68>
2040005c:	00052023          	sw	zero,0(a0)
20400060:	00450513          	addi	a0,a0,4
20400064:	feb56ce3          	bltu	a0,a1,2040005c <_start+0x5c>
20400068:	00000097          	auipc	ra,0x0
2040006c:	ff010113          	addi	sp,sp,-16
20400070:	00112423          	sw	ra,8(sp)
20400074:	00000513          	li	a0,0
20400078:	00000593          	li	a1,0
2040007c:	00002f37          	lui	t5,0x2
20400080:	800f0f13          	addi	t5,t5,-2048 # 1800 <__stack_size+0x1000>
20400084:	300f2073          	csrs	mstatus,t5
20400088:	00001317          	auipc	t1,0x1
2040008c:	70430313          	addi	t1,t1,1796 # 2040178c <main>
20400090:	34131073          	csrw	mepc,t1
20400094:	30200073          	mret

20400098 <park>:
20400098:	10500073          	wfi
2040009c:	ffdff06f          	j	20400098 <park>

204000a0 <mcopy_FZTR4MQEMZNB6>:
204000a0:	fb010113          	addi	sp,sp,-80
204000a4:	04112623          	sw	ra,76(sp)
204000a8:	04812423          	sw	s0,72(sp)
204000ac:	05010413          	addi	s0,sp,80
204000b0:	fcd42623          	sw	a3,-52(s0)
204000b4:	fcc42423          	sw	a2,-56(s0)
204000b8:	fcb42223          	sw	a1,-60(s0)
204000bc:	fca42023          	sw	a0,-64(s0)
204000c0:	0040006f          	j	204000c4 <mcopy_FZTR4MQEMZNB6+0x24>
204000c4:	00000513          	li	a0,0
204000c8:	fea42223          	sw	a0,-28(s0)
204000cc:	fea42023          	sw	a0,-32(s0)
204000d0:	fc842503          	lw	a0,-56(s0)
204000d4:	fea42423          	sw	a0,-24(s0)
204000d8:	fc042583          	lw	a1,-64(s0)
204000dc:	feb42a23          	sw	a1,-12(s0)
204000e0:	fcb42e23          	sw	a1,-36(s0)
204000e4:	fc442603          	lw	a2,-60(s0)
204000e8:	fec42823          	sw	a2,-16(s0)
204000ec:	fcc42c23          	sw	a2,-40(s0)
204000f0:	fcc42683          	lw	a3,-52(s0)
204000f4:	fed42623          	sw	a3,-20(s0)
204000f8:	0040006f          	j	204000fc <mcopy_FZTR4MQEMZNB6+0x5c>
204000fc:	fe442503          	lw	a0,-28(s0)
20400100:	fec42583          	lw	a1,-20(s0)
20400104:	40a58533          	sub	a0,a1,a0
20400108:	fe042583          	lw	a1,-32(s0)
2040010c:	fe842603          	lw	a2,-24(s0)
20400110:	00b636b3          	sltu	a3,a2,a1
20400114:	40d50533          	sub	a0,a0,a3
20400118:	40b605b3          	sub	a1,a2,a1
2040011c:	00800613          	li	a2,8
20400120:	00b635b3          	sltu	a1,a2,a1
20400124:	00000613          	li	a2,0
20400128:	00a036b3          	snez	a3,a0
2040012c:	fad42e23          	sw	a3,-68(s0)
20400130:	fab42c23          	sw	a1,-72(s0)
20400134:	00c50663          	beq	a0,a2,20400140 <mcopy_FZTR4MQEMZNB6+0xa0>
20400138:	fbc42503          	lw	a0,-68(s0)
2040013c:	faa42c23          	sw	a0,-72(s0)
20400140:	fb842503          	lw	a0,-72(s0)
20400144:	00100593          	li	a1,1
20400148:	04b51c63          	bne	a0,a1,204001a0 <mcopy_FZTR4MQEMZNB6+0x100>
2040014c:	0040006f          	j	20400150 <mcopy_FZTR4MQEMZNB6+0xb0>
20400150:	fd842503          	lw	a0,-40(s0)
20400154:	00052583          	lw	a1,0(a0)
20400158:	00452503          	lw	a0,4(a0)
2040015c:	fdc42603          	lw	a2,-36(s0)
20400160:	00a62223          	sw	a0,4(a2)
20400164:	00b62023          	sw	a1,0(a2)
20400168:	fdc42503          	lw	a0,-36(s0)
2040016c:	00850513          	addi	a0,a0,8
20400170:	fca42e23          	sw	a0,-36(s0)
20400174:	fd842503          	lw	a0,-40(s0)
20400178:	00850513          	addi	a0,a0,8
2040017c:	fca42c23          	sw	a0,-40(s0)
20400180:	fe042503          	lw	a0,-32(s0)
20400184:	00850593          	addi	a1,a0,8
20400188:	feb42023          	sw	a1,-32(s0)
2040018c:	00a5b533          	sltu	a0,a1,a0
20400190:	fe442583          	lw	a1,-28(s0)
20400194:	00a58533          	add	a0,a1,a0
20400198:	fea42223          	sw	a0,-28(s0)
2040019c:	f61ff06f          	j	204000fc <mcopy_FZTR4MQEMZNB6+0x5c>
204001a0:	fdc42503          	lw	a0,-36(s0)
204001a4:	fca42a23          	sw	a0,-44(s0)
204001a8:	fd842503          	lw	a0,-40(s0)
204001ac:	fca42823          	sw	a0,-48(s0)
204001b0:	0040006f          	j	204001b4 <mcopy_FZTR4MQEMZNB6+0x114>
204001b4:	fe842503          	lw	a0,-24(s0)
204001b8:	fe042583          	lw	a1,-32(s0)
204001bc:	00a5b533          	sltu	a0,a1,a0
204001c0:	fec42583          	lw	a1,-20(s0)
204001c4:	fe442603          	lw	a2,-28(s0)
204001c8:	00b636b3          	sltu	a3,a2,a1
204001cc:	fad42a23          	sw	a3,-76(s0)
204001d0:	faa42823          	sw	a0,-80(s0)
204001d4:	00b60663          	beq	a2,a1,204001e0 <mcopy_FZTR4MQEMZNB6+0x140>
204001d8:	fb442503          	lw	a0,-76(s0)
204001dc:	faa42823          	sw	a0,-80(s0)
204001e0:	fb042503          	lw	a0,-80(s0)
204001e4:	00100593          	li	a1,1
204001e8:	04b51a63          	bne	a0,a1,2040023c <mcopy_FZTR4MQEMZNB6+0x19c>
204001ec:	0040006f          	j	204001f0 <mcopy_FZTR4MQEMZNB6+0x150>
204001f0:	fd042503          	lw	a0,-48(s0)
204001f4:	00050503          	lb	a0,0(a0)
204001f8:	fd442583          	lw	a1,-44(s0)
204001fc:	00a58023          	sb	a0,0(a1)
20400200:	fd442503          	lw	a0,-44(s0)
20400204:	00150513          	addi	a0,a0,1
20400208:	fca42a23          	sw	a0,-44(s0)
2040020c:	fd042503          	lw	a0,-48(s0)
20400210:	00150513          	addi	a0,a0,1
20400214:	fca42823          	sw	a0,-48(s0)
20400218:	0040006f          	j	2040021c <mcopy_FZTR4MQEMZNB6+0x17c>
2040021c:	fe042503          	lw	a0,-32(s0)
20400220:	00150593          	addi	a1,a0,1
20400224:	feb42023          	sw	a1,-32(s0)
20400228:	00a5b533          	sltu	a0,a1,a0
2040022c:	fe442583          	lw	a1,-28(s0)
20400230:	00a58533          	add	a0,a1,a0
20400234:	fea42223          	sw	a0,-28(s0)
20400238:	f7dff06f          	j	204001b4 <mcopy_FZTR4MQEMZNB6+0x114>
2040023c:	ff442503          	lw	a0,-12(s0)
20400240:	04812403          	lw	s0,72(sp)
20400244:	04c12083          	lw	ra,76(sp)
20400248:	05010113          	addi	sp,sp,80
2040024c:	00008067          	ret

20400250 <mset_DDVWFSR6I7FQK>:
20400250:	f9010113          	addi	sp,sp,-112
20400254:	06112623          	sw	ra,108(sp)
20400258:	06812423          	sw	s0,104(sp)
2040025c:	07010413          	addi	s0,sp,112
20400260:	fd440713          	addi	a4,s0,-44
20400264:	fce42823          	sw	a4,-48(s0)
20400268:	fcd42023          	sw	a3,-64(s0)
2040026c:	fac42e23          	sw	a2,-68(s0)
20400270:	fab42c23          	sw	a1,-72(s0)
20400274:	faa42a23          	sw	a0,-76(s0)
20400278:	0040006f          	j	2040027c <mset_DDVWFSR6I7FQK+0x2c>
2040027c:	fbc42503          	lw	a0,-68(s0)
20400280:	fea42423          	sw	a0,-24(s0)
20400284:	fb842583          	lw	a1,-72(s0)
20400288:	feb409a3          	sb	a1,-13(s0)
2040028c:	fb442603          	lw	a2,-76(s0)
20400290:	fec42a23          	sw	a2,-12(s0)
20400294:	fcc42e23          	sw	a2,-36(s0)
20400298:	fd040693          	addi	a3,s0,-48
2040029c:	fcd42623          	sw	a3,-52(s0)
204002a0:	00000693          	li	a3,0
204002a4:	fed42223          	sw	a3,-28(s0)
204002a8:	fed42023          	sw	a3,-32(s0)
204002ac:	fcd42423          	sw	a3,-56(s0)
204002b0:	fc042683          	lw	a3,-64(s0)
204002b4:	fed42623          	sw	a3,-20(s0)
204002b8:	0040006f          	j	204002bc <mset_DDVWFSR6I7FQK+0x6c>
204002bc:	fc842503          	lw	a0,-56(s0)
204002c0:	00853593          	sltiu	a1,a0,8
204002c4:	41f55513          	srai	a0,a0,0x1f
204002c8:	00000613          	li	a2,0
204002cc:	00052693          	slti	a3,a0,0
204002d0:	fad42823          	sw	a3,-80(s0)
204002d4:	fab42623          	sw	a1,-84(s0)
204002d8:	00c50663          	beq	a0,a2,204002e4 <mset_DDVWFSR6I7FQK+0x94>
204002dc:	fb042503          	lw	a0,-80(s0)
204002e0:	faa42623          	sw	a0,-84(s0)
204002e4:	fac42503          	lw	a0,-84(s0)
204002e8:	00100593          	li	a1,1
204002ec:	02b51863          	bne	a0,a1,2040031c <mset_DDVWFSR6I7FQK+0xcc>
204002f0:	0040006f          	j	204002f4 <mset_DDVWFSR6I7FQK+0xa4>
204002f4:	fc842503          	lw	a0,-56(s0)
204002f8:	fd042583          	lw	a1,-48(s0)
204002fc:	00a58533          	add	a0,a1,a0
20400300:	ff340583          	lb	a1,-13(s0)
20400304:	00b50023          	sb	a1,0(a0)
20400308:	0040006f          	j	2040030c <mset_DDVWFSR6I7FQK+0xbc>
2040030c:	fc842503          	lw	a0,-56(s0)
20400310:	00150513          	addi	a0,a0,1
20400314:	fca42423          	sw	a0,-56(s0)
20400318:	fa5ff06f          	j	204002bc <mset_DDVWFSR6I7FQK+0x6c>
2040031c:	0040006f          	j	20400320 <mset_DDVWFSR6I7FQK+0xd0>
20400320:	fe442503          	lw	a0,-28(s0)
20400324:	fec42583          	lw	a1,-20(s0)
20400328:	40a58533          	sub	a0,a1,a0
2040032c:	fe042583          	lw	a1,-32(s0)
20400330:	fe842603          	lw	a2,-24(s0)
20400334:	00b636b3          	sltu	a3,a2,a1
20400338:	40d50533          	sub	a0,a0,a3
2040033c:	40b605b3          	sub	a1,a2,a1
20400340:	00800613          	li	a2,8
20400344:	00b635b3          	sltu	a1,a2,a1
20400348:	00000613          	li	a2,0
2040034c:	00a036b3          	snez	a3,a0
20400350:	fad42423          	sw	a3,-88(s0)
20400354:	fab42223          	sw	a1,-92(s0)
20400358:	00c50663          	beq	a0,a2,20400364 <mset_DDVWFSR6I7FQK+0x114>
2040035c:	fa842503          	lw	a0,-88(s0)
20400360:	faa42223          	sw	a0,-92(s0)
20400364:	fa442503          	lw	a0,-92(s0)
20400368:	00100593          	li	a1,1
2040036c:	04b51663          	bne	a0,a1,204003b8 <mset_DDVWFSR6I7FQK+0x168>
20400370:	0040006f          	j	20400374 <mset_DDVWFSR6I7FQK+0x124>
20400374:	fcc42503          	lw	a0,-52(s0)
20400378:	00052583          	lw	a1,0(a0)
2040037c:	00452503          	lw	a0,4(a0)
20400380:	fdc42603          	lw	a2,-36(s0)
20400384:	00a62223          	sw	a0,4(a2)
20400388:	00b62023          	sw	a1,0(a2)
2040038c:	fdc42503          	lw	a0,-36(s0)
20400390:	00850513          	addi	a0,a0,8
20400394:	fca42e23          	sw	a0,-36(s0)
20400398:	fe042503          	lw	a0,-32(s0)
2040039c:	00850593          	addi	a1,a0,8
204003a0:	feb42023          	sw	a1,-32(s0)
204003a4:	00a5b533          	sltu	a0,a1,a0
204003a8:	fe442583          	lw	a1,-28(s0)
204003ac:	00a58533          	add	a0,a1,a0
204003b0:	fea42223          	sw	a0,-28(s0)
204003b4:	f6dff06f          	j	20400320 <mset_DDVWFSR6I7FQK+0xd0>
204003b8:	fdc42503          	lw	a0,-36(s0)
204003bc:	fca42223          	sw	a0,-60(s0)
204003c0:	0040006f          	j	204003c4 <mset_DDVWFSR6I7FQK+0x174>
204003c4:	fe842503          	lw	a0,-24(s0)
204003c8:	fe042583          	lw	a1,-32(s0)
204003cc:	00a5b533          	sltu	a0,a1,a0
204003d0:	fec42583          	lw	a1,-20(s0)
204003d4:	fe442603          	lw	a2,-28(s0)
204003d8:	00b636b3          	sltu	a3,a2,a1
204003dc:	fad42023          	sw	a3,-96(s0)
204003e0:	f8a42e23          	sw	a0,-100(s0)
204003e4:	00b60663          	beq	a2,a1,204003f0 <mset_DDVWFSR6I7FQK+0x1a0>
204003e8:	fa042503          	lw	a0,-96(s0)
204003ec:	f8a42e23          	sw	a0,-100(s0)
204003f0:	f9c42503          	lw	a0,-100(s0)
204003f4:	00100593          	li	a1,1
204003f8:	04b51263          	bne	a0,a1,2040043c <mset_DDVWFSR6I7FQK+0x1ec>
204003fc:	0040006f          	j	20400400 <mset_DDVWFSR6I7FQK+0x1b0>
20400400:	ff340503          	lb	a0,-13(s0)
20400404:	fc442583          	lw	a1,-60(s0)
20400408:	00a58023          	sb	a0,0(a1)
2040040c:	fc442503          	lw	a0,-60(s0)
20400410:	00150513          	addi	a0,a0,1
20400414:	fca42223          	sw	a0,-60(s0)
20400418:	0040006f          	j	2040041c <mset_DDVWFSR6I7FQK+0x1cc>
2040041c:	fe042503          	lw	a0,-32(s0)
20400420:	00150593          	addi	a1,a0,1
20400424:	feb42023          	sw	a1,-32(s0)
20400428:	00a5b533          	sltu	a0,a1,a0
2040042c:	fe442583          	lw	a1,-28(s0)
20400430:	00a58533          	add	a0,a1,a0
20400434:	fea42223          	sw	a0,-28(s0)
20400438:	f8dff06f          	j	204003c4 <mset_DDVWFSR6I7FQK+0x174>
2040043c:	ff442503          	lw	a0,-12(s0)
20400440:	06812403          	lw	s0,104(sp)
20400444:	06c12083          	lw	ra,108(sp)
20400448:	07010113          	addi	sp,sp,112
2040044c:	00008067          	ret

20400450 <memcpy>:
20400450:	fd010113          	addi	sp,sp,-48
20400454:	02112623          	sw	ra,44(sp)
20400458:	02812423          	sw	s0,40(sp)
2040045c:	03010413          	addi	s0,sp,48
20400460:	fed42223          	sw	a3,-28(s0)
20400464:	fec42023          	sw	a2,-32(s0)
20400468:	fcb42e23          	sw	a1,-36(s0)
2040046c:	fca42c23          	sw	a0,-40(s0)
20400470:	0040006f          	j	20400474 <memcpy+0x24>
20400474:	fe042503          	lw	a0,-32(s0)
20400478:	fea42423          	sw	a0,-24(s0)
2040047c:	fdc42583          	lw	a1,-36(s0)
20400480:	feb42823          	sw	a1,-16(s0)
20400484:	fd842603          	lw	a2,-40(s0)
20400488:	fec42a23          	sw	a2,-12(s0)
2040048c:	fe442683          	lw	a3,-28(s0)
20400490:	fed42623          	sw	a3,-20(s0)
20400494:	00060513          	mv	a0,a2
20400498:	fe042603          	lw	a2,-32(s0)
2040049c:	00000097          	auipc	ra,0x0
204004a0:	c04080e7          	jalr	-1020(ra) # 204000a0 <mcopy_FZTR4MQEMZNB6>
204004a4:	02812403          	lw	s0,40(sp)
204004a8:	02c12083          	lw	ra,44(sp)
204004ac:	03010113          	addi	sp,sp,48
204004b0:	00008067          	ret

204004b4 <memset>:
204004b4:	fd010113          	addi	sp,sp,-48
204004b8:	02112623          	sw	ra,44(sp)
204004bc:	02812423          	sw	s0,40(sp)
204004c0:	03010413          	addi	s0,sp,48
204004c4:	fed42223          	sw	a3,-28(s0)
204004c8:	fec42023          	sw	a2,-32(s0)
204004cc:	fcb42e23          	sw	a1,-36(s0)
204004d0:	fca42c23          	sw	a0,-40(s0)
204004d4:	0040006f          	j	204004d8 <memset+0x24>
204004d8:	fe042503          	lw	a0,-32(s0)
204004dc:	fea42423          	sw	a0,-24(s0)
204004e0:	fdc42583          	lw	a1,-36(s0)
204004e4:	feb409a3          	sb	a1,-13(s0)
204004e8:	fd842603          	lw	a2,-40(s0)
204004ec:	fec42a23          	sw	a2,-12(s0)
204004f0:	fe442683          	lw	a3,-28(s0)
204004f4:	fed42623          	sw	a3,-20(s0)
204004f8:	00060513          	mv	a0,a2
204004fc:	fe042603          	lw	a2,-32(s0)
20400500:	00000097          	auipc	ra,0x0
20400504:	d50080e7          	jalr	-688(ra) # 20400250 <mset_DDVWFSR6I7FQK>
20400508:	02812403          	lw	s0,40(sp)
2040050c:	02c12083          	lw	ra,44(sp)
20400510:	03010113          	addi	sp,sp,48
20400514:	00008067          	ret

20400518 <i32mul>:
20400518:	fe010113          	addi	sp,sp,-32
2040051c:	00112e23          	sw	ra,28(sp)
20400520:	00812c23          	sw	s0,24(sp)
20400524:	02010413          	addi	s0,sp,32
20400528:	feb42223          	sw	a1,-28(s0)
2040052c:	fea42023          	sw	a0,-32(s0)
20400530:	0040006f          	j	20400534 <i32mul+0x1c>
20400534:	fe442503          	lw	a0,-28(s0)
20400538:	fea42823          	sw	a0,-16(s0)
2040053c:	fe042583          	lw	a1,-32(s0)
20400540:	feb42a23          	sw	a1,-12(s0)
20400544:	00000613          	li	a2,0
20400548:	fec42623          	sw	a2,-20(s0)
2040054c:	fec42423          	sw	a2,-24(s0)
20400550:	0040006f          	j	20400554 <i32mul+0x3c>
20400554:	ff042503          	lw	a0,-16(s0)
20400558:	fe842583          	lw	a1,-24(s0)
2040055c:	02a5d663          	bge	a1,a0,20400588 <i32mul+0x70>
20400560:	0040006f          	j	20400564 <i32mul+0x4c>
20400564:	ff442503          	lw	a0,-12(s0)
20400568:	fec42583          	lw	a1,-20(s0)
2040056c:	00a58533          	add	a0,a1,a0
20400570:	fea42623          	sw	a0,-20(s0)
20400574:	0040006f          	j	20400578 <i32mul+0x60>
20400578:	fe842503          	lw	a0,-24(s0)
2040057c:	00150513          	addi	a0,a0,1
20400580:	fea42423          	sw	a0,-24(s0)
20400584:	fd1ff06f          	j	20400554 <i32mul+0x3c>
20400588:	fec42503          	lw	a0,-20(s0)
2040058c:	01812403          	lw	s0,24(sp)
20400590:	01c12083          	lw	ra,28(sp)
20400594:	02010113          	addi	sp,sp,32
20400598:	00008067          	ret

2040059c <i32div>:
2040059c:	fe010113          	addi	sp,sp,-32
204005a0:	00112e23          	sw	ra,28(sp)
204005a4:	00812c23          	sw	s0,24(sp)
204005a8:	02010413          	addi	s0,sp,32
204005ac:	feb42423          	sw	a1,-24(s0)
204005b0:	fea42223          	sw	a0,-28(s0)
204005b4:	0040006f          	j	204005b8 <i32div+0x1c>
204005b8:	fe842503          	lw	a0,-24(s0)
204005bc:	fea42823          	sw	a0,-16(s0)
204005c0:	fe442583          	lw	a1,-28(s0)
204005c4:	feb42a23          	sw	a1,-12(s0)
204005c8:	00000613          	li	a2,0
204005cc:	fec42623          	sw	a2,-20(s0)
204005d0:	0040006f          	j	204005d4 <i32div+0x38>
204005d4:	00000513          	li	a0,0
204005d8:	00100593          	li	a1,1
204005dc:	ff442603          	lw	a2,-12(s0)
204005e0:	fea42023          	sw	a0,-32(s0)
204005e4:	02b64663          	blt	a2,a1,20400610 <i32div+0x74>
204005e8:	0040006f          	j	204005ec <i32div+0x50>
204005ec:	00100513          	li	a0,1
204005f0:	ff042583          	lw	a1,-16(s0)
204005f4:	ff442603          	lw	a2,-12(s0)
204005f8:	fea42023          	sw	a0,-32(s0)
204005fc:	00b65a63          	bge	a2,a1,20400610 <i32div+0x74>
20400600:	0040006f          	j	20400604 <i32div+0x68>
20400604:	00000513          	li	a0,0
20400608:	fea42023          	sw	a0,-32(s0)
2040060c:	0040006f          	j	20400610 <i32div+0x74>
20400610:	fe042503          	lw	a0,-32(s0)
20400614:	00000593          	li	a1,0
20400618:	02b50463          	beq	a0,a1,20400640 <i32div+0xa4>
2040061c:	0040006f          	j	20400620 <i32div+0x84>
20400620:	ff042503          	lw	a0,-16(s0)
20400624:	ff442583          	lw	a1,-12(s0)
20400628:	40a58533          	sub	a0,a1,a0
2040062c:	fea42a23          	sw	a0,-12(s0)
20400630:	fec42503          	lw	a0,-20(s0)
20400634:	00150513          	addi	a0,a0,1
20400638:	fea42623          	sw	a0,-20(s0)
2040063c:	f99ff06f          	j	204005d4 <i32div+0x38>
20400640:	fec42503          	lw	a0,-20(s0)
20400644:	01812403          	lw	s0,24(sp)
20400648:	01c12083          	lw	ra,28(sp)
2040064c:	02010113          	addi	sp,sp,32
20400650:	00008067          	ret

20400654 <i32mod>:
20400654:	fe010113          	addi	sp,sp,-32
20400658:	00112e23          	sw	ra,28(sp)
2040065c:	00812c23          	sw	s0,24(sp)
20400660:	02010413          	addi	s0,sp,32
20400664:	feb42623          	sw	a1,-20(s0)
20400668:	fea42423          	sw	a0,-24(s0)
2040066c:	0040006f          	j	20400670 <i32mod+0x1c>
20400670:	fec42503          	lw	a0,-20(s0)
20400674:	fea42823          	sw	a0,-16(s0)
20400678:	fe842583          	lw	a1,-24(s0)
2040067c:	feb42a23          	sw	a1,-12(s0)
20400680:	00058513          	mv	a0,a1
20400684:	fec42583          	lw	a1,-20(s0)
20400688:	00000097          	auipc	ra,0x0
2040068c:	f14080e7          	jalr	-236(ra) # 2040059c <i32div>
20400690:	fec42583          	lw	a1,-20(s0)
20400694:	fea42223          	sw	a0,-28(s0)
20400698:	00058513          	mv	a0,a1
2040069c:	fe442583          	lw	a1,-28(s0)
204006a0:	00000097          	auipc	ra,0x0
204006a4:	e78080e7          	jalr	-392(ra) # 20400518 <i32mul>
204006a8:	fe842583          	lw	a1,-24(s0)
204006ac:	40a58533          	sub	a0,a1,a0
204006b0:	01812403          	lw	s0,24(sp)
204006b4:	01c12083          	lw	ra,28(sp)
204006b8:	02010113          	addi	sp,sp,32
204006bc:	00008067          	ret

204006c0 <configure_DJ3GWJX5RJBZ6>:
204006c0:	fe010113          	addi	sp,sp,-32
204006c4:	00112e23          	sw	ra,28(sp)
204006c8:	00812c23          	sw	s0,24(sp)
204006cc:	02010413          	addi	s0,sp,32
204006d0:	0040006f          	j	204006d4 <configure_DJ3GWJX5RJBZ6+0x14>
204006d4:	80000537          	lui	a0,0x80000
204006d8:	fea42623          	sw	a0,-20(s0)
204006dc:	c0000537          	lui	a0,0xc0000
204006e0:	fea42823          	sw	a0,-16(s0)
204006e4:	10013537          	lui	a0,0x10013
204006e8:	fea42a23          	sw	a0,-12(s0)
204006ec:	23300593          	li	a1,563
204006f0:	00b52c23          	sw	a1,24(a0) # 10013018 <__stack_size+0x10012818>
204006f4:	ff042503          	lw	a0,-16(s0)
204006f8:	ff442583          	lw	a1,-12(s0)
204006fc:	00a5a423          	sw	a0,8(a1)
20400700:	fec42503          	lw	a0,-20(s0)
20400704:	ff442583          	lw	a1,-12(s0)
20400708:	00a5a623          	sw	a0,12(a1)
2040070c:	01812403          	lw	s0,24(sp)
20400710:	01c12083          	lw	ra,28(sp)
20400714:	02010113          	addi	sp,sp,32
20400718:	00008067          	ret

2040071c <read_KK223CQSKU6KE>:
2040071c:	ff010113          	addi	sp,sp,-16
20400720:	00112623          	sw	ra,12(sp)
20400724:	00812423          	sw	s0,8(sp)
20400728:	01010413          	addi	s0,sp,16
2040072c:	0040006f          	j	20400730 <read_KK223CQSKU6KE+0x14>
20400730:	10013537          	lui	a0,0x10013
20400734:	fea42a23          	sw	a0,-12(s0)
20400738:	00452503          	lw	a0,4(a0) # 10013004 <__stack_size+0x10012804>
2040073c:	fea42823          	sw	a0,-16(s0)
20400740:	ff344503          	lbu	a0,-13(s0)
20400744:	08057513          	andi	a0,a0,128
20400748:	00000593          	li	a1,0
2040074c:	00b50e63          	beq	a0,a1,20400768 <read_KK223CQSKU6KE+0x4c>
20400750:	0040006f          	j	20400754 <read_KK223CQSKU6KE+0x38>
20400754:	00000513          	li	a0,0
20400758:	00812403          	lw	s0,8(sp)
2040075c:	00c12083          	lw	ra,12(sp)
20400760:	01010113          	addi	sp,sp,16
20400764:	00008067          	ret
20400768:	ff042503          	lw	a0,-16(s0)
2040076c:	00812403          	lw	s0,8(sp)
20400770:	00c12083          	lw	ra,12(sp)
20400774:	01010113          	addi	sp,sp,16
20400778:	00008067          	ret

2040077c <read_echo_DJOHO5RF3POM2>:
2040077c:	ff010113          	addi	sp,sp,-16
20400780:	00112623          	sw	ra,12(sp)
20400784:	00812423          	sw	s0,8(sp)
20400788:	01010413          	addi	s0,sp,16
2040078c:	0040006f          	j	20400790 <read_echo_DJOHO5RF3POM2+0x14>
20400790:	00000097          	auipc	ra,0x0
20400794:	f8c080e7          	jalr	-116(ra) # 2040071c <read_KK223CQSKU6KE>
20400798:	fea40ba3          	sb	a0,-9(s0)
2040079c:	0ff57513          	andi	a0,a0,255
204007a0:	00d00593          	li	a1,13
204007a4:	00b51c63          	bne	a0,a1,204007bc <read_echo_DJOHO5RF3POM2+0x40>
204007a8:	0040006f          	j	204007ac <read_echo_DJOHO5RF3POM2+0x30>
204007ac:	00a00513          	li	a0,10
204007b0:	00000097          	auipc	ra,0x0
204007b4:	030080e7          	jalr	48(ra) # 204007e0 <write_DJAR2NJT5Z6LT>
204007b8:	0140006f          	j	204007cc <read_echo_DJOHO5RF3POM2+0x50>
204007bc:	ff740503          	lb	a0,-9(s0)
204007c0:	00000097          	auipc	ra,0x0
204007c4:	020080e7          	jalr	32(ra) # 204007e0 <write_DJAR2NJT5Z6LT>
204007c8:	0040006f          	j	204007cc <read_echo_DJOHO5RF3POM2+0x50>
204007cc:	ff740503          	lb	a0,-9(s0)
204007d0:	00812403          	lw	s0,8(sp)
204007d4:	00c12083          	lw	ra,12(sp)
204007d8:	01010113          	addi	sp,sp,16
204007dc:	00008067          	ret

204007e0 <write_DJAR2NJT5Z6LT>:
204007e0:	fe010113          	addi	sp,sp,-32
204007e4:	00112e23          	sw	ra,28(sp)
204007e8:	00812c23          	sw	s0,24(sp)
204007ec:	02010413          	addi	s0,sp,32
204007f0:	fea42423          	sw	a0,-24(s0)
204007f4:	0040006f          	j	204007f8 <write_DJAR2NJT5Z6LT+0x18>
204007f8:	10013537          	lui	a0,0x10013
204007fc:	fea42823          	sw	a0,-16(s0)
20400800:	fe842503          	lw	a0,-24(s0)
20400804:	fea40ba3          	sb	a0,-9(s0)
20400808:	0040006f          	j	2040080c <write_DJAR2NJT5Z6LT+0x2c>
2040080c:	00000513          	li	a0,0
20400810:	02051863          	bnez	a0,20400840 <write_DJAR2NJT5Z6LT+0x60>
20400814:	0040006f          	j	20400818 <write_DJAR2NJT5Z6LT+0x38>
20400818:	ff042503          	lw	a0,-16(s0)
2040081c:	00052503          	lw	a0,0(a0) # 10013000 <__stack_size+0x10012800>
20400820:	fea42623          	sw	a0,-20(s0)
20400824:	fef44503          	lbu	a0,-17(s0)
20400828:	08057513          	andi	a0,a0,128
2040082c:	00000593          	li	a1,0
20400830:	00b51663          	bne	a0,a1,2040083c <write_DJAR2NJT5Z6LT+0x5c>
20400834:	0040006f          	j	20400838 <write_DJAR2NJT5Z6LT+0x58>
20400838:	0080006f          	j	20400840 <write_DJAR2NJT5Z6LT+0x60>
2040083c:	fd1ff06f          	j	2040080c <write_DJAR2NJT5Z6LT+0x2c>
20400840:	ff744503          	lbu	a0,-9(s0)
20400844:	ff042583          	lw	a1,-16(s0)
20400848:	00a5a023          	sw	a0,0(a1)
2040084c:	01812403          	lw	s0,24(sp)
20400850:	01c12083          	lw	ra,28(sp)
20400854:	02010113          	addi	sp,sp,32
20400858:	00008067          	ret

2040085c <write_string_LNEGVSSIZZ6RT>:
2040085c:	ff010113          	addi	sp,sp,-16
20400860:	00112623          	sw	ra,12(sp)
20400864:	00812423          	sw	s0,8(sp)
20400868:	01010413          	addi	s0,sp,16
2040086c:	fea42823          	sw	a0,-16(s0)
20400870:	0040006f          	j	20400874 <write_string_LNEGVSSIZZ6RT+0x18>
20400874:	ff042503          	lw	a0,-16(s0)
20400878:	fea42a23          	sw	a0,-12(s0)
2040087c:	0040006f          	j	20400880 <write_string_LNEGVSSIZZ6RT+0x24>
20400880:	ff442503          	lw	a0,-12(s0)
20400884:	00054503          	lbu	a0,0(a0)
20400888:	00000593          	li	a1,0
2040088c:	02b50463          	beq	a0,a1,204008b4 <write_string_LNEGVSSIZZ6RT+0x58>
20400890:	0040006f          	j	20400894 <write_string_LNEGVSSIZZ6RT+0x38>
20400894:	ff442503          	lw	a0,-12(s0)
20400898:	00050503          	lb	a0,0(a0)
2040089c:	00000097          	auipc	ra,0x0
204008a0:	f44080e7          	jalr	-188(ra) # 204007e0 <write_DJAR2NJT5Z6LT>
204008a4:	ff442503          	lw	a0,-12(s0)
204008a8:	00150513          	addi	a0,a0,1
204008ac:	fea42a23          	sw	a0,-12(s0)
204008b0:	fd1ff06f          	j	20400880 <write_string_LNEGVSSIZZ6RT+0x24>
204008b4:	00812403          	lw	s0,8(sp)
204008b8:	00c12083          	lw	ra,12(sp)
204008bc:	01010113          	addi	sp,sp,16
204008c0:	00008067          	ret

204008c4 <cstrlen_PD4HXS525IJAR>:
204008c4:	fe010113          	addi	sp,sp,-32
204008c8:	00112e23          	sw	ra,28(sp)
204008cc:	00812c23          	sw	s0,24(sp)
204008d0:	02010413          	addi	s0,sp,32
204008d4:	fea42223          	sw	a0,-28(s0)
204008d8:	0040006f          	j	204008dc <cstrlen_PD4HXS525IJAR+0x18>
204008dc:	00000513          	li	a0,0
204008e0:	fea42623          	sw	a0,-20(s0)
204008e4:	fea42423          	sw	a0,-24(s0)
204008e8:	fe442503          	lw	a0,-28(s0)
204008ec:	fea42a23          	sw	a0,-12(s0)
204008f0:	0040006f          	j	204008f4 <cstrlen_PD4HXS525IJAR+0x30>
204008f4:	ff442503          	lw	a0,-12(s0)
204008f8:	00054503          	lbu	a0,0(a0)
204008fc:	00000593          	li	a1,0
20400900:	02b50a63          	beq	a0,a1,20400934 <cstrlen_PD4HXS525IJAR+0x70>
20400904:	0040006f          	j	20400908 <cstrlen_PD4HXS525IJAR+0x44>
20400908:	ff442503          	lw	a0,-12(s0)
2040090c:	00150513          	addi	a0,a0,1
20400910:	fea42a23          	sw	a0,-12(s0)
20400914:	fe842503          	lw	a0,-24(s0)
20400918:	00150593          	addi	a1,a0,1
2040091c:	feb42423          	sw	a1,-24(s0)
20400920:	00a5b533          	sltu	a0,a1,a0
20400924:	fec42583          	lw	a1,-20(s0)
20400928:	00a58533          	add	a0,a1,a0
2040092c:	fea42623          	sw	a0,-20(s0)
20400930:	fc5ff06f          	j	204008f4 <cstrlen_PD4HXS525IJAR+0x30>
20400934:	fe842503          	lw	a0,-24(s0)
20400938:	fec42583          	lw	a1,-20(s0)
2040093c:	01812403          	lw	s0,24(sp)
20400940:	01c12083          	lw	ra,28(sp)
20400944:	02010113          	addi	sp,sp,32
20400948:	00008067          	ret

2040094c <cstrcpy_LBW6EUK6XUGQC>:
2040094c:	fd010113          	addi	sp,sp,-48
20400950:	02112623          	sw	ra,44(sp)
20400954:	02812423          	sw	s0,40(sp)
20400958:	03010413          	addi	s0,sp,48
2040095c:	feb42223          	sw	a1,-28(s0)
20400960:	fea42023          	sw	a0,-32(s0)
20400964:	0040006f          	j	20400968 <cstrcpy_LBW6EUK6XUGQC+0x1c>
20400968:	fe042503          	lw	a0,-32(s0)
2040096c:	fea42a23          	sw	a0,-12(s0)
20400970:	fe442583          	lw	a1,-28(s0)
20400974:	feb42823          	sw	a1,-16(s0)
20400978:	00058513          	mv	a0,a1
2040097c:	00000097          	auipc	ra,0x0
20400980:	f48080e7          	jalr	-184(ra) # 204008c4 <cstrlen_PD4HXS525IJAR>
20400984:	00150613          	addi	a2,a0,1
20400988:	00a63533          	sltu	a0,a2,a0
2040098c:	00a58533          	add	a0,a1,a0
20400990:	fec42423          	sw	a2,-24(s0)
20400994:	fea42623          	sw	a0,-20(s0)
20400998:	ff442583          	lw	a1,-12(s0)
2040099c:	ff042683          	lw	a3,-16(s0)
204009a0:	fca42e23          	sw	a0,-36(s0)
204009a4:	00058513          	mv	a0,a1
204009a8:	00068593          	mv	a1,a3
204009ac:	fdc42683          	lw	a3,-36(s0)
204009b0:	fffff097          	auipc	ra,0xfffff
204009b4:	6f0080e7          	jalr	1776(ra) # 204000a0 <mcopy_FZTR4MQEMZNB6>
204009b8:	ff442583          	lw	a1,-12(s0)
204009bc:	fca42c23          	sw	a0,-40(s0)
204009c0:	00058513          	mv	a0,a1
204009c4:	02812403          	lw	s0,40(sp)
204009c8:	02c12083          	lw	ra,44(sp)
204009cc:	03010113          	addi	sp,sp,48
204009d0:	00008067          	ret

204009d4 <cstrcmp_DWKSER2MYA2XW>:
204009d4:	fe010113          	addi	sp,sp,-32
204009d8:	00112e23          	sw	ra,28(sp)
204009dc:	00812c23          	sw	s0,24(sp)
204009e0:	02010413          	addi	s0,sp,32
204009e4:	feb42623          	sw	a1,-20(s0)
204009e8:	fea42423          	sw	a0,-24(s0)
204009ec:	0040006f          	j	204009f0 <cstrcmp_DWKSER2MYA2XW+0x1c>
204009f0:	fec42503          	lw	a0,-20(s0)
204009f4:	fea42823          	sw	a0,-16(s0)
204009f8:	fe842583          	lw	a1,-24(s0)
204009fc:	feb42a23          	sw	a1,-12(s0)
20400a00:	0040006f          	j	20400a04 <cstrcmp_DWKSER2MYA2XW+0x30>
20400a04:	ff442503          	lw	a0,-12(s0)
20400a08:	00054503          	lbu	a0,0(a0)
20400a0c:	00000593          	li	a1,0
20400a10:	00058613          	mv	a2,a1
20400a14:	fec42223          	sw	a2,-28(s0)
20400a18:	02b50a63          	beq	a0,a1,20400a4c <cstrcmp_DWKSER2MYA2XW+0x78>
20400a1c:	0040006f          	j	20400a20 <cstrcmp_DWKSER2MYA2XW+0x4c>
20400a20:	00100513          	li	a0,1
20400a24:	ff042583          	lw	a1,-16(s0)
20400a28:	0005c583          	lbu	a1,0(a1)
20400a2c:	ff442603          	lw	a2,-12(s0)
20400a30:	00064603          	lbu	a2,0(a2)
20400a34:	fea42223          	sw	a0,-28(s0)
20400a38:	00b60a63          	beq	a2,a1,20400a4c <cstrcmp_DWKSER2MYA2XW+0x78>
20400a3c:	0040006f          	j	20400a40 <cstrcmp_DWKSER2MYA2XW+0x6c>
20400a40:	00000513          	li	a0,0
20400a44:	fea42223          	sw	a0,-28(s0)
20400a48:	0040006f          	j	20400a4c <cstrcmp_DWKSER2MYA2XW+0x78>
20400a4c:	fe442503          	lw	a0,-28(s0)
20400a50:	00000593          	li	a1,0
20400a54:	02b50263          	beq	a0,a1,20400a78 <cstrcmp_DWKSER2MYA2XW+0xa4>
20400a58:	0040006f          	j	20400a5c <cstrcmp_DWKSER2MYA2XW+0x88>
20400a5c:	ff442503          	lw	a0,-12(s0)
20400a60:	00150513          	addi	a0,a0,1
20400a64:	fea42a23          	sw	a0,-12(s0)
20400a68:	ff042503          	lw	a0,-16(s0)
20400a6c:	00150513          	addi	a0,a0,1
20400a70:	fea42823          	sw	a0,-16(s0)
20400a74:	f91ff06f          	j	20400a04 <cstrcmp_DWKSER2MYA2XW+0x30>
20400a78:	ff042503          	lw	a0,-16(s0)
20400a7c:	00050503          	lb	a0,0(a0)
20400a80:	ff442583          	lw	a1,-12(s0)
20400a84:	00058583          	lb	a1,0(a1)
20400a88:	40a58533          	sub	a0,a1,a0
20400a8c:	01851513          	slli	a0,a0,0x18
20400a90:	41855513          	srai	a0,a0,0x18
20400a94:	01812403          	lw	s0,24(sp)
20400a98:	01c12083          	lw	ra,28(sp)
20400a9c:	02010113          	addi	sp,sp,32
20400aa0:	00008067          	ret

20400aa4 <cstrcat_OFU2YEECSOKD6>:
20400aa4:	fe010113          	addi	sp,sp,-32
20400aa8:	00112e23          	sw	ra,28(sp)
20400aac:	00812c23          	sw	s0,24(sp)
20400ab0:	02010413          	addi	s0,sp,32
20400ab4:	feb42423          	sw	a1,-24(s0)
20400ab8:	fea42223          	sw	a0,-28(s0)
20400abc:	0040006f          	j	20400ac0 <cstrcat_OFU2YEECSOKD6+0x1c>
20400ac0:	fe842503          	lw	a0,-24(s0)
20400ac4:	fea42823          	sw	a0,-16(s0)
20400ac8:	fe442583          	lw	a1,-28(s0)
20400acc:	feb42a23          	sw	a1,-12(s0)
20400ad0:	00058513          	mv	a0,a1
20400ad4:	00000097          	auipc	ra,0x0
20400ad8:	df0080e7          	jalr	-528(ra) # 204008c4 <cstrlen_PD4HXS525IJAR>
20400adc:	fe442603          	lw	a2,-28(s0)
20400ae0:	00a60533          	add	a0,a2,a0
20400ae4:	fea42623          	sw	a0,-20(s0)
20400ae8:	feb42023          	sw	a1,-32(s0)
20400aec:	0040006f          	j	20400af0 <cstrcat_OFU2YEECSOKD6+0x4c>
20400af0:	ff042503          	lw	a0,-16(s0)
20400af4:	00054503          	lbu	a0,0(a0)
20400af8:	fec42583          	lw	a1,-20(s0)
20400afc:	00a58023          	sb	a0,0(a1)
20400b00:	00000593          	li	a1,0
20400b04:	02b50263          	beq	a0,a1,20400b28 <cstrcat_OFU2YEECSOKD6+0x84>
20400b08:	0040006f          	j	20400b0c <cstrcat_OFU2YEECSOKD6+0x68>
20400b0c:	fec42503          	lw	a0,-20(s0)
20400b10:	00150513          	addi	a0,a0,1
20400b14:	fea42623          	sw	a0,-20(s0)
20400b18:	ff042503          	lw	a0,-16(s0)
20400b1c:	00150513          	addi	a0,a0,1
20400b20:	fea42823          	sw	a0,-16(s0)
20400b24:	fcdff06f          	j	20400af0 <cstrcat_OFU2YEECSOKD6+0x4c>
20400b28:	ff442503          	lw	a0,-12(s0)
20400b2c:	01812403          	lw	s0,24(sp)
20400b30:	01c12083          	lw	ra,28(sp)
20400b34:	02010113          	addi	sp,sp,32
20400b38:	00008067          	ret

20400b3c <cstrrev_PD4674KVBI2WX>:
20400b3c:	fe010113          	addi	sp,sp,-32
20400b40:	00112e23          	sw	ra,28(sp)
20400b44:	00812c23          	sw	s0,24(sp)
20400b48:	02010413          	addi	s0,sp,32
20400b4c:	fea42423          	sw	a0,-24(s0)
20400b50:	0040006f          	j	20400b54 <cstrrev_PD4674KVBI2WX+0x18>
20400b54:	fe842503          	lw	a0,-24(s0)
20400b58:	fea42823          	sw	a0,-16(s0)
20400b5c:	fea42a23          	sw	a0,-12(s0)
20400b60:	00000097          	auipc	ra,0x0
20400b64:	d64080e7          	jalr	-668(ra) # 204008c4 <cstrlen_PD4HXS525IJAR>
20400b68:	fe842603          	lw	a2,-24(s0)
20400b6c:	00a60533          	add	a0,a2,a0
20400b70:	fff50513          	addi	a0,a0,-1
20400b74:	fea42623          	sw	a0,-20(s0)
20400b78:	feb42223          	sw	a1,-28(s0)
20400b7c:	0040006f          	j	20400b80 <cstrrev_PD4674KVBI2WX+0x44>
20400b80:	fec42503          	lw	a0,-20(s0)
20400b84:	ff042583          	lw	a1,-16(s0)
20400b88:	06a5f663          	bgeu	a1,a0,20400bf4 <cstrrev_PD4674KVBI2WX+0xb8>
20400b8c:	0040006f          	j	20400b90 <cstrrev_PD4674KVBI2WX+0x54>
20400b90:	fec42503          	lw	a0,-20(s0)
20400b94:	00050503          	lb	a0,0(a0)
20400b98:	ff042583          	lw	a1,-16(s0)
20400b9c:	00058603          	lb	a2,0(a1)
20400ba0:	00a64533          	xor	a0,a2,a0
20400ba4:	00a58023          	sb	a0,0(a1)
20400ba8:	ff042503          	lw	a0,-16(s0)
20400bac:	00050503          	lb	a0,0(a0)
20400bb0:	fec42583          	lw	a1,-20(s0)
20400bb4:	00058603          	lb	a2,0(a1)
20400bb8:	00a64533          	xor	a0,a2,a0
20400bbc:	00a58023          	sb	a0,0(a1)
20400bc0:	fec42503          	lw	a0,-20(s0)
20400bc4:	00050503          	lb	a0,0(a0)
20400bc8:	ff042583          	lw	a1,-16(s0)
20400bcc:	00058603          	lb	a2,0(a1)
20400bd0:	00a64533          	xor	a0,a2,a0
20400bd4:	00a58023          	sb	a0,0(a1)
20400bd8:	ff042503          	lw	a0,-16(s0)
20400bdc:	00150513          	addi	a0,a0,1
20400be0:	fea42823          	sw	a0,-16(s0)
20400be4:	fec42503          	lw	a0,-20(s0)
20400be8:	fff50513          	addi	a0,a0,-1
20400bec:	fea42623          	sw	a0,-20(s0)
20400bf0:	f91ff06f          	j	20400b80 <cstrrev_PD4674KVBI2WX+0x44>
20400bf4:	01812403          	lw	s0,24(sp)
20400bf8:	01c12083          	lw	ra,28(sp)
20400bfc:	02010113          	addi	sp,sp,32
20400c00:	00008067          	ret

20400c04 <itoa_BZEWFQZ4Z7G4X>:
20400c04:	fd010113          	addi	sp,sp,-48
20400c08:	02112623          	sw	ra,44(sp)
20400c0c:	02812423          	sw	s0,40(sp)
20400c10:	03010413          	addi	s0,sp,48
20400c14:	fcb42e23          	sw	a1,-36(s0)
20400c18:	fca42c23          	sw	a0,-40(s0)
20400c1c:	0040006f          	j	20400c20 <itoa_BZEWFQZ4Z7G4X+0x1c>
20400c20:	fdc42503          	lw	a0,-36(s0)
20400c24:	fea42823          	sw	a0,-16(s0)
20400c28:	fd842583          	lw	a1,-40(s0)
20400c2c:	feb42a23          	sw	a1,-12(s0)
20400c30:	00000613          	li	a2,0
20400c34:	fec42623          	sw	a2,-20(s0)
20400c38:	fec405a3          	sb	a2,-21(s0)
20400c3c:	02c59863          	bne	a1,a2,20400c6c <itoa_BZEWFQZ4Z7G4X+0x68>
20400c40:	0040006f          	j	20400c44 <itoa_BZEWFQZ4Z7G4X+0x40>
20400c44:	ff042503          	lw	a0,-16(s0)
20400c48:	03000593          	li	a1,48
20400c4c:	00b50023          	sb	a1,0(a0)
20400c50:	00000513          	li	a0,0
20400c54:	ff042583          	lw	a1,-16(s0)
20400c58:	00a580a3          	sb	a0,1(a1)
20400c5c:	02812403          	lw	s0,40(sp)
20400c60:	02c12083          	lw	ra,44(sp)
20400c64:	03010113          	addi	sp,sp,48
20400c68:	00008067          	ret
20400c6c:	ff442503          	lw	a0,-12(s0)
20400c70:	fff00593          	li	a1,-1
20400c74:	02a5c263          	blt	a1,a0,20400c98 <itoa_BZEWFQZ4Z7G4X+0x94>
20400c78:	0040006f          	j	20400c7c <itoa_BZEWFQZ4Z7G4X+0x78>
20400c7c:	00100513          	li	a0,1
20400c80:	fea405a3          	sb	a0,-21(s0)
20400c84:	00000513          	li	a0,0
20400c88:	ff442583          	lw	a1,-12(s0)
20400c8c:	40b50533          	sub	a0,a0,a1
20400c90:	fea42a23          	sw	a0,-12(s0)
20400c94:	0040006f          	j	20400c98 <itoa_BZEWFQZ4Z7G4X+0x94>
20400c98:	0040006f          	j	20400c9c <itoa_BZEWFQZ4Z7G4X+0x98>
20400c9c:	00000513          	li	a0,0
20400ca0:	ff442583          	lw	a1,-12(s0)
20400ca4:	08a58663          	beq	a1,a0,20400d30 <itoa_BZEWFQZ4Z7G4X+0x12c>
20400ca8:	0040006f          	j	20400cac <itoa_BZEWFQZ4Z7G4X+0xa8>
20400cac:	ff442503          	lw	a0,-12(s0)
20400cb0:	00a00593          	li	a1,10
20400cb4:	fcb42a23          	sw	a1,-44(s0)
20400cb8:	00000097          	auipc	ra,0x0
20400cbc:	99c080e7          	jalr	-1636(ra) # 20400654 <i32mod>
20400cc0:	fec42583          	lw	a1,-20(s0)
20400cc4:	ff042603          	lw	a2,-16(s0)
20400cc8:	00b605b3          	add	a1,a2,a1
20400ccc:	fea42223          	sw	a0,-28(s0)
20400cd0:	fd442603          	lw	a2,-44(s0)
20400cd4:	fcb42823          	sw	a1,-48(s0)
20400cd8:	00c54c63          	blt	a0,a2,20400cf0 <itoa_BZEWFQZ4Z7G4X+0xec>
20400cdc:	0040006f          	j	20400ce0 <itoa_BZEWFQZ4Z7G4X+0xdc>
20400ce0:	fe442503          	lw	a0,-28(s0)
20400ce4:	05750513          	addi	a0,a0,87
20400ce8:	fea42023          	sw	a0,-32(s0)
20400cec:	0140006f          	j	20400d00 <itoa_BZEWFQZ4Z7G4X+0xfc>
20400cf0:	fe442503          	lw	a0,-28(s0)
20400cf4:	03050513          	addi	a0,a0,48
20400cf8:	fea42023          	sw	a0,-32(s0)
20400cfc:	0040006f          	j	20400d00 <itoa_BZEWFQZ4Z7G4X+0xfc>
20400d00:	fe042503          	lw	a0,-32(s0)
20400d04:	fd042583          	lw	a1,-48(s0)
20400d08:	00a58023          	sb	a0,0(a1)
20400d0c:	fec42503          	lw	a0,-20(s0)
20400d10:	00150513          	addi	a0,a0,1
20400d14:	fea42623          	sw	a0,-20(s0)
20400d18:	ff442503          	lw	a0,-12(s0)
20400d1c:	00a00593          	li	a1,10
20400d20:	00000097          	auipc	ra,0x0
20400d24:	87c080e7          	jalr	-1924(ra) # 2040059c <i32div>
20400d28:	fea42a23          	sw	a0,-12(s0)
20400d2c:	f71ff06f          	j	20400c9c <itoa_BZEWFQZ4Z7G4X+0x98>
20400d30:	00000513          	li	a0,0
20400d34:	feb44583          	lbu	a1,-21(s0)
20400d38:	02a58663          	beq	a1,a0,20400d64 <itoa_BZEWFQZ4Z7G4X+0x160>
20400d3c:	0040006f          	j	20400d40 <itoa_BZEWFQZ4Z7G4X+0x13c>
20400d40:	fec42503          	lw	a0,-20(s0)
20400d44:	ff042583          	lw	a1,-16(s0)
20400d48:	00a58533          	add	a0,a1,a0
20400d4c:	02d00593          	li	a1,45
20400d50:	00b50023          	sb	a1,0(a0)
20400d54:	fec42503          	lw	a0,-20(s0)
20400d58:	00150513          	addi	a0,a0,1
20400d5c:	fea42623          	sw	a0,-20(s0)
20400d60:	0040006f          	j	20400d64 <itoa_BZEWFQZ4Z7G4X+0x160>
20400d64:	fec42503          	lw	a0,-20(s0)
20400d68:	ff042583          	lw	a1,-16(s0)
20400d6c:	00a58533          	add	a0,a1,a0
20400d70:	00000593          	li	a1,0
20400d74:	00b50023          	sb	a1,0(a0)
20400d78:	ff042503          	lw	a0,-16(s0)
20400d7c:	00000097          	auipc	ra,0x0
20400d80:	dc0080e7          	jalr	-576(ra) # 20400b3c <cstrrev_PD4674KVBI2WX>
20400d84:	02812403          	lw	s0,40(sp)
20400d88:	02c12083          	lw	ra,44(sp)
20400d8c:	03010113          	addi	sp,sp,48
20400d90:	00008067          	ret

20400d94 <clear_N46OAFLVPZDRA>:
20400d94:	ff010113          	addi	sp,sp,-16
20400d98:	00112623          	sw	ra,12(sp)
20400d9c:	00812423          	sw	s0,8(sp)
20400da0:	01010413          	addi	s0,sp,16
20400da4:	fea42a23          	sw	a0,-12(s0)
20400da8:	0040006f          	j	20400dac <clear_N46OAFLVPZDRA+0x18>
20400dac:	00000513          	li	a0,0
20400db0:	ff442583          	lw	a1,-12(s0)
20400db4:	00a5a423          	sw	a0,8(a1)
20400db8:	00812403          	lw	s0,8(sp)
20400dbc:	00c12083          	lw	ra,12(sp)
20400dc0:	01010113          	addi	sp,sp,16
20400dc4:	00008067          	ret

20400dc8 <get_GTKIY7X6AUHZX>:
20400dc8:	fe010113          	addi	sp,sp,-32
20400dcc:	00112e23          	sw	ra,28(sp)
20400dd0:	00812c23          	sw	s0,24(sp)
20400dd4:	02010413          	addi	s0,sp,32
20400dd8:	feb42823          	sw	a1,-16(s0)
20400ddc:	fea42623          	sw	a0,-20(s0)
20400de0:	0040006f          	j	20400de4 <get_GTKIY7X6AUHZX+0x1c>
20400de4:	ff042503          	lw	a0,-16(s0)
20400de8:	fea42a23          	sw	a0,-12(s0)
20400dec:	fec42583          	lw	a1,-20(s0)
20400df0:	0015c603          	lbu	a2,1(a1)
20400df4:	00861613          	slli	a2,a2,0x8
20400df8:	0005c683          	lbu	a3,0(a1)
20400dfc:	00d66633          	or	a2,a2,a3
20400e00:	0025c683          	lbu	a3,2(a1)
20400e04:	0035c703          	lbu	a4,3(a1)
20400e08:	00871713          	slli	a4,a4,0x8
20400e0c:	00d766b3          	or	a3,a4,a3
20400e10:	01069693          	slli	a3,a3,0x10
20400e14:	00c6e633          	or	a2,a3,a2
20400e18:	00a60533          	add	a0,a2,a0
20400e1c:	01812403          	lw	s0,24(sp)
20400e20:	01c12083          	lw	ra,28(sp)
20400e24:	02010113          	addi	sp,sp,32
20400e28:	00008067          	ret

20400e2c <pop_MI7T72VEP5LDW>:
20400e2c:	ff010113          	addi	sp,sp,-16
20400e30:	00112623          	sw	ra,12(sp)
20400e34:	00812423          	sw	s0,8(sp)
20400e38:	01010413          	addi	s0,sp,16
20400e3c:	fea42a23          	sw	a0,-12(s0)
20400e40:	0040006f          	j	20400e44 <pop_MI7T72VEP5LDW+0x18>
20400e44:	ff442503          	lw	a0,-12(s0)
20400e48:	00852583          	lw	a1,8(a0)
20400e4c:	00000613          	li	a2,0
20400e50:	00c59e63          	bne	a1,a2,20400e6c <pop_MI7T72VEP5LDW+0x40>
20400e54:	0040006f          	j	20400e58 <pop_MI7T72VEP5LDW+0x2c>
20400e58:	fff00513          	li	a0,-1
20400e5c:	00812403          	lw	s0,8(sp)
20400e60:	00c12083          	lw	ra,12(sp)
20400e64:	01010113          	addi	sp,sp,16
20400e68:	00008067          	ret
20400e6c:	ff442503          	lw	a0,-12(s0)
20400e70:	00852583          	lw	a1,8(a0)
20400e74:	fff58593          	addi	a1,a1,-1
20400e78:	00b52423          	sw	a1,8(a0)
20400e7c:	00058513          	mv	a0,a1
20400e80:	00812403          	lw	s0,8(sp)
20400e84:	00c12083          	lw	ra,12(sp)
20400e88:	01010113          	addi	sp,sp,16
20400e8c:	00008067          	ret

20400e90 <create_ETYHZ52COKCHA>:
20400e90:	fd010113          	addi	sp,sp,-48
20400e94:	02112623          	sw	ra,44(sp)
20400e98:	02812423          	sw	s0,40(sp)
20400e9c:	03010413          	addi	s0,sp,48
20400ea0:	fcc42e23          	sw	a2,-36(s0)
20400ea4:	fcb42c23          	sw	a1,-40(s0)
20400ea8:	fca42a23          	sw	a0,-44(s0)
20400eac:	0040006f          	j	20400eb0 <create_ETYHZ52COKCHA+0x20>
20400eb0:	fd842503          	lw	a0,-40(s0)
20400eb4:	fea42823          	sw	a0,-16(s0)
20400eb8:	fd442583          	lw	a1,-44(s0)
20400ebc:	feb42a23          	sw	a1,-12(s0)
20400ec0:	00a58633          	add	a2,a1,a0
20400ec4:	fdc42683          	lw	a3,-36(s0)
20400ec8:	fed42623          	sw	a3,-20(s0)
20400ecc:	fed42223          	sw	a3,-28(s0)
20400ed0:	fec42023          	sw	a2,-32(s0)
20400ed4:	00060513          	mv	a0,a2
20400ed8:	00068593          	mv	a1,a3
20400edc:	02812403          	lw	s0,40(sp)
20400ee0:	02c12083          	lw	ra,44(sp)
20400ee4:	03010113          	addi	sp,sp,48
20400ee8:	00008067          	ret

20400eec <create_N46QFN2UOXRBJ>:
20400eec:	fd010113          	addi	sp,sp,-48
20400ef0:	02112623          	sw	ra,44(sp)
20400ef4:	02812423          	sw	s0,40(sp)
20400ef8:	03010413          	addi	s0,sp,48
20400efc:	fcc42e23          	sw	a2,-36(s0)
20400f00:	fcb42c23          	sw	a1,-40(s0)
20400f04:	fca42a23          	sw	a0,-44(s0)
20400f08:	0040006f          	j	20400f0c <create_N46QFN2UOXRBJ+0x20>
20400f0c:	fd842503          	lw	a0,-40(s0)
20400f10:	fea42823          	sw	a0,-16(s0)
20400f14:	fdc42583          	lw	a1,-36(s0)
20400f18:	feb42a23          	sw	a1,-12(s0)
20400f1c:	ff040513          	addi	a0,s0,-16
20400f20:	00000097          	auipc	ra,0x0
20400f24:	03c080e7          	jalr	60(ra) # 20400f5c <data_UVZPW5XTYOJW>
20400f28:	00000593          	li	a1,0
20400f2c:	feb42423          	sw	a1,-24(s0)
20400f30:	fea42023          	sw	a0,-32(s0)
20400f34:	ff442603          	lw	a2,-12(s0)
20400f38:	fec42223          	sw	a2,-28(s0)
20400f3c:	fd442683          	lw	a3,-44(s0)
20400f40:	00b6a423          	sw	a1,8(a3)
20400f44:	00c6a223          	sw	a2,4(a3)
20400f48:	00a6a023          	sw	a0,0(a3)
20400f4c:	02812403          	lw	s0,40(sp)
20400f50:	02c12083          	lw	ra,44(sp)
20400f54:	03010113          	addi	sp,sp,48
20400f58:	00008067          	ret

20400f5c <data_UVZPW5XTYOJW>:
20400f5c:	ff010113          	addi	sp,sp,-16
20400f60:	00112623          	sw	ra,12(sp)
20400f64:	00812423          	sw	s0,8(sp)
20400f68:	01010413          	addi	s0,sp,16
20400f6c:	fea42a23          	sw	a0,-12(s0)
20400f70:	0040006f          	j	20400f74 <data_UVZPW5XTYOJW+0x18>
20400f74:	ff442503          	lw	a0,-12(s0)
20400f78:	00154583          	lbu	a1,1(a0)
20400f7c:	00859593          	slli	a1,a1,0x8
20400f80:	00054603          	lbu	a2,0(a0)
20400f84:	00c5e5b3          	or	a1,a1,a2
20400f88:	00254603          	lbu	a2,2(a0)
20400f8c:	00354683          	lbu	a3,3(a0)
20400f90:	00869693          	slli	a3,a3,0x8
20400f94:	00c6e633          	or	a2,a3,a2
20400f98:	01061613          	slli	a2,a2,0x10
20400f9c:	00b66533          	or	a0,a2,a1
20400fa0:	00812403          	lw	s0,8(sp)
20400fa4:	00c12083          	lw	ra,12(sp)
20400fa8:	01010113          	addi	sp,sp,16
20400fac:	00008067          	ret

20400fb0 <push_OXEQ2JVHTCRW7>:
20400fb0:	fe010113          	addi	sp,sp,-32
20400fb4:	00112e23          	sw	ra,28(sp)
20400fb8:	00812c23          	sw	s0,24(sp)
20400fbc:	02010413          	addi	s0,sp,32
20400fc0:	feb42623          	sw	a1,-20(s0)
20400fc4:	fea42423          	sw	a0,-24(s0)
20400fc8:	0040006f          	j	20400fcc <push_OXEQ2JVHTCRW7+0x1c>
20400fcc:	fec42503          	lw	a0,-20(s0)
20400fd0:	fea40ba3          	sb	a0,-9(s0)
20400fd4:	fe842583          	lw	a1,-24(s0)
20400fd8:	0045a603          	lw	a2,4(a1)
20400fdc:	0085a683          	lw	a3,8(a1)
20400fe0:	00c69e63          	bne	a3,a2,20400ffc <push_OXEQ2JVHTCRW7+0x4c>
20400fe4:	0040006f          	j	20400fe8 <push_OXEQ2JVHTCRW7+0x38>
20400fe8:	fff00513          	li	a0,-1
20400fec:	01812403          	lw	s0,24(sp)
20400ff0:	01c12083          	lw	ra,28(sp)
20400ff4:	02010113          	addi	sp,sp,32
20400ff8:	00008067          	ret
20400ffc:	fe842503          	lw	a0,-24(s0)
20401000:	00852583          	lw	a1,8(a0)
20401004:	feb42823          	sw	a1,-16(s0)
20401008:	00154603          	lbu	a2,1(a0)
2040100c:	00861613          	slli	a2,a2,0x8
20401010:	00054683          	lbu	a3,0(a0)
20401014:	00d66633          	or	a2,a2,a3
20401018:	00354683          	lbu	a3,3(a0)
2040101c:	00869693          	slli	a3,a3,0x8
20401020:	00254703          	lbu	a4,2(a0)
20401024:	00e6e6b3          	or	a3,a3,a4
20401028:	01069693          	slli	a3,a3,0x10
2040102c:	00c6e633          	or	a2,a3,a2
20401030:	00b605b3          	add	a1,a2,a1
20401034:	ff740603          	lb	a2,-9(s0)
20401038:	00c58023          	sb	a2,0(a1)
2040103c:	00852583          	lw	a1,8(a0)
20401040:	00158593          	addi	a1,a1,1
20401044:	00b52423          	sw	a1,8(a0)
20401048:	ff042503          	lw	a0,-16(s0)
2040104c:	01812403          	lw	s0,24(sp)
20401050:	01c12083          	lw	ra,28(sp)
20401054:	02010113          	addi	sp,sp,32
20401058:	00008067          	ret

2040105c <writeln_GD2KPBA3KGJZN>:
2040105c:	fe010113          	addi	sp,sp,-32
20401060:	00112e23          	sw	ra,28(sp)
20401064:	00812c23          	sw	s0,24(sp)
20401068:	02010413          	addi	s0,sp,32
2040106c:	feb42823          	sw	a1,-16(s0)
20401070:	fea42623          	sw	a0,-20(s0)
20401074:	0040006f          	j	20401078 <writeln_GD2KPBA3KGJZN+0x1c>
20401078:	ff042503          	lw	a0,-16(s0)
2040107c:	fea42a23          	sw	a0,-12(s0)
20401080:	fec42503          	lw	a0,-20(s0)
20401084:	ff042583          	lw	a1,-16(s0)
20401088:	00000097          	auipc	ra,0x0
2040108c:	02c080e7          	jalr	44(ra) # 204010b4 <write_KDZ65VRPN5XHP>
20401090:	20402537          	lui	a0,0x20402
20401094:	aba50593          	addi	a1,a0,-1350 # 20401aba <main+0x32e>
20401098:	fec42503          	lw	a0,-20(s0)
2040109c:	00000097          	auipc	ra,0x0
204010a0:	018080e7          	jalr	24(ra) # 204010b4 <write_KDZ65VRPN5XHP>
204010a4:	01812403          	lw	s0,24(sp)
204010a8:	01c12083          	lw	ra,28(sp)
204010ac:	02010113          	addi	sp,sp,32
204010b0:	00008067          	ret

204010b4 <write_KDZ65VRPN5XHP>:
204010b4:	fe010113          	addi	sp,sp,-32
204010b8:	00112e23          	sw	ra,28(sp)
204010bc:	00812c23          	sw	s0,24(sp)
204010c0:	02010413          	addi	s0,sp,32
204010c4:	feb42823          	sw	a1,-16(s0)
204010c8:	fea42623          	sw	a0,-20(s0)
204010cc:	0040006f          	j	204010d0 <write_KDZ65VRPN5XHP+0x1c>
204010d0:	ff042503          	lw	a0,-16(s0)
204010d4:	fea42a23          	sw	a0,-12(s0)
204010d8:	0040006f          	j	204010dc <write_KDZ65VRPN5XHP+0x28>
204010dc:	ff442503          	lw	a0,-12(s0)
204010e0:	00054503          	lbu	a0,0(a0)
204010e4:	00000593          	li	a1,0
204010e8:	08b50e63          	beq	a0,a1,20401184 <write_KDZ65VRPN5XHP+0xd0>
204010ec:	0040006f          	j	204010f0 <write_KDZ65VRPN5XHP+0x3c>
204010f0:	ff442503          	lw	a0,-12(s0)
204010f4:	00050583          	lb	a1,0(a0)
204010f8:	fec42503          	lw	a0,-20(s0)
204010fc:	00c50513          	addi	a0,a0,12
20401100:	00000097          	auipc	ra,0x0
20401104:	eb0080e7          	jalr	-336(ra) # 20400fb0 <push_OXEQ2JVHTCRW7>
20401108:	00100593          	li	a1,1
2040110c:	ff442603          	lw	a2,-12(s0)
20401110:	00064603          	lbu	a2,0(a2)
20401114:	00a00693          	li	a3,10
20401118:	fea42423          	sw	a0,-24(s0)
2040111c:	feb42223          	sw	a1,-28(s0)
20401120:	02d60a63          	beq	a2,a3,20401154 <write_KDZ65VRPN5XHP+0xa0>
20401124:	0040006f          	j	20401128 <write_KDZ65VRPN5XHP+0x74>
20401128:	00100513          	li	a0,1
2040112c:	fec42583          	lw	a1,-20(s0)
20401130:	0145a603          	lw	a2,20(a1)
20401134:	0105a683          	lw	a3,16(a1)
20401138:	fff68693          	addi	a3,a3,-1
2040113c:	fea42223          	sw	a0,-28(s0)
20401140:	00d60a63          	beq	a2,a3,20401154 <write_KDZ65VRPN5XHP+0xa0>
20401144:	0040006f          	j	20401148 <write_KDZ65VRPN5XHP+0x94>
20401148:	00000513          	li	a0,0
2040114c:	fea42223          	sw	a0,-28(s0)
20401150:	0040006f          	j	20401154 <write_KDZ65VRPN5XHP+0xa0>
20401154:	fe442503          	lw	a0,-28(s0)
20401158:	00000593          	li	a1,0
2040115c:	00b50c63          	beq	a0,a1,20401174 <write_KDZ65VRPN5XHP+0xc0>
20401160:	0040006f          	j	20401164 <write_KDZ65VRPN5XHP+0xb0>
20401164:	fec42503          	lw	a0,-20(s0)
20401168:	00000097          	auipc	ra,0x0
2040116c:	02c080e7          	jalr	44(ra) # 20401194 <flush_KPZ5Y4V6SNAPI>
20401170:	0040006f          	j	20401174 <write_KDZ65VRPN5XHP+0xc0>
20401174:	ff442503          	lw	a0,-12(s0)
20401178:	00150513          	addi	a0,a0,1
2040117c:	fea42a23          	sw	a0,-12(s0)
20401180:	f5dff06f          	j	204010dc <write_KDZ65VRPN5XHP+0x28>
20401184:	01812403          	lw	s0,24(sp)
20401188:	01c12083          	lw	ra,28(sp)
2040118c:	02010113          	addi	sp,sp,32
20401190:	00008067          	ret

20401194 <flush_KPZ5Y4V6SNAPI>:
20401194:	fe010113          	addi	sp,sp,-32
20401198:	00112e23          	sw	ra,28(sp)
2040119c:	00812c23          	sw	s0,24(sp)
204011a0:	02010413          	addi	s0,sp,32
204011a4:	fea42a23          	sw	a0,-12(s0)
204011a8:	0040006f          	j	204011ac <flush_KPZ5Y4V6SNAPI+0x18>
204011ac:	00000513          	li	a0,0
204011b0:	ff442583          	lw	a1,-12(s0)
204011b4:	00c58613          	addi	a2,a1,12
204011b8:	fea42823          	sw	a0,-16(s0)
204011bc:	00060513          	mv	a0,a2
204011c0:	ff042583          	lw	a1,-16(s0)
204011c4:	fec42623          	sw	a2,-20(s0)
204011c8:	00000097          	auipc	ra,0x0
204011cc:	de8080e7          	jalr	-536(ra) # 20400fb0 <push_OXEQ2JVHTCRW7>
204011d0:	ff442583          	lw	a1,-12(s0)
204011d4:	00d5c603          	lbu	a2,13(a1)
204011d8:	00861613          	slli	a2,a2,0x8
204011dc:	00c5c683          	lbu	a3,12(a1)
204011e0:	00d66633          	or	a2,a2,a3
204011e4:	00e5c683          	lbu	a3,14(a1)
204011e8:	00f5c703          	lbu	a4,15(a1)
204011ec:	00871713          	slli	a4,a4,0x8
204011f0:	00d766b3          	or	a3,a4,a3
204011f4:	01069693          	slli	a3,a3,0x10
204011f8:	00c6e633          	or	a2,a3,a2
204011fc:	fea42423          	sw	a0,-24(s0)
20401200:	00060513          	mv	a0,a2
20401204:	fffff097          	auipc	ra,0xfffff
20401208:	658080e7          	jalr	1624(ra) # 2040085c <write_string_LNEGVSSIZZ6RT>
2040120c:	fec42503          	lw	a0,-20(s0)
20401210:	00000097          	auipc	ra,0x0
20401214:	b84080e7          	jalr	-1148(ra) # 20400d94 <clear_N46OAFLVPZDRA>
20401218:	01812403          	lw	s0,24(sp)
2040121c:	01c12083          	lw	ra,28(sp)
20401220:	02010113          	addi	sp,sp,32
20401224:	00008067          	ret

20401228 <writeln_MTDR7HRHSHJOT>:
20401228:	ff010113          	addi	sp,sp,-16
2040122c:	00112623          	sw	ra,12(sp)
20401230:	00812423          	sw	s0,8(sp)
20401234:	01010413          	addi	s0,sp,16
20401238:	fea42a23          	sw	a0,-12(s0)
2040123c:	0040006f          	j	20401240 <writeln_MTDR7HRHSHJOT+0x18>
20401240:	20402537          	lui	a0,0x20402
20401244:	aba50593          	addi	a1,a0,-1350 # 20401aba <main+0x32e>
20401248:	ff442503          	lw	a0,-12(s0)
2040124c:	00000097          	auipc	ra,0x0
20401250:	e68080e7          	jalr	-408(ra) # 204010b4 <write_KDZ65VRPN5XHP>
20401254:	00812403          	lw	s0,8(sp)
20401258:	00c12083          	lw	ra,12(sp)
2040125c:	01010113          	addi	sp,sp,16
20401260:	00008067          	ret

20401264 <writeln_HH657NUKXKRAX>:
20401264:	fe010113          	addi	sp,sp,-32
20401268:	00112e23          	sw	ra,28(sp)
2040126c:	00812c23          	sw	s0,24(sp)
20401270:	02010413          	addi	s0,sp,32
20401274:	feb42823          	sw	a1,-16(s0)
20401278:	fea42623          	sw	a0,-20(s0)
2040127c:	0040006f          	j	20401280 <writeln_HH657NUKXKRAX+0x1c>
20401280:	ff042503          	lw	a0,-16(s0)
20401284:	fea42a23          	sw	a0,-12(s0)
20401288:	fec42503          	lw	a0,-20(s0)
2040128c:	ff042583          	lw	a1,-16(s0)
20401290:	00000097          	auipc	ra,0x0
20401294:	02c080e7          	jalr	44(ra) # 204012bc <write_CQHFIJDGCNEOV>
20401298:	20402537          	lui	a0,0x20402
2040129c:	aba50593          	addi	a1,a0,-1350 # 20401aba <main+0x32e>
204012a0:	fec42503          	lw	a0,-20(s0)
204012a4:	00000097          	auipc	ra,0x0
204012a8:	e10080e7          	jalr	-496(ra) # 204010b4 <write_KDZ65VRPN5XHP>
204012ac:	01812403          	lw	s0,24(sp)
204012b0:	01c12083          	lw	ra,28(sp)
204012b4:	02010113          	addi	sp,sp,32
204012b8:	00008067          	ret

204012bc <write_CQHFIJDGCNEOV>:
204012bc:	fa010113          	addi	sp,sp,-96
204012c0:	04112e23          	sw	ra,92(sp)
204012c4:	04812c23          	sw	s0,88(sp)
204012c8:	06010413          	addi	s0,sp,96
204012cc:	fb440613          	addi	a2,s0,-76
204012d0:	fac42823          	sw	a2,-80(s0)
204012d4:	fab42623          	sw	a1,-84(s0)
204012d8:	faa42423          	sw	a0,-88(s0)
204012dc:	0040006f          	j	204012e0 <write_CQHFIJDGCNEOV+0x24>
204012e0:	fac42503          	lw	a0,-84(s0)
204012e4:	fea42a23          	sw	a0,-12(s0)
204012e8:	fb042583          	lw	a1,-80(s0)
204012ec:	00000097          	auipc	ra,0x0
204012f0:	918080e7          	jalr	-1768(ra) # 20400c04 <itoa_BZEWFQZ4Z7G4X>
204012f4:	fb042583          	lw	a1,-80(s0)
204012f8:	fa842503          	lw	a0,-88(s0)
204012fc:	00000097          	auipc	ra,0x0
20401300:	db8080e7          	jalr	-584(ra) # 204010b4 <write_KDZ65VRPN5XHP>
20401304:	05812403          	lw	s0,88(sp)
20401308:	05c12083          	lw	ra,92(sp)
2040130c:	06010113          	addi	sp,sp,96
20401310:	00008067          	ret

20401314 <write_CXMNRMJIHGXAF>:
20401314:	fe010113          	addi	sp,sp,-32
20401318:	00112e23          	sw	ra,28(sp)
2040131c:	00812c23          	sw	s0,24(sp)
20401320:	02010413          	addi	s0,sp,32
20401324:	feb42823          	sw	a1,-16(s0)
20401328:	fea42623          	sw	a0,-20(s0)
2040132c:	0040006f          	j	20401330 <write_CXMNRMJIHGXAF+0x1c>
20401330:	ff042503          	lw	a0,-16(s0)
20401334:	fea40ba3          	sb	a0,-9(s0)
20401338:	fec42583          	lw	a1,-20(s0)
2040133c:	00c58513          	addi	a0,a1,12
20401340:	ff042583          	lw	a1,-16(s0)
20401344:	00000097          	auipc	ra,0x0
20401348:	c6c080e7          	jalr	-916(ra) # 20400fb0 <push_OXEQ2JVHTCRW7>
2040134c:	00100593          	li	a1,1
20401350:	00a00613          	li	a2,10
20401354:	ff744683          	lbu	a3,-9(s0)
20401358:	fea42423          	sw	a0,-24(s0)
2040135c:	feb42223          	sw	a1,-28(s0)
20401360:	02c68a63          	beq	a3,a2,20401394 <write_CXMNRMJIHGXAF+0x80>
20401364:	0040006f          	j	20401368 <write_CXMNRMJIHGXAF+0x54>
20401368:	00100513          	li	a0,1
2040136c:	fec42583          	lw	a1,-20(s0)
20401370:	0145a603          	lw	a2,20(a1)
20401374:	0105a683          	lw	a3,16(a1)
20401378:	fff68693          	addi	a3,a3,-1
2040137c:	fea42223          	sw	a0,-28(s0)
20401380:	00d60a63          	beq	a2,a3,20401394 <write_CXMNRMJIHGXAF+0x80>
20401384:	0040006f          	j	20401388 <write_CXMNRMJIHGXAF+0x74>
20401388:	00000513          	li	a0,0
2040138c:	fea42223          	sw	a0,-28(s0)
20401390:	0040006f          	j	20401394 <write_CXMNRMJIHGXAF+0x80>
20401394:	fe442503          	lw	a0,-28(s0)
20401398:	00000593          	li	a1,0
2040139c:	00b50c63          	beq	a0,a1,204013b4 <write_CXMNRMJIHGXAF+0xa0>
204013a0:	0040006f          	j	204013a4 <write_CXMNRMJIHGXAF+0x90>
204013a4:	fec42503          	lw	a0,-20(s0)
204013a8:	00000097          	auipc	ra,0x0
204013ac:	dec080e7          	jalr	-532(ra) # 20401194 <flush_KPZ5Y4V6SNAPI>
204013b0:	0040006f          	j	204013b4 <write_CXMNRMJIHGXAF+0xa0>
204013b4:	01812403          	lw	s0,24(sp)
204013b8:	01c12083          	lw	ra,28(sp)
204013bc:	02010113          	addi	sp,sp,32
204013c0:	00008067          	ret

204013c4 <echo_on_DG2IJKDAYJJGT>:
204013c4:	ff010113          	addi	sp,sp,-16
204013c8:	00112623          	sw	ra,12(sp)
204013cc:	00812423          	sw	s0,8(sp)
204013d0:	01010413          	addi	s0,sp,16
204013d4:	fea42a23          	sw	a0,-12(s0)
204013d8:	0040006f          	j	204013dc <echo_on_DG2IJKDAYJJGT+0x18>
204013dc:	20400537          	lui	a0,0x20400
204013e0:	77c50513          	addi	a0,a0,1916 # 2040077c <read_echo_DJOHO5RF3POM2>
204013e4:	ff442583          	lw	a1,-12(s0)
204013e8:	00a5ac23          	sw	a0,24(a1)
204013ec:	00812403          	lw	s0,8(sp)
204013f0:	00c12083          	lw	ra,12(sp)
204013f4:	01010113          	addi	sp,sp,16
204013f8:	00008067          	ret

204013fc <create_HSPXW5ZZMOT3C>:
204013fc:	f6010113          	addi	sp,sp,-160
20401400:	08112e23          	sw	ra,156(sp)
20401404:	08812c23          	sw	s0,152(sp)
20401408:	0a010413          	addi	s0,sp,160
2040140c:	f6e42e23          	sw	a4,-132(s0)
20401410:	f6d42c23          	sw	a3,-136(s0)
20401414:	f6c42a23          	sw	a2,-140(s0)
20401418:	f6b42823          	sw	a1,-144(s0)
2040141c:	f6a42623          	sw	a0,-148(s0)
20401420:	0040006f          	j	20401424 <create_HSPXW5ZZMOT3C+0x28>
20401424:	f7042503          	lw	a0,-144(s0)
20401428:	fea42423          	sw	a0,-24(s0)
2040142c:	f6c42583          	lw	a1,-148(s0)
20401430:	feb42a23          	sw	a1,-12(s0)
20401434:	f7442603          	lw	a2,-140(s0)
20401438:	fec42623          	sw	a2,-20(s0)
2040143c:	f7842683          	lw	a3,-136(s0)
20401440:	fed42023          	sw	a3,-32(s0)
20401444:	f7c42703          	lw	a4,-132(s0)
20401448:	fee42223          	sw	a4,-28(s0)
2040144c:	f9040513          	addi	a0,s0,-112
20401450:	00068593          	mv	a1,a3
20401454:	00070613          	mv	a2,a4
20401458:	00000097          	auipc	ra,0x0
2040145c:	0ec080e7          	jalr	236(ra) # 20401544 <create_NU3XHJW226JYF>
20401460:	f9842503          	lw	a0,-104(s0)
20401464:	f9442583          	lw	a1,-108(s0)
20401468:	f9042603          	lw	a2,-112(s0)
2040146c:	fe842683          	lw	a3,-24(s0)
20401470:	fec42703          	lw	a4,-20(s0)
20401474:	f8040793          	addi	a5,s0,-128
20401478:	f6a42423          	sw	a0,-152(s0)
2040147c:	00078513          	mv	a0,a5
20401480:	f6b42223          	sw	a1,-156(s0)
20401484:	00068593          	mv	a1,a3
20401488:	f6c42023          	sw	a2,-160(s0)
2040148c:	00070613          	mv	a2,a4
20401490:	00000097          	auipc	ra,0x0
20401494:	0b4080e7          	jalr	180(ra) # 20401544 <create_NU3XHJW226JYF>
20401498:	f6042503          	lw	a0,-160(s0)
2040149c:	faa42623          	sw	a0,-84(s0)
204014a0:	fca42623          	sw	a0,-52(s0)
204014a4:	f6442583          	lw	a1,-156(s0)
204014a8:	fab42823          	sw	a1,-80(s0)
204014ac:	fcb42823          	sw	a1,-48(s0)
204014b0:	f6842603          	lw	a2,-152(s0)
204014b4:	fac42a23          	sw	a2,-76(s0)
204014b8:	fcc42a23          	sw	a2,-44(s0)
204014bc:	00000693          	li	a3,0
204014c0:	fad42c23          	sw	a3,-72(s0)
204014c4:	fcd42c23          	sw	a3,-40(s0)
204014c8:	f8042683          	lw	a3,-128(s0)
204014cc:	fad42023          	sw	a3,-96(s0)
204014d0:	fcd42023          	sw	a3,-64(s0)
204014d4:	f8442683          	lw	a3,-124(s0)
204014d8:	fad42223          	sw	a3,-92(s0)
204014dc:	fcd42223          	sw	a3,-60(s0)
204014e0:	f8842683          	lw	a3,-120(s0)
204014e4:	fad42423          	sw	a3,-88(s0)
204014e8:	fcd42423          	sw	a3,-56(s0)
204014ec:	fc040513          	addi	a0,s0,-64
204014f0:	00000097          	auipc	ra,0x0
204014f4:	ed4080e7          	jalr	-300(ra) # 204013c4 <echo_on_DG2IJKDAYJJGT>
204014f8:	ff442503          	lw	a0,-12(s0)
204014fc:	fd842583          	lw	a1,-40(s0)
20401500:	00b52c23          	sw	a1,24(a0)
20401504:	fd442583          	lw	a1,-44(s0)
20401508:	00b52a23          	sw	a1,20(a0)
2040150c:	fd042583          	lw	a1,-48(s0)
20401510:	00b52823          	sw	a1,16(a0)
20401514:	fcc42583          	lw	a1,-52(s0)
20401518:	00b52623          	sw	a1,12(a0)
2040151c:	fc842583          	lw	a1,-56(s0)
20401520:	00b52423          	sw	a1,8(a0)
20401524:	fc442583          	lw	a1,-60(s0)
20401528:	00b52223          	sw	a1,4(a0)
2040152c:	fc042583          	lw	a1,-64(s0)
20401530:	00b52023          	sw	a1,0(a0)
20401534:	09812403          	lw	s0,152(sp)
20401538:	09c12083          	lw	ra,156(sp)
2040153c:	0a010113          	addi	sp,sp,160
20401540:	00008067          	ret

20401544 <create_NU3XHJW226JYF>:
20401544:	fd010113          	addi	sp,sp,-48
20401548:	02112623          	sw	ra,44(sp)
2040154c:	02812423          	sw	s0,40(sp)
20401550:	03010413          	addi	s0,sp,48
20401554:	fcc42e23          	sw	a2,-36(s0)
20401558:	fcb42c23          	sw	a1,-40(s0)
2040155c:	fca42a23          	sw	a0,-44(s0)
20401560:	0040006f          	j	20401564 <create_NU3XHJW226JYF+0x20>
20401564:	fd842503          	lw	a0,-40(s0)
20401568:	fea42823          	sw	a0,-16(s0)
2040156c:	fdc42583          	lw	a1,-36(s0)
20401570:	feb42a23          	sw	a1,-12(s0)
20401574:	ff040513          	addi	a0,s0,-16
20401578:	00000097          	auipc	ra,0x0
2040157c:	9e4080e7          	jalr	-1564(ra) # 20400f5c <data_UVZPW5XTYOJW>
20401580:	00000593          	li	a1,0
20401584:	feb42423          	sw	a1,-24(s0)
20401588:	fea42023          	sw	a0,-32(s0)
2040158c:	ff442603          	lw	a2,-12(s0)
20401590:	fec42223          	sw	a2,-28(s0)
20401594:	fd442683          	lw	a3,-44(s0)
20401598:	00b6a423          	sw	a1,8(a3)
2040159c:	00c6a223          	sw	a2,4(a3)
204015a0:	00a6a023          	sw	a0,0(a3)
204015a4:	02812403          	lw	s0,40(sp)
204015a8:	02c12083          	lw	ra,44(sp)
204015ac:	03010113          	addi	sp,sp,48
204015b0:	00008067          	ret

204015b4 <echo_off_KBCRTULCRQXL5>:
204015b4:	ff010113          	addi	sp,sp,-16
204015b8:	00112623          	sw	ra,12(sp)
204015bc:	00812423          	sw	s0,8(sp)
204015c0:	01010413          	addi	s0,sp,16
204015c4:	fea42a23          	sw	a0,-12(s0)
204015c8:	0040006f          	j	204015cc <echo_off_KBCRTULCRQXL5+0x18>
204015cc:	20400537          	lui	a0,0x20400
204015d0:	71c50513          	addi	a0,a0,1820 # 2040071c <read_KK223CQSKU6KE>
204015d4:	ff442583          	lw	a1,-12(s0)
204015d8:	00a5ac23          	sw	a0,24(a1)
204015dc:	00812403          	lw	s0,8(sp)
204015e0:	00c12083          	lw	ra,12(sp)
204015e4:	01010113          	addi	sp,sp,16
204015e8:	00008067          	ret

204015ec <readchar_J52GRX44JDBLG>:
204015ec:	ff010113          	addi	sp,sp,-16
204015f0:	00112623          	sw	ra,12(sp)
204015f4:	00812423          	sw	s0,8(sp)
204015f8:	01010413          	addi	s0,sp,16
204015fc:	fea42823          	sw	a0,-16(s0)
20401600:	0040006f          	j	20401604 <readchar_J52GRX44JDBLG+0x18>
20401604:	00000513          	li	a0,0
20401608:	fea40ba3          	sb	a0,-9(s0)
2040160c:	0040006f          	j	20401610 <readchar_J52GRX44JDBLG+0x24>
20401610:	00000513          	li	a0,0
20401614:	ff744583          	lbu	a1,-9(s0)
20401618:	00a59e63          	bne	a1,a0,20401634 <readchar_J52GRX44JDBLG+0x48>
2040161c:	0040006f          	j	20401620 <readchar_J52GRX44JDBLG+0x34>
20401620:	ff042503          	lw	a0,-16(s0)
20401624:	01852583          	lw	a1,24(a0)
20401628:	000580e7          	jalr	a1
2040162c:	fea40ba3          	sb	a0,-9(s0)
20401630:	fe1ff06f          	j	20401610 <readchar_J52GRX44JDBLG+0x24>
20401634:	ff740503          	lb	a0,-9(s0)
20401638:	00812403          	lw	s0,8(sp)
2040163c:	00c12083          	lw	ra,12(sp)
20401640:	01010113          	addi	sp,sp,16
20401644:	00008067          	ret

20401648 <readln_HHAHYNO5CKM7C>:
20401648:	fd010113          	addi	sp,sp,-48
2040164c:	02112623          	sw	ra,44(sp)
20401650:	02812423          	sw	s0,40(sp)
20401654:	03010413          	addi	s0,sp,48
20401658:	feb42623          	sw	a1,-20(s0)
2040165c:	fea42423          	sw	a0,-24(s0)
20401660:	0040006f          	j	20401664 <readln_HHAHYNO5CKM7C+0x1c>
20401664:	00000513          	li	a0,0
20401668:	fea409a3          	sb	a0,-13(s0)
2040166c:	fec42503          	lw	a0,-20(s0)
20401670:	fea42a23          	sw	a0,-12(s0)
20401674:	0040006f          	j	20401678 <readln_HHAHYNO5CKM7C+0x30>
20401678:	00000513          	li	a0,0
2040167c:	08051863          	bnez	a0,2040170c <readln_HHAHYNO5CKM7C+0xc4>
20401680:	0040006f          	j	20401684 <readln_HHAHYNO5CKM7C+0x3c>
20401684:	0040006f          	j	20401688 <readln_HHAHYNO5CKM7C+0x40>
20401688:	fe842503          	lw	a0,-24(s0)
2040168c:	01852583          	lw	a1,24(a0)
20401690:	000580e7          	jalr	a1
20401694:	fea409a3          	sb	a0,-13(s0)
20401698:	0ff57513          	andi	a0,a0,255
2040169c:	00000593          	li	a1,0
204016a0:	00b51663          	bne	a0,a1,204016ac <readln_HHAHYNO5CKM7C+0x64>
204016a4:	0040006f          	j	204016a8 <readln_HHAHYNO5CKM7C+0x60>
204016a8:	fe1ff06f          	j	20401688 <readln_HHAHYNO5CKM7C+0x40>
204016ac:	00d00513          	li	a0,13
204016b0:	ff344583          	lbu	a1,-13(s0)
204016b4:	02a59063          	bne	a1,a0,204016d4 <readln_HHAHYNO5CKM7C+0x8c>
204016b8:	0040006f          	j	204016bc <readln_HHAHYNO5CKM7C+0x74>
204016bc:	00a00593          	li	a1,10
204016c0:	fe842503          	lw	a0,-24(s0)
204016c4:	00000097          	auipc	ra,0x0
204016c8:	8ec080e7          	jalr	-1812(ra) # 20400fb0 <push_OXEQ2JVHTCRW7>
204016cc:	fea42223          	sw	a0,-28(s0)
204016d0:	03c0006f          	j	2040170c <readln_HHAHYNO5CKM7C+0xc4>
204016d4:	ff340583          	lb	a1,-13(s0)
204016d8:	fe842503          	lw	a0,-24(s0)
204016dc:	00000097          	auipc	ra,0x0
204016e0:	8d4080e7          	jalr	-1836(ra) # 20400fb0 <push_OXEQ2JVHTCRW7>
204016e4:	fea42023          	sw	a0,-32(s0)
204016e8:	0040006f          	j	204016ec <readln_HHAHYNO5CKM7C+0xa4>
204016ec:	fe842503          	lw	a0,-24(s0)
204016f0:	00852583          	lw	a1,8(a0)
204016f4:	00452603          	lw	a2,4(a0)
204016f8:	fff60613          	addi	a2,a2,-1
204016fc:	00c59663          	bne	a1,a2,20401708 <readln_HHAHYNO5CKM7C+0xc0>
20401700:	0040006f          	j	20401704 <readln_HHAHYNO5CKM7C+0xbc>
20401704:	0080006f          	j	2040170c <readln_HHAHYNO5CKM7C+0xc4>
20401708:	f71ff06f          	j	20401678 <readln_HHAHYNO5CKM7C+0x30>
2040170c:	00000513          	li	a0,0
20401710:	fe842583          	lw	a1,-24(s0)
20401714:	fca42e23          	sw	a0,-36(s0)
20401718:	00058513          	mv	a0,a1
2040171c:	fdc42583          	lw	a1,-36(s0)
20401720:	00000097          	auipc	ra,0x0
20401724:	890080e7          	jalr	-1904(ra) # 20400fb0 <push_OXEQ2JVHTCRW7>
20401728:	fe842583          	lw	a1,-24(s0)
2040172c:	0015c603          	lbu	a2,1(a1)
20401730:	00861613          	slli	a2,a2,0x8
20401734:	0005c683          	lbu	a3,0(a1)
20401738:	00d66633          	or	a2,a2,a3
2040173c:	0035c683          	lbu	a3,3(a1)
20401740:	00869693          	slli	a3,a3,0x8
20401744:	0025c703          	lbu	a4,2(a1)
20401748:	00e6e6b3          	or	a3,a3,a4
2040174c:	01069693          	slli	a3,a3,0x10
20401750:	00c6e5b3          	or	a1,a3,a2
20401754:	ff442603          	lw	a2,-12(s0)
20401758:	fca42c23          	sw	a0,-40(s0)
2040175c:	00060513          	mv	a0,a2
20401760:	fffff097          	auipc	ra,0xfffff
20401764:	1ec080e7          	jalr	492(ra) # 2040094c <cstrcpy_LBW6EUK6XUGQC>
20401768:	fe842583          	lw	a1,-24(s0)
2040176c:	fca42a23          	sw	a0,-44(s0)
20401770:	00058513          	mv	a0,a1
20401774:	fffff097          	auipc	ra,0xfffff
20401778:	620080e7          	jalr	1568(ra) # 20400d94 <clear_N46OAFLVPZDRA>
2040177c:	02812403          	lw	s0,40(sp)
20401780:	02c12083          	lw	ra,44(sp)
20401784:	03010113          	addi	sp,sp,48
20401788:	00008067          	ret

2040178c <main>:
2040178c:	c8010113          	addi	sp,sp,-896
20401790:	36112e23          	sw	ra,892(sp)
20401794:	36812c23          	sw	s0,888(sp)
20401798:	38010413          	addi	s0,sp,896
2040179c:	df440513          	addi	a0,s0,-524
204017a0:	dea42823          	sw	a0,-528(s0)
204017a4:	ef840513          	addi	a0,s0,-264
204017a8:	eea42a23          	sw	a0,-268(s0)
204017ac:	cb040513          	addi	a0,s0,-848
204017b0:	caa42623          	sw	a0,-852(s0)
204017b4:	0040006f          	j	204017b8 <main+0x2c>
204017b8:	fffff097          	auipc	ra,0xfffff
204017bc:	f08080e7          	jalr	-248(ra) # 204006c0 <configure_DJ3GWJX5RJBZ6>
204017c0:	ef442503          	lw	a0,-268(s0)
204017c4:	00000593          	li	a1,0
204017c8:	10000613          	li	a2,256
204017cc:	cab42423          	sw	a1,-856(s0)
204017d0:	cac42223          	sw	a2,-860(s0)
204017d4:	fffff097          	auipc	ra,0xfffff
204017d8:	6bc080e7          	jalr	1724(ra) # 20400e90 <create_ETYHZ52COKCHA>
204017dc:	df042603          	lw	a2,-528(s0)
204017e0:	caa42023          	sw	a0,-864(s0)
204017e4:	00060513          	mv	a0,a2
204017e8:	ca842603          	lw	a2,-856(s0)
204017ec:	c8b42e23          	sw	a1,-868(s0)
204017f0:	00060593          	mv	a1,a2
204017f4:	ca442603          	lw	a2,-860(s0)
204017f8:	fffff097          	auipc	ra,0xfffff
204017fc:	698080e7          	jalr	1688(ra) # 20400e90 <create_ETYHZ52COKCHA>
20401800:	db040613          	addi	a2,s0,-592
20401804:	c8a42c23          	sw	a0,-872(s0)
20401808:	00060513          	mv	a0,a2
2040180c:	ca042603          	lw	a2,-864(s0)
20401810:	c8b42a23          	sw	a1,-876(s0)
20401814:	00060593          	mv	a1,a2
20401818:	c9c42603          	lw	a2,-868(s0)
2040181c:	c9842683          	lw	a3,-872(s0)
20401820:	c9442703          	lw	a4,-876(s0)
20401824:	00000097          	auipc	ra,0x0
20401828:	bd8080e7          	jalr	-1064(ra) # 204013fc <create_HSPXW5ZZMOT3C>
2040182c:	dc842503          	lw	a0,-568(s0)
20401830:	dea42423          	sw	a0,-536(s0)
20401834:	dc442503          	lw	a0,-572(s0)
20401838:	dea42223          	sw	a0,-540(s0)
2040183c:	dc042503          	lw	a0,-576(s0)
20401840:	dea42023          	sw	a0,-544(s0)
20401844:	dbc42503          	lw	a0,-580(s0)
20401848:	dca42e23          	sw	a0,-548(s0)
2040184c:	db842503          	lw	a0,-584(s0)
20401850:	dca42c23          	sw	a0,-552(s0)
20401854:	db442503          	lw	a0,-588(s0)
20401858:	dca42a23          	sw	a0,-556(s0)
2040185c:	db042503          	lw	a0,-592(s0)
20401860:	dca42823          	sw	a0,-560(s0)
20401864:	20402537          	lui	a0,0x20402
20401868:	a0050593          	addi	a1,a0,-1536 # 20401a00 <main+0x274>
2040186c:	dd040513          	addi	a0,s0,-560
20401870:	c8a42823          	sw	a0,-880(s0)
20401874:	00000097          	auipc	ra,0x0
20401878:	840080e7          	jalr	-1984(ra) # 204010b4 <write_KDZ65VRPN5XHP>
2040187c:	80000537          	lui	a0,0x80000
20401880:	00852583          	lw	a1,8(a0) # 80000008 <_sp+0xffffc008>
20401884:	c9042503          	lw	a0,-880(s0)
20401888:	00000097          	auipc	ra,0x0
2040188c:	9dc080e7          	jalr	-1572(ra) # 20401264 <writeln_HH657NUKXKRAX>
20401890:	20402537          	lui	a0,0x20402
20401894:	a0d50593          	addi	a1,a0,-1523 # 20401a0d <main+0x281>
20401898:	c9042503          	lw	a0,-880(s0)
2040189c:	fffff097          	auipc	ra,0xfffff
204018a0:	7c0080e7          	jalr	1984(ra) # 2040105c <writeln_GD2KPBA3KGJZN>
204018a4:	20402537          	lui	a0,0x20402
204018a8:	a1d50593          	addi	a1,a0,-1507 # 20401a1d <main+0x291>
204018ac:	cac42503          	lw	a0,-852(s0)
204018b0:	fffff097          	auipc	ra,0xfffff
204018b4:	09c080e7          	jalr	156(ra) # 2040094c <cstrcpy_LBW6EUK6XUGQC>
204018b8:	cac42583          	lw	a1,-852(s0)
204018bc:	c8a42623          	sw	a0,-884(s0)
204018c0:	00058513          	mv	a0,a1
204018c4:	fffff097          	auipc	ra,0xfffff
204018c8:	278080e7          	jalr	632(ra) # 20400b3c <cstrrev_PD4674KVBI2WX>
204018cc:	cac42583          	lw	a1,-852(s0)
204018d0:	c9042503          	lw	a0,-880(s0)
204018d4:	fffff097          	auipc	ra,0xfffff
204018d8:	788080e7          	jalr	1928(ra) # 2040105c <writeln_GD2KPBA3KGJZN>
204018dc:	ffffd537          	lui	a0,0xffffd
204018e0:	fc750593          	addi	a1,a0,-57 # ffffcfc7 <_sp+0x7fff8fc7>
204018e4:	c9042503          	lw	a0,-880(s0)
204018e8:	00000097          	auipc	ra,0x0
204018ec:	97c080e7          	jalr	-1668(ra) # 20401264 <writeln_HH657NUKXKRAX>
204018f0:	20402537          	lui	a0,0x20402
204018f4:	a2f50593          	addi	a1,a0,-1489 # 20401a2f <main+0x2a3>
204018f8:	c9042503          	lw	a0,-880(s0)
204018fc:	fffff097          	auipc	ra,0xfffff
20401900:	760080e7          	jalr	1888(ra) # 2040105c <writeln_GD2KPBA3KGJZN>
20401904:	20402537          	lui	a0,0x20402
20401908:	a5250593          	addi	a1,a0,-1454 # 20401a52 <main+0x2c6>
2040190c:	c9042503          	lw	a0,-880(s0)
20401910:	fffff097          	auipc	ra,0xfffff
20401914:	7a4080e7          	jalr	1956(ra) # 204010b4 <write_KDZ65VRPN5XHP>
20401918:	0040006f          	j	2040191c <main+0x190>
2040191c:	fffff097          	auipc	ra,0xfffff
20401920:	e00080e7          	jalr	-512(ra) # 2040071c <read_KK223CQSKU6KE>
20401924:	0ff57513          	andi	a0,a0,255
20401928:	06e00593          	li	a1,110
2040192c:	00b50663          	beq	a0,a1,20401938 <main+0x1ac>
20401930:	0040006f          	j	20401934 <main+0x1a8>
20401934:	fe9ff06f          	j	2040191c <main+0x190>
20401938:	dd040513          	addi	a0,s0,-560
2040193c:	c8a42423          	sw	a0,-888(s0)
20401940:	00000097          	auipc	ra,0x0
20401944:	8e8080e7          	jalr	-1816(ra) # 20401228 <writeln_MTDR7HRHSHJOT>
20401948:	20402537          	lui	a0,0x20402
2040194c:	a8b50593          	addi	a1,a0,-1397 # 20401a8b <main+0x2ff>
20401950:	c8842503          	lw	a0,-888(s0)
20401954:	fffff097          	auipc	ra,0xfffff
20401958:	760080e7          	jalr	1888(ra) # 204010b4 <write_KDZ65VRPN5XHP>
2040195c:	c8842503          	lw	a0,-888(s0)
20401960:	00000097          	auipc	ra,0x0
20401964:	834080e7          	jalr	-1996(ra) # 20401194 <flush_KPZ5Y4V6SNAPI>
20401968:	cac42583          	lw	a1,-852(s0)
2040196c:	c8842503          	lw	a0,-888(s0)
20401970:	00000097          	auipc	ra,0x0
20401974:	cd8080e7          	jalr	-808(ra) # 20401648 <readln_HHAHYNO5CKM7C>
20401978:	20402537          	lui	a0,0x20402
2040197c:	a9e50593          	addi	a1,a0,-1378 # 20401a9e <main+0x312>
20401980:	c8842503          	lw	a0,-888(s0)
20401984:	fffff097          	auipc	ra,0xfffff
20401988:	730080e7          	jalr	1840(ra) # 204010b4 <write_KDZ65VRPN5XHP>
2040198c:	cac42583          	lw	a1,-852(s0)
20401990:	c8842503          	lw	a0,-888(s0)
20401994:	fffff097          	auipc	ra,0xfffff
20401998:	720080e7          	jalr	1824(ra) # 204010b4 <write_KDZ65VRPN5XHP>
2040199c:	20402537          	lui	a0,0x20402
204019a0:	aa850593          	addi	a1,a0,-1368 # 20401aa8 <main+0x31c>
204019a4:	c8842503          	lw	a0,-888(s0)
204019a8:	fffff097          	auipc	ra,0xfffff
204019ac:	6b4080e7          	jalr	1716(ra) # 2040105c <writeln_GD2KPBA3KGJZN>
204019b0:	20402537          	lui	a0,0x20402
204019b4:	aaa50593          	addi	a1,a0,-1366 # 20401aaa <main+0x31e>
204019b8:	c8842503          	lw	a0,-888(s0)
204019bc:	fffff097          	auipc	ra,0xfffff
204019c0:	6f8080e7          	jalr	1784(ra) # 204010b4 <write_KDZ65VRPN5XHP>
204019c4:	c8842503          	lw	a0,-888(s0)
204019c8:	fffff097          	auipc	ra,0xfffff
204019cc:	7cc080e7          	jalr	1996(ra) # 20401194 <flush_KPZ5Y4V6SNAPI>
204019d0:	0040006f          	j	204019d4 <main+0x248>
204019d4:	00000513          	li	a0,0
204019d8:	00051c63          	bnez	a0,204019f0 <main+0x264>
204019dc:	0040006f          	j	204019e0 <main+0x254>
204019e0:	fffff097          	auipc	ra,0xfffff
204019e4:	d9c080e7          	jalr	-612(ra) # 2040077c <read_echo_DJOHO5RF3POM2>
204019e8:	c8a42223          	sw	a0,-892(s0)
204019ec:	fe9ff06f          	j	204019d4 <main+0x248>
204019f0:	37812403          	lw	s0,888(sp)
204019f4:	37c12083          	lw	ra,892(sp)
204019f8:	38010113          	addi	sp,sp,896
204019fc:	00008067          	ret

Disassembly of section .rodata:

20401a00 <.rodata>:
20401a00:	796d                	lui	s2,0xffffb
20401a02:	675f 6f6c 6162      	0x61626f6c675f
20401a08:	206c                	fld	fa1,192(s0)
20401a0a:	203d                	jal	20401a38 <main+0x2ac>
20401a0c:	4800                	lw	s0,16(s0)
20401a0e:	6c65                	lui	s8,0x19
20401a10:	6f6c                	flw	fa1,92(a4)
20401a12:	202c                	fld	fa1,64(s0)
20401a14:	736e6f63          	bltu	t3,s6,20402152 <_data_lma+0x696>
20401a18:	2e656c6f          	jal	s8,20457cfe <_data_lma+0x56242>
20401a1c:	5400                	lw	s0,40(s0)
20401a1e:	6968                	flw	fa0,84(a0)
20401a20:	73692073          	csrs	0x736,s2
20401a24:	7220                	flw	fs0,96(a2)
20401a26:	7665                	lui	a2,0xffff9
20401a28:	7265                	lui	tp,0xffff9
20401a2a:	2e646573          	csrrsi	a0,0x2e6,8
20401a2e:	5400                	lw	s0,40(s0)
20401a30:	7079                	c.lui	zero,0xffffe
20401a32:	2065                	jal	20401ada <_data_lma+0x1e>
20401a34:	20276e27          	0x20276e27
20401a38:	6f74                	flw	fa3,92(a4)
20401a3a:	7320                	flw	fs0,96(a4)
20401a3c:	6f68                	flw	fa0,92(a4)
20401a3e:	68742077          	0x68742077
20401a42:	2065                	jal	20401aea <_data_lma+0x2e>
20401a44:	656e                	flw	fa0,216(sp)
20401a46:	7478                	flw	fa4,108(s0)
20401a48:	6d20                	flw	fs0,88(a0)
20401a4a:	7365                	lui	t1,0xffff9
20401a4c:	65676173          	csrrsi	sp,0x656,14
20401a50:	002e                	c.slli	zero,0xb
20401a52:	6874                	flw	fa3,84(s0)
20401a54:	7369                	lui	t1,0xffffa
20401a56:	7320                	flw	fs0,96(a4)
20401a58:	6f68                	flw	fa0,92(a4)
20401a5a:	6c75                	lui	s8,0x1d
20401a5c:	6e64                	flw	fs1,92(a2)
20401a5e:	73207427          	0x73207427
20401a62:	6f68                	flw	fa0,92(a4)
20401a64:	6e752077          	0x6e752077
20401a68:	6974                	flw	fa3,84(a0)
20401a6a:	206c                	fld	fa1,192(s0)
20401a6c:	6661                	lui	a2,0x18
20401a6e:	6574                	flw	fa3,76(a0)
20401a70:	2072                	fld	ft0,280(sp)
20401a72:	20276e27          	0x20276e27
20401a76:	6562                	flw	fa0,24(sp)
20401a78:	73756163          	bltu	a0,s7,2040219a <_data_lma+0x6de>
20401a7c:	2065                	jal	20401b24 <_data_lma+0x68>
20401a7e:	6220666f          	jal	a2,204080a0 <_data_lma+0x65e4>
20401a82:	6675                	lui	a2,0x1d
20401a84:	6566                	flw	fa0,88(sp)
20401a86:	6972                	flw	fs2,28(sp)
20401a88:	676e                	flw	fa4,216(sp)
20401a8a:	4700                	lw	s0,8(a4)
20401a8c:	7669                	lui	a2,0xffffa
20401a8e:	2065                	jal	20401b36 <_data_lma+0x7a>
20401a90:	656d                	lui	a0,0x1b
20401a92:	6120                	flw	fs0,64(a0)
20401a94:	7320                	flw	fs0,96(a4)
20401a96:	7274                	flw	fa3,100(a2)
20401a98:	6e69                	lui	t3,0x1a
20401a9a:	00203a67          	0x203a67
20401a9e:	6f59                	lui	t5,0x16
20401aa0:	2075                	jal	20401b4c <_data_lma+0x90>
20401aa2:	7974                	flw	fa3,116(a0)
20401aa4:	6570                	flw	fa2,76(a0)
20401aa6:	2064                	fld	fs1,192(s0)
20401aa8:	6f4e0027          	0x6f4e0027
20401aac:	63652077          	0x63652077
20401ab0:	6f68                	flw	fa0,92(a4)
20401ab2:	6e69                	lui	t3,0x1a
20401ab4:	2e2e2e67          	0x2e2e2e67
20401ab8:	0020                	addi	s0,sp,8
20401aba:	000a                	c.slli	zero,0x2

Disassembly of section .data:

80000000 <test_data>:
80000000:	00000037          	lui	zero,0x0
80000004:	0000                	unimp
	...

Disassembly of section .bss:

80000008 <__bss_start>:
80000008:	0000                	unimp
	...

Disassembly of section .stack:

80003800 <_sp-0x800>:
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	00f6                	slli	ra,ra,0x1d
   2:	0000                	unimp
   4:	0002                	c.slli64	zero
   6:	0022                	c.slli	zero,0x8
   8:	0000                	unimp
   a:	0101                	addi	sp,sp,0
   c:	000d0efb          	0xd0efb
  10:	0101                	addi	sp,sp,0
  12:	0101                	addi	sp,sp,0
  14:	0000                	unimp
  16:	0100                	addi	s0,sp,128
  18:	0000                	unimp
  1a:	6101                	0x6101
  1c:	00006d73          	csrrsi	s10,ustatus,0
  20:	72617473          	csrrci	s0,0x726,2
  24:	2e74                	fld	fa3,216(a2)
  26:	00010053          	fadd.s	ft0,ft2,ft0,rne
  2a:	0000                	unimp
  2c:	0500                	addi	s0,sp,640
  2e:	0002                	c.slli64	zero
  30:	4000                	lw	s0,0(s0)
  32:	1a20                	addi	s0,sp,312
  34:	04090103          	lb	sp,64(s2) # ffffb040 <_sp+0x7fff7040>
  38:	0100                	addi	s0,sp,128
  3a:	04090303          	lb	t1,64(s2)
  3e:	0100                	addi	s0,sp,128
  40:	04090303          	lb	t1,64(s2)
  44:	0100                	addi	s0,sp,128
  46:	04090303          	lb	t1,64(s2)
  4a:	0100                	addi	s0,sp,128
  4c:	04090103          	lb	sp,64(s2)
  50:	0100                	addi	s0,sp,128
  52:	08090303          	lb	t1,128(s2)
  56:	0100                	addi	s0,sp,128
  58:	08090103          	lb	sp,128(s2)
  5c:	0100                	addi	s0,sp,128
  5e:	08090103          	lb	sp,128(s2)
  62:	0100                	addi	s0,sp,128
  64:	08090103          	lb	sp,128(s2)
  68:	0100                	addi	s0,sp,128
  6a:	04090203          	lb	tp,64(s2)
  6e:	0100                	addi	s0,sp,128
  70:	04090103          	lb	sp,64(s2)
  74:	0100                	addi	s0,sp,128
  76:	04090103          	lb	sp,64(s2)
  7a:	0100                	addi	s0,sp,128
  7c:	04090103          	lb	sp,64(s2)
  80:	0100                	addi	s0,sp,128
  82:	04090103          	lb	sp,64(s2)
  86:	0100                	addi	s0,sp,128
  88:	04090603          	lb	a2,64(s2)
  8c:	0100                	addi	s0,sp,128
  8e:	08090103          	lb	sp,128(s2)
  92:	0100                	addi	s0,sp,128
  94:	04090103          	lb	sp,64(s2)
  98:	0100                	addi	s0,sp,128
  9a:	04090203          	lb	tp,64(s2)
  9e:	0100                	addi	s0,sp,128
  a0:	04090103          	lb	sp,64(s2)
  a4:	0100                	addi	s0,sp,128
  a6:	04090103          	lb	sp,64(s2)
  aa:	0100                	addi	s0,sp,128
  ac:	04090203          	lb	tp,64(s2)
  b0:	0100                	addi	s0,sp,128
  b2:	04090103          	lb	sp,64(s2)
  b6:	0100                	addi	s0,sp,128
  b8:	04090103          	lb	sp,64(s2)
  bc:	0100                	addi	s0,sp,128
  be:	04090103          	lb	sp,64(s2)
  c2:	0100                	addi	s0,sp,128
  c4:	04090103          	lb	sp,64(s2)
  c8:	0100                	addi	s0,sp,128
  ca:	04090503          	lb	a0,64(s2)
  ce:	0100                	addi	s0,sp,128
  d0:	08090103          	lb	sp,128(s2)
  d4:	0100                	addi	s0,sp,128
  d6:	04090203          	lb	tp,64(s2)
  da:	0100                	addi	s0,sp,128
  dc:	08090103          	lb	sp,128(s2)
  e0:	0100                	addi	s0,sp,128
  e2:	04090103          	lb	sp,64(s2)
  e6:	0100                	addi	s0,sp,128
  e8:	04090503          	lb	a0,64(s2)
  ec:	0100                	addi	s0,sp,128
  ee:	04090103          	lb	sp,64(s2)
  f2:	0100                	addi	s0,sp,128
  f4:	0409                	addi	s0,s0,2
  f6:	0000                	unimp
  f8:	0101                	addi	sp,sp,0

Disassembly of section .debug_info:

00000000 <.debug_info>:
   0:	0022                	c.slli	zero,0x8
   2:	0000                	unimp
   4:	0002                	c.slli64	zero
   6:	0000                	unimp
   8:	0000                	unimp
   a:	0104                	addi	s1,sp,128
   c:	0000                	unimp
   e:	0000                	unimp
  10:	0000                	unimp
  12:	2040                	fld	fs0,128(s0)
  14:	00a0                	addi	s0,sp,72
  16:	2040                	fld	fs0,128(s0)
  18:	0000                	unimp
  1a:	0000                	unimp
  1c:	000c                	0xc
  1e:	0000                	unimp
  20:	001f 0000 8001      	0x80010000001f

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	1101                	addi	sp,sp,-32
   2:	1000                	addi	s0,sp,32
   4:	1106                	slli	sp,sp,0x21
   6:	1201                	addi	tp,tp,-32
   8:	0301                	addi	t1,t1,0
   a:	1b0e                	slli	s6,s6,0x23
   c:	250e                	fld	fa0,192(sp)
   e:	130e                	slli	t1,t1,0x23
  10:	0005                	c.nop	1
	...

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	001c                	0x1c
   2:	0000                	unimp
   4:	0002                	c.slli64	zero
   6:	0000                	unimp
   8:	0000                	unimp
   a:	0004                	0x4
   c:	0000                	unimp
   e:	0000                	unimp
  10:	0000                	unimp
  12:	2040                	fld	fs0,128(s0)
  14:	00a0                	addi	s0,sp,72
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
   0:	7361                	lui	t1,0xffff8
   2:	2f6d                	jal	7bc <__stack_size-0x44>
   4:	72617473          	csrrci	s0,0x726,2
   8:	2e74                	fld	fa3,216(a2)
   a:	682f0053          	0x682f0053
   e:	2f656d6f          	jal	s10,56304 <__stack_size+0x55b04>
  12:	7672                	flw	fa2,60(sp)
  14:	6d2f736f          	jal	t1,f76e6 <__stack_size+0xf6ee6>
  18:	6e69736f          	jal	t1,976fe <__stack_size+0x96efe>
  1c:	4700534f          	fnmadd.q	ft6,ft0,fa6,fs0,unknown
  20:	554e                	lw	a0,240(sp)
  22:	4120                	lw	s0,64(a0)
  24:	2e322053          	0x2e322053
  28:	352e3133          	0x352e3133
  2c:	0031                	c.nop	12
