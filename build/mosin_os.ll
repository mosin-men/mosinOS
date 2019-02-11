; ModuleID = 'mosin_os'
source_filename = "mosin_os"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32-unknown-elf"

%console_K4FSINRP7ZUJF = type { %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ, i8 ()* }
%Vec_KNHG265OPCHFQ = type { i8*, i32, i32 }
%__bjou_slice_JVNSS5TRDTEIV = type { i8*, i64 }

@__con_ibuff_ON3VVF3L25G5R = internal global i8* getelementptr inbounds ([256 x i8], [256 x i8]* @__bjou_array_under___con_ibuff_ON3VVF3L25G5R, i32 0, i32 0), align 4
@__bjou_array_under___con_ibuff_ON3VVF3L25G5R = internal global [256 x i8] zeroinitializer, align 1
@__con_obuff_ON3VVF3LYU6VX = internal global i8* getelementptr inbounds ([256 x i8], [256 x i8]* @__bjou_array_under___con_obuff_ON3VVF3LYU6VX, i32 0, i32 0), align 4
@__bjou_array_under___con_obuff_ON3VVF3LYU6VX = internal global [256 x i8] zeroinitializer, align 1
@__con_PPMTR3AQIQRJQ = internal global %console_K4FSINRP7ZUJF zeroinitializer, align 1
@my_global_G53NF4TM2Q3F = internal global i32 0, align 4

define i8* @mcopy_FZTR4MQEMZNB6(i8* %dst_FYOH5G, i8* %src_FYPDIH, i64 %nbytes_GKJRHE5WS) #0 {
mcopy_FZTR4MQEMZNB6_entry:
  %dst_FYOH5G1 = alloca i8*, align 4
  %src_FYPDIH2 = alloca i8*, align 4
  %nbytes_GKJRHE5WS3 = alloca i64, align 8
  %ncopied_GQT2ZHEBU7 = alloca i64, align 8
  %ldp_FYOQC5 = alloca i64*, align 4
  %lsp_FYOQNK = alloca i64*, align 4
  %bdp_FYOR2T = alloca i8*, align 4
  %bsp_FYOSJE = alloca i8*, align 4
  br label %mcopy_FZTR4MQEMZNB6_begin

mcopy_FZTR4MQEMZNB6_begin:                        ; preds = %mcopy_FZTR4MQEMZNB6_entry
  store i8* %dst_FYOH5G, i8** %dst_FYOH5G1
  store i8* %src_FYPDIH, i8** %src_FYPDIH2
  store i64 %nbytes_GKJRHE5WS, i64* %nbytes_GKJRHE5WS3
  store i64 0, i64* %ncopied_GQT2ZHEBU7
  %dst = load i8*, i8** %dst_FYOH5G1, align 4
  %0 = bitcast i8* %dst to i64*
  store i64* %0, i64** %ldp_FYOQC5
  %src = load i8*, i8** %src_FYPDIH2, align 4
  %1 = bitcast i8* %src to i64*
  store i64* %1, i64** %lsp_FYOQNK
  br label %whilecheckcond

whilecheckcond:                                   ; preds = %then, %mcopy_FZTR4MQEMZNB6_begin
  %nbytes = load i64, i64* %nbytes_GKJRHE5WS3
  %ncopied = load i64, i64* %ncopied_GQT2ZHEBU7
  %2 = sub i64 %nbytes, %ncopied
  %3 = icmp ugt i64 %2, 8
  %whilecond = icmp eq i1 %3, true
  br i1 %whilecond, label %then, label %merge

then:                                             ; preds = %whilecheckcond
  %ldp = load i64*, i64** %ldp_FYOQC5, align 4
  %lsp = load i64*, i64** %lsp_FYOQNK, align 4
  %deref = load i64, i64* %lsp
  store i64 %deref, i64* %ldp
  %assign_load = load i64, i64* %ldp
  %ldp4 = load i64*, i64** %ldp_FYOQC5, align 4
  %4 = getelementptr inbounds i64, i64* %ldp4, i32 1
  store i64* %4, i64** %ldp_FYOQC5
  %lsp5 = load i64*, i64** %lsp_FYOQNK, align 4
  %5 = getelementptr inbounds i64, i64* %lsp5, i32 1
  store i64* %5, i64** %lsp_FYOQNK
  %ncopied6 = load i64, i64* %ncopied_GQT2ZHEBU7
  %6 = add i64 %ncopied6, 8
  store i64 %6, i64* %ncopied_GQT2ZHEBU7
  br label %whilecheckcond

merge:                                            ; preds = %whilecheckcond
  %ldp7 = load i64*, i64** %ldp_FYOQC5, align 4
  %7 = bitcast i64* %ldp7 to i8*
  store i8* %7, i8** %bdp_FYOR2T
  %lsp8 = load i64*, i64** %lsp_FYOQNK, align 4
  %8 = bitcast i64* %lsp8 to i8*
  store i8* %8, i8** %bsp_FYOSJE
  br label %forcheckcond

forcheckcond:                                     ; preds = %after, %merge
  %ncopied9 = load i64, i64* %ncopied_GQT2ZHEBU7
  %nbytes10 = load i64, i64* %nbytes_GKJRHE5WS3
  %9 = icmp ult i64 %ncopied9, %nbytes10
  %forcond = icmp eq i1 %9, true
  br i1 %forcond, label %then11, label %merge17

then11:                                           ; preds = %forcheckcond
  %bdp = load i8*, i8** %bdp_FYOR2T, align 4
  %bsp = load i8*, i8** %bsp_FYOSJE, align 4
  %deref12 = load i8, i8* %bsp
  store i8 %deref12, i8* %bdp
  %assign_load13 = load i8, i8* %bdp
  %bdp14 = load i8*, i8** %bdp_FYOR2T, align 4
  %10 = getelementptr inbounds i8, i8* %bdp14, i32 1
  store i8* %10, i8** %bdp_FYOR2T
  %bsp15 = load i8*, i8** %bsp_FYOSJE, align 4
  %11 = getelementptr inbounds i8, i8* %bsp15, i32 1
  store i8* %11, i8** %bsp_FYOSJE
  br label %after

after:                                            ; preds = %then11
  %ncopied16 = load i64, i64* %ncopied_GQT2ZHEBU7
  %12 = add i64 %ncopied16, 1
  store i64 %12, i64* %ncopied_GQT2ZHEBU7
  br label %forcheckcond

merge17:                                          ; preds = %forcheckcond
  %dst18 = load i8*, i8** %dst_FYOH5G1, align 4
  ret i8* %dst18
}

define i8* @mset_DDVWFSR6I7FQK(i8* %dst_FYOH5G, i8 %val_FYO6X6, i64 %nbytes_GKJRHE5WS) #0 {
mset_DDVWFSR6I7FQK_entry:
  %dst_FYOH5G1 = alloca i8*, align 4
  %val_FYO6X62 = alloca i8, align 1
  %nbytes_GKJRHE5WS3 = alloca i64, align 8
  %nset_F6HFINJ = alloca i64, align 8
  %ldp_FYOQC5 = alloca i64*, align 4
  %four_F6G4LVL = alloca [8 x i8], align 1
  %0 = alloca i8*
  %1 = getelementptr inbounds [8 x i8], [8 x i8]* %four_F6G4LVL, i32 0, i32 0
  store i8* %1, i8** %0
  %four_p_GKJILJDVE = alloca i64*, align 4
  %i_FNOM = alloca i32, align 4
  %bdp_FYOR2T = alloca i8*, align 4
  br label %mset_DDVWFSR6I7FQK_begin

mset_DDVWFSR6I7FQK_begin:                         ; preds = %mset_DDVWFSR6I7FQK_entry
  store i8* %dst_FYOH5G, i8** %dst_FYOH5G1
  store i8 %val_FYO6X6, i8* %val_FYO6X62
  store i64 %nbytes_GKJRHE5WS, i64* %nbytes_GKJRHE5WS3
  store i64 0, i64* %nset_F6HFINJ
  %dst = load i8*, i8** %dst_FYOH5G1, align 4
  %2 = bitcast i8* %dst to i64*
  store i64* %2, i64** %ldp_FYOQC5
  %3 = bitcast i8** %0 to i64*
  store i64* %3, i64** %four_p_GKJILJDVE
  store i32 0, i32* %i_FNOM
  br label %forcheckcond

forcheckcond:                                     ; preds = %after, %mset_DDVWFSR6I7FQK_begin
  %i = load i32, i32* %i_FNOM
  %4 = sext i32 %i to i64
  %5 = icmp slt i64 %4, 8
  %forcond = icmp eq i1 %5, true
  br i1 %forcond, label %then, label %merge

then:                                             ; preds = %forcheckcond
  %i4 = load i32, i32* %i_FNOM
  %four = load i8*, i8** %0
  %6 = getelementptr inbounds i8, i8* %four, i32 %i4
  %val = load i8, i8* %val_FYO6X62
  store i8 %val, i8* %6
  %assign_load = load i8, i8* %6
  br label %after

after:                                            ; preds = %then
  %i5 = load i32, i32* %i_FNOM
  %7 = add i32 %i5, 1
  store i32 %7, i32* %i_FNOM
  br label %forcheckcond

merge:                                            ; preds = %forcheckcond
  br label %whilecheckcond

whilecheckcond:                                   ; preds = %then6, %merge
  %nbytes = load i64, i64* %nbytes_GKJRHE5WS3
  %nset = load i64, i64* %nset_F6HFINJ
  %8 = sub i64 %nbytes, %nset
  %9 = icmp ugt i64 %8, 8
  %whilecond = icmp eq i1 %9, true
  br i1 %whilecond, label %then6, label %merge10

then6:                                            ; preds = %whilecheckcond
  %ldp = load i64*, i64** %ldp_FYOQC5, align 4
  %four_p = load i64*, i64** %four_p_GKJILJDVE, align 4
  %deref = load i64, i64* %four_p
  store i64 %deref, i64* %ldp
  %assign_load7 = load i64, i64* %ldp
  %ldp8 = load i64*, i64** %ldp_FYOQC5, align 4
  %10 = getelementptr inbounds i64, i64* %ldp8, i32 1
  store i64* %10, i64** %ldp_FYOQC5
  %nset9 = load i64, i64* %nset_F6HFINJ
  %11 = add i64 %nset9, 8
  store i64 %11, i64* %nset_F6HFINJ
  br label %whilecheckcond

merge10:                                          ; preds = %whilecheckcond
  %ldp11 = load i64*, i64** %ldp_FYOQC5, align 4
  %12 = bitcast i64* %ldp11 to i8*
  store i8* %12, i8** %bdp_FYOR2T
  br label %forcheckcond12

forcheckcond12:                                   ; preds = %after20, %merge10
  %nset13 = load i64, i64* %nset_F6HFINJ
  %nbytes14 = load i64, i64* %nbytes_GKJRHE5WS3
  %13 = icmp ult i64 %nset13, %nbytes14
  %forcond15 = icmp eq i1 %13, true
  br i1 %forcond15, label %then16, label %merge22

then16:                                           ; preds = %forcheckcond12
  %bdp = load i8*, i8** %bdp_FYOR2T, align 4
  %val17 = load i8, i8* %val_FYO6X62
  store i8 %val17, i8* %bdp
  %assign_load18 = load i8, i8* %bdp
  %bdp19 = load i8*, i8** %bdp_FYOR2T, align 4
  %14 = getelementptr inbounds i8, i8* %bdp19, i32 1
  store i8* %14, i8** %bdp_FYOR2T
  br label %after20

after20:                                          ; preds = %then16
  %nset21 = load i64, i64* %nset_F6HFINJ
  %15 = add i64 %nset21, 1
  store i64 %15, i64* %nset_F6HFINJ
  br label %forcheckcond12

merge22:                                          ; preds = %forcheckcond12
  %dst23 = load i8*, i8** %dst_FYOH5G1, align 4
  ret i8* %dst23

; uselistorder directives
  uselistorder i64 8, { 2, 3, 4, 0, 1 }
}

define i8* @memcpy(i8* %dst_FYOH5G, i8* %src_FYPDIH, i64 %nbytes_GKJRHE5WS) #0 {
memcpy_entry:
  %dst_FYOH5G1 = alloca i8*, align 4
  %src_FYPDIH2 = alloca i8*, align 4
  %nbytes_GKJRHE5WS3 = alloca i64, align 8
  br label %memcpy_begin

memcpy_begin:                                     ; preds = %memcpy_entry
  store i8* %dst_FYOH5G, i8** %dst_FYOH5G1
  store i8* %src_FYPDIH, i8** %src_FYPDIH2
  store i64 %nbytes_GKJRHE5WS, i64* %nbytes_GKJRHE5WS3
  %dst = load i8*, i8** %dst_FYOH5G1, align 4
  %src = load i8*, i8** %src_FYPDIH2, align 4
  %nbytes = load i64, i64* %nbytes_GKJRHE5WS3
  %0 = call i8* @mcopy_FZTR4MQEMZNB6(i8* %dst, i8* %src, i64 %nbytes)
  ret i8* %0
}

define i8* @memset(i8* %dst_FYOH5G, i8 %val_FYO6X6, i64 %nbytes_GKJRHE5WS) #0 {
memset_entry:
  %dst_FYOH5G1 = alloca i8*, align 4
  %val_FYO6X62 = alloca i8, align 1
  %nbytes_GKJRHE5WS3 = alloca i64, align 8
  br label %memset_begin

memset_begin:                                     ; preds = %memset_entry
  store i8* %dst_FYOH5G, i8** %dst_FYOH5G1
  store i8 %val_FYO6X6, i8* %val_FYO6X62
  store i64 %nbytes_GKJRHE5WS, i64* %nbytes_GKJRHE5WS3
  %dst = load i8*, i8** %dst_FYOH5G1, align 4
  %val = load i8, i8* %val_FYO6X62
  %nbytes = load i64, i64* %nbytes_GKJRHE5WS3
  %0 = call i8* @mset_DDVWFSR6I7FQK(i8* %dst, i8 %val, i64 %nbytes)
  ret i8* %0
}

define i32 @i32mul(i32 %a_FNOE, i32 %b_FNOH) #0 {
i32mul_entry:
  %a_FNOE1 = alloca i32, align 4
  %b_FNOH2 = alloca i32, align 4
  %sum_FYPDJO = alloca i32, align 4
  %i_FNOM = alloca i32, align 4
  br label %i32mul_begin

i32mul_begin:                                     ; preds = %i32mul_entry
  store i32 %a_FNOE, i32* %a_FNOE1
  store i32 %b_FNOH, i32* %b_FNOH2
  store i32 0, i32* %sum_FYPDJO
  store i32 0, i32* %i_FNOM
  br label %forcheckcond

forcheckcond:                                     ; preds = %after, %i32mul_begin
  %i = load i32, i32* %i_FNOM
  %b = load i32, i32* %b_FNOH2
  %0 = icmp slt i32 %i, %b
  %forcond = icmp eq i1 %0, true
  br i1 %forcond, label %then, label %merge

then:                                             ; preds = %forcheckcond
  %sum = load i32, i32* %sum_FYPDJO
  %a = load i32, i32* %a_FNOE1
  %1 = add i32 %sum, %a
  store i32 %1, i32* %sum_FYPDJO
  br label %after

after:                                            ; preds = %then
  %i3 = load i32, i32* %i_FNOM
  %2 = add i32 %i3, 1
  store i32 %2, i32* %i_FNOM
  br label %forcheckcond

merge:                                            ; preds = %forcheckcond
  %sum4 = load i32, i32* %sum_FYPDJO
  ret i32 %sum4
}

define i32 @i32div(i32 %a_FNOE, i32 %b_FNOH) #0 {
i32div_entry:
  %a_FNOE1 = alloca i32, align 4
  %b_FNOH2 = alloca i32, align 4
  %result_GKJ7JNOLM = alloca i32, align 4
  br label %i32div_begin

i32div_begin:                                     ; preds = %i32div_entry
  store i32 %a_FNOE, i32* %a_FNOE1
  store i32 %b_FNOH, i32* %b_FNOH2
  store i32 0, i32* %result_GKJ7JNOLM
  br label %whilecheckcond

whilecheckcond:                                   ; preds = %then4, %i32div_begin
  %a = load i32, i32* %a_FNOE1
  %0 = icmp sgt i32 %a, 0
  %lhs_cond = icmp eq i1 %0, true
  br i1 %lhs_cond, label %then, label %mergephi

then:                                             ; preds = %whilecheckcond
  %a3 = load i32, i32* %a_FNOE1
  %b = load i32, i32* %b_FNOH2
  %1 = icmp sge i32 %a3, %b
  %rhs_cond = icmp eq i1 %1, true
  br i1 %rhs_cond, label %mergephi, label %condfalse

condfalse:                                        ; preds = %then
  br label %mergephi

mergephi:                                         ; preds = %condfalse, %then, %whilecheckcond
  %lazyphi = phi i1 [ false, %whilecheckcond ], [ true, %then ], [ false, %condfalse ]
  %whilecond = icmp eq i1 %lazyphi, true
  br i1 %whilecond, label %then4, label %merge

then4:                                            ; preds = %mergephi
  %a5 = load i32, i32* %a_FNOE1
  %b6 = load i32, i32* %b_FNOH2
  %2 = sub i32 %a5, %b6
  store i32 %2, i32* %a_FNOE1
  %result = load i32, i32* %result_GKJ7JNOLM
  %3 = add i32 %result, 1
  store i32 %3, i32* %result_GKJ7JNOLM
  br label %whilecheckcond

merge:                                            ; preds = %mergephi
  %result7 = load i32, i32* %result_GKJ7JNOLM
  ret i32 %result7
}

define i32 @i32mod(i32 %a_FNOE, i32 %b_FNOH) #0 {
i32mod_entry:
  %a_FNOE1 = alloca i32, align 4
  %b_FNOH2 = alloca i32, align 4
  br label %i32mod_begin

i32mod_begin:                                     ; preds = %i32mod_entry
  store i32 %a_FNOE, i32* %a_FNOE1
  store i32 %b_FNOH, i32* %b_FNOH2
  %a = load i32, i32* %a_FNOE1
  %b = load i32, i32* %b_FNOH2
  %a3 = load i32, i32* %a_FNOE1
  %b4 = load i32, i32* %b_FNOH2
  %0 = call i32 @i32div(i32 %a3, i32 %b4)
  %1 = call i32 @i32mul(i32 %b, i32 %0)
  %2 = sub i32 %a, %1
  ret i32 %2
}

define void @configure_DJ3GWJX5RJBZ6() #0 {
configure_DJ3GWJX5RJBZ6_entry:
  %mem_FYORBA = alloca i32*, align 4
  %txreg_GEFOGCDZ = alloca i32, align 4
  %rxreg_GEFZLKL7 = alloca i32, align 4
  br label %configure_DJ3GWJX5RJBZ6_begin

configure_DJ3GWJX5RJBZ6_begin:                    ; preds = %configure_DJ3GWJX5RJBZ6_entry
  store i32* inttoptr (i32 268513280 to i32*), i32** %mem_FYORBA
  store i32 0, i32* %txreg_GEFOGCDZ
  %txreg = load i32, i32* %txreg_GEFOGCDZ
  %0 = or i32 %txreg, -2147483648
  store i32 %0, i32* %txreg_GEFOGCDZ
  %assign_load = load i32, i32* %txreg_GEFOGCDZ
  %txreg1 = load i32, i32* %txreg_GEFOGCDZ
  %1 = or i32 %txreg1, 1073741824
  store i32 %1, i32* %txreg_GEFOGCDZ
  %assign_load2 = load i32, i32* %txreg_GEFOGCDZ
  store i32 0, i32* %rxreg_GEFZLKL7
  %rxreg = load i32, i32* %rxreg_GEFZLKL7
  %2 = or i32 %rxreg, -2147483648
  store i32 %2, i32* %rxreg_GEFZLKL7
  %assign_load3 = load i32, i32* %rxreg_GEFZLKL7
  %mem = load i32*, i32** %mem_FYORBA, align 4
  %3 = getelementptr inbounds i32, i32* %mem, i32 6
  store volatile i32 563, i32* %3
  %assign_load4 = load i32, i32* %3
  %mem5 = load i32*, i32** %mem_FYORBA, align 4
  %4 = getelementptr inbounds i32, i32* %mem5, i32 2
  %txreg6 = load i32, i32* %txreg_GEFOGCDZ
  store volatile i32 %txreg6, i32* %4
  %assign_load7 = load i32, i32* %4
  %mem8 = load i32*, i32** %mem_FYORBA, align 4
  %5 = getelementptr inbounds i32, i32* %mem8, i32 3
  %rxreg9 = load i32, i32* %rxreg_GEFZLKL7
  store volatile i32 %rxreg9, i32* %5
  %assign_load10 = load i32, i32* %5
  ret void
}

define i8 @read_KK223CQSKU6KE() #0 {
read_KK223CQSKU6KE_entry:
  %mem_FYORBA = alloca i32*, align 4
  %val_FYO6X6 = alloca i32, align 4
  br label %read_KK223CQSKU6KE_begin

read_KK223CQSKU6KE_begin:                         ; preds = %read_KK223CQSKU6KE_entry
  store i32* inttoptr (i32 268513280 to i32*), i32** %mem_FYORBA
  %mem = load i32*, i32** %mem_FYORBA, align 4
  %0 = getelementptr inbounds i32, i32* %mem, i32 1
  %deref = load volatile i32, i32* %0
  store i32 %deref, i32* %val_FYO6X6
  %val = load i32, i32* %val_FYO6X6
  %1 = and i32 %val, -2147483648
  %2 = icmp ne i32 %1, 0
  %ifcond = icmp eq i1 %2, true
  br i1 %ifcond, label %then, label %else

then:                                             ; preds = %read_KK223CQSKU6KE_begin
  ret i8 0

else:                                             ; preds = %read_KK223CQSKU6KE_begin
  %val1 = load i32, i32* %val_FYO6X6
  %3 = trunc i32 %val1 to i8
  ret i8 %3
}

define i8 @read_echo_DJOHO5RF3POM2() #0 {
read_echo_DJOHO5RF3POM2_entry:
  %c_FNOG = alloca i8, align 1
  br label %read_echo_DJOHO5RF3POM2_begin

read_echo_DJOHO5RF3POM2_begin:                    ; preds = %read_echo_DJOHO5RF3POM2_entry
  %0 = call i8 @read_KK223CQSKU6KE()
  store i8 %0, i8* %c_FNOG
  %c = load i8, i8* %c_FNOG
  %1 = icmp eq i8 %c, 13
  %ifcond = icmp eq i1 %1, true
  br i1 %ifcond, label %then, label %else

then:                                             ; preds = %read_echo_DJOHO5RF3POM2_begin
  call void @write_DJAR2NJT5Z6LT(i8 10)
  br label %merge

else:                                             ; preds = %read_echo_DJOHO5RF3POM2_begin
  %c1 = load i8, i8* %c_FNOG
  call void @write_DJAR2NJT5Z6LT(i8 %c1)
  br label %merge

merge:                                            ; preds = %else, %then
  %c2 = load i8, i8* %c_FNOG
  ret i8 %c2
}

define void @write_DJAR2NJT5Z6LT(i8 %out_FYOXZL) #0 {
write_DJAR2NJT5Z6LT_entry:
  %out_FYOXZL1 = alloca i8, align 1
  %mem_FYORBA = alloca i32*, align 4
  %fifo_full_G53JMILON2XP = alloca i32, align 4
  br label %write_DJAR2NJT5Z6LT_begin

write_DJAR2NJT5Z6LT_begin:                        ; preds = %write_DJAR2NJT5Z6LT_entry
  store i8 %out_FYOXZL, i8* %out_FYOXZL1
  store i32* inttoptr (i32 268513280 to i32*), i32** %mem_FYORBA
  br label %whilecheckcond

whilecheckcond:                                   ; preds = %merge, %write_DJAR2NJT5Z6LT_begin
  br i1 true, label %then, label %merge3

then:                                             ; preds = %whilecheckcond
  %mem = load i32*, i32** %mem_FYORBA, align 4
  %0 = getelementptr inbounds i32, i32* %mem, i32 0
  %deref = load volatile i32, i32* %0
  store i32 %deref, i32* %fifo_full_G53JMILON2XP
  %fifo_full = load i32, i32* %fifo_full_G53JMILON2XP
  %1 = and i32 %fifo_full, -2147483648
  %2 = icmp eq i32 %1, 0
  %ifcond = icmp eq i1 %2, true
  br i1 %ifcond, label %then2, label %merge

then2:                                            ; preds = %then
  br label %merge3

merge:                                            ; preds = %then
  br label %whilecheckcond

merge3:                                           ; preds = %then2, %whilecheckcond
  %mem4 = load i32*, i32** %mem_FYORBA, align 4
  %3 = getelementptr inbounds i32, i32* %mem4, i32 0
  %out = load i8, i8* %out_FYOXZL1
  %4 = zext i8 %out to i32
  store volatile i32 %4, i32* %3
  %assign_load = load i32, i32* %3
  ret void
}

define void @write_string_LNEGVSSIZZ6RT(i8* %s_FNOW) #0 {
write_string_LNEGVSSIZZ6RT_entry:
  %s_FNOW1 = alloca i8*, align 4
  br label %write_string_LNEGVSSIZZ6RT_begin

write_string_LNEGVSSIZZ6RT_begin:                 ; preds = %write_string_LNEGVSSIZZ6RT_entry
  store i8* %s_FNOW, i8** %s_FNOW1
  br label %whilecheckcond

whilecheckcond:                                   ; preds = %then, %write_string_LNEGVSSIZZ6RT_begin
  %s = load i8*, i8** %s_FNOW1, align 4
  %deref = load i8, i8* %s
  %0 = icmp ne i8 %deref, 0
  %whilecond = icmp eq i1 %0, true
  br i1 %whilecond, label %then, label %merge

then:                                             ; preds = %whilecheckcond
  %s2 = load i8*, i8** %s_FNOW1, align 4
  %deref3 = load i8, i8* %s2
  call void @write_DJAR2NJT5Z6LT(i8 %deref3)
  %s4 = load i8*, i8** %s_FNOW1, align 4
  %1 = getelementptr inbounds i8, i8* %s4, i32 1
  store i8* %1, i8** %s_FNOW1
  br label %whilecheckcond

merge:                                            ; preds = %whilecheckcond
  ret void
}

define i64 @cstrlen_PD4HXS525IJAR(i8* %s_FNOW) #0 {
cstrlen_PD4HXS525IJAR_entry:
  %s_FNOW1 = alloca i8*, align 4
  %len_FYOQDC = alloca i64, align 8
  br label %cstrlen_PD4HXS525IJAR_begin

cstrlen_PD4HXS525IJAR_begin:                      ; preds = %cstrlen_PD4HXS525IJAR_entry
  store i8* %s_FNOW, i8** %s_FNOW1
  store i64 0, i64* %len_FYOQDC
  br label %whilecheckcond

whilecheckcond:                                   ; preds = %then, %cstrlen_PD4HXS525IJAR_begin
  %s = load i8*, i8** %s_FNOW1, align 4
  %deref = load i8, i8* %s
  %0 = icmp ne i8 %deref, 0
  %whilecond = icmp eq i1 %0, true
  br i1 %whilecond, label %then, label %merge

then:                                             ; preds = %whilecheckcond
  %s2 = load i8*, i8** %s_FNOW1, align 4
  %1 = getelementptr inbounds i8, i8* %s2, i32 1
  store i8* %1, i8** %s_FNOW1
  %len = load i64, i64* %len_FYOQDC
  %2 = add i64 %len, 1
  store i64 %2, i64* %len_FYOQDC
  br label %whilecheckcond

merge:                                            ; preds = %whilecheckcond
  %len3 = load i64, i64* %len_FYOQDC
  ret i64 %len3
}

define i8* @cstrcpy_LBW6EUK6XUGQC(i8* %dst_FYOH5G, i8* %src_FYPDIH) #0 {
cstrcpy_LBW6EUK6XUGQC_entry:
  %dst_FYOH5G1 = alloca i8*, align 4
  %src_FYPDIH2 = alloca i8*, align 4
  %len_FYOQDC = alloca i64, align 8
  br label %cstrcpy_LBW6EUK6XUGQC_begin

cstrcpy_LBW6EUK6XUGQC_begin:                      ; preds = %cstrcpy_LBW6EUK6XUGQC_entry
  store i8* %dst_FYOH5G, i8** %dst_FYOH5G1
  store i8* %src_FYPDIH, i8** %src_FYPDIH2
  %src = load i8*, i8** %src_FYPDIH2, align 4
  %0 = call i64 @cstrlen_PD4HXS525IJAR(i8* %src)
  store i64 %0, i64* %len_FYOQDC
  %len = load i64, i64* %len_FYOQDC
  %1 = add i64 %len, 1
  store i64 %1, i64* %len_FYOQDC
  %dst = load i8*, i8** %dst_FYOH5G1, align 4
  %src3 = load i8*, i8** %src_FYPDIH2, align 4
  %len4 = load i64, i64* %len_FYOQDC
  %2 = call i8* @mcopy_FZTR4MQEMZNB6(i8* %dst, i8* %src3, i64 %len4)
  %dst5 = load i8*, i8** %dst_FYOH5G1, align 4
  ret i8* %dst5

; uselistorder directives
  uselistorder i64 1, { 0, 1, 3, 2 }
}

define i32 @cstrcmp_DWKSER2MYA2XW(i8* %s1_FS4FH, i8* %s2_FS4FE) #0 {
cstrcmp_DWKSER2MYA2XW_entry:
  %s1_FS4FH1 = alloca i8*, align 4
  %s2_FS4FE2 = alloca i8*, align 4
  br label %cstrcmp_DWKSER2MYA2XW_begin

cstrcmp_DWKSER2MYA2XW_begin:                      ; preds = %cstrcmp_DWKSER2MYA2XW_entry
  store i8* %s1_FS4FH, i8** %s1_FS4FH1
  store i8* %s2_FS4FE, i8** %s2_FS4FE2
  br label %whilecheckcond

whilecheckcond:                                   ; preds = %then6, %cstrcmp_DWKSER2MYA2XW_begin
  %s1 = load i8*, i8** %s1_FS4FH1, align 4
  %deref = load i8, i8* %s1
  %0 = icmp ne i8 %deref, 0
  %lhs_cond = icmp eq i1 %0, true
  br i1 %lhs_cond, label %then, label %mergephi

then:                                             ; preds = %whilecheckcond
  %s13 = load i8*, i8** %s1_FS4FH1, align 4
  %deref4 = load i8, i8* %s13
  %s2 = load i8*, i8** %s2_FS4FE2, align 4
  %deref5 = load i8, i8* %s2
  %1 = icmp eq i8 %deref4, %deref5
  %rhs_cond = icmp eq i1 %1, true
  br i1 %rhs_cond, label %mergephi, label %condfalse

condfalse:                                        ; preds = %then
  br label %mergephi

mergephi:                                         ; preds = %condfalse, %then, %whilecheckcond
  %lazyphi = phi i1 [ false, %whilecheckcond ], [ true, %then ], [ false, %condfalse ]
  %whilecond = icmp eq i1 %lazyphi, true
  br i1 %whilecond, label %then6, label %merge

then6:                                            ; preds = %mergephi
  %s17 = load i8*, i8** %s1_FS4FH1, align 4
  %2 = getelementptr inbounds i8, i8* %s17, i32 1
  store i8* %2, i8** %s1_FS4FH1
  %s28 = load i8*, i8** %s2_FS4FE2, align 4
  %3 = getelementptr inbounds i8, i8* %s28, i32 1
  store i8* %3, i8** %s2_FS4FE2
  br label %whilecheckcond

merge:                                            ; preds = %mergephi
  %s19 = load i8*, i8** %s1_FS4FH1, align 4
  %deref10 = load i8, i8* %s19
  %s211 = load i8*, i8** %s2_FS4FE2, align 4
  %deref12 = load i8, i8* %s211
  %4 = sub i8 %deref10, %deref12
  %5 = sext i8 %4 to i32
  ret i32 %5
}

define i8* @cstrcat_OFU2YEECSOKD6(i8* %dst_FYOH5G, i8* %src_FYPDIH) #0 {
cstrcat_OFU2YEECSOKD6_entry:
  %dst_FYOH5G1 = alloca i8*, align 4
  %src_FYPDIH2 = alloca i8*, align 4
  %p_FNOV = alloca i8*, align 4
  br label %cstrcat_OFU2YEECSOKD6_begin

cstrcat_OFU2YEECSOKD6_begin:                      ; preds = %cstrcat_OFU2YEECSOKD6_entry
  store i8* %dst_FYOH5G, i8** %dst_FYOH5G1
  store i8* %src_FYPDIH, i8** %src_FYPDIH2
  %dst = load i8*, i8** %dst_FYOH5G1, align 4
  %dst3 = load i8*, i8** %dst_FYOH5G1, align 4
  %0 = call i64 @cstrlen_PD4HXS525IJAR(i8* %dst3)
  %1 = getelementptr inbounds i8, i8* %dst, i64 %0
  store i8* %1, i8** %p_FNOV
  br label %whilecheckcond

whilecheckcond:                                   ; preds = %then, %cstrcat_OFU2YEECSOKD6_begin
  %p = load i8*, i8** %p_FNOV, align 4
  %src = load i8*, i8** %src_FYPDIH2, align 4
  %deref = load i8, i8* %src
  store i8 %deref, i8* %p
  %assign_load = load i8, i8* %p
  %2 = icmp ne i8 %assign_load, 0
  %whilecond = icmp eq i1 %2, true
  br i1 %whilecond, label %then, label %merge

then:                                             ; preds = %whilecheckcond
  %p4 = load i8*, i8** %p_FNOV, align 4
  %3 = getelementptr inbounds i8, i8* %p4, i32 1
  store i8* %3, i8** %p_FNOV
  %src5 = load i8*, i8** %src_FYPDIH2, align 4
  %4 = getelementptr inbounds i8, i8* %src5, i32 1
  store i8* %4, i8** %src_FYPDIH2
  br label %whilecheckcond

merge:                                            ; preds = %whilecheckcond
  %dst6 = load i8*, i8** %dst_FYOH5G1, align 4
  ret i8* %dst6
}

define void @cstrrev_PD4674KVBI2WX(i8* %s_FNOW) #0 {
cstrrev_PD4674KVBI2WX_entry:
  %s_FNOW1 = alloca i8*, align 4
  %s8_FS4FO = alloca i8*, align 4
  %end_FYOIYK = alloca i8*, align 4
  br label %cstrrev_PD4674KVBI2WX_begin

cstrrev_PD4674KVBI2WX_begin:                      ; preds = %cstrrev_PD4674KVBI2WX_entry
  store i8* %s_FNOW, i8** %s_FNOW1
  %s = load i8*, i8** %s_FNOW1, align 4
  store i8* %s, i8** %s8_FS4FO
  %s8 = load i8*, i8** %s8_FS4FO, align 4
  %s2 = load i8*, i8** %s_FNOW1, align 4
  %0 = call i64 @cstrlen_PD4HXS525IJAR(i8* %s2)
  %1 = getelementptr inbounds i8, i8* %s8, i64 %0
  %2 = getelementptr inbounds i8, i8* %1, i32 -1
  store i8* %2, i8** %end_FYOIYK
  br label %whilecheckcond

whilecheckcond:                                   ; preds = %then, %cstrrev_PD4674KVBI2WX_begin
  %s83 = load i8*, i8** %s8_FS4FO, align 4
  %end = load i8*, i8** %end_FYOIYK, align 4
  %3 = ptrtoint i8* %s83 to i64
  %4 = ptrtoint i8* %end to i64
  %5 = icmp ult i64 %3, %4
  %whilecond = icmp eq i1 %5, true
  br i1 %whilecond, label %then, label %merge

then:                                             ; preds = %whilecheckcond
  %s84 = load i8*, i8** %s8_FS4FO, align 4
  %s85 = load i8*, i8** %s8_FS4FO, align 4
  %deref = load i8, i8* %s85
  %end6 = load i8*, i8** %end_FYOIYK, align 4
  %deref7 = load i8, i8* %end6
  %6 = xor i8 %deref, %deref7
  store i8 %6, i8* %s84
  %assign_load = load i8, i8* %s84
  %end8 = load i8*, i8** %end_FYOIYK, align 4
  %end9 = load i8*, i8** %end_FYOIYK, align 4
  %deref10 = load i8, i8* %end9
  %s811 = load i8*, i8** %s8_FS4FO, align 4
  %deref12 = load i8, i8* %s811
  %7 = xor i8 %deref10, %deref12
  store i8 %7, i8* %end8
  %assign_load13 = load i8, i8* %end8
  %s814 = load i8*, i8** %s8_FS4FO, align 4
  %s815 = load i8*, i8** %s8_FS4FO, align 4
  %deref16 = load i8, i8* %s815
  %end17 = load i8*, i8** %end_FYOIYK, align 4
  %deref18 = load i8, i8* %end17
  %8 = xor i8 %deref16, %deref18
  store i8 %8, i8* %s814
  %assign_load19 = load i8, i8* %s814
  %s820 = load i8*, i8** %s8_FS4FO, align 4
  %9 = getelementptr inbounds i8, i8* %s820, i32 1
  store i8* %9, i8** %s8_FS4FO
  %end21 = load i8*, i8** %end_FYOIYK, align 4
  %10 = getelementptr inbounds i8, i8* %end21, i32 -1
  store i8* %10, i8** %end_FYOIYK
  br label %whilecheckcond

merge:                                            ; preds = %whilecheckcond
  ret void
}

define void @itoa_BZEWFQZ4Z7G4X(i32 %i_FNOM, i8* %a_FNOE) #0 {
itoa_BZEWFQZ4Z7G4X_entry:
  %i_FNOM1 = alloca i32, align 4
  %a_FNOE2 = alloca i8*, align 4
  %it_FS3ZY = alloca i32, align 4
  %is_neg_GKJQ75NMM = alloca i1, align 1
  %rem_FYPC37 = alloca i32, align 4
  %0 = alloca i32, align 4
  br label %itoa_BZEWFQZ4Z7G4X_begin

itoa_BZEWFQZ4Z7G4X_begin:                         ; preds = %itoa_BZEWFQZ4Z7G4X_entry
  store i32 %i_FNOM, i32* %i_FNOM1
  store i8* %a_FNOE, i8** %a_FNOE2
  store i32 0, i32* %it_FS3ZY
  store i1 false, i1* %is_neg_GKJQ75NMM
  %i = load i32, i32* %i_FNOM1
  %1 = icmp eq i32 %i, 0
  %ifcond = icmp eq i1 %1, true
  br i1 %ifcond, label %then, label %merge

then:                                             ; preds = %itoa_BZEWFQZ4Z7G4X_begin
  %a = load i8*, i8** %a_FNOE2, align 4
  %2 = getelementptr inbounds i8, i8* %a, i32 0
  store i8 48, i8* %2
  %assign_load = load i8, i8* %2
  %a3 = load i8*, i8** %a_FNOE2, align 4
  %3 = getelementptr inbounds i8, i8* %a3, i32 1
  store i8 0, i8* %3
  %assign_load4 = load i8, i8* %3
  ret void

merge:                                            ; preds = %itoa_BZEWFQZ4Z7G4X_begin
  %i5 = load i32, i32* %i_FNOM1
  %4 = icmp slt i32 %i5, 0
  %ifcond6 = icmp eq i1 %4, true
  br i1 %ifcond6, label %then7, label %merge11

then7:                                            ; preds = %merge
  store i1 true, i1* %is_neg_GKJQ75NMM
  %assign_load8 = load i1, i1* %is_neg_GKJQ75NMM
  %i9 = load i32, i32* %i_FNOM1
  %5 = sub i32 0, %i9
  store i32 %5, i32* %i_FNOM1
  %assign_load10 = load i32, i32* %i_FNOM1
  br label %merge11

merge11:                                          ; preds = %then7, %merge
  br label %whilecheckcond

whilecheckcond:                                   ; preds = %merge20, %merge11
  %i12 = load i32, i32* %i_FNOM1
  %6 = icmp ne i32 %i12, 0
  %whilecond = icmp eq i1 %6, true
  br i1 %whilecond, label %then13, label %merge25

then13:                                           ; preds = %whilecheckcond
  %i14 = load i32, i32* %i_FNOM1
  %7 = call i32 @i32mod(i32 %i14, i32 10)
  store i32 %7, i32* %rem_FYPC37
  %a15 = load i8*, i8** %a_FNOE2, align 4
  %it = load i32, i32* %it_FS3ZY
  %8 = getelementptr inbounds i8, i8* %a15, i32 %it
  %rem = load i32, i32* %rem_FYPC37
  %9 = icmp sgt i32 %rem, 9
  %ifcond16 = icmp eq i1 %9, true
  br i1 %ifcond16, label %then17, label %else

then17:                                           ; preds = %then13
  %rem18 = load i32, i32* %rem_FYPC37
  %10 = sub i32 %rem18, 10
  %11 = add i32 %10, 97
  store i32 %11, i32* %0
  br label %merge20

else:                                             ; preds = %then13
  %rem19 = load i32, i32* %rem_FYPC37
  %12 = add i32 %rem19, 48
  store i32 %12, i32* %0
  br label %merge20

merge20:                                          ; preds = %else, %then17
  %13 = load i32, i32* %0
  %14 = trunc i32 %13 to i8
  store i8 %14, i8* %8
  %assign_load21 = load i8, i8* %8
  %it22 = load i32, i32* %it_FS3ZY
  %15 = add i32 %it22, 1
  store i32 %15, i32* %it_FS3ZY
  %i23 = load i32, i32* %i_FNOM1
  %16 = call i32 @i32div(i32 %i23, i32 10)
  store i32 %16, i32* %i_FNOM1
  %assign_load24 = load i32, i32* %i_FNOM1
  br label %whilecheckcond

merge25:                                          ; preds = %whilecheckcond
  %is_neg = load i1, i1* %is_neg_GKJQ75NMM
  %ifcond26 = icmp eq i1 %is_neg, true
  br i1 %ifcond26, label %then27, label %merge32

then27:                                           ; preds = %merge25
  %a28 = load i8*, i8** %a_FNOE2, align 4
  %it29 = load i32, i32* %it_FS3ZY
  %17 = getelementptr inbounds i8, i8* %a28, i32 %it29
  store i8 45, i8* %17
  %assign_load30 = load i8, i8* %17
  %it31 = load i32, i32* %it_FS3ZY
  %18 = add i32 %it31, 1
  store i32 %18, i32* %it_FS3ZY
  br label %merge32

merge32:                                          ; preds = %then27, %merge25
  %a33 = load i8*, i8** %a_FNOE2, align 4
  %it34 = load i32, i32* %it_FS3ZY
  %19 = getelementptr inbounds i8, i8* %a33, i32 %it34
  store i8 0, i8* %19
  %assign_load35 = load i8, i8* %19
  %a36 = load i8*, i8** %a_FNOE2, align 4
  call void @cstrrev_PD4674KVBI2WX(i8* %a36)
  ret void
}

define void @write_KDZ65VRPN5XHP(%console_K4FSINRP7ZUJF* dereferenceable(40) %this_F6HHPFD, i8* %s_FNOW) #0 {
write_KDZ65VRPN5XHP_entry:
  %s_FNOW1 = alloca i8*, align 4
  br label %write_KDZ65VRPN5XHP_begin

write_KDZ65VRPN5XHP_begin:                        ; preds = %write_KDZ65VRPN5XHP_entry
  store i8* %s_FNOW, i8** %s_FNOW1
  br label %whilecheckcond

whilecheckcond:                                   ; preds = %merge, %write_KDZ65VRPN5XHP_begin
  %s = load i8*, i8** %s_FNOW1, align 4
  %deref = load i8, i8* %s
  %0 = icmp ne i8 %deref, 0
  %whilecond = icmp eq i1 %0, true
  br i1 %whilecond, label %then, label %merge9

then:                                             ; preds = %whilecheckcond
  %1 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 1
  %s2 = load i8*, i8** %s_FNOW1, align 4
  %deref3 = load i8, i8* %s2
  %2 = call i32 @push_OXEQ2JVHTCRW7(%Vec_KNHG265OPCHFQ* dereferenceable(16) %1, i8 %deref3)
  %s4 = load i8*, i8** %s_FNOW1, align 4
  %deref5 = load i8, i8* %s4
  %3 = icmp eq i8 %deref5, 10
  %lhs_cond = icmp eq i1 %3, true
  br i1 %lhs_cond, label %mergephi, label %_else

_else:                                            ; preds = %then
  %4 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 1
  %5 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %4, i32 0, i32 2
  %structure_access = load i32, i32* %5
  %6 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 1
  %7 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %6, i32 0, i32 1
  %structure_access6 = load i32, i32* %7
  %8 = sub i32 %structure_access6, 1
  %9 = icmp eq i32 %structure_access, %8
  %rhs_cond = icmp eq i1 %9, true
  br i1 %rhs_cond, label %mergephi, label %condfalse

condfalse:                                        ; preds = %_else
  br label %mergephi

mergephi:                                         ; preds = %condfalse, %_else, %then
  %lazyphi = phi i1 [ true, %then ], [ true, %_else ], [ false, %condfalse ]
  %ifcond = icmp eq i1 %lazyphi, true
  br i1 %ifcond, label %then7, label %merge

then7:                                            ; preds = %mergephi
  call void @flush_KPZ5Y4V6SNAPI(%console_K4FSINRP7ZUJF* dereferenceable(40) %this_F6HHPFD)
  br label %merge

merge:                                            ; preds = %then7, %mergephi
  %s8 = load i8*, i8** %s_FNOW1, align 4
  %10 = getelementptr inbounds i8, i8* %s8, i32 1
  store i8* %10, i8** %s_FNOW1
  br label %whilecheckcond

merge9:                                           ; preds = %whilecheckcond
  ret void
}

define void @clear_N46OAFLVPZDRA(%Vec_KNHG265OPCHFQ* dereferenceable(16) %this_F6HHPFD) #0 {
clear_N46OAFLVPZDRA_entry:
  br label %clear_N46OAFLVPZDRA_begin

clear_N46OAFLVPZDRA_begin:                        ; preds = %clear_N46OAFLVPZDRA_entry
  %0 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %this_F6HHPFD, i32 0, i32 2
  store i32 0, i32* %0
  %assign_load = load i32, i32* %0
  ret void
}

define dereferenceable(1) i8* @get_GTKIY7X6AUHZX(%Vec_KNHG265OPCHFQ* dereferenceable(16) %this_F6HHPFD, i32 %idx_FYOVCQ) #0 {
get_GTKIY7X6AUHZX_entry:
  %idx_FYOVCQ1 = alloca i32, align 4
  br label %get_GTKIY7X6AUHZX_begin

get_GTKIY7X6AUHZX_begin:                          ; preds = %get_GTKIY7X6AUHZX_entry
  store i32 %idx_FYOVCQ, i32* %idx_FYOVCQ1
  %0 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %this_F6HHPFD, i32 0, i32 0
  %structure_access = load i8*, i8** %0, align 1
  %idx = load i32, i32* %idx_FYOVCQ1
  %1 = getelementptr inbounds i8, i8* %structure_access, i32 %idx
  ret i8* %1
}

define i32 @pop_MI7T72VEP5LDW(%Vec_KNHG265OPCHFQ* dereferenceable(16) %this_F6HHPFD) #0 {
pop_MI7T72VEP5LDW_entry:
  br label %pop_MI7T72VEP5LDW_begin

pop_MI7T72VEP5LDW_begin:                          ; preds = %pop_MI7T72VEP5LDW_entry
  %0 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %this_F6HHPFD, i32 0, i32 2
  %structure_access = load i32, i32* %0
  %1 = icmp eq i32 %structure_access, 0
  %ifcond = icmp eq i1 %1, true
  br i1 %ifcond, label %then, label %merge

then:                                             ; preds = %pop_MI7T72VEP5LDW_begin
  ret i32 -1

merge:                                            ; preds = %pop_MI7T72VEP5LDW_begin
  %2 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %this_F6HHPFD, i32 0, i32 2
  %3 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %this_F6HHPFD, i32 0, i32 2
  %structure_access1 = load i32, i32* %3
  %4 = sub i32 %structure_access1, 1
  store i32 %4, i32* %2
  %5 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %this_F6HHPFD, i32 0, i32 2
  %structure_access2 = load i32, i32* %5
  ret i32 %structure_access2
}

define %__bjou_slice_JVNSS5TRDTEIV @create_ETYH2D3ZRDCUA(i8* %src_FYPDIH, i64 %start_GEFZ734F, i64 %len_FYOQDC) #0 {
create_ETYH2D3ZRDCUA_entry:
  %src_FYPDIH1 = alloca i8*, align 4
  %start_GEFZ734F2 = alloca i64, align 8
  %len_FYOQDC3 = alloca i64, align 8
  %structinitializer = alloca %__bjou_slice_JVNSS5TRDTEIV, align 8
  br label %create_ETYH2D3ZRDCUA_begin

create_ETYH2D3ZRDCUA_begin:                       ; preds = %create_ETYH2D3ZRDCUA_entry
  store i8* %src_FYPDIH, i8** %src_FYPDIH1
  store i64 %start_GEFZ734F, i64* %start_GEFZ734F2
  store i64 %len_FYOQDC, i64* %len_FYOQDC3
  %0 = getelementptr inbounds %__bjou_slice_JVNSS5TRDTEIV, %__bjou_slice_JVNSS5TRDTEIV* %structinitializer, i32 0
  %src = load i8*, i8** %src_FYPDIH1, align 4
  %start = load i64, i64* %start_GEFZ734F2
  %1 = getelementptr inbounds i8, i8* %src, i64 %start
  %len = load i64, i64* %len_FYOQDC3
  %2 = getelementptr inbounds %__bjou_slice_JVNSS5TRDTEIV, %__bjou_slice_JVNSS5TRDTEIV* %0, i32 0, i32 0
  store i8* %1, i8** %2, align 4
  %3 = getelementptr inbounds %__bjou_slice_JVNSS5TRDTEIV, %__bjou_slice_JVNSS5TRDTEIV* %0, i32 0, i32 1
  store i64 %len, i64* %3
  %structinitializer_ld = load %__bjou_slice_JVNSS5TRDTEIV, %__bjou_slice_JVNSS5TRDTEIV* %structinitializer
  ret %__bjou_slice_JVNSS5TRDTEIV %structinitializer_ld
}

define %Vec_KNHG265OPCHFQ @create_N46QFN2UOXRBJ(%__bjou_slice_JVNSS5TRDTEIV %slice_GEF2Z5FV) #0 {
create_N46QFN2UOXRBJ_entry:
  %slice_GEF2Z5FV1 = alloca %__bjou_slice_JVNSS5TRDTEIV, align 8
  %structinitializer = alloca %Vec_KNHG265OPCHFQ, align 4
  br label %create_N46QFN2UOXRBJ_begin

create_N46QFN2UOXRBJ_begin:                       ; preds = %create_N46QFN2UOXRBJ_entry
  store %__bjou_slice_JVNSS5TRDTEIV %slice_GEF2Z5FV, %__bjou_slice_JVNSS5TRDTEIV* %slice_GEF2Z5FV1
  %0 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %structinitializer, i32 0
  %1 = call i8* @data_UVZPW5XTYOJW(%__bjou_slice_JVNSS5TRDTEIV* dereferenceable(16) %slice_GEF2Z5FV1)
  %2 = getelementptr inbounds %__bjou_slice_JVNSS5TRDTEIV, %__bjou_slice_JVNSS5TRDTEIV* %slice_GEF2Z5FV1, i32 0, i32 1
  %structure_access = load i64, i64* %2
  %3 = trunc i64 %structure_access to i32
  %4 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %0, i32 0, i32 0
  store i8* %1, i8** %4, align 4
  %5 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %0, i32 0, i32 1
  store i32 %3, i32* %5
  %6 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %0, i32 0, i32 2
  store i32 0, i32* %6
  %structinitializer_ld = load %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %structinitializer
  ret %Vec_KNHG265OPCHFQ %structinitializer_ld
}

define i8* @data_UVZPW5XTYOJW(%__bjou_slice_JVNSS5TRDTEIV* dereferenceable(16) %slice_GEF2Z5FV) #0 {
data_UVZPW5XTYOJW_entry:
  br label %data_UVZPW5XTYOJW_begin

data_UVZPW5XTYOJW_begin:                          ; preds = %data_UVZPW5XTYOJW_entry
  %0 = getelementptr inbounds %__bjou_slice_JVNSS5TRDTEIV, %__bjou_slice_JVNSS5TRDTEIV* %slice_GEF2Z5FV, i32 0, i32 0
  %structure_access = load i8*, i8** %0, align 1
  ret i8* %structure_access
}

define i32 @push_OXEQ2JVHTCRW7(%Vec_KNHG265OPCHFQ* dereferenceable(16) %this_F6HHPFD, i8 %item_F6HEIMQ) #0 {
push_OXEQ2JVHTCRW7_entry:
  %item_F6HEIMQ1 = alloca i8, align 1
  %idx_FYOVCQ = alloca i32, align 4
  br label %push_OXEQ2JVHTCRW7_begin

push_OXEQ2JVHTCRW7_begin:                         ; preds = %push_OXEQ2JVHTCRW7_entry
  store i8 %item_F6HEIMQ, i8* %item_F6HEIMQ1
  %0 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %this_F6HHPFD, i32 0, i32 2
  %structure_access = load i32, i32* %0
  %1 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %this_F6HHPFD, i32 0, i32 1
  %structure_access2 = load i32, i32* %1
  %2 = icmp eq i32 %structure_access, %structure_access2
  %ifcond = icmp eq i1 %2, true
  br i1 %ifcond, label %then, label %merge

then:                                             ; preds = %push_OXEQ2JVHTCRW7_begin
  ret i32 -1

merge:                                            ; preds = %push_OXEQ2JVHTCRW7_begin
  %3 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %this_F6HHPFD, i32 0, i32 2
  %structure_access3 = load i32, i32* %3
  store i32 %structure_access3, i32* %idx_FYOVCQ
  %4 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %this_F6HHPFD, i32 0, i32 0
  %structure_access4 = load i8*, i8** %4, align 1
  %idx = load i32, i32* %idx_FYOVCQ
  %5 = getelementptr inbounds i8, i8* %structure_access4, i32 %idx
  %item = load i8, i8* %item_F6HEIMQ1
  store i8 %item, i8* %5
  %assign_load = load i8, i8* %5
  %6 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %this_F6HHPFD, i32 0, i32 2
  %7 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %this_F6HHPFD, i32 0, i32 2
  %structure_access5 = load i32, i32* %7
  %8 = add i32 %structure_access5, 1
  store i32 %8, i32* %6
  %idx6 = load i32, i32* %idx_FYOVCQ
  ret i32 %idx6

; uselistorder directives
  uselistorder i32 -1, { 2, 3, 0, 1 }
}

define void @flush_KPZ5Y4V6SNAPI(%console_K4FSINRP7ZUJF* dereferenceable(40) %this_F6HHPFD) #0 {
flush_KPZ5Y4V6SNAPI_entry:
  br label %flush_KPZ5Y4V6SNAPI_begin

flush_KPZ5Y4V6SNAPI_begin:                        ; preds = %flush_KPZ5Y4V6SNAPI_entry
  %0 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 1
  %1 = call i32 @push_OXEQ2JVHTCRW7(%Vec_KNHG265OPCHFQ* dereferenceable(16) %0, i8 0)
  %2 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 1
  %3 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %2, i32 0, i32 0
  %structure_access = load i8*, i8** %3, align 1
  call void @write_string_LNEGVSSIZZ6RT(i8* %structure_access)
  %4 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 1
  call void @clear_N46OAFLVPZDRA(%Vec_KNHG265OPCHFQ* dereferenceable(16) %4)
  ret void
}

define void @write_CXMNRMJIHGXAF(%console_K4FSINRP7ZUJF* dereferenceable(40) %this_F6HHPFD, i8 %c_FNOG) #0 {
write_CXMNRMJIHGXAF_entry:
  %c_FNOG1 = alloca i8, align 1
  br label %write_CXMNRMJIHGXAF_begin

write_CXMNRMJIHGXAF_begin:                        ; preds = %write_CXMNRMJIHGXAF_entry
  store i8 %c_FNOG, i8* %c_FNOG1
  %0 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 1
  %c = load i8, i8* %c_FNOG1
  %1 = call i32 @push_OXEQ2JVHTCRW7(%Vec_KNHG265OPCHFQ* dereferenceable(16) %0, i8 %c)
  %c2 = load i8, i8* %c_FNOG1
  %2 = icmp eq i8 %c2, 10
  %lhs_cond = icmp eq i1 %2, true
  br i1 %lhs_cond, label %mergephi, label %_else

_else:                                            ; preds = %write_CXMNRMJIHGXAF_begin
  %3 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 1
  %4 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %3, i32 0, i32 2
  %structure_access = load i32, i32* %4
  %5 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 1
  %6 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %5, i32 0, i32 1
  %structure_access3 = load i32, i32* %6
  %7 = sub i32 %structure_access3, 1
  %8 = icmp eq i32 %structure_access, %7
  %rhs_cond = icmp eq i1 %8, true
  br i1 %rhs_cond, label %mergephi, label %condfalse

condfalse:                                        ; preds = %_else
  br label %mergephi

mergephi:                                         ; preds = %condfalse, %_else, %write_CXMNRMJIHGXAF_begin
  %lazyphi = phi i1 [ true, %write_CXMNRMJIHGXAF_begin ], [ true, %_else ], [ false, %condfalse ]
  %ifcond = icmp eq i1 %lazyphi, true
  br i1 %ifcond, label %then, label %merge

then:                                             ; preds = %mergephi
  call void @flush_KPZ5Y4V6SNAPI(%console_K4FSINRP7ZUJF* dereferenceable(40) %this_F6HHPFD)
  br label %merge

merge:                                            ; preds = %then, %mergephi
  ret void

; uselistorder directives
  uselistorder void (%console_K4FSINRP7ZUJF*)* @flush_KPZ5Y4V6SNAPI, { 1, 0 }
}

define void @echo_on_DG2IJKDAYJJGT(%console_K4FSINRP7ZUJF* dereferenceable(40) %this_F6HHPFD) #0 {
echo_on_DG2IJKDAYJJGT_entry:
  br label %echo_on_DG2IJKDAYJJGT_begin

echo_on_DG2IJKDAYJJGT_begin:                      ; preds = %echo_on_DG2IJKDAYJJGT_entry
  %0 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 2
  store i8 ()* @read_echo_DJOHO5RF3POM2, i8 ()** %0
  %assign_load = load i8 ()*, i8 ()** %0
  ret void
}

define void @create_HSPXW5ZZMOT3C(%console_K4FSINRP7ZUJF* %__bjou_sret, %__bjou_slice_JVNSS5TRDTEIV %ibuff_GEFK5W23, %__bjou_slice_JVNSS5TRDTEIV %obuff_GEFM5W25) #0 {
create_HSPXW5ZZMOT3C_entry:
  %__bjou_sret1 = alloca %console_K4FSINRP7ZUJF*, align 4
  %ibuff_GEFK5W232 = alloca %__bjou_slice_JVNSS5TRDTEIV, align 8
  %obuff_GEFM5W253 = alloca %__bjou_slice_JVNSS5TRDTEIV, align 8
  %"ibuff'_GKJQIURU4" = alloca %Vec_KNHG265OPCHFQ, align 4
  %0 = alloca %Vec_KNHG265OPCHFQ, align 4
  %"obuff'_GKJSKURW2" = alloca %Vec_KNHG265OPCHFQ, align 4
  %1 = alloca %Vec_KNHG265OPCHFQ, align 4
  %c_FNOG = alloca %console_K4FSINRP7ZUJF, align 1
  %structinitializer = alloca %console_K4FSINRP7ZUJF, align 1
  br label %create_HSPXW5ZZMOT3C_begin

create_HSPXW5ZZMOT3C_begin:                       ; preds = %create_HSPXW5ZZMOT3C_entry
  store %console_K4FSINRP7ZUJF* %__bjou_sret, %console_K4FSINRP7ZUJF** %__bjou_sret1
  store %__bjou_slice_JVNSS5TRDTEIV %ibuff_GEFK5W23, %__bjou_slice_JVNSS5TRDTEIV* %ibuff_GEFK5W232
  store %__bjou_slice_JVNSS5TRDTEIV %obuff_GEFM5W25, %__bjou_slice_JVNSS5TRDTEIV* %obuff_GEFM5W253
  %ibuff = load %__bjou_slice_JVNSS5TRDTEIV, %__bjou_slice_JVNSS5TRDTEIV* %ibuff_GEFK5W232
  %2 = call %Vec_KNHG265OPCHFQ @create_NU3XHJW226JYF(%__bjou_slice_JVNSS5TRDTEIV %ibuff)
  store %Vec_KNHG265OPCHFQ %2, %Vec_KNHG265OPCHFQ* %0
  %3 = bitcast %Vec_KNHG265OPCHFQ* %"ibuff'_GKJQIURU4" to i8*
  %4 = bitcast %Vec_KNHG265OPCHFQ* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %3, i8* align 4 %4, i64 12, i1 false)
  %obuff = load %__bjou_slice_JVNSS5TRDTEIV, %__bjou_slice_JVNSS5TRDTEIV* %obuff_GEFM5W253
  %5 = call %Vec_KNHG265OPCHFQ @create_NU3XHJW226JYF(%__bjou_slice_JVNSS5TRDTEIV %obuff)
  store %Vec_KNHG265OPCHFQ %5, %Vec_KNHG265OPCHFQ* %1
  %6 = bitcast %Vec_KNHG265OPCHFQ* %"obuff'_GKJSKURW2" to i8*
  %7 = bitcast %Vec_KNHG265OPCHFQ* %1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %6, i8* align 4 %7, i64 12, i1 false)
  %8 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %structinitializer, i32 0
  %"ibuff'" = load %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %"ibuff'_GKJQIURU4"
  %"obuff'" = load %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %"obuff'_GKJSKURW2"
  %9 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %8, i32 0, i32 0
  store %Vec_KNHG265OPCHFQ %"ibuff'", %Vec_KNHG265OPCHFQ* %9
  %10 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %8, i32 0, i32 1
  store %Vec_KNHG265OPCHFQ %"obuff'", %Vec_KNHG265OPCHFQ* %10
  %11 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %8, i32 0, i32 2
  store i8 ()* null, i8 ()** %11
  %12 = bitcast %console_K4FSINRP7ZUJF* %c_FNOG to i8*
  %13 = bitcast %console_K4FSINRP7ZUJF* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %12, i8* align 1 %13, i64 0, i1 false)
  call void @echo_on_DG2IJKDAYJJGT(%console_K4FSINRP7ZUJF* dereferenceable(40) %c_FNOG)
  %sret = load %console_K4FSINRP7ZUJF*, %console_K4FSINRP7ZUJF** %__bjou_sret1
  %14 = bitcast %console_K4FSINRP7ZUJF* %sret to i8*
  %15 = bitcast %console_K4FSINRP7ZUJF* %c_FNOG to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %14, i8* align 1 %15, i64 0, i1 false)
  ret void

; uselistorder directives
  uselistorder i64 0, { 3, 4, 0, 2, 1 }
  uselistorder i1 false, { 7, 8, 9, 10, 6, 5, 0, 1, 2, 3, 4 }
}

define %Vec_KNHG265OPCHFQ @create_NU3XHJW226JYF(%__bjou_slice_JVNSS5TRDTEIV %slice_GEF2Z5FV) #0 {
create_NU3XHJW226JYF_entry:
  %slice_GEF2Z5FV1 = alloca %__bjou_slice_JVNSS5TRDTEIV, align 8
  %structinitializer = alloca %Vec_KNHG265OPCHFQ, align 4
  br label %create_NU3XHJW226JYF_begin

create_NU3XHJW226JYF_begin:                       ; preds = %create_NU3XHJW226JYF_entry
  store %__bjou_slice_JVNSS5TRDTEIV %slice_GEF2Z5FV, %__bjou_slice_JVNSS5TRDTEIV* %slice_GEF2Z5FV1
  %0 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %structinitializer, i32 0
  %1 = call i8* @data_UVZPW5XTYOJW(%__bjou_slice_JVNSS5TRDTEIV* dereferenceable(16) %slice_GEF2Z5FV1)
  %2 = getelementptr inbounds %__bjou_slice_JVNSS5TRDTEIV, %__bjou_slice_JVNSS5TRDTEIV* %slice_GEF2Z5FV1, i32 0, i32 1
  %structure_access = load i64, i64* %2
  %3 = trunc i64 %structure_access to i32
  %4 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %0, i32 0, i32 0
  store i8* %1, i8** %4, align 4
  %5 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %0, i32 0, i32 1
  store i32 %3, i32* %5
  %6 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %0, i32 0, i32 2
  store i32 0, i32* %6
  %structinitializer_ld = load %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %structinitializer
  ret %Vec_KNHG265OPCHFQ %structinitializer_ld
}

define void @echo_off_KBCRTULCRQXL5(%console_K4FSINRP7ZUJF* dereferenceable(40) %this_F6HHPFD) #0 {
echo_off_KBCRTULCRQXL5_entry:
  br label %echo_off_KBCRTULCRQXL5_begin

echo_off_KBCRTULCRQXL5_begin:                     ; preds = %echo_off_KBCRTULCRQXL5_entry
  %0 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 2
  store i8 ()* @read_KK223CQSKU6KE, i8 ()** %0
  %assign_load = load i8 ()*, i8 ()** %0
  ret void

; uselistorder directives
  uselistorder i8 ()* @read_KK223CQSKU6KE, { 1, 0 }
}

define i8 @readchar_J52GRX44JDBLG(%console_K4FSINRP7ZUJF* dereferenceable(40) %this_F6HHPFD) #0 {
readchar_J52GRX44JDBLG_entry:
  %c_FNOG = alloca i8, align 1
  br label %readchar_J52GRX44JDBLG_begin

readchar_J52GRX44JDBLG_begin:                     ; preds = %readchar_J52GRX44JDBLG_entry
  store i8 0, i8* %c_FNOG
  br label %whilecheckcond

whilecheckcond:                                   ; preds = %then, %readchar_J52GRX44JDBLG_begin
  %c = load i8, i8* %c_FNOG
  %0 = icmp ne i8 %c, 0
  %1 = xor i1 %0, true
  %whilecond = icmp eq i1 %1, true
  br i1 %whilecond, label %then, label %merge

then:                                             ; preds = %whilecheckcond
  %2 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 2
  %structure_access = load i8 ()*, i8 ()** %2
  %3 = call i8 %structure_access()
  store i8 %3, i8* %c_FNOG
  %assign_load = load i8, i8* %c_FNOG
  br label %whilecheckcond

merge:                                            ; preds = %whilecheckcond
  %c1 = load i8, i8* %c_FNOG
  ret i8 %c1
}

define void @readln_HHAHYNO5CKM7C(%console_K4FSINRP7ZUJF* dereferenceable(40) %this_F6HHPFD, i8* %dst_FYOH5G) #0 {
readln_HHAHYNO5CKM7C_entry:
  %dst_FYOH5G1 = alloca i8*, align 4
  %c_FNOG = alloca i8, align 1
  br label %readln_HHAHYNO5CKM7C_begin

readln_HHAHYNO5CKM7C_begin:                       ; preds = %readln_HHAHYNO5CKM7C_entry
  store i8* %dst_FYOH5G, i8** %dst_FYOH5G1
  store i8 0, i8* %c_FNOG
  br label %whilecheckcond

whilecheckcond:                                   ; preds = %merge11, %readln_HHAHYNO5CKM7C_begin
  br i1 true, label %then, label %merge12

then:                                             ; preds = %whilecheckcond
  br label %whilecheckcond2

whilecheckcond2:                                  ; preds = %then3, %then
  %0 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 2
  %structure_access = load i8 ()*, i8 ()** %0
  %1 = call i8 %structure_access()
  store i8 %1, i8* %c_FNOG
  %assign_load = load i8, i8* %c_FNOG
  %2 = icmp ne i8 %assign_load, 0
  %3 = xor i1 %2, true
  %whilecond = icmp eq i1 %3, true
  br i1 %whilecond, label %then3, label %merge

then3:                                            ; preds = %whilecheckcond2
  br label %whilecheckcond2

merge:                                            ; preds = %whilecheckcond2
  %c = load i8, i8* %c_FNOG
  %4 = icmp eq i8 %c, 13
  %ifcond = icmp eq i1 %4, true
  br i1 %ifcond, label %then4, label %else

then4:                                            ; preds = %merge
  %5 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 0
  %6 = call i32 @push_OXEQ2JVHTCRW7(%Vec_KNHG265OPCHFQ* dereferenceable(16) %5, i8 10)
  br label %merge12

else:                                             ; preds = %merge
  %7 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 0
  %c5 = load i8, i8* %c_FNOG
  %8 = call i32 @push_OXEQ2JVHTCRW7(%Vec_KNHG265OPCHFQ* dereferenceable(16) %7, i8 %c5)
  br label %merge6

merge6:                                           ; preds = %else
  %9 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 0
  %10 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %9, i32 0, i32 2
  %structure_access7 = load i32, i32* %10
  %11 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 0
  %12 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %11, i32 0, i32 1
  %structure_access8 = load i32, i32* %12
  %13 = sub i32 %structure_access8, 1
  %14 = icmp eq i32 %structure_access7, %13
  %ifcond9 = icmp eq i1 %14, true
  br i1 %ifcond9, label %then10, label %merge11

then10:                                           ; preds = %merge6
  br label %merge12

merge11:                                          ; preds = %merge6
  br label %whilecheckcond

merge12:                                          ; preds = %then10, %then4, %whilecheckcond
  %15 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 0
  %16 = call i32 @push_OXEQ2JVHTCRW7(%Vec_KNHG265OPCHFQ* dereferenceable(16) %15, i8 0)
  %dst = load i8*, i8** %dst_FYOH5G1, align 4
  %17 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 0
  %18 = getelementptr inbounds %Vec_KNHG265OPCHFQ, %Vec_KNHG265OPCHFQ* %17, i32 0, i32 0
  %structure_access13 = load i8*, i8** %18, align 1
  %19 = call i8* @cstrcpy_LBW6EUK6XUGQC(i8* %dst, i8* %structure_access13)
  %20 = getelementptr inbounds %console_K4FSINRP7ZUJF, %console_K4FSINRP7ZUJF* %this_F6HHPFD, i32 0, i32 0
  call void @clear_N46OAFLVPZDRA(%Vec_KNHG265OPCHFQ* dereferenceable(16) %20)
  ret void

; uselistorder directives
  uselistorder i32 (%Vec_KNHG265OPCHFQ*, i8)* @push_OXEQ2JVHTCRW7, { 2, 3, 4, 1, 5, 0 }
  uselistorder i8 10, { 3, 2, 1, 0 }
  uselistorder i8 13, { 1, 0 }
  uselistorder i32 2, { 3, 4, 5, 6, 9, 8, 7, 2, 10, 11, 12, 13, 14, 16, 17, 18, 19, 15, 1, 0 }
  uselistorder i32 0, { 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 54, 61, 62, 63, 64, 65, 66, 67, 56, 57, 58, 59, 60, 55, 24, 25, 26, 27, 28, 49, 50, 51, 52, 53, 68, 69, 70, 71, 72, 73, 74, 95, 96, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 90, 91, 92, 93, 94, 86, 87, 88, 89, 19, 20, 21, 22, 23, 0, 1, 2, 3, 4, 5, 10, 11, 12, 13, 14, 15, 6, 7, 8, 9, 16, 17, 18, 97, 98, 99, 100, 101 }
  uselistorder i8 0, { 8, 9, 10, 11, 12, 13, 7, 0, 1, 2, 3, 4, 5, 6 }
  uselistorder i32 1, { 95, 96, 97, 98, 99, 113, 114, 115, 116, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 89, 90, 91, 92, 93, 94, 100, 101, 102, 117, 119, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 131, 130, 82, 83, 84, 85, 86, 87, 88, 0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 69, 71, 72, 70, 73, 74, 75, 76, 77, 78, 79, 80, 81, 57, 58, 61, 62, 59, 60, 63, 64, 65, 66, 67, 68 }
}

define void @debug1() #0 {
debug1_entry:
  br label %debug1_begin

debug1_begin:                                     ; preds = %debug1_entry
  br label %whilecheckcond

whilecheckcond:                                   ; preds = %then, %debug1_begin
  br i1 true, label %then, label %merge

then:                                             ; preds = %whilecheckcond
  br label %whilecheckcond

merge:                                            ; preds = %whilecheckcond
  ret void

; uselistorder directives
  uselistorder i1 true, { 48, 39, 40, 41, 42, 43, 44, 45, 34, 35, 36, 37, 38, 46, 47, 28, 29, 30, 31, 32, 33, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 18, 19, 20, 21, 22, 13, 14, 15, 16, 17, 25, 26, 27, 23, 24 }
}

define void @main() #0 {
main_entry:
  br label %main_begin

main_begin:                                       ; preds = %main_entry
  call void @configure_DJ3GWJX5RJBZ6()
  call void @debug1()
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #1

attributes #0 = { "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf"="true" }
attributes #1 = { argmemonly nounwind }
