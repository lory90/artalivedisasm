;  =========================================================================
; |           Art Alive! Disassembly for Mega Drive/Genesis                 |
;  =========================================================================
;
;  Created by Lorenzo, <lory2004@gmail.com>
;
; 	Credits
;
; - Nemesis for the Active Disassembler tool of the Exodus emulator.


	cpu 68000
	include "art.macrosetup.asm"

StartOfRom:

VectorTable:
	dc.l	$01000000, EntryPoint, StartOfRom, StartOfRom
	dc.l	StartOfRom, StartOfRom, StartOfRom, StartOfRom
	dc.l	StartOfRom, StartOfRom, StartOfRom, StartOfRom
	dc.l	StartOfRom, StartOfRom, StartOfRom, StartOfRom
	dc.l	StartOfRom, StartOfRom, StartOfRom, StartOfRom
	dc.l	StartOfRom, StartOfRom, StartOfRom, StartOfRom
	dc.l	StartOfRom, StartOfRom, StartOfRom, StartOfRom
	dc.l	StartOfRom, StartOfRom, VInt, StartOfRom
	dc.l	StartOfRom, StartOfRom, StartOfRom, StartOfRom
	dc.l	StartOfRom, StartOfRom, StartOfRom, StartOfRom
	dc.l	StartOfRom, StartOfRom, StartOfRom, StartOfRom
	dc.l	StartOfRom, StartOfRom, StartOfRom, StartOfRom
	dc.l	StartOfRom, StartOfRom, StartOfRom, StartOfRom
	dc.l	StartOfRom, StartOfRom, StartOfRom, StartOfRom
	dc.l	StartOfRom, StartOfRom, StartOfRom, StartOfRom
	dc.l	StartOfRom, StartOfRom, StartOfRom, StartOfRom
	
Header:
	dc.b	"SEGA MEGA DRIVE "	; Console name
	dc.b	"(C)SEGA 1991.AUG"	; Copyright/date
	dc.b	"Art Alive!                                      "	; Domestic name
	dc.b	"Art Alive!                                      "	; International name
	dc.b	"GM MK-1703 -00"	; Version
	
	dc.w	$FC31		; Checksum
	dc.b	"J               "	; I/O Support
	dc.l	StartOfRom	; ROM Start
	dc.l	EndOfRom-1	; ROM End
	dc.l	$FF0000		; RAM Start
	dc.l	$FFFFFF		; RAM End
	dc.b	"    "		; SRAM ID
	dc.b	"    "		; SRAM start address
	dc.b	"    "		; SRAM end address
	dc.b	"            "		; Modem support
	dc.b	"                                        "	; Notes
	dc.b	"U               "	; Country
EndOfHeader:

EntryPoint:
	tst.l	($A10008).l
	bne.s	loc_20E
	tst.w	($A1000C).l
loc_20E:
	bne.s	loc_28C
	lea	loc_28E(pc), a5
	movem.w	(a5)+, d5-d7
	movem.l	(a5)+, a0-a4
	move.b	-$10FF(a1), d0
	andi.b	#$F, d0
	beq.s	loc_22E
	move.l	#'SEGA', $2F00(a1)
loc_22E:
	move.w	(a4), d0
	moveq	#0, d0
	movea.l	d0, a6
	move.l	a6, usp
	moveq	#(VDPInitValues_End-VDPInitValues)-1, d1
loc_238:
	move.b	(a5)+, d5
	move.w	d5, (a4)
	add.w	d7, d5
	dbf	d1, loc_238
	move.l	(a5)+, (a4)
	move.w	d0, (a3)
	move.w	d7, (a1)
	move.w	d7, (a2)
loc_24A:
	btst	d0, (a1)
	bne.s	loc_24A
	moveq	#(Z80StartupCode_End-Z80StartupCode)-1, d2
loc_250:
	move.b	(a5)+, (a0)+
	dbf	d2, loc_250
	move.w	d0, (a2)
	move.w	d0, (a1)
	move.w	d7, (a2)
loc_25C:
	move.l	d0, -(a6)
	dbf	d6, loc_25C
	move.l	(a5)+, (a4)
	move.l	(a5)+, (a4)
	moveq	#$1F, d3
loc_268:
	move.l	d0, (a3)
	dbf	d3, loc_268
	move.l	(a5)+, (a4)
	moveq	#$13, d4
loc_272:
	move.l	d0, (a3)
	dbf	d4, loc_272
	moveq	#(PSGInitValues_End-PSGInitValues)-1, d5
loc_27A:
	move.b	(a5)+, $11(a3)
	dbf	d5, loc_27A
	move.w	d0, (a2)
	movem.l	(a6), d0-a6
	move	#$2700, sr
loc_28C:
	bra.s	loc_2FA

loc_28E:
	dc.w	$8000
	dc.w	$3FFF
	dc.w	$0100

	dc.l	$A00000
	dc.l	$A11100
	dc.l	$A11200
	dc.l	$C00000
	dc.l	$C00004

VDPInitValues:
	dc.b	$04		; Command $8004 - HInt off, Enable HV counter read
	dc.b	$14		; Command $8114 - Display off, VInt off, DMA on, PAL off
	dc.b	$30		; Command $8230 - Scroll A Address $C000
	dc.b	$3C		; Command $833C - Window Address $F000
	dc.b	$07		; Command $8407 - Scroll B Address $E000
	dc.b	$6C		; Command $856C - Sprite Table Address $D800
	dc.b	$00		; Command $8600 - Null
	dc.b	$00		; Command $8700 - Background color Pal 0 Color 0
	dc.b	$00		; Command $8800 - Null
	dc.b	$00		; Command $8900 - Null
	dc.b	$FF		; Command $8AFF - Hint timing $FF scanlines
	dc.b	$00		; Command $8B00 - Ext Int off, VScroll full, HScroll full
	dc.b	$81		; Command $8C81 - 40 cell mode, shadow/highlight off, no interlace
	dc.b	$37		; Command $8D37 - H Scroll Table Address $DC00
	dc.b	$00		; Command $8E00 - Null
	dc.b	$01		; Command $8F01 - VDP auto increment 1 byte
	dc.b	$01		; Command $9001 - 64x32 cell scroll size
	dc.b	$00		; Command $9100 - Window H left side, Base Point 0
	dc.b	$00		; Command $9200 - Window V upside, Base Point 0
	dc.b	$FF		; Command $93FF - DMA Length Counter $FFFF
	dc.b	$FF		; Command $94FF - DMA Length Counter $FFFF
	dc.b	$00		; Command $9500 - DMA Source Address $0
	dc.b	$00		; Command $9600 - DMA Source Address $0
	dc.b	$80		; Command $9780 - DMA Source Address $0 + VRAM fill mode
VDPInitValues_End:

	dc.l	$40000080	; DMA - VRAM write mode
	
Z80StartupCode:
	save
	cpu Z80
	xor	a
	ld	bc, 1FD9h
	ld	de, 27h
	ld	hl, 26h
	ld	sp, hl
	ld	(hl), a
	ldir
	pop	ix
	pop	iy
	ld	i, a
	ld	r, a
	pop	de
	pop	hl
	pop	af
	ex	af, af'
	exx
	pop	bc
	pop	de
	pop	hl
	pop	af
	ld	sp, hl
	di
	im	1
	ld	(hl), 0E9h
	jp	(hl)
	
	restore
	padding off
Z80StartupCode_End:
	
VDPMiscData:
	dc.w	$8104	; VDP display mode
	dc.w	$8F02	; VDP auto-increment
	dc.l	$C0000000	; CRAM write
	dc.l	$40000010	; VSRAM write
	
PSGInitValues:
	dc.b	$9F, $BF, $DF, $FF
PSGInitValues_End:

loc_2FA:
	move.w	#$64, ($A11100).l
	lea	loc_28E(pc), a5
	movem.w	(a5)+, d5-d7
	movem.l	(a5)+, a0-a4
	move.w	(a4), d0
	moveq	#0, d0
	movea.l	d0, a6
	move.l	a6, usp
	moveq	#(VDPInitValues_End-VDPInitValues)-1, d1
loc_318:
	move.b	(a5)+, d5
	move.w	d5, (a4)
	add.w	d7, d5
	dbf	d1, loc_318
	move.l	(a5)+, (a4)
	move.w	d0, (a3)
	move.l	#$3FFE, d6
	movea.l	#0, a6
	clr.l	d0
loc_334:
	move.l	d0, -(a6)
	dbf	d6, loc_334
	move.w	d7, (a1)
	move.w	d7, (a2)
	movea.l	#VDPMiscData, a5
	move.l	(a5)+, (a4)
	move.l	(a5)+, (a4)
	moveq	#$1F, d3
loc_34A:
	move.l	d0, (a3)
	dbf	d3, loc_34A
	move.l	(a5)+, (a4)
	moveq	#$13, d4
loc_354:
	move.l	d0, (a3)
	dbf	d4, loc_354
	moveq	#3, d5
loc_35C:
	move.b	(a5)+, $11(a3)
	dbf	d5, loc_35C
	movem.l	(a6), d0-a6
	move	#$2700, sr
	move.l	#$A, d6
	jsr	(loc_5E6).l
	move.w	#$8144, ($C00004).l
	move.w	#$9000, ($C00004).l
	lea	(loc_678).l, a0
	move.l	#$40200000, ($C00004).l
	move.l	#$2FF, d0
loc_39E:
	move.w	(a0)+, ($C00000).l
	dbf	d0, loc_39E
	lea	(loc_C78).l, a0
	move.l	#$C0000000, ($C00004).l
	moveq	#$F, d0
loc_3BA:
	move.w	(a0)+, ($C00000).l
	dbf	d0, loc_3BA
	move.l	#$431C0003, d7
	moveq	#1, d1
	moveq	#3, d2
loc_3CE:
	move.l	d7, ($C00004).l
	moveq	#$B, d0
loc_3D6:
	move.w	d1, ($C00000).l
	addq.w	#1, d1
	dbf	d0, loc_3D6
	addi.l	#$400000, d7
	dbf	d2, loc_3CE
	lea	(loc_C86).l, a0
	adda.w	#$20, a0
	move.w	#$10, d1
	move.w	#$4F, d6
	jsr	(loc_5E6).l
loc_404:
	movea.w	a0, a1
	move.l	#$C00E0000, ($C00004).l
	moveq	#8, d0
loc_412:
	move.w	(a1)+, ($C00000).l
	dbf	d0, loc_412
	moveq	#7, d6
	jsr	(loc_5E6).l
	subq.w	#2, a0
	dbf	d1, loc_404
	move.l	#$64, d6
	bsr.w	loc_5E6
	move.w	#$8104, ($C00004).l
	move.w	#$9001, ($C00004).l
	lea	($C00000).l, a2
	lea	$4(a2), a0
	move.w	#$8F02, (a0)
	move.l	#$58000003, (a0)
	move.l	#$1FF, d0
loc_45E:
	move.w	#0, (a2)
	dbf	d0, loc_45E
	move.w	#$700, d0
	move.l	#$60000003, (a0)
	moveq	#0, d1
	moveq	#0, d2
loc_474:
	move.w	d2, (a2)
	addq.w	#1, d1
	addq.w	#1, d2
	move.w	d1, d3
	andi.w	#$3F, d3
	bne.w	loc_488
	subi.w	#$18, d2
loc_488:
	dbf	d0, loc_474
	bsr.w	loc_5BA
	lea	(loc_5F8).l, a1
	move.w	#$3F, d0
	move.l	#$C0000000, (a0)
loc_4A0:
	move.w	(a1)+, (a2)
	dbf	d0, loc_4A0
	move.w	#$8238, (a0)
	move.w	#$8338, (a0)
	move.w	#$8407, (a0)
	move.w	#$9180, (a0)
	move.w	#$9280, (a0)
	move.w	#$8C81, (a0)
	move.w	#$8700, (a0)
	move.w	#$8800, (a0)
	move.w	#$856E, (a0)
	move.w	#$8900, (a0)
	move.w	#$8600, (a0)
	move.w	#$8D36, (a0)
	move.w	#0, ($FF003E).l
	move.w	#1, ($FF0040).l
	move.w	#$F, ($FF0042).l
	move.w	#2, ($FF0044).l
	move.w	(loc_F8C).l, ($FF0046).l
	move.w	#0, ($FF00A6).l
	lea	(loc_4D94).l, a3
	move.l	a3, ($FF0058).l
	lea	(loc_5A70).l, a3
	move.l	a3, ($FF005C).l
	move.l	#$9600, ($FF0060).l
	clr.w	($FF0064).l
	clr.w	($FF00AA).l
	clr.w	($FF00AC).l
	clr.w	($FF0038).l
	clr.l	($FF00B0).l
	clr.l	($FF00B4).l
	clr.w	($FF00C0).l
	move.w	#1, ($FF004A).l
	movea.l	#loc_8F54, a3
	movea.l	(a3), a4
	adda.l	#2, a4
	move.l	#$C03E0000, (a0)
	move.w	(a4), (a2)
	jsr	(loc_A680).l
	jsr	(loc_B044).l
	move.w	#1, ($FF0056).l
	move.w	#$FFCE, ($FF0006).l
	move.w	#$FFCE, ($FF0004).l
	move.w	#0, ($FF0036).l
	jsr	(loc_16A2).l
	move.l	#loc_3496, ($FF00B8).l
	move	#$2000, sr
	move.w	#$8164, (a0)
	bra.w	loc_CB8

loc_5BA:
	move.l	#$40000000, (a0)
	move.w	#$45FF, d0
loc_5C4:
	move.w	#0, (a2)
	dbf	d0, loc_5C4
	rts
loc_5CE:
	move.l	#0, (a0)
	movea.l	#$FF32B4, a3
	move.w	#$45FF, d0
loc_5DE:
	move.w	(a2), (a3)+
	dbf	d0, loc_5DE
	rts
loc_5E6:
	move.l	#$FFF, d7
loc_5EC:
	nop
	dbf	d7, loc_5EC
	dbf	d6, loc_5E6
	rts

loc_5F8:
	dc.w	$0EEE, $0EC6, $0E66, $0800, $0E6E, $0808, $066E, $0008, $06E4, $0080, $06EE, $0066, $0EEE, $0888, $0444, $0000
	dc.w	$0000, $0000, $0A00, $0E64, $0224, $0448, $066C, $0246, $02AA, $02CC, $04EE, $0222, $0666, $0AAA, $0EEE, $0000 ;0x0 (0x000005F8-0x00000678, Entry count: 0x80)
	dc.w	$0000, $0EEE, $028E, $02E2, $0E22, $0E6E, $044E, $0000, $04EE, $00C4, $0C0C, $0EE4, $044E, $0E4E, $0CEE, $0EEE
	dc.w	$0000, $0600, $0C00, $0E44, $0004, $022A, $066E, $0620, $0A60, $0EC4, $0806, $0C4A, $0E8E, $0AAA, $0CCC, $0EEE ;0x20
loc_678:
	dc.w	$0000, $0000, $0000, $0111, $0001, $1BBC, $001A, $BBBB, $01AA, $BBBB, $01AA, $ABBB, $1AAA, $ABB1, $19AA, $AA1B
	dc.w	$0000, $0000, $1111, $1111, $CCCD, $DDDE, $CCCC, $DDDD, $CCCC, $DDDD, $BCCC, $CDDD, $1111, $1111, $BBCC, $CCDD ;0x0 (0x00000678-0x00000C78, Entry count: 0x600)
	dc.w	$0000, $0000, $1111, $1100, $EEEF, $F100, $EEEE, $F101, $EEEE, $F11A, $DEEE, $E11A, $1111, $11AA, $DDEE, $E1AA
	dc.w	$0000, $0000, $0011, $1111, $11BB, $CCCC, $BBBB, $CCCC, $ABBB, $BCCC, $ABBB, $BCCC, $AABB, $B111, $AABB, $1BCC ;0x20
	dc.w	$0000, $0000, $1111, $1111, $DDDD, $EEEE, $DDDD, $EEEE, $CDDD, $DEEE, $CDDD, $DEEE, $1111, $1111, $CCDD, $DDEE
	dc.w	$0000, $0000, $1111, $0000, $FFF1, $0011, $FFF1, $01BB, $EFF1, $1ABB, $EFF1, $1ABB, $1111, $AAAB, $EEF1, $AAAB ;0x40
	dc.w	$0000, $0000, $1111, $1111, $BCCC, $CDDD, $BCCC, $CDDD, $BBCC, $CCDD, $BBCC, $CCDD, $BBB1, $1111, $B11C, $CCCD
	dc.w	$0000, $0000, $1111, $1111, $DEEE, $EFFF, $DEEE, $EFFF, $DDEE, $EEFF, $DDEE, $EEFF, $1111, $1111, $DDDE, $EEEF ;0x60
	dc.w	$0000, $0000, $1100, $0000, $F100, $0000, $F100, $0000, $F100, $0000, $F100, $0000, $1100, $0000, $F100, $0001
	dc.w	$0000, $0000, $0000, $0111, $0001, $1DDD, $001C, $CDDD, $01CC, $CDDD, $1BCC, $CCDD, $1BCC, $CCDD, $BBBC, $CC11 ;0x80
	dc.w	$0000, $1111, $1000, $0010, $E110, $0010, $DEE1, $0010, $DEEE, $1010, $DDEE, $E100, $DDEE, $E100, $DDDE, $EE10
	dc.w	$1010, $0001, $0011, $0011, $0010, $1101, $0010, $0001, $0010, $0001, $0000, $0000, $0000, $0000, $0000, $0000 ;0xA0
	dc.w	$19AA, $A1BB, $199A, $A1AB, $199A, $A1AB, $1999, $A1AA, $1999, $A1AA, $1999, $91AA, $1999, $91AA, $1899, $991A
	dc.w	$BBCC, $CCDD, $BBBC, $CCCD, $BBBC, $CCCD, $BB11, $1111, $BBBB, $CCCC, $ABBB, $BCCC, $ABBB, $BCCC, $AABB, $BBCC ;0xC0
	dc.w	$DDEE, $E19A, $DDDE, $E19A, $DDDE, $E199, $1111, $1199, $1111, $1199, $CD11, $1199, $CDD1, $1199, $CCDD, $1199
	dc.w	$AAA1, $BBBC, $AAA1, $BBBC, $AAA1, $BBBB, $AAA1, $BBB1, $9AA1, $ABBB, $9AA1, $ABBB, $99A1, $AABB, $99A1, $AABB ;0xE0
	dc.w	$CCCD, $DDDE, $CCCD, $DDDE, $CCCC, $DDDD, $1111, $1111, $BCCC, $CDDD, $BCCC, $CDDD, $BBCC, $CCDD, $BBCC, $CCDD
	dc.w	$EEE1, $AAAA, $EEE1, $9AAA, $EEE1, $9AAA, $1111, $99AA, $D111, $99AA, $D111, $999A, $D111, $999A, $D111, $9999 ;0x100
	dc.w	$1BBB, $CCCC, $1BBB, $BCCC, $1BBB, $BCCC, $1ABB, $B111, $1ABB, $B1CC, $1AAB, $B1BC, $1AAB, $B1BC, $1AAA, $B1BB
	dc.w	$DDDD, $EEEE, $CDDD, $EEEE, $CDDD, $DEEE, $1111, $1111, $CCDD, $DDEE, $CCCD, $DDEE, $CCCD, $DDDE, $CCCC, $DDDE ;0x120
	dc.w	$F100, $0001, $F100, $0001, $E100, $001A, $1100, $001A, $E100, $001A, $E100, $01AA, $E100, $01AA, $E100, $019A
	dc.w	$BBBC, $CC11, $BBBB, $C1CC, $BBBB, $C1CC, $ABBB, $B1CC, $ABBB, $1CCC, $AABB, $1BCC, $AABB, $1BCC, $AAA1, $BBBC ;0x140
	dc.w	$DDDE, $EE10, $1DDD, $EE10, $1DDD, $EEE1, $1DDD, $DEE1, $C1DD, $DEE1, $C1DD, $DDEE, $C1DD, $DDEE, $CC1D, $DDDE
	dc.w	$0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $1000, $0000, $1000, $0000, $1000, $0000 ;0x160
	dc.w	$0199, $99A1, $0189, $999A, $0019, $999A, $0018, $9999, $0001, $1199, $1111, $1111, $1888, $8999, $1888, $8899
	dc.w	$1111, $111C, $AAAB, $BBB1, $AAAB, $BBBC, $AAAA, $BBBB, $AAAA, $BBBB, $1111, $ABBB, $9AAA, $ABBB, $99AA, $AABB ;0x180
	dc.w	$CCDD, $1189, $CCCD, $D189, $1CCD, $D188, $1CCC, $D188, $1CCC, $D188, $1CCC, $C188, $1CCC, $C188, $1BCC, $C188
	dc.w	$9991, $1111, $9991, $AAAB, $9991, $AAAA, $9991, $AAAA, $8991, $9AAA, $8991, $9AA1, $8891, $99AA, $8891, $99AA ;0x1A0
	dc.w	$1111, $1111, $BBBC, $CCCD, $BBBB, $CCCC, $BBBB, $CCCC, $ABBB, $BCCC, $1111, $1111, $AABB, $BBCC, $AABB, $BBCC
	dc.w	$1111, $9999, $D111, $8999, $D111, $8999, $D111, $8899, $C111, $8899, $1111, $8889, $CCD1, $8889, $CCD1, $8888 ;0x1C0
	dc.w	$1AAA, $B111, $1AAA, $A1BB, $1AAA, $A1BB, $19AA, $A1BB, $19AA, $A1BB, $199A, $A111, $199A, $AAAB, $1999, $AAAA
	dc.w	$1111, $1DDD, $BCCC, $1DDD, $BCCC, $1DDD, $BBCC, $1CDD, $BBCC, $1CDD, $BBBC, $1CCD, $BBBC, $1CCD, $BBBB, $1CCC ;0x1E0
	dc.w	$E100, $199A, $E100, $1999, $D100, $1999, $D101, $8999, $D101, $8999, $D101, $8899, $D118, $8899, $D118, $8889
	dc.w	$AAA1, $BBBC, $AAA1, $BBBB, $AA1A, $BBBB, $9A1A, $ABBB, $9A1A, $AB11, $91AA, $AA11, $91AA, $AABB, $919A, $AAAB ;0x200
	dc.w	$CC1D, $DDDE, $CC1C, $DDDD, $CCC1, $DDDD, $BCC1, $CDDD, $BCC1, $CDDD, $BBCC, $1CDD, $BBCC, $1CDD, $BBBC, $1CCD
	dc.w	$E100, $0000, $E100, $0000, $E100, $0000, $DE10, $0000, $DE10, $0000, $DD10, $0000, $DDE1, $0000, $DDD1, $0000 ;0x220
	dc.w	$1788, $8899, $1778, $8889, $1111, $1111, $1777, $8888, $1777, $8888, $1777, $7888, $1777, $7888, $1111, $1111
	dc.w	$99AA, $AABB, $999A, $AAA1, $1111, $111B, $9999, $AAAA, $9999, $AAAA, $8999, $9AAA, $8999, $9AAA, $1111, $1111 ;0x240
	dc.w	$1BCC, $C178, $BBBC, $C178, $BBBC, $C177, $BBBB, $1017, $BBBB, $1017, $ABB1, $0001, $A110, $0000, $1000, $0000
	dc.w	$8881, $999A, $8889, $199A, $8888, $9111, $8888, $9999, $7888, $8999, $7888, $8999, $1188, $8899, $0011, $1111 ;0x260
	dc.w	$AAAB, $BBBC, $AAAB, $BBBC, $1111, $1111, $AAAA, $BBBB, $9AAA, $ABBB, $9AAA, $ABBB, $99AA, $AABB, $1111, $1111
	dc.w	$CCC1, $7888, $CCC1, $7888, $1111, $1788, $CCC1, $1788, $BCC1, $1778, $BCC1, $0178, $BBC1, $0011, $1111, $0000 ;0x280
	dc.w	$1999, $AAAA, $8119, $9AAA, $8891, $1111, $8899, $99AA, $8889, $999A, $8889, $999A, $8888, $9999, $1111, $1111
	dc.w	$BBBB, $1CCC, $ABBB, $1CCC, $1111, $1BCC, $AABB, $BBCC, $AAAB, $BBBC, $AAAB, $BBBC, $AAAA, $BBBB, $1111, $1111 ;0x2A0
	dc.w	$D178, $8889, $C177, $8888, $CC77, $8888, $CC77, $7881, $CC77, $7881, $CC77, $7781, $CC77, $7781, $1111, $1111
	dc.w	$199A, $AAAB, $1999, $AAAA, $1999, $1111, $8999, $1AAA, $8991, $1AAA, $8891, $19AA, $8811, $19AA, $1111, $1111 ;0x2C0
	dc.w	$BBBC, $C1CD, $BBBB, $C1CC, $1111, $11CC, $ABBB, $BCCC, $ABBB, $BCCC, $AABB, $BBCC, $AABB, $BBCC, $1111, $1111
	dc.w	$DDD1, $0000, $DDDD, $1000, $DDDD, $1000, $CDDD, $1000, $CDDD, $D100, $CCDD, $D100, $CCDD, $D100, $1111, $1100 ;0x2E0
loc_C78:
	dc.w	$0000, $0EEE, $0EEE, $0EEE, $0EEE, $0EEE, $0EEE ;0x0 (0x00000C78-0x00000C86, Entry count: 0xE)
loc_C86:
	dc.b	$0E, $A0, $0E, $80, $0E, $60, $0E, $40, $0E, $20, $0E, $00, $0C, $00, $0A, $00
	dc.b	$08, $00, $0A, $00, $0C, $00, $0E, $00, $0E, $20, $0E, $40, $0E, $60, $0E, $80 ;0x0 (0x00000C86-0x00000CB8, Entry count: 0x32) [Unknown data]
	dc.b	$0E, $A0, $0E, $80, $0E, $60, $0E, $40, $0E, $20, $0E, $00, $0C, $00, $0A, $00, $08, $00 ;0x20
	

loc_CB8:
	move.l	($FF00B0).l, d0
loc_CBE:
	cmp.l	($FF00B0).l, d0
	beq.w	loc_CBE
	movea.l	($FF00B8).l, a4
	move.l	#loc_111E, ($FF00B8).l
	jsr	(a4)
	bra.w	loc_CB8

VInt:
	movem.l	d0-a6, -(sp)
	addq.l	#1, ($FF00B0).l
	cmpi.w	#0, ($FF0036).l
	beq.w	loc_F1A
	move	#$2700, sr
	bsr.w	loc_1246
	btst	#4, d0
	beq.w	loc_D24
	cmpi.w	#0, ($FF0094).l
	beq.w	loc_D1C
	cmpi.w	#0, ($FF00A6).l
	bne.w	loc_D24
loc_D1C:
	movea.l	($FF007C).l, a3
	jsr	(a3)
loc_D24:
	btst	#5, d0
	beq.w	loc_D40
	cmpi.w	#0, ($FF00A6).l
	bne.w	loc_D40
	movea.l	($FF0080).l, a3
	jsr	(a3)
loc_D40:
	cmpi.w	#0, ($FF0038).l
	beq.w	loc_D56
	subq.w	#1, ($FF0038).l
	bra.w	loc_D72
loc_D56:
	btst	#7, d0
	beq.w	loc_D72
	cmpi.w	#0, ($FF00A6).l
	bne.w	loc_D72
	movea.l	($FF0084).l, a3
	jsr	(a3)
loc_D72:
	cmpi.w	#0, ($FF000E).l
	beq.w	loc_E16
	cmpi.w	#0, ($FF0008).l	;Predicted (Code-scan)
	bne.w	loc_DA2	;Predicted (Code-scan)
	cmpi.w	#0, ($FF0018).l	;Predicted (Code-scan)
	beq.w	loc_EE2	;Predicted (Code-scan)
	movea.l	($FF00A2).l, a3	;Predicted (Code-scan)
	jsr	(a3)	;Predicted (Code-scan) (Uncertain target!)
	bra.w	loc_EE2	;Predicted (Code-scan)
loc_DA2:
	btst	#6, d0	;Predicted (Code-scan)
	beq.w	loc_DCA	;Predicted (Code-scan)
	cmpi.w	#0, ($FF0094).l	;Predicted (Code-scan)
	beq.w	loc_DC2	;Predicted (Code-scan)
	cmpi.w	#0, ($FF00A6).l	;Predicted (Code-scan)
	bne.w	loc_DCA	;Predicted (Code-scan)
loc_DC2:
	movea.l	($FF0078).l, a3	;Predicted (Code-scan)
	jsr	(a3)	;Predicted (Code-scan) (Uncertain target!)
loc_DCA:
	move.w	($FF0004).l, d1	;Predicted (Code-scan)
	cmp.w	($FF0014).l, d1	;Predicted (Code-scan)
	bne.w	loc_DEA	;Predicted (Code-scan)
	move.w	($FF0006).l, d1	;Predicted (Code-scan)
	cmp.w	($FF0016).l, d1	;Predicted (Code-scan)
	beq.w	loc_E0A	;Predicted (Code-scan)
loc_DEA:
	movea.l	($FF008C).l, a3	;Predicted (Code-scan)
	jsr	(a3)	;Predicted (Code-scan) (Uncertain target!)
	cmpi.l	#loc_111E, ($FF00B8).l	;Predicted (Code-scan)
	bne.w	loc_E0A	;Predicted (Code-scan)
	move.l	($FF0088).l, ($FF00B8).l	;Predicted (Code-scan)
loc_E0A:
	movea.l	($FF009A).l, a3	;Predicted (Code-scan)
	jsr	(a3)	;Predicted (Code-scan) (Uncertain target!)
	bra.w	loc_EE2	;Predicted (Code-scan)
loc_E16:
	btst	#6, d0
	beq.w	loc_E3E
	cmpi.w	#0, ($FF0094).l
	beq.w	loc_E36
	cmpi.w	#0, ($FF00A6).l
	bne.w	loc_E3E
loc_E36:
	movea.l	($FF0078).l, a3
	jsr	(a3)
loc_E3E:
	move.w	($FF0046).l, d7
	bpl.w	loc_E62
	clr.w	d7
	cmpi.w	#0, ($FF0050).l
	beq.w	loc_E62
	addi.w	#1, ($FF0050).l
	bra.w	loc_EE2
loc_E62:
	btst	#0, d0
	beq.w	loc_E72
	movea.l	($FF0068).l, a3
	jsr	(a3)
loc_E72:
	btst	#1, d0
	beq.w	loc_E82
	movea.l	($FF006C).l, a3
	jsr	(a3)
loc_E82:
	btst	#2, d0
	beq.w	loc_E92
	movea.l	($FF0070).l, a3
	jsr	(a3)
loc_E92:
	btst	#3, d0
	beq.w	loc_EA2
	movea.l	($FF0074).l, a3
	jsr	(a3)
loc_EA2:
	move.b	d0, d1
	andi.w	#$F, d1
	beq.w	loc_ECC
	movea.l	($FF008C).l, a3
	jsr	(a3)
	cmpi.l	#loc_111E, ($FF00B8).l
	bne.w	loc_ECC
	move.l	($FF0088).l, ($FF00B8).l
loc_ECC:
	movea.l	($FF009A).l, a3
	jsr	(a3)
	dbf	d7, loc_E62
	move.w	($FF0046).l, ($FF0050).l
loc_EE2:
	move.w	d0, d1
	andi.w	#$F0, d1
	beq.w	loc_EF8
	move.w	#3, ($FF00A6).l
	bra.w	loc_F0C
loc_EF8:
	cmpi.w	#0, ($FF00A6).l
	beq.w	loc_F0C
	subi.w	#1, ($FF00A6).l
loc_F0C:
	move.b	d0, $00FF00A8
	movea.l	($FF009E).l, a3
	jsr	(a3)
loc_F1A:
	jsr	(loc_A81A).l
	jsr	(loc_A4C4).l
	movem.l	(sp)+, d0-a6
	rte
loc_F2C:
	addi.w	#1, ($FF0044).l
	cmpi.w	#5, ($FF0044).l
	bne.w	loc_F48
	move.w	#0, ($FF0044).l
loc_F48:
	move.w	($FF0044).l, d1
	lsl.w	#1, d1
	movea.l	#$F88, a1
	adda.w	d1, a1
	move.w	(a1), ($FF0046).l
	clr.w	($FF0050).l
	cmpi.w	#0, ($FF004A).l
	bne.w	loc_F86
	move.w	($FF0046).l, ($FF0048).l
	clr.w	($FF0046).l
	clr.w	($FF0052).l
loc_F86:
	rts
	dc.w	$FFF1
	dc.w	$FFFF
loc_F8C:
	dc.w	$0000
	dc.w	$0001
	dc.w	$0003
	
loc_F92:
	cmpi.w	#0, ($FF0006).l
	beq.w	loc_FA6
	subi.w	#1, ($FF0006).l
loc_FA6:
	cmpi.l	#0, ($FF0032).l
	beq.w	loc_FBE
	subi.l	#$10000, ($FF0032).l
loc_FBE:
	rts
	
loc_FC0:
	cmpi.w	#$DF, ($FF0006).l
	beq.w	loc_FD4
	addi.w	#1, ($FF0006).l
loc_FD4:
	cmpi.l	#$DF0000, ($FF0032).l
	beq.w	loc_FEC
	addi.l	#$10000, ($FF0032).l
loc_FEC:
	rts
	
loc_FEE:
	cmpi.w	#0, ($FF0004).l
	beq.w	loc_1002
	subi.w	#1, ($FF0004).l
loc_1002:
	cmpi.l	#0, ($FF002E).l
	beq.w	loc_101A
	subi.l	#$10000, ($FF002E).l
loc_101A:
	rts
	
loc_101C:
	cmpi.w	#$13F, ($FF0004).l
	beq.w	loc_1030
	addi.w	#1, ($FF0004).l
loc_1030:
	cmpi.l	#$13F0000, ($FF002E).l
	beq.w	loc_1048
	addi.l	#$10000, ($FF002E).l
loc_1048:
	rts

loc_104A:
	move.l	#loc_F92, ($FF0068).l
	move.l	#loc_FC0, ($FF006C).l
	move.l	#loc_FEE, ($FF0070).l
	move.l	#loc_101C, ($FF0074).l
	move.l	#loc_111E, ($FF007C).l
	move.l	#loc_111E, ($FF0088).l
	move.l	#loc_111E, ($FF0090).l
	move.l	#loc_111E, ($FF009A).l
	move.l	#loc_111E, ($FF009E).l
	move.l	#loc_1106, ($FF00A2).l
	move.l	#loc_1144, ($FF0084).l
	move.l	#loc_F2C, ($FF0080).l
	move.l	#loc_10DA, ($FF008C).l
	bsr.w	loc_10DA
	move.w	#1, ($FF0094).l
	rts

loc_10DA:
	move.l	#$5C000003, (a0)
	move.w	($FF0006).l, d1
	add.w	($FF004E).l, d1
	move.w	d1, (a2)
	move.w	#$500, (a2)
	move.w	#$A460, (a2)
	move.w	($FF0004).l, d1
	add.w	($FF004C).l, d1
	move.w	d1, (a2)
	rts
loc_1106:
	move.l	#$5C000003, (a0)
	move.w	#0, (a2)
	move.w	#0, (a2)
	move.w	#0, (a2)
	move.w	#0, (a2)
	rts
loc_111E:
	rts
	cmpi.w	#0, ($FF0066).l
	beq.w	loc_1134
	clr.w	($FF0066).l
	rts
loc_1134:
	move.w	#1, ($FF0066).l
	movea.l	($FF0088).l, a3
	jmp	(a3)
loc_1144:
	movea.l	($FF0090).l, a3
	jsr	(a3)
	move.l	#2, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	cmpi.l	#loc_AA20, ($FF0060).l
	bne.w	loc_11C8
	cmpi.l	#loc_56D4, ($FF0058).l
	beq.w	loc_118C
	cmpi.l	#loc_5754, ($FF0058).l
	beq.w	loc_118C
	bra.w	loc_1196
loc_118C:
	move.l	#loc_5414, ($FF0058).l	;Predicted (Code-scan)
loc_1196:
	move.l	#loc_5A96, -(sp)
	cmpi.w	#9, ($FF003C).l
	bne.w	loc_11B2
	jsr	(loc_16A2).l	;Predicted (Code-scan)
	bra.w	loc_1238	;Predicted (Code-scan)
loc_11B2:
	cmpi.w	#$B, ($FF003C).l
	bne.w	loc_1238
	jsr	(loc_16A2).l	;Predicted (Code-scan)
	bra.w	loc_1238	;Predicted (Code-scan)
loc_11C8:
	cmpi.l	#loc_ABDC, ($FF0060).l
	bne.w	loc_1232
	cmpi.l	#loc_56D4, ($FF0058).l
	beq.w	loc_11F6
	cmpi.l	#loc_5654, ($FF0058).l
	beq.w	loc_11F6
	bra.w	loc_1200
loc_11F6:
	move.l	#loc_5414, ($FF0058).l
loc_1200:
	move.l	#loc_5ABC, -(sp)
	cmpi.w	#9, ($FF003C).l
	bne.w	loc_121C
	jsr	(loc_16A2).l	;Predicted (Code-scan)
	bra.w	loc_1238	;Predicted (Code-scan)
loc_121C:
	cmpi.w	#$A, ($FF003C).l
	bne.w	loc_1238
	jsr	(loc_16A2).l	;Predicted (Code-scan)
	bra.w	loc_1238	;Predicted (Code-scan)
loc_1232:
	move.l	#loc_5A70, -(sp)
loc_1238:
	move.l	($FF0058).l, -(sp)
	jsr	(loc_9794).l
	rts
loc_1246:
	cmpi.w	#0, ($FF000E).l
	beq.w	loc_12A0
	move.w	($FF0004).l, ($FF0014).l	;Predicted (Code-scan)
	move.w	($FF0006).l, ($FF0016).l	;Predicted (Code-scan)
	move.w	($FF0008).l, ($FF0018).l	;Predicted (Code-scan)
	jsr	(loc_AF8C).l	;Predicted (Code-scan)
	jsr	(loc_AFBA).l	;Predicted (Code-scan)
	clr.b	d0	;Predicted (Code-scan)
	cmpi.w	#0, ($FF000A).l	;Predicted (Code-scan)
	beq.w	loc_128E	;Predicted (Code-scan)
	ori.b	#$40, d0	;Predicted (Code-scan)
loc_128E:
	cmpi.w	#0, ($FF000C).l	;Predicted (Code-scan)
	beq.w	loc_129E	;Predicted (Code-scan)
	ori.b	#$80, d0	;Predicted (Code-scan)
loc_129E:
	rts	;Predicted (Code-scan)

loc_12A0:
	move.b	#$40, ($A10009).l
	move.b	#0, ($A10003).l
	move.w	#$A, d1
loc_12B4:
	dbf	d1, loc_12B4
	moveq	#0, d0
	move.b	($A10003).l, d0
	lsl.b	#2, d0
	andi.b	#$C0, d0
	move.b	#$40, ($A10003).l
	move.w	#$A, d1
loc_12D2:
	dbf	d1, loc_12D2
	move.b	($A10003).l, d1
	andi.b	#$3F, d1
	or.b	d1, d0
	not.b	d0
	rts
	
; ---------------------------------------
	move.b	#$40, ($A1000B).l
	move.b	#0, ($A10005).l
	move.w	#$A, d1
-
	dbf	d1, -
	moveq	#0, d0
	move.b	($A10005).l, d0
	lsl.b	#2, d0
	andi.b	#$C0, d0
	move.b	#$40, ($A10005).l
	move.w	#$A, d1
-
	dbf	d1, -
	move.b	($A10005).l, d1
	andi.b	#$3F, d1
	or.b	d1, d0
	not.b	d0
	rts
; ---------------------------------------	

loc_132C:
	move.w	d1, d3
	andi.l	#$FFF8, d3
	mulu.w	#$A0, d3
	andi.l	#7, d1
	lsl.l	#2, d1
	add.l	d1, d3
	move.w	d0, d1
	andi.l	#$FFF8, d1
	lsl.l	#2, d1
	add.l	d1, d3
	andi.l	#7, d0
	move.w	d0, d1
	lsr.l	#1, d1
	add.l	d1, d3
	move.w	d3, d1
	andi.w	#$3FFF, d3
	lsl.l	#8, d3
	lsl.l	#8, d3
	lsr.l	#8, d1
	lsr.l	#6, d1
	add.l	d1, d3
	rts
loc_136C:
	link	a6, #0
	movem.l	d6/d5/d4/d3/d2/d1/d0, -(sp)
	move.w	($FF0040).l, d0
	move.w	d0, d4
	lsr.w	#1, d0
	sub.w	d0, $A(a6)
	sub.w	d0, $8(a6)
loc_1386:
	move.w	($FF0040).l, d5
	move.w	$A(a6), d6
loc_1390:
	move.w	d6, d0
	bmi.w	loc_1420
	cmpi.w	#$140, d0
	bge.w	loc_1420
	move.w	$8(a6), d1
	bmi.w	loc_1420
	cmpi.w	#$E0, d1
	bge.w	loc_1420
	bsr.w	loc_1448
	cmpi.w	#0, ($FF003E).l
	beq.w	loc_13C8
	cmpi.w	#0, d2
	bne.w	loc_13C8
	moveq	#8, d2	;Predicted (Code-scan)
loc_13C8:
	bsr.w	loc_132C
	move.w	#$FFF0, d1
	btst	#$10, d3
	bne.w	loc_13DE
	move.w	#$F0FF, d1
	lsl.w	#8, d2
loc_13DE:
	btst	#0, d0
	bne.w	loc_13EE
	lsl.w	#4, d1
	ori.w	#$F, d1
	lsl.w	#4, d2
loc_13EE:
	andi.l	#$FFFEFFFF, d3
	move	#$2700, sr
	move.l	d3, (a0)
	move.w	(a2), d0
	cmpi.w	#0, ($FF003E).l
	bne.w	loc_1410
	and.w	d0, d1
	or.w	d1, d2
	bra.w	loc_1412
loc_1410:
	eor.w	d0, d2
loc_1412:
	addi.l	#$40000000, d3
	move.l	d3, (a0)
	move.w	d2, (a2)
	move	#$2000, sr
loc_1420:
	addi.w	#1, d6
	subi.w	#1, d5
	bne.w	loc_1390
	addi.w	#1, $8(a6)
	subi.w	#1, d4
	bne.w	loc_1386
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/d6
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	jmp	(a3)
loc_1448:
	move.w	($FF0042).l, d2
	cmpi.w	#$F, d2
	ble.w	loc_148A
	subi.w	#$10, d2
	lsl.w	#6, d2
	andi.l	#$FFFF, d2
	movem.l	d1/d0, -(sp)
	andi.l	#7, d0
	andi.l	#7, d1
	lsl.l	#3, d1
	add.l	d0, d2
	add.l	d1, d2
	addi.l	#$148C, d2
	movea.l	d2, a1
	move.b	(a1), d2
	andi.w	#$FF, d2
	movem.l	(sp)+, d0/d1
loc_148A:
	rts
	dc.b	$0F, $0F, $0A, $0F, $0F, $0F, $0F, $0F, $0A, $0A, $0A, $0A, $0A, $0F, $0F, $0F
	dc.b	$0F, $0A, $0A, $0A, $0F, $0F, $0F, $0F, $0F, $0A, $0F, $0A, $0F, $0F, $0F, $0F ;0x0 (0x0000148C-0x000014CC, Entry count: 0x40)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0A, $0F, $0A, $0F, $0F, $0F, $0F, $0F, $0A, $0A, $0A
	dc.b	$0A, $0F, $0F, $0F, $0A, $0A, $0A, $0A, $0F, $0F, $0F, $0F, $0F, $0F, $0A, $0F ;0x20
	dc.b	$0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $02, $02, $02, $0C, $02, $02, $02
	dc.b	$0C, $02, $02, $02, $0C, $02, $02, $02, $0C, $02, $02, $02, $0C, $02, $02, $02 ;0x0 (0x000014CC-0x0000150C, Entry count: 0x40) [Unknown data]
	dc.b	$0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $02, $02, $02, $0C, $02, $02, $02
	dc.b	$0C, $02, $02, $02, $0C, $02, $02, $02, $0C, $02, $02, $02, $0C, $02, $02, $02 ;0x20
	dc.b	$0D, $07, $07, $07, $07, $07, $07, $07, $0D ;0x0 (0x0000150C-0x00001515, Entry count: 0x9)
	dc.b	$07, $07, $07, $07, $07, $07 ;0x0 (0x00001515-0x0000151B, Entry count: 0x6) [Unknown data]
	dc.b	$07
	dc.b	$0D
	dc.b	$07, $07, $07, $07, $07, $07 ;0x0 (0x0000151D-0x00001523, Entry count: 0x6) [Unknown data]
	dc.b	$07
	dc.b	$0D
	dc.b	$0D, $0D, $0D, $0D, $0D, $0D ;0x0 (0x00001525-0x0000152B, Entry count: 0x6) [Unknown data]
	dc.b	$0D
	dc.b	$07
	dc.b	$07, $07, $07, $0D, $07, $07 ;0x0 (0x0000152D-0x00001533, Entry count: 0x6) [Unknown data]
	dc.b	$07
	dc.b	$07
	dc.b	$07, $07, $07, $0D, $07, $07 ;0x0 (0x00001535-0x0000153B, Entry count: 0x6) [Unknown data]
	dc.b	$07
	dc.b	$07
	dc.b	$07, $07, $07, $0D, $07, $07 ;0x0 (0x0000153D-0x00001543, Entry count: 0x6) [Unknown data]
	dc.b	$07, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $09, $09, $09, $09, $0C, $0C, $0C
	dc.b	$0C, $09, $09, $09, $09, $0C, $0C, $0C, $0C, $09, $09, $09, $09, $0C, $0C, $0C ;0x0 (0x00001543-0x0000158C, Entry count: 0x49)
	dc.b	$0C, $09, $09, $09, $09, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $09, $09, $09
	dc.b	$09, $0C, $0C, $0C, $0C, $09, $09, $09, $09, $0C, $0C, $0C, $0C, $09, $09, $09 ;0x20
	dc.b	$09, $0C, $0C, $0C, $0C, $09, $09, $09, $09 ;0x40
loc_158C:
	movem.l	d3/d2/d1/d0, -(sp)
	clr.l	d0
	move.l	d4, d1
	bsr.w	loc_132C
	move.l	d3, (a0)
	movea.l	#$FF3214, a3
	move.l	#$27, d0
loc_15A6:
	move.w	(a2), (a3)
	addq.l	#4, a3
	dbf	d0, loc_15A6
	addi.l	#$20000, d3
	move.l	d3, (a0)
	movea.l	#$FF3216, a3
	move.l	#$27, d0
loc_15C2:
	move.w	(a2), (a3)
	addq.l	#4, a3
	dbf	d0, loc_15C2
	clr.w	d5
	movem.l	(sp)+, d0/d1/d2/d3
	rts
loc_15D2:
	movem.l	d3/d2/d1/d0, -(sp)
	cmpi.w	#0, d5
	beq.w	loc_161E
	clr.l	d0
	move.l	d4, d1
	bsr.w	loc_132C
	addi.l	#$40000000, d3
	move.l	d3, (a0)
	movea.l	#$FF3214, a3
	move.l	#$27, d0
loc_15FA:
	move.w	(a3), (a2)
	addq.l	#4, a3
	dbf	d0, loc_15FA
	addi.l	#$20000, d3
	move.l	d3, (a0)
	movea.l	#$FF3216, a3
	move.l	#$27, d0
loc_1616:
	move.w	(a3), (a2)
	addq.l	#4, a3
	dbf	d0, loc_1616
loc_161E:
	movem.l	(sp)+, d0/d1/d2/d3
	rts
loc_1624:
	move.l	d2, -(sp)
	move.w	d0, d1
	moveq	#$C, d2
	lsr.w	#1, d1
	bcc.w	loc_1632
	moveq	#8, d2
loc_1632:
	lsr.w	#1, d1
	bcc.w	loc_163C
	subi.b	#8, d2
loc_163C:
	lsl.w	#1, d1
	andi.l	#$FFFF, d1
	movea.l	#$FF3214, a3
	adda.l	d1, a3
	move.w	(a3), d1
	lsr.w	d2, d1
	andi.w	#$F, d1
	move.l	(sp)+, d2
	rts
loc_1658:
	movem.l	d4/d3/d2/d1/d0, -(sp)
	move.w	d0, d1
	moveq	#$C, d2
	lsr.w	#1, d1
	bcc.w	loc_1668
	moveq	#8, d2
loc_1668:
	lsr.w	#1, d1
	bcc.w	loc_1672
	subi.b	#8, d2
loc_1672:
	lsl.w	#1, d1
	andi.l	#$FFFF, d1
	movea.l	#$FF3214, a3
	adda.l	d1, a3
	move.l	d2, -(sp)
	move.w	d4, d1
	jsr	(loc_3016).l
	move.w	d2, d1
	move.l	(sp)+, d2
	move.w	#$FFF0, d3
	rol.w	d2, d3
	lsl.w	d2, d1
	and.w	d3, (a3)
	or.w	d1, (a3)
	movem.l	(sp)+, d0/d1/d2/d3/d4
	rts
loc_16A2:
	move.w	#5, ($FF003C).l
	move.w	#$82, ($FF004C).l
	move.w	#$70, ($FF004E).l
	bsr.w	loc_104A
	move.l	#$1120, ($FF0078).l
	move.l	#$16A2, ($FF0096).l
	move.l	#$170C, ($FF009A).l
	move.l	#$176E, ($FF0090).l
	move.l	#$1776, ($FF00A2).l
	lea	(loc_B8D4).l, a1
	moveq	#$3F, d0
	move.l	#$4C000002, (a0)
loc_16FE:
	move.w	(a1)+, (a2)
	dbf	d0, loc_16FE
	clr.w	($FF0066).l
	rts
	cmpi.w	#0, ($FF0066).l
	bne.w	loc_1720
	jsr	(loc_A9E6).l
	rts
loc_1720:
	jsr	(loc_AA16).l
	cmpi.w	#0, ($FF000E).l
	bne.w	loc_1744
loc_1732:
	move.w	($FF0004).l, -(sp)
	move.w	($FF0006).l, -(sp)
	bsr.w	loc_136C
	rts
loc_1744:
	cmpi.w	#$150, ($FF0014).l	;Predicted (Code-scan)
	bgt.w	loc_1732	;Predicted (Code-scan)
	move.w	($FF0014).l, -(sp)	;Predicted (Code-scan)
	move.w	($FF0016).l, -(sp)	;Predicted (Code-scan)
	move.w	($FF0004).l, -(sp)	;Predicted (Code-scan)
	move.w	($FF0006).l, -(sp)	;Predicted (Code-scan)
	bsr.w	loc_1A18	;Predicted (Code-scan)
	rts	;Predicted (Code-scan)
	jsr	(loc_A9E6).l
	rts
	dc.b	$4E, $B9, $00, $00, $17, $6E, $4E, $B9, $00, $00, $11, $06, $4E, $75 ;0x0 (0x00001776-0x00001784, Entry count: 0xE) [Unknown data]
	move.w	#4, ($FF003C).l
	move.w	#$7C, ($FF004C).l
	move.w	#$7C, ($FF004E).l
	bsr.w	loc_104A
	move.l	#$1120, ($FF0078).l
	move.l	#$1784, ($FF0096).l
	move.l	#$17DC, ($FF0088).l
	lea	(loc_BA54).l, a1
	moveq	#$3F, d0
	move.l	#$4C000002, (a0)
loc_17CC:
	move.w	(a1)+, (a2)
	dbf	d0, loc_17CC
	move.w	#0, ($FF0066).l
	rts
	cmpi.w	#0, ($FF0066).l
	beq.w	loc_1842
	move.l	#6, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	move.w	($FF0040).l, $00FF0022
	move.w	#8, ($FF0040).l
	move.w	($FF0042).l, $00FF0024
	move.w	#0, ($FF0042).l
	move.w	($FF0004).l, -(sp)
	move.w	($FF0006).l, -(sp)
	bsr.w	loc_136C
	move.w	$00FF0022, ($FF0040).l
	move.w	$00FF0024, ($FF0042).l
loc_1842:
	rts
	move.w	#6, ($FF003C).l
	move.w	#$78, ($FF004C).l
	move.w	#$78, ($FF004E).l
	bsr.w	loc_104A
	move.l	#$19B2, ($FF0088).l
	move.l	#$18B2, ($FF0078).l
	move.l	#$196C, ($FF007C).l
	move.l	#$196C, ($FF0090).l
	move.l	#$1844, ($FF0096).l
	move.l	#$1A0C, ($FF00A2).l
	lea	(loc_BAD4).l, a1
	moveq	#$3F, d0
	move.l	#$4C000002, (a0)
loc_18AA:
	move.w	(a1)+, (a2)
	dbf	d0, loc_18AA
	rts
	move.l	#8, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	move.l	#loc_18D0, ($FF00B8).l
	rts
	
loc_18D0:
	cmpi.w	#1, ($FF003E).l
	beq.w	loc_1920
	move.w	($FF0004).l, $00FF0022
	move.w	($FF0006).l, $00FF0024
	move.w	($FF0004).l, $00FF001A
	move.w	($FF0006).l, $00FF001E
	move.w	#1, ($FF003E).l
	move.w	($FF0040).l, ($FF0066).l
	move.w	#1, ($FF0040).l
	rts
loc_1920:
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	bsr.w	loc_1A18
	move.w	#0, ($FF003E).l
	move.w	($FF0066).l, ($FF0040).l
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	bsr.w	loc_1A18
	rts
	move.l	#loc_1978, ($FF00B8).l
	rts
	
loc_1978:
	cmpi.w	#1, ($FF003E).l
	bne.w	loc_19B0
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	bsr.w	loc_1A18
	clr.w	($FF003E).l
	move.w	($FF0066).l, ($FF0040).l
loc_19B0:
	rts
	cmpi.w	#0, ($FF003E).l
	beq.w	loc_1A0A
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	move.w	($FF0004).l, $00FF001A
	move.w	($FF0006).l, $00FF001E
	bsr.w	loc_1A18
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	bsr.w	loc_1A18
loc_1A0A:
	rts
	dc.b	$61, $00, $FF, $5E, $4E, $B9, $00, $00, $11, $06, $4E, $75 ;0x0 (0x00001A0C-0x00001A18, Entry count: 0xC) [Unknown data]
loc_1A18:
	link	a6, #0
	movem.l	a5/d7/d6/d5/d4/d3/d2/d1/d0, -(sp)
	move.w	$E(a6), d0
	cmp.w	$A(a6), d0
	bne.w	loc_1A38
	move.w	$C(a6), d0
	cmp.w	$8(a6), d0
	beq.w	loc_1B16
loc_1A38:
	move.w	$E(a6), -(sp)
	move.w	$C(a6), -(sp)
	bsr.w	loc_136C
	move.w	$A(a6), d0
	sub.w	$E(a6), d0
	bcc.w	loc_1A52
	neg.w	d0
loc_1A52:
	move.w	$8(a6), d1
	sub.w	$C(a6), d1
	bcc.w	loc_1A60
	neg.w	d1
loc_1A60:
	cmp.w	d0, d1
	SLE	d7
	ble.w	loc_1A84
	move.w	$E(a6), d0
	move.w	$C(a6), $E(a6)
	move.w	d0, $C(a6)
	move.w	$A(a6), d0
	move.w	$8(a6), $A(a6)
	move.w	d0, $8(a6)
loc_1A84:
	move.w	$A(a6), d0
	cmp.w	$E(a6), d0
	bge.w	loc_1AA8
	move.w	$E(a6), $A(a6)
	move.w	d0, $E(a6)
	move.w	$C(a6), d0
	move.w	$8(a6), $C(a6)
	move.w	d0, $8(a6)
loc_1AA8:
	move.w	$A(a6), d0
	sub.w	$E(a6), d0
	movea.w	#1, a5
	move.w	$8(a6), d1
	sub.w	$C(a6), d1
	bcc.w	loc_1AC6
	neg.w	d1
	movea.w	#$FFFF, a5
loc_1AC6:
	move.w	d1, d2
	lsl.w	#1, d2
	move.w	d2, d3
	sub.w	d0, d3
	move.w	d1, d4
	sub.w	d0, d4
	lsl.w	#1, d4
	move.w	$E(a6), d5
	move.w	$C(a6), d6
loc_1ADC:
	cmp.w	$A(a6), d5
	beq.w	loc_1B16
	addi.w	#1, d5
	cmpi.w	#0, d3
	ble.w	loc_1AF8
	add.w	d4, d3
	add.w	a5, d6
	bra.w	loc_1AFA
loc_1AF8:
	add.w	d2, d3
loc_1AFA:
	btst	#1, d7
	beq.w	loc_1B0A
	move.w	d5, -(sp)
	move.w	d6, -(sp)
	bra.w	loc_1B0E
loc_1B0A:
	move.w	d6, -(sp)
	move.w	d5, -(sp)
loc_1B0E:
	bsr.w	loc_136C
	bra.w	loc_1ADC
loc_1B16:
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/d6/d7/a5
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#8, a7
	jmp	(a3)
	move.w	#1, ($FF003C).l
	move.w	#$78, ($FF004C).l
	move.w	#$78, ($FF004E).l
	bsr.w	loc_104A
	move.l	#$1C90, ($FF0088).l
	move.l	#$1B92, ($FF0078).l
	move.l	#$1C4A, ($FF007C).l
	move.l	#$1C4A, ($FF0090).l
	move.l	#$1B24, ($FF0096).l
	move.l	#$1CEA, ($FF00A2).l
	lea	(loc_BAD4).l, a1
	moveq	#$3F, d0
	move.l	#$4C000002, (a0)
loc_1B8A:
	move.w	(a1)+, (a2)
	dbf	d0, loc_1B8A
	rts
	move.l	#8, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	move.l	#loc_1BB0, ($FF00B8).l
	rts
	
loc_1BB0:
	cmpi.w	#1, ($FF003E).l
	beq.w	loc_1C00
	move.w	($FF0004).l, $00FF0022
	move.w	($FF0006).l, $00FF0024
	move.w	($FF0004).l, $00FF001A
	move.w	($FF0006).l, $00FF001E
	move.w	#1, ($FF003E).l
	move.w	($FF0040).l, ($FF0066).l
	move.w	#1, ($FF0040).l
	rts
loc_1C00:
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	bsr.w	loc_1CF6
	clr.w	($FF003E).l
	move.w	($FF0066).l, ($FF0040).l
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	bsr.w	loc_1CF6
	rts
	move.l	#loc_1C56, ($FF00B8).l
	rts
	
loc_1C56:
	cmpi.w	#1, ($FF003E).l
	bne.w	loc_1C8E
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	bsr.w	loc_1CF6
	clr.w	($FF003E).l
	move.w	($FF0066).l, ($FF0040).l
loc_1C8E:
	rts
	cmpi.w	#0, ($FF003E).l
	beq.w	loc_1CE8
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	move.w	($FF0004).l, $00FF001A
	move.w	($FF0006).l, $00FF001E
	bsr.w	loc_1CF6
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	bsr.w	loc_1CF6
loc_1CE8:
	rts
	dc.b	$61, $00, $FF, $5E, $4E, $B9, $00, $00, $11, $06, $4E, $75 ;0x0 (0x00001CEA-0x00001CF6, Entry count: 0xC) [Unknown data]
loc_1CF6:
	link	a6, #0
	move.l	d0, -(sp)
	move.w	$E(a6), d0
	cmp.w	$A(a6), d0
	bne.w	loc_1D14
	move.w	$C(a6), d0
	cmp.w	$8(a6), d0
	beq.w	loc_1D64
loc_1D14:
	move.w	$E(a6), -(sp)
	move.w	$C(a6), -(sp)
	move.w	$A(a6), -(sp)
	move.w	$C(a6), -(sp)
	bsr.w	loc_1A18
	move.w	$A(a6), -(sp)
	move.w	$C(a6), -(sp)
	move.w	$A(a6), -(sp)
	move.w	$8(a6), -(sp)
	bsr.w	loc_1A18
	move.w	$A(a6), -(sp)
	move.w	$8(a6), -(sp)
	move.w	$E(a6), -(sp)
	move.w	$8(a6), -(sp)
	bsr.w	loc_1A18
	move.w	$E(a6), -(sp)
	move.w	$8(a6), -(sp)
	move.w	$E(a6), -(sp)
	move.w	$C(a6), -(sp)
	bsr.w	loc_1A18
loc_1D64:
	move.l	(sp)+, d0
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#8, a7
	jmp	(a3)
	move.w	#2, ($FF003C).l
	move.w	#$78, ($FF004C).l
	move.w	#$78, ($FF004E).l
	bsr.w	loc_104A
	move.l	#$1EDC, ($FF0088).l
	move.l	#$1DDE, ($FF0078).l
	move.l	#$1E96, ($FF007C).l
	move.l	#$1E96, ($FF0090).l
	move.l	#$1D70, ($FF0096).l
	move.l	#$1F36, ($FF00A2).l
	lea	(loc_BAD4).l, a1
	moveq	#$3F, d0
	move.l	#$4C000002, (a0)
loc_1DD6:
	move.w	(a1)+, (a2)
	dbf	d0, loc_1DD6
	rts
	move.l	#8, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	move.l	#loc_1DFC, ($FF00B8).l
	rts
	
loc_1DFC:
	cmpi.w	#1, ($FF003E).l
	beq.w	loc_1E4C
	move.w	($FF0004).l, $00FF0022
	move.w	($FF0006).l, $00FF0024
	move.w	($FF0004).l, $00FF001A
	move.w	($FF0006).l, $00FF001E
	move.w	#1, ($FF003E).l
	move.w	($FF0040).l, ($FF0066).l
	move.w	#1, ($FF0040).l
	rts
loc_1E4C:
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	bsr.w	loc_1FE0
	clr.w	($FF003E).l
	move.w	($FF0066).l, ($FF0040).l
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	bsr.w	loc_1FE0
	rts
	move.l	#loc_1EA2, ($FF00B8).l
	rts
	
loc_1EA2:
	cmpi.w	#1, ($FF003E).l
	bne.w	loc_1EDA
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	bsr.w	loc_1FE0
	clr.w	($FF003E).l
	move.w	($FF0066).l, ($FF0040).l
loc_1EDA:
	rts
	cmpi.w	#0, ($FF003E).l
	beq.w	loc_1F34
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	move.w	($FF0004).l, $00FF001A
	move.w	($FF0006).l, $00FF001E
	bsr.w	loc_1FE0
	move.w	$00FF0022, -(sp)
	move.w	$00FF0024, -(sp)
	move.w	$00FF001A, -(sp)
	move.w	$00FF001E, -(sp)
	bsr.w	loc_1FE0
loc_1F34:
	rts
	dc.b	$61, $00, $FF, $5E, $4E, $B9, $00, $00, $11, $06, $4E, $75 ;0x0 (0x00001F36-0x00001F42, Entry count: 0xC) [Unknown data]
loc_1F42:
	link	a6, #0
	movem.l	a5/a4/d7/d6/d5/d4/d3/d2/d1/d0, -(sp)
	move.w	$C(a6), d0
	move.w	$E(a6), d1
	move.w	$8(a6), d2
	move.w	$A(a6), d3
	move.w	d0, d4
	add.w	d1, d4
	move.w	d4, -(sp)
	move.w	d2, d4
	add.w	d3, d4
	move.w	d4, -(sp)
	jsr	(loc_136C).l
	move.w	$C(a6), d0
	move.w	$E(a6), d1
	move.w	$8(a6), d2
	move.w	$A(a6), d3
	move.w	d0, d4
	add.w	d1, d4
	move.w	d4, -(sp)
	move.w	d2, d4
	sub.w	d3, d4
	move.w	d4, -(sp)
	jsr	(loc_136C).l
	move.w	$C(a6), d0
	move.w	$E(a6), d1
	move.w	$8(a6), d2
	move.w	$A(a6), d3
	move.w	d0, d4
	sub.w	d1, d4
	move.w	d4, -(sp)
	move.w	d2, d4
	add.w	d3, d4
	move.w	d4, -(sp)
	jsr	(loc_136C).l
	move.w	$C(a6), d0
	move.w	$E(a6), d1
	move.w	$8(a6), d2
	move.w	$A(a6), d3
	move.w	d0, d4
	sub.w	d1, d4
	move.w	d4, -(sp)
	move.w	d2, d4
	sub.w	d3, d4
	move.w	d4, -(sp)
	jsr	(loc_136C).l
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/d6/d7/a4/a5
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#8, a7
	jmp	(a3)
loc_1FE0:
	link	a6, #-12
	movem.l	a5/a4/d7/d6/d5/d4/d3/d2/d1/d0, -(sp)
	move.w	$E(a6), d0
	cmp.w	$A(a6), d0
	bne.w	loc_2010
	move.w	$C(a6), d0
	cmp.w	$8(a6), d0
	beq.w	loc_2196
	clr.l	d0
	clr.l	d1
	clr.l	d2
	clr.l	d3
	clr.l	d4
	clr.l	d5
	clr.l	d6
	clr.l	d7
loc_2010:
	move.w	$E(a6), d0
	move.w	$A(a6), d1
	cmp.w	d0, d1
	bgt.w	loc_2024
	move.w	d0, d1
	move.w	$A(a6), d0
loc_2024:
	move.w	$C(a6), d2
	move.w	$8(a6), d3
	cmp.w	d2, d3
	bgt.w	loc_2038
	move.w	d3, d2
	move.w	$C(a6), d3
loc_2038:
	sub.w	d0, d1
	lsr.w	#1, d1
	sub.w	d2, d3
	lsr.w	#1, d3
	move.w	d1, -$8(a6)
	mulu.w	d1, d1
	move.w	d3, -$C(a6)
	mulu.w	d3, d3
	move.l	d1, d4
	lsr.l	#2, d4
	add.l	d3, d4
	move.l	d1, d5
	mulu.w	-$C(a6), d5
	sub.l	d5, d4
	move.l	d3, d5
	mulu.w	#3, d5
	move.l	d5, d6
	move.l	d1, d7
	add.l	d7, d7
	add.l	d7, d6
	mulu.w	-$C(a6), d7
	sub.l	d7, d6
	move.l	d1, d0
	mulu.w	-$C(a6), d0
	move.l	d0, d7
	move.l	d1, d0
	lsr.l	#1, d0
	sub.l	d0, d7
	sub.l	d3, d7
	move.w	$E(a6), d0
	add.w	$A(a6), d0
	lsr.w	#1, d0
	move.w	d0, -$E(a6)
	move.w	$C(a6), d0
	add.w	$8(a6), d0
	lsr.w	#1, d0
	move.w	d0, -$10(a6)
	clr.w	d0
	move.w	-$C(a6), d2
	move.w	d0, -(sp)
	move.w	-$E(a6), -(sp)
	move.w	d2, -(sp)
	move.w	-$10(a6), -(sp)
	jsr	(loc_1F42).l
loc_20B2:
	cmpi.l	#0, d7
	ble.w	loc_2104
	cmpi.l	#0, d4
	bge.w	loc_20D8
	add.l	d5, d4
	add.l	d3, d5
	add.l	d3, d5
	add.l	d3, d6
	add.l	d3, d6
	sub.l	d3, d7
	addq.w	#1, d0
	bra.w	loc_20EE
loc_20D8:
	add.l	d6, d4
	add.l	d3, d5
	add.l	d3, d5
	add.l	d1, d6
	add.l	d1, d6
	add.l	d3, d6
	add.l	d3, d6
	sub.l	d1, d7
	sub.l	d3, d7
	addq.w	#1, d0
	subq.w	#1, d2
loc_20EE:
	move.w	d0, -(sp)
	move.w	-$E(a6), -(sp)
	move.w	d2, -(sp)
	move.w	-$10(a6), -(sp)
	jsr	(loc_1F42).l
	bra.w	loc_20B2
loc_2104:
	move.w	d0, d4
	mulu.w	d4, d4
	mulu.w	d3, d4
	move.l	d0, d5
	mulu.w	d3, d5
	add.l	d5, d4
	move.l	d3, d5
	lsr.l	#2, d5
	add.l	d5, d4
	move.w	d2, d5
	subq.w	#1, d5
	mulu.w	d5, d5
	mulu.w	d1, d5
	add.l	d5, d4
	move.l	d1, d5
	mulu.w	d3, d5
	sub.l	d5, d4
	move.w	d0, d6
	addq.w	#1, d6
	move.w	d3, d5
	add.l	d3, d5
	mulu.w	d5, d6
	move.w	d1, d5
	add.l	d1, d5
	mulu.w	d2, d5
	sub.l	d5, d6
	add.l	d1, d6
	add.l	d1, d6
	add.l	d1, d6
	move.w	d2, d5
	mulu.w	d1, d5
	add.l	d5, d5
	neg.l	d5
	add.l	d1, d5
	add.l	d1, d5
	add.l	d1, d5
loc_214C:
	cmpi.w	#0, d2
	ble.w	loc_2196
	cmpi.l	#0, d4
	bge.w	loc_2174
	add.l	d6, d4
	add.l	d1, d6
	add.l	d1, d6
	add.l	d3, d6
	add.l	d3, d6
	add.l	d1, d5
	add.l	d1, d5
	addq.w	#1, d0
	subq.w	#1, d2
	bra.w	loc_2180
loc_2174:
	add.l	d5, d4
	add.l	d1, d6
	add.l	d1, d6
	add.l	d1, d5
	add.l	d1, d5
	subq.w	#1, d2
loc_2180:
	move.w	d0, -(sp)
	move.w	-$E(a6), -(sp)
	move.w	d2, -(sp)
	move.w	-$10(a6), -(sp)
	jsr	(loc_1F42).l
	bra.w	loc_214C
loc_2196:
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/d6/d7/a4/a5
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#8, a7
	jmp	(a3)
	move.w	#0, ($FF003C).l
	bsr.w	loc_104A
	move.l	#$2378, ($FF0068).l
	move.l	#$2382, ($FF006C).l
	move.l	#$2360, ($FF0070).l
	move.l	#$236C, ($FF0074).l
	move.l	#$111E, ($FF0088).l
	move.l	#$246E, ($FF007C).l
	move.l	#$111E, ($FF008C).l
	move.l	#$21A4, ($FF0096).l
	move.l	#$2274, ($FF0090).l
	clr.w	($FF004A).l
	move.w	($FF0046).l, ($FF0048).l
	clr.w	($FF0046).l
	move.w	#0, $00FF00AE
	jsr	(loc_2288).l
	move.l	#$2426, ($FF0078).l
	clr.w	($FF0094).l
	lea	(loc_BB54).l, a1
	moveq	#$5F, d0
	move.l	#$4C000002, (a0)
loc_224C:
	move.w	(a1)+, (a2)
	dbf	d0, loc_224C
	move.w	($FF0004).l, d1
	lsl.l	#8, d1
	lsl.l	#8, d1
	move.l	d1, $00FF001A
	move.w	($FF0006).l, d1
	lsl.l	#8, d1
	lsl.l	#8, d1
	move.l	d1, $00FF001E
	rts
	move.w	#1, ($FF004A).l
	move.w	($FF0048).l, ($FF0046).l
	rts
loc_2288:
	move.l	#0, d1
	move.w	$00FF00AE, d1
	lsl.l	#2, d1
	movea.l	d1, a3
	move.w	$270A(a3), d1
	lsr.w	#6, d1
	add.w	($FF0004).l, d1
	move.w	d1, $00FF0022
	move.w	$25A2(a3), d1
	lsr.w	#6, d1
	add.w	($FF0006).l, d1
	move.w	d1, $00FF0024
	move.l	#$5C000003, (a0)
	move.w	$00FF0024, d1
	addi.w	#$7C, d1
	move.w	d1, (a2)
	move.w	#1, (a2)
	move.w	#$A460, d1
	movea.l	#0, a4
	move.w	$00FF00AE, d2
loc_22E2:
	cmp.w	$255C(a4), d2
	ble.w	loc_22F4
	adda.l	#2, a4
	bra.w	loc_22E2
loc_22F4:
	add.w	$257E(a4), d1
	cmpi.w	#$5A, $00FF00AE
	ble.w	loc_2314
	cmpi.w	#$10E, $00FF00AE
	bgt.w	loc_2314
	ori.w	#$1000, d1
loc_2314:
	cmpi.w	#$B4, $00FF00AE
	ble.w	loc_2324
	ori.w	#$800, d1
loc_2324:
	move.w	d1, (a2)
	move.w	$00FF0022, d1
	addi.w	#$7C, d1
	move.w	d1, (a2)
	move.w	$25A2(a3), d1
	lsr.w	#3, d1
	add.w	($FF0006).l, d1
	addi.w	#$7C, d1
	move.w	d1, (a2)
	move.w	#0, (a2)
	move.w	#$A465, (a2)
	move.w	$270A(a3), d1
	lsr.w	#3, d1
	add.w	($FF0004).l, d1
	addi.w	#$7C, d1
	move.w	d1, (a2)
	rts
	move.w	#$10E, d1
	andi.b	#$F4, d0
	bra.w	loc_238A
	move.w	#$5A, d1
	andi.b	#$F8, d0
	bra.w	loc_238A
	clr.w	d1
	andi.b	#$F1, d0
	bra.w	loc_238A
	move.w	#$B4, d1
	andi.b	#$F2, d0
loc_238A:
	move.b	d0, d2
	andi.b	#$50, d2
	beq.w	loc_23AE
	cmp.b	$00FF00A8, d0
	bne.w	loc_23AE
	cmpi.w	#1, $00FF0026
	bne.w	loc_23DC
	bra.w	loc_2404
loc_23AE:
	sub.w	$00FF00AE, d1
	beq.w	loc_2420
	bmi.w	loc_23C8
	cmpi.w	#$B4, d1
	bgt.w	loc_23D6
	bra.w	loc_23FC
loc_23C8:
	neg.w	d1
	cmpi.w	#$B4, d1
	blt.w	loc_23D6
	bra.w	loc_23FC
loc_23D6:
	clr.w	$00FF0026
loc_23DC:
	cmpi.w	#0, $00FF00AE
	bne.w	loc_23F0
	move.w	#$168, $00FF00AE
loc_23F0:
	subi.w	#1, $00FF00AE
	bra.w	loc_2420
loc_23FC:
	move.w	#1, $00FF0026
loc_2404:
	cmpi.w	#$167, $00FF00AE
	bne.w	loc_2418
	move.w	#$FFFF, $00FF00AE
loc_2418:
	addi.w	#1, $00FF00AE
loc_2420:
	bsr.w	loc_2288
	rts
	move.w	($FF0048).l, d7
	bpl.w	loc_244A
	clr.w	d7	;Predicted (Code-scan)
	cmpi.w	#0, ($FF0052).l	;Predicted (Code-scan)
	beq.w	loc_244A	;Predicted (Code-scan)
	addi.w	#1, ($FF0052).l	;Predicted (Code-scan)
	bra.w	loc_246C	;Predicted (Code-scan)
loc_244A:
	move.w	($FF0004).l, -(sp)
	move.w	($FF0006).l, -(sp)
	bsr.w	loc_136C
	bsr.w	loc_24A6
	dbf	d7, loc_244A
	move.w	($FF0048).l, ($FF0052).l
loc_246C:
	rts
	move.w	($FF0048).l, d7
	bpl.w	loc_2492
	clr.w	d7	;Predicted (Code-scan)
	cmpi.w	#0, ($FF0052).l	;Predicted (Code-scan)
	beq.w	loc_2492	;Predicted (Code-scan)
	addi.w	#1, ($FF0052).l	;Predicted (Code-scan)
	bra.w	loc_24A4	;Predicted (Code-scan)
loc_2492:
	bsr.w	loc_24A6
	dbf	d7, loc_2492
	move.w	($FF0048).l, ($FF0052).l
loc_24A4:
	rts
loc_24A6:
	clr.l	d1
	move.w	$00FF00AE, d1
	lsl.w	#2, d1
	movea.l	d1, a3
	move.l	$2708(a3), d1
	lsl.l	#8, d1
	add.l	d1, $00FF001A
	move.l	$00FF001A, d1
	lsr.l	#8, d1
	lsr.l	#8, d1
	move.w	d1, ($FF0004).l
	move.l	$25A0(a3), d1
	lsl.l	#8, d1
	add.l	d1, $00FF001E
	move.l	$00FF001E, d1
	lsr.l	#8, d1
	lsr.l	#8, d1
	move.w	d1, ($FF0006).l
	cmpi.w	#$FFFF, ($FF0004).l
	bne.w	loc_2508
	move.w	#$13F, ($FF0004).l
	move.l	#$13F0000, $00FF001A
loc_2508:
	cmpi.w	#$140, ($FF0004).l
	bne.w	loc_2520
	clr.w	($FF0004).l
	clr.l	$00FF001A
loc_2520:
	cmpi.w	#$FFFF, ($FF0006).l
	bne.w	loc_253E
	move.w	#$DF, ($FF0006).l
	move.l	#$DF0000, $00FF001E
loc_253E:
	cmpi.w	#$E0, ($FF0006).l
	bne.w	loc_2556
	clr.w	($FF0006).l
	clr.l	$00FF001E
loc_2556:
	bsr.w	loc_2288
	rts
	dc.w	$000C, $0022, $0039, $004F, $0066, $007C, $0093, $00A9, $00C0, $00D6, $00ED, $0103, $011A, $0130, $0147, $015D
	dc.w	$01F4, $0000, $0001, $0002, $0003, $0004, $0003, $0002, $0001, $0000, $0001, $0002, $0003, $0004, $0003, $0002 ;0x0 (0x0000255C-0x000025A0, Entry count: 0x44)
	dc.w	$0001, $0000 ;0x20
	dc.l	$FFFFFF00
	dc.l	$FFFFFF00
	dc.l	$FFFFFF00
	dc.l	$FFFFFF00
	dc.l	$FFFFFF01
	dc.l	$FFFFFF01
	dc.l	$FFFFFF01
	dc.l	$FFFFFF02
	dc.l	$FFFFFF02
	dc.l	$FFFFFF03
	dc.l	$FFFFFF04
	dc.l	$FFFFFF05
	dc.l	$FFFFFF06
	dc.l	$FFFFFF07
	dc.l	$FFFFFF08
	dc.l	$FFFFFF09
	dc.l	$FFFFFF0A
	dc.l	$FFFFFF0B
	dc.l	$FFFFFF0D
	dc.l	$FFFFFF0E
	dc.l	$FFFFFF0F
	dc.l	$FFFFFF11
	dc.l	$FFFFFF13
	dc.l	$FFFFFF14
	dc.l	$FFFFFF16
	dc.l	$FFFFFF18
	dc.l	$FFFFFF1A
	dc.l	$FFFFFF1C
	dc.l	$FFFFFF1E
	dc.l	$FFFFFF20
	dc.l	$FFFFFF22
	dc.l	$FFFFFF25
	dc.l	$FFFFFF27
	dc.l	$FFFFFF29
	dc.l	$FFFFFF2C
	dc.l	$FFFFFF2E
	dc.l	$FFFFFF31
	dc.l	$FFFFFF34
	dc.l	$FFFFFF36
	dc.l	$FFFFFF39
	dc.l	$FFFFFF3C
	dc.l	$FFFFFF3F
	dc.l	$FFFFFF42
	dc.l	$FFFFFF45
	dc.l	$FFFFFF48
	dc.l	$FFFFFF4B
	dc.l	$FFFFFF4E
	dc.l	$FFFFFF51
	dc.l	$FFFFFF55
	dc.l	$FFFFFF58
	dc.l	$FFFFFF5B
	dc.l	$FFFFFF5F
	dc.l	$FFFFFF62
	dc.l	$FFFFFF66
	dc.l	$FFFFFF6A
	dc.l	$FFFFFF6D
	dc.l	$FFFFFF71
	dc.l	$FFFFFF75
	dc.l	$FFFFFF78
	dc.l	$FFFFFF7C
	dc.l	$FFFFFF80
	dc.l	$FFFFFF84
	dc.l	$FFFFFF88
	dc.l	$FFFFFF8C
	dc.l	$FFFFFF90
	dc.l	$FFFFFF94
	dc.l	$FFFFFF98
	dc.l	$FFFFFF9C
	dc.l	$FFFFFFA0
	dc.l	$FFFFFFA4
	dc.l	$FFFFFFA8
	dc.l	$FFFFFFAD
	dc.l	$FFFFFFB1
	dc.l	$FFFFFFB5
	dc.l	$FFFFFFB9
	dc.l	$FFFFFFBE
	dc.l	$FFFFFFC2
	dc.l	$FFFFFFC6
	dc.l	$FFFFFFCB
	dc.l	$FFFFFFCF
	dc.l	$FFFFFFD4
	dc.l	$FFFFFFD8
	dc.l	$FFFFFFDC
	dc.l	$FFFFFFE1
	dc.l	$FFFFFFE5
	dc.l	$FFFFFFEA
	dc.l	$FFFFFFEE
	dc.l	$FFFFFFF3
	dc.l	$FFFFFFF7
	dc.l	$FFFFFFFC
	dc.l	$00000000
	dc.l	$00000004
	dc.l	$00000009
	dc.l	$0000000D
	dc.l	$00000012
	dc.l	$00000016
	dc.l	$0000001B
	dc.l	$0000001F
	dc.l	$00000024
	dc.l	$00000028
	dc.l	$0000002C
	dc.l	$00000031
	dc.l	$00000035
	dc.l	$0000003A
	dc.l	$0000003E
	dc.l	$00000042
	dc.l	$00000047
	dc.l	$0000004B
	dc.l	$0000004F
	dc.l	$00000053
	dc.l	$00000058
	dc.l	$0000005C
	dc.l	$00000060
	dc.l	$00000064
	dc.l	$00000068
	dc.l	$0000006C
	dc.l	$00000070
	dc.l	$00000074
	dc.l	$00000078
	dc.l	$0000007C
	dc.l	$00000080
	dc.l	$00000084
	dc.l	$00000088
	dc.l	$0000008B
	dc.l	$0000008F
	dc.l	$00000093
	dc.l	$00000096
	dc.l	$0000009A
	dc.l	$0000009E
	dc.l	$000000A1
	dc.l	$000000A5
	dc.l	$000000A8
	dc.l	$000000AB
	dc.l	$000000AF
	dc.l	$000000B2
	dc.l	$000000B5
	dc.l	$000000B8
	dc.l	$000000BB
	dc.l	$000000BE
	dc.l	$000000C1
	dc.l	$000000C4
	dc.l	$000000C7
	dc.l	$000000CA
	dc.l	$000000CC
	dc.l	$000000CF
	dc.l	$000000D2
	dc.l	$000000D4
	dc.l	$000000D7
	dc.l	$000000D9
	dc.l	$000000DB
	dc.l	$000000DE
	dc.l	$000000E0
	dc.l	$000000E2
	dc.l	$000000E4
	dc.l	$000000E6
	dc.l	$000000E8
	dc.l	$000000EA
	dc.l	$000000EC
	dc.l	$000000ED
	dc.l	$000000EF
	dc.l	$000000F1
	dc.l	$000000F2
	dc.l	$000000F3
	dc.l	$000000F5
	dc.l	$000000F6
	dc.l	$000000F7
	dc.l	$000000F8
	dc.l	$000000F9
	dc.l	$000000FA
	dc.l	$000000FB
	dc.l	$000000FC
	dc.l	$000000FD
	dc.l	$000000FE
	dc.l	$000000FE
	dc.l	$000000FF
	dc.l	$000000FF
	dc.l	$000000FF
	dc.l	$00000100
	dc.l	$00000100
	dc.l	$00000100
	dc.l	$00000100
	dc.l	$00000100
	dc.l	$00000100
	dc.l	$00000100
	dc.l	$000000FF
	dc.l	$000000FF
	dc.l	$000000FF
	dc.l	$000000FE
	dc.l	$000000FE
	dc.l	$000000FD
	dc.l	$000000FC
	dc.l	$000000FB
	dc.l	$000000FA
	dc.l	$000000F9
	dc.l	$000000F8
	dc.l	$000000F7
	dc.l	$000000F6
	dc.l	$000000F5
	dc.l	$000000F3
	dc.l	$000000F2
	dc.l	$000000F1
	dc.l	$000000EF
	dc.l	$000000ED
	dc.l	$000000EC
	dc.l	$000000EA
	dc.l	$000000E8
	dc.l	$000000E6
	dc.l	$000000E4
	dc.l	$000000E2
	dc.l	$000000E0
	dc.l	$000000DE
	dc.l	$000000DB
	dc.l	$000000D9
	dc.l	$000000D7
	dc.l	$000000D4
	dc.l	$000000D2
	dc.l	$000000CF
	dc.l	$000000CC
	dc.l	$000000CA
	dc.l	$000000C7
	dc.l	$000000C4
	dc.l	$000000C1
	dc.l	$000000BE
	dc.l	$000000BB
	dc.l	$000000B8
	dc.l	$000000B5
	dc.l	$000000B2
	dc.l	$000000AF
	dc.l	$000000AB
	dc.l	$000000A8
	dc.l	$000000A5
	dc.l	$000000A1
	dc.l	$0000009E
	dc.l	$0000009A
	dc.l	$00000096
	dc.l	$00000093
	dc.l	$0000008F
	dc.l	$0000008B
	dc.l	$00000088
	dc.l	$00000084
	dc.l	$00000080
	dc.l	$0000007C
	dc.l	$00000078
	dc.l	$00000074
	dc.l	$00000070
	dc.l	$0000006C
	dc.l	$00000068
	dc.l	$00000064
	dc.l	$00000060
	dc.l	$0000005C
	dc.l	$00000058
	dc.l	$00000053
	dc.l	$0000004F
	dc.l	$0000004B
	dc.l	$00000047
	dc.l	$00000042
	dc.l	$0000003E
	dc.l	$0000003A
	dc.l	$00000035
	dc.l	$00000031
	dc.l	$0000002C
	dc.l	$00000028
	dc.l	$00000024
	dc.l	$0000001F
	dc.l	$0000001B
	dc.l	$00000016
	dc.l	$00000012
	dc.l	$0000000D
	dc.l	$00000009
	dc.l	$00000004
	dc.l	$00000000
	dc.l	$FFFFFFFC
	dc.l	$FFFFFFF7
	dc.l	$FFFFFFF3
	dc.l	$FFFFFFEE
	dc.l	$FFFFFFEA
	dc.l	$FFFFFFE5
	dc.l	$FFFFFFE1
	dc.l	$FFFFFFDC
	dc.l	$FFFFFFD8
	dc.l	$FFFFFFD4
	dc.l	$FFFFFFCF
	dc.l	$FFFFFFCB
	dc.l	$FFFFFFC6
	dc.l	$FFFFFFC2
	dc.l	$FFFFFFBE
	dc.l	$FFFFFFB9
	dc.l	$FFFFFFB5
	dc.l	$FFFFFFB1
	dc.l	$FFFFFFAD
	dc.l	$FFFFFFA8
	dc.l	$FFFFFFA4
	dc.l	$FFFFFFA0
	dc.l	$FFFFFF9C
	dc.l	$FFFFFF98
	dc.l	$FFFFFF94
	dc.l	$FFFFFF90
	dc.l	$FFFFFF8C
	dc.l	$FFFFFF88
	dc.l	$FFFFFF84
	dc.l	$FFFFFF80
	dc.l	$FFFFFF7C
	dc.l	$FFFFFF78
	dc.l	$FFFFFF75
	dc.l	$FFFFFF71
	dc.l	$FFFFFF6D
	dc.l	$FFFFFF6A
	dc.l	$FFFFFF66
	dc.l	$FFFFFF62
	dc.l	$FFFFFF5F
	dc.l	$FFFFFF5B
	dc.l	$FFFFFF58
	dc.l	$FFFFFF55
	dc.l	$FFFFFF51
	dc.l	$FFFFFF4E
	dc.l	$FFFFFF4B
	dc.l	$FFFFFF48
	dc.l	$FFFFFF45
	dc.l	$FFFFFF42
	dc.l	$FFFFFF3F
	dc.l	$FFFFFF3C
	dc.l	$FFFFFF39
	dc.l	$FFFFFF36
	dc.l	$FFFFFF34
	dc.l	$FFFFFF31
	dc.l	$FFFFFF2E
	dc.l	$FFFFFF2C
	dc.l	$FFFFFF29
	dc.l	$FFFFFF27
	dc.l	$FFFFFF25
	dc.l	$FFFFFF22
	dc.l	$FFFFFF20
	dc.l	$FFFFFF1E
	dc.l	$FFFFFF1C
	dc.l	$FFFFFF1A
	dc.l	$FFFFFF18
	dc.l	$FFFFFF16
	dc.l	$FFFFFF14
	dc.l	$FFFFFF13
	dc.l	$FFFFFF11
	dc.l	$FFFFFF0F
	dc.l	$FFFFFF0E
	dc.l	$FFFFFF0D
	dc.l	$FFFFFF0B
	dc.l	$FFFFFF0A
	dc.l	$FFFFFF09
	dc.l	$FFFFFF08
	dc.l	$FFFFFF07
	dc.l	$FFFFFF06
	dc.l	$FFFFFF05
	dc.l	$FFFFFF04
	dc.l	$FFFFFF03
	dc.l	$FFFFFF02
	dc.l	$FFFFFF02
	dc.l	$FFFFFF01
	dc.l	$FFFFFF01
	dc.l	$FFFFFF01
	dc.l	$FFFFFF00
	dc.l	$FFFFFF00
	dc.l	$FFFFFF00
	dc.l	$FFFFFF00
	dc.l	$FFFFFF00
	dc.l	$FFFFFF00
	dc.l	$FFFFFF00
	dc.l	$FFFFFF01
	dc.l	$FFFFFF01
	dc.l	$FFFFFF01
	dc.l	$FFFFFF02
	dc.l	$FFFFFF02
	dc.l	$FFFFFF03
	dc.l	$FFFFFF04
	dc.l	$FFFFFF05
	dc.l	$FFFFFF06
	dc.l	$FFFFFF07
	dc.l	$FFFFFF08
	dc.l	$FFFFFF09
	dc.l	$FFFFFF0A
	dc.l	$FFFFFF0B
	dc.l	$FFFFFF0D
	dc.l	$FFFFFF0E
	dc.l	$FFFFFF0F
	dc.l	$FFFFFF11
	dc.l	$FFFFFF13
	dc.l	$FFFFFF14
	dc.l	$FFFFFF16
	dc.l	$FFFFFF18
	dc.l	$FFFFFF1A
	dc.l	$FFFFFF1C
	dc.l	$FFFFFF1E
	dc.l	$FFFFFF20
	dc.l	$FFFFFF22
	dc.l	$FFFFFF25
	dc.l	$FFFFFF27
	dc.l	$FFFFFF29
	dc.l	$FFFFFF2C
	dc.l	$FFFFFF2E
	dc.l	$FFFFFF31
	dc.l	$FFFFFF34
	dc.l	$FFFFFF36
	dc.l	$FFFFFF39
	dc.l	$FFFFFF3C
	dc.l	$FFFFFF3F
	dc.l	$FFFFFF42
	dc.l	$FFFFFF45
	dc.l	$FFFFFF48
	dc.l	$FFFFFF4B
	dc.l	$FFFFFF4E
	dc.l	$FFFFFF51
	dc.l	$FFFFFF55
	dc.l	$FFFFFF58
	dc.l	$FFFFFF5B
	dc.l	$FFFFFF5F
	dc.l	$FFFFFF62
	dc.l	$FFFFFF66
	dc.l	$FFFFFF6A
	dc.l	$FFFFFF6D
	dc.l	$FFFFFF71
	dc.l	$FFFFFF75
	dc.l	$FFFFFF78
	dc.l	$FFFFFF7C
	dc.l	$FFFFFF80
	dc.l	$FFFFFF84
	dc.l	$FFFFFF88
	dc.l	$FFFFFF8C
	dc.l	$FFFFFF90
	dc.l	$FFFFFF94
	dc.l	$FFFFFF98
	dc.l	$FFFFFF9C
	dc.l	$FFFFFFA0
	dc.l	$FFFFFFA4
	dc.l	$FFFFFFA8
	dc.l	$FFFFFFAD
	dc.l	$FFFFFFB1
	dc.l	$FFFFFFB5
	dc.l	$FFFFFFB9
	dc.l	$FFFFFFBE
	dc.l	$FFFFFFC2
	dc.l	$FFFFFFC6
	dc.l	$FFFFFFCB
	dc.l	$FFFFFFCF
	dc.l	$FFFFFFD4
	dc.l	$FFFFFFD8
	dc.l	$FFFFFFDC
	dc.l	$FFFFFFE1
	dc.l	$FFFFFFE5
	dc.l	$FFFFFFEA
	dc.l	$FFFFFFEE
	dc.l	$FFFFFFF3
	dc.l	$FFFFFFF7
	dc.l	$FFFFFFFC
	move.w	#7, ($FF003C).l
	move.w	#$8F, ($FF004C).l
	move.w	#$85, ($FF004E).l
	bsr.w	loc_104A
	move.l	#$1120, ($FF0078).l
	move.l	#$2CA8, ($FF0096).l
	move.l	#$2CFE, ($FF009A).l
	lea	(loc_B9D4).l, a1
	moveq	#$3F, d0
	move.l	#$4C000002, (a0)
loc_2CF0:
	move.w	(a1)+, (a2)
	dbf	d0, loc_2CF0
	clr.w	($FF0066).l
	rts
	cmpi.w	#0, ($FF0066).l
	beq.w	loc_2D60
	move.l	d0, -(sp)
	move.l	#7, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
loc_2D1E:
	bsr.w	loc_2D62
	move.l	d0, d1
	divu.w	#$7D0, d1
	bsr.w	loc_2D62
	divu.w	#$7D0, d0
	move.w	d0, d2
	move.w	d1, d3
	subi.w	#7, d2
	subi.w	#7, d3
	muls.w	d2, d2
	muls.w	d3, d3
	add.l	d3, d2
	cmpi.w	#$31, d2
	bgt.w	loc_2D1E
	add.w	($FF0004).l, d0
	move.w	d0, -(sp)
	add.w	($FF0006).l, d1
	move.w	d1, -(sp)
	bsr.w	loc_136C
	move.l	(sp)+, d0
loc_2D60:
	rts
loc_2D62:
	move.l	$00FF00BC, d0
	mulu.w	#$4E7, d0
	addi.l	#$181D, d0
	divu.w	#$7262, d0
	asr.l	#8, d0
	asr.l	#8, d0
	move.l	d0, $00FF00BC
	rts
loc_2D82:
	move.w	#3, ($FF003C).l
	move.w	#$72, ($FF004C).l
	move.w	#$71, ($FF004E).l
	bsr.w	loc_104A
	lea	(loc_2DCC).l, a3
	move.l	a3, ($FF0078).l
	lea	(loc_2D82).l, a3
	move.l	a3, ($FF0096).l
	lea	(loc_B954).l, a1
	moveq	#$3F, d0
	move.l	#$4C000002, (a0)
loc_2DC4:
	move.w	(a1)+, (a2)
	dbf	d0, loc_2DC4
	rts
loc_2DCC:
	move.l	#9, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	move.l	#loc_2DEA, ($FF00B8).l
	rts

loc_2DEA:
	move.l	d0, -(sp)
	move.w	#0, ($FF0036).l
	move.w	#3, ($FF00A6).l
	movea.l	#$FFBEF4, a4
	move.w	#$8F20, (a0)
	move.w	($FF0006).l, d4
	bsr.w	loc_158C
	move.w	($FF0004).l, d0
	bsr.w	loc_1624
	jsr	(loc_2FCC).l
	move.w	d1, d3
	move.w	($FF0006).l, d1
	jsr	(loc_3016).l
	cmp.w	d2, d3
	beq.w	loc_2EB2
	move.w	d3, $00FF00AE
	move.w	($FF0006).l, (a4)+
	move.w	($FF0004).l, (a4)+
	move.w	($FF0004).l, (a4)+
loc_2E4C:
	move.w	-(a4), $00FF0024
	move.w	-(a4), $00FF0022
	move.w	-(a4), d4
	bsr.w	loc_158C
	bsr.w	loc_2EC8
	bsr.w	loc_15D2
	bsr.w	loc_1246
	andi.b	#$F0, d0
	bne.w	loc_2E8A
	cmpi.w	#0, ($FF00A6).l
	beq.w	loc_2EA4
	subi.w	#1, ($FF00A6).l
	bra.w	loc_2EA4
loc_2E8A:
	cmpi.w	#0, ($FF00A6).l
	bne.w	loc_2EA4
	move.w	#3, ($FF00A6).l
	clr.w	d1
	bra.w	loc_2EB2
loc_2EA4:
	cmpa.l	#$FFBEF4, a4
	bne.w	loc_2E4C
	move.w	#1, d1
loc_2EB2:
	move.w	#$8F02, (a0)
	move.w	#1, ($FF0036).l
	jsr	(loc_A54E).l
	move.l	(sp)+, d0
	rts
loc_2EC8:
	clr.w	$00FF001A
	clr.w	$00FF001E
	clr.w	d0
	move.w	#$FFFF, $00FF001A
loc_2EDE:
	bsr.w	loc_1624
	cmp.w	$00FF00AE, d1
	bne.w	loc_2F02
	cmpi.w	#$FFFF, $00FF001A
	bne.w	loc_2F28
	move.w	d0, $00FF001A
	bra.w	loc_2F28
loc_2F02:
	cmpi.w	#$FFFF, $00FF001A
	beq.w	loc_2F28
	move.w	d0, $00FF001E
	subi.w	#1, $00FF001E
	bsr.w	loc_2F4E
	move.w	#$FFFF, $00FF001A
loc_2F28:
	addi.w	#1, d0
	cmpi.w	#$140, d0
	bne.w	loc_2EDE
	cmpi.w	#$FFFF, $00FF001A
	beq.w	loc_2F4C
	move.w	#$13F, $00FF001E
	bsr.w	loc_2F4E
loc_2F4C:
	rts
loc_2F4E:
	move.w	$00FF001A, d1
	cmp.w	$00FF0024, d1
	bgt.w	loc_2FAC
	move.w	$00FF001E, d1
	cmp.w	$00FF0022, d1
	blt.w	loc_2FAC
	move.w	d0, -(sp)
	move.w	$00FF001A, d0
loc_2F76:
	bsr.w	loc_1658
	addi.w	#1, d0
	cmp.w	$00FF001E, d0
	ble.w	loc_2F76
	move.w	#1, d5
	move.w	d4, d0
	subi.w	#1, d0
	bmi.w	loc_2F9A
	bsr.w	loc_2FAE
loc_2F9A:
	addi.w	#2, d0
	cmpi.w	#$E0, d0
	beq.w	loc_2FAA
	bsr.w	loc_2FAE
loc_2FAA:
	move.w	(sp)+, d0
loc_2FAC:
	rts
loc_2FAE:
	move.l	a7, d1
	sub.l	a4, d1
	cmpi.l	#$A, d1
	blt.w	loc_2FCA
	move.w	d0, (a4)+
	move.w	$00FF001A, (a4)+
	move.w	$00FF001E, (a4)+
loc_2FCA:
	rts
loc_2FCC:
	move.w	($FF0042).l, d2
	cmpi.w	#$F, d2
	ble.w	loc_3014
	subi.w	#$10, d2
	lsl.w	#6, d2
	andi.l	#$FFFF, d2
	addi.l	#$148C, d2
	movea.l	d2, a1
	movea.l	#$FFBEB4, a3
	move.w	#$3F, d2
loc_2FF8:
	move.b	(a1)+, d0
	cmp.b	d0, d1
	bne.w	loc_300E
	addi.b	#1, d0	;Predicted (Code-scan)
	cmpi.b	#$10, d0	;Predicted (Code-scan)
	blt.w	loc_300E	;Predicted (Code-scan)
	clr.b	d0	;Predicted (Code-scan)
loc_300E:
	move.b	d0, (a3)+
	dbf	d2, loc_2FF8
loc_3014:
	rts
loc_3016:
	move.w	($FF0042).l, d2
	cmpi.w	#$F, d2
	ble.w	loc_304A
	movem.l	d1/d0, -(sp)
	andi.l	#7, d0
	andi.l	#7, d1
	lsl.l	#3, d1
	add.l	d1, d0
	addi.l	#$FFBEB4, d0
	movea.l	d0, a1
	move.b	(a1), d2
	andi.w	#$FF, d2
	movem.l	(sp)+, d0/d1
loc_304A:
	rts
loc_304C:
	move.w	#8, ($FF003C).l
	bsr.w	loc_30E2
	move.l	#$30E2, ($FF008C).l
	move.l	#$307C, ($FF0078).l
	clr.w	$00FF001E
	move.w	#1, $00FF0026
	rts
	movem.l	d7/d0, -(sp)
	jsr	(loc_1106).l
	move.l	#5, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	movea.l	$00FF00C6, a4
	move.w	($FF0004).l, $00FF0022
	subi.w	#$20, $00FF0022
	move.w	($FF0006).l, $00FF0024
	subi.w	#$20, $00FF0024
	cmpi.w	#0, $00FF001E
	beq.w	loc_30D8
	jsr	(loc_3324).l
	bra.w	loc_30DC
loc_30D8:
	bsr.w	loc_327A
loc_30DC:
	movem.l	(sp)+, d0/d7
	rts
loc_30E2:
	move.w	($FF0004).l, d2
	move.w	($FF0006).l, d1
	subi.w	#$20, d2
	subi.w	#$20, d1
loc_30F6:
	move.l	d0, -(sp)
	move.l	#$5C000003, (a0)
	move.w	#$F01, d0
	move.w	#$8680, d3
	move.w	#1, d4
	cmpi.w	#0, $00FF0026
	beq.w	loc_314C
	move.w	$00FF001A, d5
	cmp.w	($FF0004).l, d5
	blt.w	loc_314C
	bgt.w	loc_3136
	cmpi.w	#0, $00FF001E
	beq.w	loc_314C
loc_3136:
	ori.w	#$800, d3
	jsr	(loc_B18A).l
	move.w	#1, $00FF001E
	bra.w	loc_3158
loc_314C:
	jsr	(loc_3166).l
	clr.w	$00FF001E
loc_3158:
	move.w	($FF0004).l, $00FF001A
	move.l	(sp)+, d0
	rts
loc_3166:
	addi.w	#$80, d1
	move.w	d1, (a2)
	move.w	d0, (a2)
	addi.w	#1, d0
	move.w	d3, (a2)
	addi.w	#$10, d3
	addi.w	#$80, d2
	move.w	d2, (a2)
	move.w	d1, (a2)
	move.w	d0, (a2)
	addi.w	#1, d0
	move.w	d3, (a2)
	addi.w	#$10, d3
	addi.w	#$20, d2
	move.w	d2, (a2)
	addi.w	#$20, d1
	move.w	d1, (a2)
	move.w	d0, (a2)
	addi.w	#1, d0
	move.w	d3, (a2)
	addi.w	#$10, d3
	subi.w	#$20, d2
	move.w	d2, (a2)
	move.w	d1, (a2)
	addi.w	#$20, d2
	cmpi.w	#0, d4
	bne.w	loc_31C8
	move.w	d0, (a2)
	addi.w	#1, d0
	move.w	d3, (a2)
	addi.w	#$10, d3
	move.w	d2, (a2)
	rts
loc_31C8:
	move.w	#$F00, (a2)
	move.w	d3, (a2)
	move.w	d2, (a2)
	rts
loc_31D2:
	movem.l	a4/a3/d5/d4/d3/d2/d1/d0, -(sp)
	movea.l	#$FF01EC, a3
	cmpa.l	#$FF0000, a4
	blt.w	loc_31F4
	move.w	#$200, d0
loc_31EA:
	move.l	(a4)+, (a3)+
	dbf	d0, loc_31EA
	bra.w	loc_3236
loc_31F4:
	clr.l	d0
	clr.b	d4
loc_31F8:
	move.b	(a4)+, d1
	move.b	d1, d2
	move.b	d1, d3
	lsr.b	#4, d3
	andi.b	#$F0, d2
	andi.l	#$F, d1
loc_320A:
	cmpi.b	#0, d4
	bne.w	loc_321C
	move.b	d2, d5
	move.b	#1, d4
	bra.w	loc_3222
loc_321C:
	or.b	d3, d5
	move.b	d5, (a3)+
	clr.w	d4
loc_3222:
	addq.l	#1, d0
	cmpi.l	#$1000, d0
	bge.w	loc_3236
	dbf	d1, loc_320A
	bra.w	loc_31F8
loc_3236:
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/a3/a4
	rts
loc_323C:
	move.l	a1, (a0)
	bsr.w	loc_324E
	adda.l	#$400, a3
	bsr.w	loc_324E
	rts
loc_324E:
	clr.l	d2
	move.l	#7, d1
loc_3256:
	move.l	#$1F, d0
	movea.l	a3, a1
	adda.l	d2, a1
loc_3260:
	move.w	(a1)+, (a2)
	move.w	(a1)+, (a2)
	adda.l	#$1C, a1
	dbf	d0, loc_3260
	addi.l	#4, d2
	dbf	d1, loc_3256
	rts
loc_327A:
	move.w	($FF0042).l, -(sp)
	move.w	#$8F20, (a0)
	clr.w	d7
loc_3286:
	clr.w	d6
	move.w	d6, d0
	add.w	$00FF0022, d0
	move.w	d7, d4
	add.w	$00FF0024, d4
	andi.l	#$FFF, d4
	cmpi.l	#$E0, d4
	blt.w	loc_32B2
	adda.l	#$20, a4
	bra.w	loc_330E
loc_32B2:
	bsr.w	loc_158C
loc_32B6:
	move.b	(a4)+, d3
	move.b	d3, d2
	lsr.b	#4, d2
	andi.w	#$F, d2
	cmpi.w	#0, d2
	beq.w	loc_32DA
	cmpi.w	#$140, d0
	bge.w	loc_32DA
	move.w	d2, ($FF0042).l
	bsr.w	loc_1658
loc_32DA:
	addq.w	#1, d0
	andi.w	#$F, d3
	cmpi.w	#0, d3
	beq.w	loc_32FA
	cmpi.w	#$140, d0
	bge.w	loc_32FA
	move.w	d3, ($FF0042).l
	bsr.w	loc_1658
loc_32FA:
	addq.w	#1, d0
	addq.w	#2, d6
	cmpi.w	#$40, d6
	blt.w	loc_32B6
	move.w	#1, d5
	bsr.w	loc_15D2
loc_330E:
	addq.w	#1, d7
	cmpi.w	#$40, d7
	blt.w	loc_3286
	move.w	#$8F02, (a0)
	move.w	(sp)+, ($FF0042).l
	rts
loc_3324:
	move.w	($FF0042).l, -(sp)
	move.w	#$8F20, (a0)
	clr.w	d7
loc_3330:
	clr.w	d6
	move.w	d6, d0
	add.w	$00FF0022, d0
	addi.w	#$3F, d0
	move.w	d7, d4
	add.w	$00FF0024, d4
	andi.l	#$FFF, d4
	cmpi.l	#$E0, d4
	blt.w	loc_3360
	adda.l	#$20, a4	;Predicted (Code-scan)
	bra.w	loc_33BC	;Predicted (Code-scan)
loc_3360:
	bsr.w	loc_158C
loc_3364:
	move.b	(a4)+, d3
	move.b	d3, d2
	lsr.b	#4, d2
	andi.w	#$F, d2
	cmpi.w	#0, d2
	beq.w	loc_3388
	cmpi.w	#$140, d0
	bge.w	loc_3388
	move.w	d2, ($FF0042).l
	bsr.w	loc_1658
loc_3388:
	subq.w	#1, d0
	andi.w	#$F, d3
	cmpi.w	#0, d3
	beq.w	loc_33A8
	cmpi.w	#$140, d0
	bge.w	loc_33A8
	move.w	d3, ($FF0042).l
	bsr.w	loc_1658
loc_33A8:
	subq.w	#1, d0
	addq.w	#2, d6
	cmpi.w	#$40, d6
	blt.w	loc_3364
	move.w	#1, d5
	bsr.w	loc_15D2
loc_33BC:
	addq.w	#1, d7
	cmpi.w	#$40, d7
	blt.w	loc_3330
	move.w	#$8F02, (a0)
	move.w	(sp)+, ($FF0042).l
	rts
loc_33D2:
	move.w	#$8F20, (a0)
	clr.w	d7
loc_33D8:
	clr.w	d6
	move.w	d6, d0
	add.w	$00FF0022, d0
	move.w	d7, d4
	add.w	$00FF0024, d4
	bsr.w	loc_158C
loc_33EE:
	bsr.w	loc_1624
	lsl.b	#4, d1
	move.b	d1, d2
	addq.w	#1, d0
	bsr.w	loc_1624
	andi.b	#$F, d1
	or.b	d2, d1
	move.b	d1, (a4)+
	addq.w	#1, d0
	addq.w	#2, d6
	cmpi.w	#$40, d6
	blt.w	loc_33EE
	addq.w	#1, d7
	cmpi.w	#$40, d7
	blt.w	loc_33D8
	move.w	#$8F02, (a0)
	rts
loc_3420:
	move.w	($FF0042).l, d7
	move.w	d7, -(sp)
	cmpi.w	#$F, d7
	ble.w	loc_3434
	move.w	#$F, d7
loc_3434:
	move.w	#$8F20, (a0)
	clr.w	d4
	bsr.w	loc_158C
	clr.w	d0
loc_3440:
	move.b	(a4)+, d1
	move.b	d1, d2
	andi.w	#$7F, d2
	move.w	#0, ($FF0042).l
	lsr.b	#7, d1
	beq.w	loc_345C
	move.w	d7, ($FF0042).l
loc_345C:
	bsr.w	loc_1658
	addq.w	#1, d0
	cmpi.w	#$140, d0
	blt.w	loc_348E
	move.w	#1, d5
	bsr.w	loc_15D2
	addq.w	#1, d4
	cmpi.w	#$E0, d4
	blt.w	loc_3488
	move.w	#$8F02, (a0)
	move.w	(sp)+, ($FF0042).l
	rts
loc_3488:
	bsr.w	loc_158C
	clr.w	d0
loc_348E:
	dbf	d2, loc_345C
	bra.w	loc_3440
	
loc_3496:
	jsr	(loc_A988).l
	jsr	(loc_104A).l
	jsr	(loc_1246).l
	cmpi.b	#$64, d0
	bne.w	loc_34FC
	move.w	(loc_3960).l, d0	;Predicted (Code-scan)
	move.l	#$C0000000, (a0)	;Predicted (Code-scan)
	move.w	#$EEA, (a2)	;Predicted (Code-scan)
loc_34C0:
	movea.l	#$3772, a5	;Predicted (Code-scan)
	jsr	(loc_4CBE).l	;Predicted (Code-scan)
	jsr	(loc_1246).l	;Predicted (Code-scan)
	bne.w	loc_34FC	;Predicted (Code-scan)
	jsr	(loc_5BA).l	;Predicted (Code-scan)
	movea.l	#$3869, a5	;Predicted (Code-scan)
	jsr	(loc_4CBE).l	;Predicted (Code-scan)
	jsr	(loc_1246).l	;Predicted (Code-scan)
	bne.w	loc_34FC	;Predicted (Code-scan)
	jsr	(loc_5BA).l	;Predicted (Code-scan)
	bra.w	loc_34C0	;Predicted (Code-scan)
loc_34FC:
	move.l	#$C0000000, (a0)
	move.w	#$EEE, (a2)
	move.w	#$F, ($FF0042).l
	movea.l	#$17936, a4
	jsr	(loc_3420).l
	movea.l	#$369C, a1
loc_3520:
	move.w	(a1)+, ($FF0042).l
	move.w	(a1)+, ($FF0004).l
	move.w	(a1)+, ($FF0006).l
	jsr	(loc_2DEA).l
	cmpi.w	#0, d1
	beq.w	loc_363C
	cmpi.w	#0, (a1)
	bne.w	loc_3520
	move.l	#$C0000000, (a0)
	move.w	#$EAE, (a2)
	movea.l	#$373A, a1
loc_3558:
	move.w	(a1)+, ($FF0042).l
	move.w	(a1)+, ($FF0004).l
	move.w	(a1)+, ($FF0006).l
	jsr	(loc_2DEA).l
	cmpi.w	#0, d1
	beq.w	loc_363C
	cmpi.w	#0, (a1)
	bne.w	loc_3558
	clr.w	($FF0036).l
	move.l	$00FF0000, d0
	addi.l	#1, $00FF0000
	cmpi.l	#9, $00FF0000
	bne.w	loc_35AA
	clr.l	$00FF0000	;Predicted (Code-scan)
loc_35AA:
	lsl.l	#4, d0
	addi.l	#$12BBA, d0
	move.l	d0, $00FF00C2
	move.w	#2, $00FF00CA
	jsr	(loc_3D86).l
	clr.w	($FF0036).l
	move.w	#$23A, d7
loc_35D0:
	move.l	($FF00B0).l, d1
loc_35D6:
	cmp.l	($FF00B0).l, d1
	beq.w	loc_35D6
	bsr.w	loc_1246
	cmpi.w	#0, d0
	bne.w	loc_363C
	bsr.w	loc_B1FA
	dbf	d7, loc_35D0
	jsr	(loc_A9B8).l
	jsr	(loc_A9B8).l
	move.l	#$32, d6
	jsr	(loc_5E6).l
	jsr	(loc_A9E6).l
	move.l	($FF00B0).l, d1
loc_3618:
	cmp.l	($FF00B0).l, d1
	beq.w	loc_3618
	move.l	($FF00B0).l, d1
loc_3628:
	cmp.l	($FF00B0).l, d1
	beq.w	loc_3628
	move	#$2700, sr
	bra.w	loc_28C

; -----------
	rts
; -----------

loc_363C:
	move	#$2700, sr
	clr.w	$00FF003A
	jsr	(loc_16A2).l
	jsr	(loc_1106).l
	jsr	(loc_A9E6).l
	jsr	(loc_5BA).l
	move.w	#$64, ($FF0006).l
	move.w	#$64, ($FF0004).l
	move.w	#1, ($FF0042).l
	move.l	#$C0000000, (a0)
	move.w	#$EEE, (a2)
	jsr	(loc_1144).l
	move.w	#3, ($FF00A6).l
	move.w	#1, ($FF0036).l
	move	#$2000, sr
	rts
	dc.w	$0002, $007A, $000B ;0x0 (0x0000369C-0x000036A2, Entry count: 0x6)
	dc.w	$0002
	dc.b	$00, $AA, $00, $1F ;0x0 (0x000036A4-0x000036A8, Entry count: 0x4) [Unknown data]
	dc.w	$0002
	dc.b	$00, $D0, $00, $14 ;0x0 (0x000036AA-0x000036AE, Entry count: 0x4) [Unknown data]
	dc.w	$0001
	dc.b	$00, $0D, $00, $60 ;0x0 (0x000036B0-0x000036B4, Entry count: 0x4) [Unknown data]
	dc.w	$0006
	dc.b	$00, $47, $00, $59 ;0x0 (0x000036B6-0x000036BA, Entry count: 0x4) [Unknown data]
	dc.w	$0008
	dc.b	$00, $8D, $00, $53 ;0x0 (0x000036BC-0x000036C0, Entry count: 0x4) [Unknown data]
	dc.w	$0004
	dc.b	$00, $A0, $00, $54 ;0x0 (0x000036C2-0x000036C6, Entry count: 0x4) [Unknown data]
	dc.w	$000A
	dc.b	$00, $E5, $00, $60 ;0x0 (0x000036C8-0x000036CC, Entry count: 0x4) [Unknown data]
	dc.w	$0001
	dc.b	$01, $20, $00, $5D ;0x0 (0x000036CE-0x000036D2, Entry count: 0x4) [Unknown data]
	dc.w	$0001
	dc.b	$01, $17, $00, $BB ;0x0 (0x000036D4-0x000036D8, Entry count: 0x4) [Unknown data]
	dc.w	$0007
	dc.b	$00, $A5, $00, $BC ;0x0 (0x000036DA-0x000036DE, Entry count: 0x4) [Unknown data]
	dc.w	$0006
	dc.b	$01, $28, $00, $22 ;0x0 (0x000036E0-0x000036E4, Entry count: 0x4) [Unknown data]
	dc.w	$0006
	dc.b	$01, $04, $00, $05 ;0x0 (0x000036E6-0x000036EA, Entry count: 0x4) [Unknown data]
	dc.w	$000D
	dc.b	$01, $01, $00, $0B ;0x0 (0x000036EC-0x000036F0, Entry count: 0x4) [Unknown data]
	dc.w	$000A
	dc.b	$00, $FC, $00, $13 ;0x0 (0x000036F2-0x000036F6, Entry count: 0x4) [Unknown data]
	dc.w	$000B
	dc.b	$00, $E5, $00, $41 ;0x0 (0x000036F8-0x000036FC, Entry count: 0x4) [Unknown data]
	dc.w	$000A
	dc.b	$00, $1B, $00, $03 ;0x0 (0x000036FE-0x00003702, Entry count: 0x4) [Unknown data]
	dc.w	$000A
	dc.b	$00, $27, $00, $47 ;0x0 (0x00003704-0x00003708, Entry count: 0x4) [Unknown data]
	dc.w	$0007
	dc.b	$00, $2F, $00, $0F ;0x0 (0x0000370A-0x0000370E, Entry count: 0x4) [Unknown data]
	dc.w	$0009
	dc.b	$00, $3D, $00, $1B ;0x0 (0x00003710-0x00003714, Entry count: 0x4) [Unknown data]
	dc.w	$0006
	dc.b	$00, $46, $00, $2A ;0x0 (0x00003716-0x0000371A, Entry count: 0x4) [Unknown data]
	dc.w	$0005
	dc.b	$00, $4C, $00, $38 ;0x0 (0x0000371C-0x00003720, Entry count: 0x4) [Unknown data]
	dc.w	$0003
	dc.b	$00, $4B, $00, $44 ;0x0 (0x00003722-0x00003726, Entry count: 0x4) [Unknown data]
	dc.w	$000B
	dc.b	$00, $56, $00, $56 ;0x0 (0x00003728-0x0000372C, Entry count: 0x4) [Unknown data]
	dc.w	$000D
	dc.b	$00, $22, $00, $41 ;0x0 (0x0000372E-0x00003732, Entry count: 0x4) [Unknown data]
	dc.w	$0007
	dc.b	$00, $11, $00, $38 ;0x0 (0x00003734-0x00003738, Entry count: 0x4) [Unknown data]
	dc.w	$0000
	dc.w	$000C, $00A0, $0004 ;0x0 (0x0000373A-0x00003740, Entry count: 0x6)
	dc.w	$000C
	dc.b	$00, $77, $00, $0A ;0x0 (0x00003742-0x00003746, Entry count: 0x4) [Unknown data]
	dc.w	$000C
	dc.b	$00, $37, $00, $3A ;0x0 (0x00003748-0x0000374C, Entry count: 0x4) [Unknown data]
	dc.w	$000C
	dc.b	$00, $2D, $00, $50 ;0x0 (0x0000374E-0x00003752, Entry count: 0x4) [Unknown data]
	dc.w	$000C
	dc.b	$00, $80, $00, $AE ;0x0 (0x00003754-0x00003758, Entry count: 0x4) [Unknown data]
	dc.w	$000C
	dc.b	$00, $94, $00, $BF ;0x0 (0x0000375A-0x0000375E, Entry count: 0x4) [Unknown data]
	dc.w	$000C
	dc.b	$00, $FA, $00, $A4 ;0x0 (0x00003760-0x00003764, Entry count: 0x4) [Unknown data]
	dc.w	$000C
	dc.b	$00, $D6, $00, $70 ;0x0 (0x00003766-0x0000376A, Entry count: 0x4) [Unknown data]
	dc.w	$000C
	dc.b	$00, $95, $00, $AD ;0x0 (0x0000376C-0x00003770, Entry count: 0x4) [Unknown data]
	dc.w	$0000
	dc.b	"   THE ART ALIVE    DEVELOPMENT " ;0x0 (0x00003772-0x00003960, Entry count: 0x1EE) [Unknown data]
	dc.b	"TEAM                     PROGRAM" ;0x20
	dc.b	"MING           JAY OBERNOLTE    " ;0x40
	dc.b	"  CHRIS ZIOMKOWSKI              " ;0x60
	dc.b	"     ADULT SUPERVISION     JEFF " ;0x80
	dc.b	"FORT          SCOTT BERFIELD    " ;0xA0
	dc.b	"                 ART AND MUSIC  " ;0xC0
	dc.b	"       ERIC IWASAKI       THE AR" ;0xE0
	dc.b	"T ALIVE    DEVELOPMENT TEAM     " ;0x100
	dc.b	"                PROGRAM DESIGN  " ;0x120
	dc.b	"      RAND SIEGFRIED     JEFF FO" ;0x140
	dc.b	"RT          JAY SMITH           " ;0x160
	dc.b	"                  DEVELOPED BY  " ;0x180
	dc.b	"                          WESTER" ;0x1A0
	dc.b	"N          TECHNOLOGIES         " ;0x1C0
	dc.b	"              " ;0x1E0
loc_3960:
	dc.b	$00, $00 ;0x0 (0x00003960-0x00003962, Entry count: 0x2) [Unknown data]
loc_3962:
	jsr	(loc_1106).l
	move.l	a6, -(sp)
	move.w	#$2BF, d0
	move.l	#$60000003, (a0)
	moveq	#0, d1
	moveq	#0, d2
loc_3978:
	move.w	#$65E0, (a2)
	addq.w	#1, d1
	addq.w	#1, d2
	move.w	d1, d3
	andi.w	#$3F, d3
	bne.w	loc_398E
	subi.w	#$18, d2
loc_398E:
	dbf	d0, loc_3978
	bsr.w	loc_3A36
	movea.l	#$54000002, a6
	move.w	($FF00AA).l, d1
	andi.l	#$FF, d1
	lsl.l	#2, d1
	addi.l	#$BC14, d1
	movea.l	d1, a5
	move.w	#3, d3
loc_39B6:
	movea.l	(a5), a4
	bsr.w	loc_31D2
	movea.l	a6, a1
	movea.l	#$FF01EC, a3
	bsr.w	loc_323C
	adda.l	#$8000000, a6
	adda.l	#4, a5
	cmpa.l	#$BCDC, a5
	ble.w	loc_39E4
	movea.l	#$BC14, a5	;Predicted (Code-scan)
loc_39E4:
	dbf	d3, loc_39B6
	move.w	($FF00AA).l, $00FF001E
	bsr.w	loc_3B36
	move.l	#$3C0E, ($FF0078).l
	move.l	#$41AC, ($FF0070).l
	move.l	#$423E, ($FF0074).l
	move.l	#$111E, ($FF0068).l
	move.l	#$111E, ($FF006C).l
	movea.l	(sp)+, a6
	move.l	#$47B6, ($FF002E).l
	rts
loc_3A36:
	movea.l	#$4954, a4
	bsr.w	loc_31D2
	movea.l	#$FF01EC, a3
	movea.l	#$4C000002, a1
	bsr.w	loc_323C
	rts
loc_3A52:
	jsr	(loc_1106).l
	move.l	a6, -(sp)
	move.w	#$27F, d0
	move.l	#$60000003, (a0)
	moveq	#0, d1
	moveq	#0, d2
loc_3A68:
	move.w	#$65E0, (a2)
	addq.w	#1, d1
	addq.w	#1, d2
	move.w	d1, d3
	andi.w	#$3F, d3
	bne.w	loc_3A7E
	subi.w	#$18, d2
loc_3A7E:
	dbf	d0, loc_3A68
	bsr.w	loc_3A36
	movea.l	#$54000002, a6
	move.w	($FF00AC).l, d1
	andi.l	#$FF, d1
	lsl.l	#2, d1
	addi.l	#$12B92, d1
	movea.l	d1, a5
	move.w	#3, d3
loc_3AA6:
	movea.l	(a5), a4
	bsr.w	loc_31D2
	movea.l	a6, a1
	movea.l	#$FF01EC, a3
	bsr.w	loc_323C
	adda.l	#$8000000, a6
	adda.l	#4, a5
	cmpa.l	#$12BB6, a5
	ble.w	loc_3AD4
	movea.l	#$12B92, a5
loc_3AD4:
	dbf	d3, loc_3AA6
	move.w	($FF00AC).l, $00FF001E
	bsr.w	loc_3B36
	move.l	#$42E0, ($FF0070).l
	move.l	#$4372, ($FF0074).l
	move.l	#$44BA, ($FF0068).l
	move.l	#$44BA, ($FF006C).l
	move.l	#$3CE0, ($FF0078).l
	movea.l	(sp)+, a6
	move.l	#$47D8, ($FF002E).l
	rts
	jsr	(loc_963E).l
	movea.l	($FF0096).l, a3
	jsr	(a3)
	rts
loc_3B36:
	moveq	#$1F, d0
	move.l	#$7C000002, (a0)
loc_3B3E:
	move.w	#$9999, (a2)
	dbf	d0, loc_3B3E
	bsr.w	loc_104A
	move.l	#$3DCC, ($FF009E).l
	move.l	#$111E, ($FF008C).l
	move.l	#$3B26, ($FF0084).l
	clr.w	($FF0066).l
	move.w	#$14, $00FF0022
	move.w	#$A, $00FF0024
	move.w	#$14, $00FF00CC
	move.w	#$5E, $00FF00CE
	move.w	#$A8, $00FF00D0
	move.w	#$F2, $00FF00D2
	move.w	#$84A0, $00FF00D6
	move.w	#$84E0, $00FF00D8
	move.w	#$8520, $00FF00DA
	move.w	#$8560, $00FF00DC
	move.w	#$85A0, $00FF00DE
	move.l	#$54000002, $00FF00E0
	move.l	#$5C000002, $00FF00E4
	move.l	#$64000002, $00FF00E8
	move.l	#$6C000002, $00FF00EC
	move.l	#$74000002, $00FF00F0
	lea	(loc_8C94).l, a1
	moveq	#$3F, d0
	move.l	#$47200003, (a0)
loc_3C06:
	move.w	(a1)+, (a2)
	dbf	d0, loc_3C06
	rts
	move.l	d0, -(sp)
	cmpi.w	#0, ($FF0066).l
	bne.w	loc_3C98
	cmpi.w	#0, ($FF000E).l
	beq.w	loc_3C34
	cmpi.w	#0, $00FF002A	;Predicted (Code-scan)
	bne.w	loc_3C98	;Predicted (Code-scan)
loc_3C34:
	move.l	#3, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	jsr	(loc_963E).l
	move.w	$00FF0022, d0
	subi.w	#$14, d0
	andi.l	#$FFFF, d0
	divu.w	#$4A, d0
	add.w	$00FF001E, d0
	cmpi.w	#$33, d0
	blt.w	loc_3C72
	subi.w	#$33, d0	;Predicted (Code-scan)
loc_3C72:
	move.w	d0, ($FF00AA).l
	lsl.l	#2, d0
	movea.l	d0, a1
	adda.l	#$BC14, a1
	move.l	(a1), $00FF00C2
	move.l	#$FF01EC, $00FF00C6
	jsr	(loc_3C9C).l
loc_3C98:
	move.l	(sp)+, d0
	rts
loc_3C9C:
	move	sr, -(sp)
	move	#$2700, sr
	movea.l	$00FF00C2, a4
	bsr.w	loc_31D2
	movea.l	#$50000003, a1
	movea.l	#$FF01EC, a3
	bsr.w	loc_323C
	move.l	#$FF01EC, $00FF00C6
	jsr	(loc_104A).l
	move.l	#$3C9C, ($FF0096).l
	jsr	(loc_304C).l
	move	(sp)+, sr
	rts
	move.l	d0, -(sp)
	cmpi.w	#0, ($FF0066).l
	bne.w	loc_3D82
	cmpi.w	#0, ($FF000E).l
	beq.w	loc_3D06
	cmpi.w	#0, $00FF002A	;Predicted (Code-scan)
	bne.w	loc_3D82	;Predicted (Code-scan)
loc_3D06:
	move.l	#3, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	jsr	(loc_963E).l
	cmpi.l	#$ADD4, $00FF0026
	bne.w	loc_3D40
	move.l	#loc_5ABC, ($FF005C).l
	move.l	#loc_ABDC, ($FF0060).l
loc_3D40:
	move.w	$00FF0022, d0
	subi.w	#$14, d0
	andi.l	#$FFFF, d0
	divu.w	#$4A, d0
	add.w	$00FF001E, d0
	cmpi.w	#$A, d0
	blt.w	loc_3D66
	subi.w	#$A, d0
loc_3D66:
	move.w	d0, ($FF00AC).l
	lsl.l	#4, d0
	addi.l	#$12BBA, d0
	move.l	d0, $00FF00C2
	movea.l	$00FF0026, a3
	jsr	(a3)
loc_3D82:
	move.l	(sp)+, d0
	rts
loc_3D86:
	movea.l	#$54000002, a6
	move.l	#3, d6
	movea.l	$00FF00C2, a5
loc_3D98:
	movea.l	(a5)+, a4
	bsr.w	loc_31D2
	movea.l	a6, a1
	movea.l	#$FF01EC, a3
	bsr.w	loc_323C
	adda.l	#$8000000, a6
	dbf	d6, loc_3D98
	jsr	(loc_104A).l
	move.l	#$3D86, ($FF0096).l
	jsr	(loc_B07A).l
	rts
	move.l	d0, -(sp)
	cmpi.w	#1, ($FF0066).l
	bne.w	loc_3DFC
	subi.w	#3, $00FF0022
	subi.w	#1, $00FF001A
	bne.w	loc_3DFC
	subi.w	#2, $00FF0022
	clr.w	($FF0066).l
loc_3DFC:
	cmpi.w	#2, ($FF0066).l
	bne.w	loc_3E2A
	addi.w	#3, $00FF0022
	subi.w	#1, $00FF001A
	bne.w	loc_3E2A
	addi.w	#2, $00FF0022
	clr.w	($FF0066).l
loc_3E2A:
	cmpi.w	#3, ($FF0066).l
	bne.w	loc_3EE4
	movea.l	#$FF00CC, a1
loc_3E3C:
	subi.w	#2, (a1)+
	cmpa.l	#$FF00D6, a1
	blt.w	loc_3E3C
	subi.w	#1, $00FF001A
	bne.w	loc_3EE4
	clr.w	($FF0066).l
	move.w	$00FF00D6, d0
	move.w	$00FF00D8, $00FF00D6
	move.w	$00FF00DA, $00FF00D8
	move.w	$00FF00DC, $00FF00DA
	move.w	$00FF00DE, $00FF00DC
	move.w	d0, $00FF00DE
	move.l	$00FF00E0, d0
	move.l	$00FF00E4, $00FF00E0
	move.l	$00FF00E8, $00FF00E4
	move.l	$00FF00EC, $00FF00E8
	move.l	$00FF00F0, $00FF00EC
	move.l	d0, $00FF00F0
	move.w	#$14, $00FF00CC
	move.w	#$5E, $00FF00CE
	move.w	#$A8, $00FF00D0
	move.w	#$F2, $00FF00D2
loc_3EE4:
	cmpi.w	#4, ($FF0066).l
	bne.w	loc_3F9E
	movea.l	#$FF00CC, a1
loc_3EF6:
	addi.w	#2, (a1)+
	cmpa.l	#$FF00D6, a1
	blt.w	loc_3EF6
	subi.w	#1, $00FF001A
	bne.w	loc_3F9E
	clr.w	($FF0066).l
	move.w	$00FF00DE, d0
	move.w	$00FF00DC, $00FF00DE
	move.w	$00FF00DA, $00FF00DC
	move.w	$00FF00D8, $00FF00DA
	move.w	$00FF00D6, $00FF00D8
	move.w	d0, $00FF00D6
	move.l	$00FF00F0, d0
	move.l	$00FF00EC, $00FF00F0
	move.l	$00FF00E8, $00FF00EC
	move.l	$00FF00E4, $00FF00E8
	move.l	$00FF00E0, $00FF00E4
	move.l	d0, $00FF00E0
	move.w	#$14, $00FF00CC
	move.w	#$5E, $00FF00CE
	move.w	#$A8, $00FF00D0
	move.w	#$F2, $00FF00D2
loc_3F9E:
	bsr.w	loc_3FC4
	cmpi.w	#0, ($FF000E).l
	beq.w	loc_3FB6
	bsr.w	loc_4080	;Predicted (Code-scan)
	bra.w	loc_3FBA	;Predicted (Code-scan)
loc_3FB6:
	bsr.w	loc_4032
loc_3FBA:
	jsr	(loc_9FC2).l
	move.l	(sp)+, d0
	rts
loc_3FC4:
	move.l	#$5C000003, (a0)
	clr.w	d4
	move.w	#$F01, d0
	move.w	$00FF00D6, d3
	move.w	$00FF00CC, d2
	move.w	#$A, d1
	bsr.w	loc_3166
	move.w	$00FF00D8, d3
	move.w	$00FF00CE, d2
	move.w	#$A, d1
	bsr.w	loc_3166
	move.w	$00FF00DA, d3
	move.w	$00FF00D0, d2
	move.w	#$A, d1
	bsr.w	loc_3166
	move.w	$00FF00DC, d3
	move.w	$00FF00D2, d2
	move.w	#$A, d1
	bsr.w	loc_3166
	move.w	$00FF00DE, d3
	move.w	$00FF00D4, d2
	move.w	#$A, d1
	rts
loc_4032:
	cmpi.w	#2, ($FF0066).l
	bgt.w	loc_404E
	move.w	#$C460, d3
	move.w	$00FF0022, d2
	move.w	$00FF0024, d1
loc_404E:
	move.w	#1, d4
	bsr.w	loc_3166
	rts
loc_4058:
	move.w	($FF0006).l, d0	;Predicted (Code-scan)
	addi.w	#$78, d0	;Predicted (Code-scan)
	move.w	d0, (a2)	;Predicted (Code-scan)
	move.w	#$500, (a2)	;Predicted (Code-scan)
	move.w	#$639, d0	;Predicted (Code-scan)
	ori.w	#$C000, d0	;Predicted (Code-scan)
	move.w	d0, (a2)	;Predicted (Code-scan)
	move.w	($FF0004).l, d0	;Predicted (Code-scan)
	addi.w	#$78, d0	;Predicted (Code-scan)
	move.w	d0, (a2)	;Predicted (Code-scan)
	rts	;Predicted (Code-scan)
loc_4080:
	cmpi.w	#0, ($FF0066).l	;Predicted (Code-scan)
	beq.w	loc_4096	;Predicted (Code-scan)
	move.w	#1, d4	;Predicted (Code-scan)
	bsr.w	loc_3166	;Predicted (Code-scan)
	rts	;Predicted (Code-scan)
loc_4096:
	movea.l	($FF002E).l, a1	;Predicted (Code-scan)
loc_409C:
	move.w	(a1), d5	;Predicted (Code-scan)
	cmpi.w	#$FFFF, d5	;Predicted (Code-scan)
	beq.w	loc_4136	;Predicted (Code-scan)
	move.w	($FF0004).l, d5	;Predicted (Code-scan)
	cmp.w	(a1), d5	;Predicted (Code-scan)
	blt.w	loc_412E	;Predicted (Code-scan)
	cmp.w	$4(a1), d5	;Predicted (Code-scan)
	bgt.w	loc_412E	;Predicted (Code-scan)
	move.w	($FF0006).l, d5	;Predicted (Code-scan)
	cmp.w	$2(a1), d5	;Predicted (Code-scan)
	blt.w	loc_412E	;Predicted (Code-scan)
	cmp.w	$6(a1), d5	;Predicted (Code-scan)
	bgt.w	loc_412E	;Predicted (Code-scan)
	move.w	(a1), $00FF0022	;Predicted (Code-scan)
	move.w	$2(a1), $00FF0024	;Predicted (Code-scan)
	bsr.w	loc_4032	;Predicted (Code-scan)
	cmpi.w	#$4A, ($FF0006).l	;Predicted (Code-scan)
	blt.w	loc_4104	;Predicted (Code-scan)
	cmpi.l	#$3CE0, ($FF0078).l	;Predicted (Code-scan)
	bne.w	loc_4126	;Predicted (Code-scan)
	bsr.w	loc_45A4	;Predicted (Code-scan)
	bra.w	loc_4126	;Predicted (Code-scan)
loc_4104:
	cmpi.l	#$4688, ($FF0078).l	;Predicted (Code-scan)
	bne.w	loc_4126	;Predicted (Code-scan)
	bsr.w	loc_4194	;Predicted (Code-scan)
	jsr	(loc_3A36).l	;Predicted (Code-scan)
	move.l	#$3CE0, ($FF0078).l	;Predicted (Code-scan)
loc_4126:
	clr.b	$00FF002A	;Predicted (Code-scan)
	rts	;Predicted (Code-scan)
loc_412E:
	adda.w	#8, a1	;Predicted (Code-scan)
	bra.w	loc_409C	;Predicted (Code-scan)
loc_4136:
	bsr.w	loc_4058	;Predicted (Code-scan)
	move.b	#1, $00FF002A	;Predicted (Code-scan)
	cmpi.w	#0, ($FF0066).l	;Predicted (Code-scan)
	bne.w	loc_4192	;Predicted (Code-scan)
	cmpi.w	#$54, ($FF0006).l	;Predicted (Code-scan)
	bgt.w	loc_4192	;Predicted (Code-scan)
	cmpi.w	#$A, ($FF0004).l	;Predicted (Code-scan)
	bgt.w	loc_4176	;Predicted (Code-scan)
	move.w	#$14, $00FF0022	;Predicted (Code-scan)
	movea.l	($FF0070).l, a3	;Predicted (Code-scan)
	jmp	(a3)	;Predicted (Code-scan) (Uncertain target!)
loc_4176:
	cmpi.w	#$13C, ($FF0004).l	;Predicted (Code-scan)
	blt.w	loc_4192	;Predicted (Code-scan)
	move.w	#$F2, $00FF0022	;Predicted (Code-scan)
	movea.l	($FF0074).l, a3	;Predicted (Code-scan)
	jmp	(a3)	;Predicted (Code-scan) (Uncertain target!)
loc_4192:
	rts	;Predicted (Code-scan)
loc_4194:
	move.l	#$5C800003, (a0)
	move.w	#0, (a2)
	move.w	#0, (a2)
	move.w	#0, (a2)
	move.w	#0, (a2)
	rts
	move.l	d0, -(sp)
	cmpi.w	#0, ($FF0066).l
	bne.w	loc_423A
	cmpi.w	#$14, $00FF0022
	beq.w	loc_41DA
	move.w	#1, ($FF0066).l
	move.w	#$18, $00FF001A
	bra.w	loc_423A
loc_41DA:
	move.w	#4, ($FF0066).l	;Predicted (Code-scan)
	move.w	#$25, $00FF001A	;Predicted (Code-scan)
	move.w	#$FFCA, $00FF00D4	;Predicted (Code-scan)
	subi.w	#1, $00FF001E	;Predicted (Code-scan)
	cmpi.w	#$FFFF, $00FF001E	;Predicted (Code-scan)
	bne.w	loc_420E	;Predicted (Code-scan)
	move.w	#$32, $00FF001E	;Predicted (Code-scan)
loc_420E:
	move.w	$00FF001E, d0	;Predicted (Code-scan)
	andi.l	#$FFFF, d0	;Predicted (Code-scan)
	lsl.l	#2, d0	;Predicted (Code-scan)
	movea.l	d0, a1	;Predicted (Code-scan)
	adda.l	#$BC14, a1	;Predicted (Code-scan)
	movea.l	(a1), a4	;Predicted (Code-scan)
	bsr.w	loc_31D2	;Predicted (Code-scan)
	movea.l	$00FF00F0, a1	;Predicted (Code-scan)
	movea.l	#$FF01EC, a3	;Predicted (Code-scan)
	bsr.w	loc_323C	;Predicted (Code-scan)
loc_423A:
	move.l	(sp)+, d0
	rts
	move.l	d0, -(sp)
	cmpi.w	#0, ($FF0066).l
	bne.w	loc_42DC
	cmpi.w	#$F2, $00FF0022
	beq.w	loc_426C
	move.w	#2, ($FF0066).l
	move.w	#$18, $00FF001A
	bra.w	loc_42DC
loc_426C:
	move.w	#3, ($FF0066).l
	move.w	#$25, $00FF001A
	move.w	#$13C, $00FF00D4
	addi.w	#1, $00FF001E
	cmpi.w	#$33, $00FF001E
	bne.w	loc_42A0
	move.w	#0, $00FF001E	;Predicted (Code-scan)
loc_42A0:
	move.w	$00FF001E, d0
	addi.w	#3, d0
	cmpi.w	#$33, d0
	blt.w	loc_42B6
	subi.w	#$33, d0	;Predicted (Code-scan)
loc_42B6:
	andi.l	#$FFFF, d0
	lsl.l	#2, d0
	movea.l	d0, a1
	adda.l	#$BC14, a1
	movea.l	(a1), a4
	bsr.w	loc_31D2
	movea.l	$00FF00F0, a1
	movea.l	#$FF01EC, a3
	bsr.w	loc_323C
loc_42DC:
	move.l	(sp)+, d0
	rts
	move.l	d0, -(sp)
	cmpi.w	#0, ($FF0066).l
	bne.w	loc_436E
	cmpi.w	#$14, $00FF0022
	beq.w	loc_430E
	move.w	#1, ($FF0066).l
	move.w	#$18, $00FF001A
	bra.w	loc_436E
loc_430E:
	move.w	#4, ($FF0066).l
	move.w	#$25, $00FF001A
	move.w	#$FFCA, $00FF00D4
	subi.w	#1, $00FF001E
	cmpi.w	#$FFFF, $00FF001E
	bne.w	loc_4342
	move.w	#9, $00FF001E
loc_4342:
	move.w	$00FF001E, d0
	andi.l	#$FFFF, d0
	lsl.l	#2, d0
	movea.l	d0, a1
	adda.l	#$12B92, a1
	movea.l	(a1), a4
	bsr.w	loc_31D2
	movea.l	$00FF00F0, a1
	movea.l	#$FF01EC, a3
	bsr.w	loc_323C
loc_436E:
	move.l	(sp)+, d0
	rts
	move.l	d0, -(sp)
	cmpi.w	#0, ($FF0066).l
	bne.w	loc_4410
	cmpi.w	#$F2, $00FF0022
	beq.w	loc_43A0
	move.w	#2, ($FF0066).l
	move.w	#$18, $00FF001A
	bra.w	loc_4410
loc_43A0:
	move.w	#3, ($FF0066).l
	move.w	#$25, $00FF001A
	move.w	#$13C, $00FF00D4
	addi.w	#1, $00FF001E
	cmpi.w	#$A, $00FF001E
	bne.w	loc_43D4
	move.w	#0, $00FF001E
loc_43D4:
	move.w	$00FF001E, d0
	addi.w	#3, d0
	cmpi.w	#$A, d0
	blt.w	loc_43EA
	subi.w	#$A, d0
loc_43EA:
	andi.l	#$FFFF, d0
	lsl.l	#2, d0
	movea.l	d0, a1
	adda.l	#$12B92, a1
	movea.l	(a1), a4
	bsr.w	loc_31D2
	movea.l	$00FF00F0, a1
	movea.l	#$FF01EC, a3
	bsr.w	loc_323C
loc_4410:
	move.l	(sp)+, d0
	rts
	dc.b	$0C, $79, $00, $00, $00, $FF, $00, $66, $66, $00, $00, $2A, $33, $FC, $00, $14
	dc.b	$00, $FF, $00, $1A, $0C, $79, $00, $0A, $00, $FF, $00, $24, $66, $00, $00, $0E ;0x0 (0x00004414-0x0000444A, Entry count: 0x36) [Unknown data]
	dc.b	$33, $FC, $00, $06, $00, $FF, $00, $66, $60, $00, $00, $0A, $33, $FC, $00, $05
	dc.b	00, $FF, $00, $66, $4E, $75 ;0x20
loc_444A:
	link	a6, #0
	movem.l	a4/d7/d6/d5/d4/d3/d2/d1/d0, -(sp)
	move.w	#4, d0
	move.l	#$2C0, d1
	addi.l	#2, d1
	lsl.l	#1, d1
	swap	d1
	addi.l	#$60000003, d1
loc_446C:
	move.l	d1, (a0)
	move.w	#4, d2
	sub.w	d0, d2
	cmp.w	$00FF00CA, d2
	bne.w	loc_4492
	move.w	#$6637, (a2)
	addi.l	#$800000, d1
	move.l	d1, (a0)
	move.w	#$6638, (a2)
	bra.w	loc_44A2
loc_4492:
	move.w	#$6602, (a2)
	addi.l	#$800000, d1
	move.l	d1, (a0)
	move.w	#$6602, (a2)
loc_44A2:
	subi.l	#$720000, d1
	dbf	d0, loc_446C
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/d6/d7/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#0, a7
	jmp	(a3)
	move.l	d0, -(sp)
	cmpi.w	#0, ($FF0066).l
	bne.w	loc_45A0
	move.l	($FF00B0).l, d0
	sub.l	($FF00B4).l, d0
	cmpi.l	#$10, d0
	blt.w	loc_45A0
	move.l	($FF00B0).l, ($FF00B4).l
	move.l	#$462C, ($FF0070).l
	move.l	#$45D0, ($FF0074).l
	move.l	#$46EE, ($FF0068).l
	move.l	#$46EE, ($FF006C).l
	bsr.w	loc_45A4
	move.l	($FF00B0).l, ($FF00B4).l
	move.w	#$57, $00FF0024
	cmpi.w	#$20, $00FF0022
	bgt.w	loc_453E
	move.w	#$17, $00FF0022
	bra.w	loc_458E
loc_453E:
	cmpi.w	#$58, $00FF0022
	bgt.w	loc_4556
	move.w	#$4F, $00FF0022	;Predicted (Code-scan)
	bra.w	loc_458E	;Predicted (Code-scan)
loc_4556:
	cmpi.w	#$90, $00FF0022
	bgt.w	loc_456E
	move.w	#$87, $00FF0022
	bra.w	loc_458E
loc_456E:
	cmpi.w	#$C8, $00FF0022
	bgt.w	loc_4586
	move.w	#$BF, $00FF0022
	bra.w	loc_458E
loc_4586:
	move.w	#$F7, $00FF0022
loc_458E:
	move.l	#1, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
loc_45A0:
	move.l	(sp)+, d0
	rts
loc_45A4:
	jsr	(loc_4194).l
	move.l	#$4688, ($FF0078).l
	movea.l	#$4822, a4
	bsr.w	loc_31D2
	movea.l	#$FF01EC, a3
	movea.l	#$4C000002, a1
	bsr.w	loc_323C
	rts
	movem.l	a4/d4/d3/d2/d1/d0, -(sp)
	move.l	($FF00B0).l, d0
	sub.l	($FF00B4).l, d0
	cmpi.l	#$10, d0
	blt.w	loc_4626
	move.l	($FF00B0).l, ($FF00B4).l
	move.l	#1, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	cmpi.w	#$C8, $00FF0022
	bgt.w	loc_461E
	addi.w	#$38, $00FF0022
	bra.w	loc_4626
loc_461E:
	move.w	#$17, $00FF0022
loc_4626:
	movem.l	(sp)+, d0/d1/d2/d3/d4/a4
	rts
	movem.l	a4/d4/d3/d2/d1/d0, -(sp)
	move.l	($FF00B0).l, d0
	sub.l	($FF00B4).l, d0
	cmpi.l	#$10, d0
	blt.w	loc_4682
	move.l	($FF00B0).l, ($FF00B4).l
	move.l	#1, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	cmpi.w	#$20, $00FF0022
	blt.w	loc_467A
	subi.w	#$38, $00FF0022
	bra.w	loc_4682
loc_467A:
	move.w	#$F7, $00FF0022
loc_4682:
	movem.l	(sp)+, d0/d1/d2/d3/d4/a4
	rts
	move.l	d0, -(sp)
	cmpi.w	#0, ($FF000E).l
	beq.w	loc_46A2
	cmpi.w	#0, $00FF002A	;Predicted (Code-scan)
	bne.w	loc_46EA	;Predicted (Code-scan)
loc_46A2:
	move.l	($FF00B0).l, d0
	sub.l	($FF00B4).l, d0
	cmpi.l	#$10, d0
	blt.w	loc_46EA
	move.l	($FF00B0).l, ($FF00B4).l
	move.l	#4, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	clr.l	d0
	move.w	$00FF0022, d0
	divu.w	#$38, d0
	move.w	d0, $00FF00CA
	bsr.w	loc_444A
loc_46EA:
	move.l	(sp)+, d0
	rts
	move.l	d0, -(sp)
	move.l	($FF00B0).l, d0
	sub.l	($FF00B4).l, d0
	cmpi.l	#$10, d0
	blt.w	loc_47B2
	move.l	($FF00B0).l, ($FF00B4).l
	move.l	#1, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	move.w	#$A, $00FF0024
	cmpi.w	#$28, $00FF0022
	bgt.w	loc_4742
	move.w	#$14, $00FF0022
	bra.w	loc_477A
loc_4742:
	cmpi.w	#$70, $00FF0022
	bgt.w	loc_475A
	move.w	#$5E, $00FF0022
	bra.w	loc_477A
loc_475A:
	cmpi.w	#$B8, $00FF0022
	bgt.w	loc_4772
	move.w	#$A8, $00FF0022
	bra.w	loc_477A
loc_4772:
	move.w	#$F2, $00FF0022
loc_477A:
	jsr	(loc_3A36).l
	move.l	#$42E0, ($FF0070).l
	move.l	#$4372, ($FF0074).l
	move.l	#$44BA, ($FF0068).l
	move.l	#$44BA, ($FF006C).l
	move.l	#$3CE0, ($FF0078).l
loc_47B2:
	move.l	(sp)+, d0
	rts
	dc.b	$00, $14, $00, $0A, $00, $54, $00, $4A, $00, $5E, $00, $0A, $00, $9E, $00, $4A
	dc.b	$00, $A8, $00, $0A, $00, $E8, $00, $4A, $00, $F2, $00, $0A, $01, $32, $00, $4A ;0x0 (0x000047B6-0x00004822, Entry count: 0x6C) [Unknown data]
	dc.b	$FF, $FF, $00, $14, $00, $0A, $00, $54, $00, $4A, $00, $5E, $00, $0A, $00, $9E
	dc.b	$00, $4A, $00, $A8, $00, $0A, $00, $E8, $00, $4A, $00, $F2, $00, $0A, $01, $32 ;0x20
	dc.b	$00, $4A, $00, $17, $00, $57, $00, $3F, $00, $67, $00, $4F, $00, $57, $00, $77
	dc.b	$00, $67, $00, $85, $00, $57, $00, $AD, $00, $67, $00, $BF, $00, $57, $00, $E7 ;0x40
	dc.b	$00, $67, $00, $F7, $00, $57, $01, $1F, $00, $67, $FF, $FF ;0x60
	dc.b	$FF, $FF, $F9, $0F, $05, $F0, $0F, $0F, $07, $F0, $0F, $05, $F0, $0F, $0F, $07
	dc.b	$F0, $0F, $05, $F0, $0F, $0F, $07, $F0, $0F, $05, $F0, $0F, $0F, $07, $F0, $0F ;0x0 (0x00004822-0x00004AD0, Entry count: 0x2AE)
	dc.b	$05, $F0, $0F, $0F, $07, $F0, $0F, $05, $F0, $0F, $0F, $07, $F0, $0F, $05, $F0
	dc.b	$0F, $0F, $07, $F0, $0F, $05, $F0, $0F, $0F, $07, $F0, $0F, $05, $F0, $0F, $0F ;0x20
	dc.b	$07, $F0, $0F, $05, $F0, $0F, $0F, $07, $F0, $0F, $05, $F0, $0F, $0F, $07, $F0
	dc.b	$0F, $05, $F0, $0F, $0F, $07, $F0, $0F, $05, $F0, $0F, $0F, $07, $F0, $0F, $05 ;0x40
	dc.b	$F0, $0F, $0F, $07, $F0, $0F, $05, $F0, $0F, $0F, $07, $F0, $0F, $05, $F0, $0F
	dc.b	$0F, $07, $F0, $0F, $05, $FF, $FF, $F9, $0F, $05, $0F, $0F, $0F, $0F, $0F, $0F ;0x60
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x80
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0xA0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0xC0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0xE0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x100
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $FF, $FF, $FF, $FF, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F ;0x120
	dc.b	$0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F
	dc.b	$0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0 ;0x140
	dc.b	$F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F
	dc.b	$0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F ;0x160
	dc.b	$0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0
	dc.b	$F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F ;0x180
	dc.b	$0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F
	dc.b	$0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0 ;0x1A0
	dc.b	$F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F
	dc.b	$0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F ;0x1C0
	dc.b	$0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0
	dc.b	$F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F ;0x1E0
	dc.b	$0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F
	dc.b	$0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0 ;0x200
	dc.b	$F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F
	dc.b	$0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F ;0x220
	dc.b	$0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0
	dc.b	$F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F ;0x240
	dc.b	$0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F
	dc.b	$0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0 ;0x260
	dc.b	$F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F
	dc.b	$0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $F0, $0F ;0x280
	dc.b	$0F, $0F, $0D, $F0, $F0, $0F, $0F, $0F, $0D, $F0, $FF, $FF, $FF, $FF ;0x2A0
	cmpi.w	#0, ($FF0042).l
	bne.w	loc_4AE4
	move.w	#$F, ($FF0042).l	;Predicted (Code-scan)
loc_4AE4:
	clr.w	$00FF002A
	bsr.w	loc_4B3C
	jsr	(loc_104A).l
	clr.w	$00FF0026
	move.l	#$4AD0, ($FF0096).l
	move.w	#$C, ($FF003C).l
	move.l	#$4C20, ($FF008C).l
	move.l	#$4B66, ($FF0078).l
	move.l	#$4BE8, ($FF007C).l
	move.l	#$4C30, ($FF00A2).l
	jsr	(loc_4C20).l
	rts
loc_4B3C:
	clr.l	d1
	move.w	$00FF002A, d1
	lsl.l	#2, d1
	addi.l	#$1F392, d1
	movea.l	d1, a1
	movea.l	(a1), a4
	bsr.w	loc_4C3C
	movea.l	#$50000003, a1
	movea.l	#$FF01EC, a3
	bsr.w	loc_323C
	rts
	move.l	#5, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	jsr	(loc_4B8A).l
	bsr.w	loc_4BB2
	jsr	(loc_4C20).l
	rts
loc_4B8A:
	movem.l	d7/d0, -(sp)
	movea.l	#$FF01EC, a4
	move.w	($FF0004).l, $00FF0022
	move.w	($FF0006).l, $00FF0024
	bsr.w	loc_327A
	movem.l	(sp)+, d0/d7
	rts
loc_4BB2:
	addi.w	#$10, ($FF0004).l
	cmpi.w	#$130, ($FF0004).l
	blt.w	loc_4BE6
	clr.w	($FF0004).l	;Predicted (Code-scan)
	addi.w	#$10, ($FF0006).l	;Predicted (Code-scan)
	cmpi.w	#$D0, ($FF0006).l	;Predicted (Code-scan)
	blt.w	loc_4BE6	;Predicted (Code-scan)
	clr.w	($FF0006).l	;Predicted (Code-scan)
loc_4BE6:
	rts
	move.l	d0, -(sp)
	move.l	#1, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	addi.w	#1, $00FF002A
	cmpi.w	#$24, $00FF002A
	bne.w	loc_4C16
	clr.w	$00FF002A
loc_4C16:
	jsr	(loc_4B3C).l
	move.l	(sp)+, d0
	rts
loc_4C20:
	move.w	($FF0004).l, d2
	move.w	($FF0006).l, d1
	bra.w	loc_30F6
	dc.b	$61, $00, $FF, $B6, $4E, $B9, $00, $00, $11, $06, $4E, $75 ;0x0 (0x00004C30-0x00004C3C, Entry count: 0xC) [Unknown data]
loc_4C3C:
	movem.l	a4/a3/d6/d5/d4/d3/d2/d1/d0, -(sp)
	movea.l	#$FF01EC, a3
	clr.l	d0
	clr.b	d4
loc_4C4A:
	move.b	(a4)+, d1
	clr.b	d2
	btst	#7, d1
	beq.w	loc_4C5C
	move.w	($FF0042).l, d2
loc_4C5C:
	move.b	d2, d3
	lsl.b	#4, d2
	andi.l	#$7F, d1
loc_4C66:
	cmpi.b	#0, d4
	bne.w	loc_4C78
	move.b	d2, d5
	move.b	#1, d4
	bra.w	loc_4C7E
loc_4C78:
	or.b	d3, d5
	move.b	d5, (a3)+
	clr.w	d4
loc_4C7E:
	addq.l	#1, d0
	move.l	d0, d6
	andi.b	#$F, d6
	bne.w	loc_4CB6
	move.w	#5, d6
loc_4C8E:
	move.l	#0, (a3)+
	dbf	d6, loc_4C8E
	cmpi.l	#$100, d0
	blt.w	loc_4CB6
	move.w	#$17F, d6
loc_4CA6:
	move.l	#0, (a3)+
	dbf	d6, loc_4CA6
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/d6/a3/a4
	rts
loc_4CB6:
	dbf	d1, loc_4C66
	bra.w	loc_4C4A
loc_4CBE:
	clr.w	$00FF003A	;Predicted (Code-scan)
	clr.w	($FF0004).l	;Predicted (Code-scan)
	clr.w	($FF0006).l	;Predicted (Code-scan)
	move.l	#$FF01EC, $00FF00C6	;Predicted (Code-scan)
	move.l	#$F6, d0	;Predicted (Code-scan)
loc_4CE0:
	move.b	(a5)+, d1	;Predicted (Code-scan)
	cmpi.b	#$20, d1	;Predicted (Code-scan)
	beq.w	loc_4D26	;Predicted (Code-scan)
	subi.b	#$41, d1	;Predicted (Code-scan)
	andi.l	#$FF, d1	;Predicted (Code-scan)
	lsl.l	#2, d1	;Predicted (Code-scan)
	addi.l	#$1F392, d1	;Predicted (Code-scan)
	movea.l	d1, a1	;Predicted (Code-scan)
	movea.l	(a1), a4	;Predicted (Code-scan)
	bsr.w	loc_4C3C	;Predicted (Code-scan)
	jsr	(loc_4B8A).l	;Predicted (Code-scan)
	addi.w	#1, ($FF0042).l	;Predicted (Code-scan)
	cmpi.w	#$10, ($FF0042).l	;Predicted (Code-scan)
	bne.w	loc_4D26	;Predicted (Code-scan)
	move.w	#1, ($FF0042).l	;Predicted (Code-scan)
loc_4D26:
	bsr.w	loc_4BB2	;Predicted (Code-scan)
	move.l	d0, d7	;Predicted (Code-scan)
	bsr.w	loc_1246	;Predicted (Code-scan)
	cmpi.w	#0, $00FF003A	;Predicted (Code-scan)
	beq.w	loc_4D4C	;Predicted (Code-scan)
	cmpi.w	#0, d0	;Predicted (Code-scan)
	bne.w	loc_4D4A	;Predicted (Code-scan)
loc_4D44:
	move.l	d7, d0	;Predicted (Code-scan)
	dbf	d0, loc_4CE0	;Predicted (Code-scan)
loc_4D4A:
	rts	;Predicted (Code-scan)
loc_4D4C:
	cmpi.w	#0, d0	;Predicted (Code-scan)
	bne.w	loc_4D44	;Predicted (Code-scan)
	move.w	#1, $00FF003A	;Predicted (Code-scan)
	bra.w	loc_4D44	;Predicted (Code-scan)
	dc.l	loc_5354
	dc.l	loc_53D4
	dc.l	loc_5454
	dc.l	loc_54D4
	dc.l	loc_5394
	dc.l	loc_5414
	dc.l	loc_5494
	dc.l	loc_5514
	dc.l	loc_5714
	dc.l	loc_56D4
	dc.l	loc_5654
	dc.l	loc_5754
	dc.l	loc_5794
loc_4D94:
	dc.l	$00005654
	dc.b	$00, $00, $56, $54, $00, $00, $57, $14 ;0x0 (0x00004D98-0x00004DA0, Entry count: 0x8) [Unknown data]
	dc.l	$00005314
	dc.b	$00, $00, $53, $14, $00, $00, $53, $14 ;0x0 (0x00004DA4-0x00004DAC, Entry count: 0x8) [Unknown data]
	dc.l	$00004DD4
	dc.l	$00004DD4
	dc.b	$00, $00, $4D, $D4 ;0x0 (0x00004DB4-0x00004DB8, Entry count: 0x4) [Unknown data]
	dc.l	$00004E94
	dc.b	$00, $00, $4E, $94, $00, $00, $4E, $94 ;0x0 (0x00004DBC-0x00004DC4, Entry count: 0x8) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$00000000
	dc.w	$000F
	dc.w	$001F
	dc.l	$00004D94
	dc.l	$00004D94
	dc.b	$00, $00, $4D, $94 ;0x0 (0x00004DDC-0x00004DE0, Entry count: 0x4) [Unknown data]
	dc.l	$000051D4, $000051D4, $000051D4, $00004E14, $00004E14 ;0x0 (0x00004DE0-0x00004DF4, Entry count: 0x14)
	dc.b	$00, $00, $4E, $14 ;0x0 (0x00004DF4-0x00004DF8, Entry count: 0x4) [Unknown data]
	dc.l	$00004ED4
	dc.l	$00004ED4
	dc.l	$00004ED4
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$00000001
	dc.w	$001F
	dc.w	$001F
	dc.l	$00004DD4, $00004DD4, $00004DD4, $000052D4 ;0x0 (0x00004E14-0x00004E24, Entry count: 0x10)
	dc.b	$00, $00, $52, $D4 ;0x0 (0x00004E24-0x00004E28, Entry count: 0x4) [Unknown data]
	dc.l	$000052D4
	dc.l	$00004E54
	dc.l	$00004E54
	dc.b	$00, $00, $4E, $54 ;0x0 (0x00004E34-0x00004E38, Entry count: 0x4) [Unknown data]
	dc.l	$00004F14
	dc.b	$00, $00, $4F, $14, $00, $00, $4F, $14 ;0x0 (0x00004E3C-0x00004E44, Entry count: 0x8) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$00000002
	dc.w	$002F
	dc.w	$001F
	dc.l	$00004E14, $00004E14, $00004E14, $00005294 ;0x0 (0x00004E54-0x00004E64, Entry count: 0x10)
	dc.b	$00, $00, $52, $94 ;0x0 (0x00004E64-0x00004E68, Entry count: 0x4) [Unknown data]
	dc.l	$00005294
	dc.l	$00005354
	dc.l	$00005354
	dc.b	$00, $00, $53, $54 ;0x0 (0x00004E74-0x00004E78, Entry count: 0x4) [Unknown data]
	dc.l	$00004F54
	dc.b	$00, $00, $4F, $54, $00, $00, $4F, $54 ;0x0 (0x00004E7C-0x00004E84, Entry count: 0x8) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$00000003
	dc.w	$003F
	dc.w	$001F
	dc.b	$00, $00, $57, $54, $00, $00, $56, $54, $00, $00, $57, $54 ;0x0 (0x00004E94-0x00004EA0, Entry count: 0xC) [Unknown data]
	dc.l	$00004D94
	dc.b	$00, $00, $4D, $94, $00, $00, $4D, $94 ;0x0 (0x00004EA4-0x00004EAC, Entry count: 0x8) [Unknown data]
	dc.l	$00004ED4
	dc.b	$00, $00, $4E, $D4, $00, $00, $4E, $D4 ;0x0 (0x00004EB0-0x00004EB8, Entry count: 0x8) [Unknown data]
	dc.l	$00004F94
	dc.b	$00, $00, $4F, $94, $00, $00, $4F, $94 ;0x0 (0x00004EBC-0x00004EC4, Entry count: 0x8) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074	;Predicted (Code target predicted at 0x9074)
	dc.b	$00, $00, $00, $04 ;0x0 (0x00004ECC-0x00004ED0, Entry count: 0x4) [Unknown data]
	dc.w	$000F
	dc.w	$0027
	dc.b	$00, $00, $4E, $94, $00, $00, $4E, $94, $00, $00, $4E, $94 ;0x0 (0x00004ED4-0x00004EE0, Entry count: 0xC) [Unknown data]
	dc.l	$00004DD4
	dc.l	$00004DD4
	dc.b	$00, $00, $4D, $D4 ;0x0 (0x00004EE8-0x00004EEC, Entry count: 0x4) [Unknown data]
	dc.l	$00004F14
	dc.b	$00, $00, $4F, $14 ;0x0 (0x00004EF0-0x00004EF4, Entry count: 0x4) [Unknown data]
	dc.l	$00004F14
	dc.b	$00, $00, $4F, $D4 ;0x0 (0x00004EF8-0x00004EFC, Entry count: 0x4) [Unknown data]
	dc.l	$00004FD4
	dc.b	$00, $00, $4F, $D4 ;0x0 (0x00004F00-0x00004F04, Entry count: 0x4) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$00000005
	dc.w	$001F
	dc.w	$0027
	dc.l	$00004ED4
	dc.b	$00, $00, $4E, $D4, $00, $00, $4E, $D4 ;0x0 (0x00004F18-0x00004F20, Entry count: 0x8) [Unknown data]
	dc.l	$00004E14
	dc.b	$00, $00, $4E, $14 ;0x0 (0x00004F24-0x00004F28, Entry count: 0x4) [Unknown data]
	dc.l	$00004E14
	dc.l	$00004F54
	dc.b	$00, $00, $4F, $54, $00, $00, $4F, $54 ;0x0 (0x00004F30-0x00004F38, Entry count: 0x8) [Unknown data]
	dc.l	$00005014
	dc.b	$00, $00, $50, $14 ;0x0 (0x00004F3C-0x00004F40, Entry count: 0x4) [Unknown data]
	dc.l	$00005014
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$00000006
	dc.w	$002F
	dc.w	$0027
	dc.l	$00004F14
	dc.b	$00, $00, $4F, $14, $00, $00, $4F, $14 ;0x0 (0x00004F58-0x00004F60, Entry count: 0x8) [Unknown data]
	dc.l	$00004E54
	dc.b	$00, $00, $4E, $54, $00, $00, $4E, $54 ;0x0 (0x00004F64-0x00004F6C, Entry count: 0x8) [Unknown data]
	dc.l	$00005354
	dc.b	$00, $00, $53, $54, $00, $00, $53, $54 ;0x0 (0x00004F70-0x00004F78, Entry count: 0x8) [Unknown data]
	dc.l	$00005054
	dc.b	$00, $00, $50, $54, $00, $00, $50, $54 ;0x0 (0x00004F7C-0x00004F84, Entry count: 0x8) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$00000007
	dc.w	$003F
	dc.w	$0027
	dc.l	$00005754, $00005614, $00005754, $00004E94 ;0x0 (0x00004F94-0x00004FA4, Entry count: 0x10)
	dc.b	$00, $00, $4E, $94, $00, $00, $4E, $94 ;0x0 (0x00004FA4-0x00004FAC, Entry count: 0x8) [Unknown data]
	dc.l	$00004FD4
	dc.b	$00, $00, $4F, $D4 ;0x0 (0x00004FB0-0x00004FB4, Entry count: 0x4) [Unknown data]
	dc.l	$00004FD4
	dc.l	$00005094
	dc.b	$00, $00, $50, $94, $00, $00, $50, $94 ;0x0 (0x00004FBC-0x00004FC4, Entry count: 0x8) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074	;Predicted (Code target predicted at 0x9074)
	dc.b	$00, $00, $00, $08 ;0x0 (0x00004FCC-0x00004FD0, Entry count: 0x4) [Unknown data]
	dc.w	$000F
	dc.w	$002F
	dc.b	$00, $00, $4F, $94 ;0x0 (0x00004FD4-0x00004FD8, Entry count: 0x4) [Unknown data]
	dc.l	$00004F94
	dc.l	$00004F94
	dc.l	$00004ED4
	dc.b	$00, $00, $4E, $D4, $00, $00, $4E, $D4 ;0x0 (0x00004FE4-0x00004FEC, Entry count: 0x8) [Unknown data]
	dc.l	$00005014
	dc.b	$00, $00, $50, $14, $00, $00, $50, $14 ;0x0 (0x00004FF0-0x00004FF8, Entry count: 0x8) [Unknown data]
	dc.l	$000050D4
	dc.b	$00, $00, $50, $D4, $00, $00, $50, $D4 ;0x0 (0x00004FFC-0x00005004, Entry count: 0x8) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$00000009
	dc.w	$001F
	dc.w	$002F
	dc.l	$00004FD4
	dc.b	$00, $00, $4F, $D4, $00, $00, $4F, $D4 ;0x0 (0x00005018-0x00005020, Entry count: 0x8) [Unknown data]
	dc.l	$00004F14
	dc.b	$00, $00, $4F, $14 ;0x0 (0x00005024-0x00005028, Entry count: 0x4) [Unknown data]
	dc.l	$00004F14
	dc.l	$00005054
	dc.b	$00, $00, $50, $54, $00, $00, $50, $54 ;0x0 (0x00005030-0x00005038, Entry count: 0x8) [Unknown data]
	dc.l	$00005114
	dc.b	$00, $00, $51, $14 ;0x0 (0x0000503C-0x00005040, Entry count: 0x4) [Unknown data]
	dc.l	$00005114
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$0000000A
	dc.w	$002F
	dc.w	$002F
	dc.b	$00, $00, $50, $14, $00, $00, $50, $14 ;0x0 (0x00005054-0x0000505C, Entry count: 0x8) [Unknown data]
	dc.l	$00005014
	dc.l	$00004F54
	dc.b	$00, $00, $4F, $54, $00, $00, $4F, $54 ;0x0 (0x00005064-0x0000506C, Entry count: 0x8) [Unknown data]
	dc.l	$00005414
	dc.b	$00, $00, $54, $14 ;0x0 (0x00005070-0x00005074, Entry count: 0x4) [Unknown data]
	dc.l	$00005414
	dc.l	$00005154
	dc.b	$00, $00, $51, $54, $00, $00, $51, $54 ;0x0 (0x0000507C-0x00005084, Entry count: 0x8) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$0000000B
	dc.w	$003F
	dc.w	$002F
	dc.l	$00005614
	dc.l	$00005614
	dc.b	$00, $00, $56, $14 ;0x0 (0x0000509C-0x000050A0, Entry count: 0x4) [Unknown data]
	dc.l	$00004F94
	dc.b	$00, $00, $4F, $94 ;0x0 (0x000050A4-0x000050A8, Entry count: 0x4) [Unknown data]
	dc.l	$00004F94
	dc.l	$000050D4
	dc.b	$00, $00, $50, $D4, $00, $00, $50, $D4 ;0x0 (0x000050B0-0x000050B8, Entry count: 0x8) [Unknown data]
	dc.l	$00005194
	dc.b	$00, $00, $51, $94, $00, $00, $51, $94 ;0x0 (0x000050BC-0x000050C4, Entry count: 0x8) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074	;Predicted (Code target predicted at 0x9074)
	dc.b	$00, $00, $00, $0C ;0x0 (0x000050CC-0x000050D0, Entry count: 0x4) [Unknown data]
	dc.w	$000F
	dc.w	$0037
	dc.l	$00005094, $00005094, $00005094, $00004FD4 ;0x0 (0x000050D4-0x000050E4, Entry count: 0x10)
	dc.b	$00, $00, $4F, $D4, $00, $00, $4F, $D4 ;0x0 (0x000050E4-0x000050EC, Entry count: 0x8) [Unknown data]
	dc.l	$00005114
	dc.b	$00, $00, $51, $14 ;0x0 (0x000050F0-0x000050F4, Entry count: 0x4) [Unknown data]
	dc.l	$00005114
	dc.l	$000051D4
	dc.b	$00, $00, $51, $D4, $00, $00, $51, $D4 ;0x0 (0x000050FC-0x00005104, Entry count: 0x8) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074	;Predicted (Code target predicted at 0x9074)
	dc.b	$00, $00, $00, $0D ;0x0 (0x0000510C-0x00005110, Entry count: 0x4) [Unknown data]
	dc.w	$001F
	dc.w	$0037
	dc.l	$000050D4
	dc.b	$00, $00, $50, $D4, $00, $00, $50, $D4 ;0x0 (0x00005118-0x00005120, Entry count: 0x8) [Unknown data]
	dc.l	$00005014
	dc.b	$00, $00, $50, $14, $00, $00, $50, $14 ;0x0 (0x00005124-0x0000512C, Entry count: 0x8) [Unknown data]
	dc.l	$00005154
	dc.b	$00, $00, $51, $54 ;0x0 (0x00005130-0x00005134, Entry count: 0x4) [Unknown data]
	dc.l	$00005154
	dc.l	$00005214
	dc.b	$00, $00, $52, $14 ;0x0 (0x0000513C-0x00005140, Entry count: 0x4) [Unknown data]
	dc.l	$00005214
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$0000000E
	dc.w	$002F
	dc.w	$0037
	dc.l	$00005114
	dc.b	$00, $00, $51, $14 ;0x0 (0x00005158-0x0000515C, Entry count: 0x4) [Unknown data]
	dc.l	$00005114
	dc.l	$00005054
	dc.b	$00, $00, $50, $54 ;0x0 (0x00005164-0x00005168, Entry count: 0x4) [Unknown data]
	dc.l	$00005054
	dc.l	$00005414
	dc.b	$00, $00, $54, $14 ;0x0 (0x00005170-0x00005174, Entry count: 0x4) [Unknown data]
	dc.l	$00005414
	dc.l	$00005254
	dc.b	$00, $00, $52, $54, $00, $00, $52, $54 ;0x0 (0x0000517C-0x00005184, Entry count: 0x8) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$0000000F
	dc.w	$003F
	dc.w	$0037
	dc.l	$00005614
	dc.b	$00, $00, $56, $14 ;0x0 (0x00005198-0x0000519C, Entry count: 0x4) [Unknown data]
	dc.l	$00005614
	dc.l	$00005094
	dc.b	$00, $00, $50, $94, $00, $00, $50, $94 ;0x0 (0x000051A4-0x000051AC, Entry count: 0x8) [Unknown data]
	dc.l	$000051D4
	dc.b	$00, $00, $51, $D4 ;0x0 (0x000051B0-0x000051B4, Entry count: 0x4) [Unknown data]
	dc.l	$000051D4
	dc.l	$00005314
	dc.b	$00, $00, $53, $14, $00, $00, $53, $14 ;0x0 (0x000051BC-0x000051C4, Entry count: 0x8) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$00000010
	dc.w	$000F
	dc.w	$003F
	dc.l	$00005194
	dc.b	$00, $00, $51, $94 ;0x0 (0x000051D8-0x000051DC, Entry count: 0x4) [Unknown data]
	dc.l	$00005194, $000050D4, $000050D4, $000050D4, $00005214 ;0x0 (0x000051DC-0x000051F0, Entry count: 0x14)
	dc.b	$00, $00, $52, $14, $00, $00, $52, $14 ;0x0 (0x000051F0-0x000051F8, Entry count: 0x8) [Unknown data]
	dc.l	$00004DD4
	dc.l	$00004DD4
	dc.b	$00, $00, $4D, $D4 ;0x0 (0x00005200-0x00005204, Entry count: 0x4) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$00000011
	dc.w	$001F
	dc.w	$003F
	dc.l	$000051D4
	dc.l	$000051D4
	dc.b	$00, $00, $51, $D4 ;0x0 (0x0000521C-0x00005220, Entry count: 0x4) [Unknown data]
	dc.l	$00005114
	dc.b	$00, $00, $51, $14, $00, $00, $51, $14 ;0x0 (0x00005224-0x0000522C, Entry count: 0x8) [Unknown data]
	dc.l	$00005254
	dc.b	$00, $00, $52, $54, $00, $00, $52, $54 ;0x0 (0x00005230-0x00005238, Entry count: 0x8) [Unknown data]
	dc.l	$000052D4
	dc.b	$00, $00, $52, $D4 ;0x0 (0x0000523C-0x00005240, Entry count: 0x4) [Unknown data]
	dc.l	$000052D4
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$00000012
	dc.w	$002F
	dc.w	$003F
	dc.l	$00005214
	dc.l	$00005214
	dc.b	$00, $00, $52, $14 ;0x0 (0x0000525C-0x00005260, Entry count: 0x4) [Unknown data]
	dc.l	$00005154
	dc.b	$00, $00, $51, $54, $00, $00, $51, $54 ;0x0 (0x00005264-0x0000526C, Entry count: 0x8) [Unknown data]
	dc.l	$00005694
	dc.b	$00, $00, $57, $94, $00, $00, $57, $94 ;0x0 (0x00005270-0x00005278, Entry count: 0x8) [Unknown data]
	dc.l	$00005294
	dc.b	$00, $00, $52, $94, $00, $00, $52, $94 ;0x0 (0x0000527C-0x00005284, Entry count: 0x8) [Unknown data]
	dc.w	$0460
	dc.w	$0901
	dc.l	loc_9074
	dc.l	$00000013
	dc.w	$003F
	dc.w	$003F
	dc.l	$000052D4
	dc.b	$00, $00, $52, $D4 ;0x0 (0x00005298-0x0000529C, Entry count: 0x4) [Unknown data]
	dc.l	$000052D4
	dc.l	$00005254
	dc.b	$00, $00, $52, $54, $00, $00, $52, $54 ;0x0 (0x000052A4-0x000052AC, Entry count: 0x8) [Unknown data]
	dc.l	$00005354
	dc.b	$00, $00, $53, $54 ;0x0 (0x000052B0-0x000052B4, Entry count: 0x4) [Unknown data]
	dc.l	$00005354
	dc.l	$00004E54
	dc.b	$00, $00, $4E, $54, $00, $00, $4E, $54 ;0x0 (0x000052BC-0x000052C4, Entry count: 0x8) [Unknown data]
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_90D0
	dc.l	$00000001
	dc.w	$003F
	dc.w	$0007
	dc.l	$00005314
	dc.b	$00, $00, $53, $14 ;0x0 (0x000052D8-0x000052DC, Entry count: 0x4) [Unknown data]
	dc.l	$00005314
	dc.b	$00, $00, $52, $14, $00, $00, $52, $14, $00, $00, $52, $14 ;0x0 (0x000052E0-0x000052EC, Entry count: 0xC) [Unknown data]
	dc.l	$00005294
	dc.b	$00, $00, $52, $94 ;0x0 (0x000052F0-0x000052F4, Entry count: 0x4) [Unknown data]
	dc.l	$00005294
	dc.l	$00004E14
	dc.b	$00, $00, $4E, $14 ;0x0 (0x000052FC-0x00005300, Entry count: 0x4) [Unknown data]
	dc.l	$00004E14
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_90D0
	dc.l	$FFFFFFFF
	dc.w	$002F
	dc.w	$0007
	dc.l	$00005654
	dc.b	$00, $00, $56, $54 ;0x0 (0x00005318-0x0000531C, Entry count: 0x4) [Unknown data]
	dc.l	$00005754
	dc.b	$00, $00, $51, $94, $00, $00, $51, $94, $00, $00, $51, $94 ;0x0 (0x00005320-0x0000532C, Entry count: 0xC) [Unknown data]
	dc.l	$000052D4
	dc.b	$00, $00, $52, $D4, $00, $00, $52, $D4 ;0x0 (0x00005330-0x00005338, Entry count: 0x8) [Unknown data]
	dc.l	$00004D94
	dc.b	$00, $00, $4D, $94, $00, $00, $4D, $94 ;0x0 (0x0000533C-0x00005344, Entry count: 0x8) [Unknown data]
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_9192
	dc.l	$00000001
	dc.w	$000F
	dc.w	$0007
loc_5354:
	dc.l	$00004E54
	dc.b	$00, $00, $4E, $54 ;0x0 (0x00005358-0x0000535C, Entry count: 0x4) [Unknown data]
	dc.l	$00004E54
	dc.l	$00005414
	dc.b	$00, $00, $54, $14 ;0x0 (0x00005364-0x00005368, Entry count: 0x4) [Unknown data]
	dc.l	$00005414, $00005494, $00005494, $00005494, $00005414 ;0x0 (0x00005368-0x0000537C, Entry count: 0x14)
	dc.b	$00, $00, $54, $14, $00, $00, $54, $14 ;0x0 (0x0000537C-0x00005384, Entry count: 0x8) [Unknown data]
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_9516
	dc.l	$00000000
	dc.w	$005F
	dc.w	$000F
loc_5394:
	dc.l	$00005414
	dc.b	$00, $00, $54, $14, $00, $00, $54, $14 ;0x0 (0x00005398-0x000053A0, Entry count: 0x8) [Unknown data]
	dc.l	$00005494
	dc.b	$00, $00, $54, $94 ;0x0 (0x000053A4-0x000053A8, Entry count: 0x4) [Unknown data]
	dc.l	$00005494
	dc.l	$000054D4
	dc.b	$00, $00, $54, $D4 ;0x0 (0x000053B0-0x000053B4, Entry count: 0x4) [Unknown data]
	dc.l	$000054D4
	dc.l	$00005494
	dc.b	$00, $00, $54, $94 ;0x0 (0x000053BC-0x000053C0, Entry count: 0x4) [Unknown data]
	dc.l	$00005494
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_9516
	dc.l	$00000004
	dc.w	$0077
	dc.w	$0027
loc_53D4:
	dc.l	$00005454
	dc.b	$00, $00, $54, $54 ;0x0 (0x000053D8-0x000053DC, Entry count: 0x4) [Unknown data]
	dc.l	$00005454
	dc.l	$00005514
	dc.b	$00, $00, $55, $14, $00, $00, $55, $14 ;0x0 (0x000053E4-0x000053EC, Entry count: 0x8) [Unknown data]
	dc.l	$00005554, $00005554, $00005554, $00005514 ;0x0 (0x000053EC-0x000053FC, Entry count: 0x10)
	dc.b	$00, $00, $55, $14 ;0x0 (0x000053FC-0x00005400, Entry count: 0x4) [Unknown data]
	dc.l	$00005514
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_9516
	dc.l	$00000001
	dc.w	$00A7
	dc.w	$000F
loc_5414:
	dc.l	$00005154
	dc.b	$00, $00, $51, $54 ;0x0 (0x00005418-0x0000541C, Entry count: 0x4) [Unknown data]
	dc.l	$00005154
	dc.l	$00005354
	dc.b	$00, $00, $53, $54 ;0x0 (0x00005424-0x00005428, Entry count: 0x4) [Unknown data]
	dc.l	$00005354
	dc.l	$00005394
	dc.b	$00, $00, $53, $94 ;0x0 (0x00005430-0x00005434, Entry count: 0x4) [Unknown data]
	dc.l	$00005394
	dc.l	$00005354
	dc.b	$00, $00, $53, $54, $00, $00, $53, $54 ;0x0 (0x0000543C-0x00005444, Entry count: 0x8) [Unknown data]
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_9516
	dc.l	$00000005
	dc.w	$005F
	dc.w	$0027
loc_5454:
	dc.l	$00005494
	dc.b	$00, $00, $54, $94 ;0x0 (0x00005458-0x0000545C, Entry count: 0x4) [Unknown data]
	dc.l	$00005494
	dc.l	$000054D4
	dc.b	$00, $00, $54, $D4, $00, $00, $54, $D4 ;0x0 (0x00005464-0x0000546C, Entry count: 0x8) [Unknown data]
	dc.l	$000053D4, $000053D4, $000053D4, $000054D4 ;0x0 (0x0000546C-0x0000547C, Entry count: 0x10)
	dc.b	$00, $00, $54, $D4, $00, $00, $54, $D4 ;0x0 (0x0000547C-0x00005484, Entry count: 0x8) [Unknown data]
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_9516
	dc.l	$00000002
	dc.w	$008F
	dc.w	$000F
loc_5494:
	dc.l	$00005354
	dc.b	$00, $00, $53, $54 ;0x0 (0x00005498-0x0000549C, Entry count: 0x4) [Unknown data]
	dc.l	$00005354
	dc.l	$00005394
	dc.b	$00, $00, $53, $94 ;0x0 (0x000054A4-0x000054A8, Entry count: 0x4) [Unknown data]
	dc.l	$00005394, $00005454, $00005454, $00005454, $00005394 ;0x0 (0x000054A8-0x000054BC, Entry count: 0x14)
	dc.b	$00, $00, $53, $94 ;0x0 (0x000054BC-0x000054C0, Entry count: 0x4) [Unknown data]
	dc.l	$00005394
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_9516
	dc.l	$00000006
	dc.w	$0077
	dc.w	$000F
loc_54D4:
	dc.l	$00005394
	dc.b	$00, $00, $53, $94, $00, $00, $53, $94 ;0x0 (0x000054D8-0x000054E0, Entry count: 0x8) [Unknown data]
	dc.l	$00005454
	dc.b	$00, $00, $54, $54, $00, $00, $54, $54 ;0x0 (0x000054E4-0x000054EC, Entry count: 0x8) [Unknown data]
	dc.l	$00005514
	dc.b	$00, $00, $55, $14 ;0x0 (0x000054F0-0x000054F4, Entry count: 0x4) [Unknown data]
	dc.l	$00005514
	dc.l	$00005454
	dc.b	$00, $00, $54, $54, $00, $00, $54, $54 ;0x0 (0x000054FC-0x00005504, Entry count: 0x8) [Unknown data]
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_9516
	dc.l	$00000003
	dc.w	$008F
	dc.w	$0027
loc_5514:
	dc.l	$000054D4
	dc.b	$00, $00, $54, $D4, $00, $00, $54, $D4 ;0x0 (0x00005518-0x00005520, Entry count: 0x8) [Unknown data]
	dc.l	$000053D4
	dc.b	$00, $00, $53, $D4, $00, $00, $53, $D4 ;0x0 (0x00005524-0x0000552C, Entry count: 0x8) [Unknown data]
	dc.l	$000055D4
	dc.b	$00, $00, $55, $D4 ;0x0 (0x00005530-0x00005534, Entry count: 0x4) [Unknown data]
	dc.l	$000055D4
	dc.b	$00, $00, $53, $D4, $00, $00, $53, $D4, $00, $00, $53, $D4 ;0x0 (0x00005538-0x00005544, Entry count: 0xC) [Unknown data]
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_9516
	dc.l	$00000007
	dc.w	$00A7
	dc.w	$0027
	dc.l	$000053D4
	dc.b	$00, $00, $53, $D4, $00, $00, $53, $D4 ;0x0 (0x00005558-0x00005560, Entry count: 0x8) [Unknown data]
	dc.l	$000055D4
	dc.b	$00, $00, $55, $D4, $00, $00, $55, $D4 ;0x0 (0x00005564-0x0000556C, Entry count: 0x8) [Unknown data]
	dc.l	$00005714, $00005714, $00005714, $00005594 ;0x0 (0x0000556C-0x0000557C, Entry count: 0x10)
	dc.b	$00, $00, $55, $94, $00, $00, $55, $94 ;0x0 (0x0000557C-0x00005584, Entry count: 0x8) [Unknown data]
	dc.w	$0485
	dc.w	$0D01
	dc.l	loc_94EE
	dc.l	$00000001
	dc.w	$00CE
	dc.w	$000E
	dc.l	$000053D4
	dc.b	$00, $00, $53, $D4 ;0x0 (0x00005598-0x0000559C, Entry count: 0x4) [Unknown data]
	dc.l	$000053D4
	dc.l	$00005554
	dc.b	$00, $00, $55, $54, $00, $00, $55, $54 ;0x0 (0x000055A4-0x000055AC, Entry count: 0x8) [Unknown data]
	dc.l	$000056D4
	dc.b	$00, $00, $57, $14, $00, $00, $57, $14 ;0x0 (0x000055B0-0x000055B8, Entry count: 0x8) [Unknown data]
	dc.l	$000055D4
	dc.b	$00, $00, $55, $D4, $00, $00, $55, $D4 ;0x0 (0x000055BC-0x000055C4, Entry count: 0x8) [Unknown data]
	dc.w	$0485
	dc.w	$0D01
	dc.l	loc_94EE
	dc.l	$00000002
	dc.w	$00CE
	dc.w	$001E
	dc.l	$00005514
	dc.b	$00, $00, $55, $14, $00, $00, $55, $14 ;0x0 (0x000055D8-0x000055E0, Entry count: 0x8) [Unknown data]
	dc.l	$00005594
	dc.b	$00, $00, $55, $94, $00, $00, $55, $94 ;0x0 (0x000055E4-0x000055EC, Entry count: 0x8) [Unknown data]
	dc.l	$000056D4
	dc.b	$00, $00, $57, $94 ;0x0 (0x000055F0-0x000055F4, Entry count: 0x4) [Unknown data]
	dc.l	$00005794
	dc.l	$00005694
	dc.b	$00, $00, $55, $54, $00, $00, $55, $54 ;0x0 (0x000055FC-0x00005604, Entry count: 0x8) [Unknown data]
	dc.w	$0485
	dc.w	$0D01
	dc.l	loc_94EE
	dc.l	$00000003
	dc.w	$00CE
	dc.w	$002E
	dc.l	$00005794
	dc.l	$00005794
	dc.b	$00, $00, $57, $94 ;0x0 (0x0000561C-0x00005620, Entry count: 0x4) [Unknown data]
	dc.l	$00005754, $00005654, $00005754, $00005194 ;0x0 (0x00005620-0x00005630, Entry count: 0x10)
	dc.b	$00, $00, $51, $94 ;0x0 (0x00005630-0x00005634, Entry count: 0x4) [Unknown data]
	dc.l	$00005194
	dc.b	$00, $00, $56, $54 ;0x0 (0x00005638-0x0000563C, Entry count: 0x4) [Unknown data]
	dc.l	$00005654
	dc.l	$00005754
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_94A4
	dc.l	$00000000
	dc.w	$011F
	dc.w	$0037
loc_5654:
	dc.l	$00005714
	dc.b	$00, $00, $57, $14, $00, $00, $56, $D4 ;0x0 (0x00005658-0x00005660, Entry count: 0x8) [Unknown data]
	dc.l	$00005614
	dc.b	$00, $00, $56, $14, $00, $00, $56, $14 ;0x0 (0x00005664-0x0000566C, Entry count: 0x8) [Unknown data]
	dc.l	$00004D94
	dc.l	$00004D94
	dc.b	$00, $00, $4D, $94 ;0x0 (0x00005674-0x00005678, Entry count: 0x4) [Unknown data]
	dc.l	$00005754
	dc.l	$00005614
	dc.b	$00, $00, $57, $54 ;0x0 (0x00005680-0x00005684, Entry count: 0x4) [Unknown data]
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_9294
	dc.l	$00000000
	dc.w	$011F
	dc.w	$0007
	dc.l	$00005254
	dc.b	$00, $00, $52, $54, $00, $00, $52, $54 ;0x0 (0x00005698-0x000056A0, Entry count: 0x8) [Unknown data]
	dc.l	$000055D4
	dc.b	$00, $00, $55, $D4, $00, $00, $55, $D4 ;0x0 (0x000056A4-0x000056AC, Entry count: 0x8) [Unknown data]
	dc.l	$00005794
	dc.b	$00, $00, $57, $94, $00, $00, $57, $94 ;0x0 (0x000056B0-0x000056B8, Entry count: 0x8) [Unknown data]
	dc.l	$00005554
	dc.b	$00, $00, $55, $54, $00, $00, $55, $54 ;0x0 (0x000056BC-0x000056C4, Entry count: 0x8) [Unknown data]
	dc.w	$046F
	dc.w	$0D01
	dc.l	loc_9432
	dc.l	$00000000
	dc.w	$00D0
	dc.w	$0041
loc_56D4:
	dc.l	$000055D4
	dc.b	$00, $00, $55, $D4, $00, $00, $55, $D4 ;0x0 (0x000056D8-0x000056E0, Entry count: 0x8) [Unknown data]
	dc.l	$00005714
	dc.b	$00, $00, $57, $14, $00, $00, $57, $94 ;0x0 (0x000056E4-0x000056EC, Entry count: 0x8) [Unknown data]
	dc.l	$00005754
	dc.b	$00, $00, $4F, $94, $00, $00, $57, $54 ;0x0 (0x000056F0-0x000056F8, Entry count: 0x8) [Unknown data]
	dc.l	$00005794
	dc.b	$00, $00, $57, $94, $00, $00, $57, $94 ;0x0 (0x000056FC-0x00005704, Entry count: 0x8) [Unknown data]
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_93E0
	dc.l	$00000000
	dc.w	$0107
	dc.w	$001F
loc_5714:
	dc.l	$00005554
	dc.b	$00, $00, $55, $54, $00, $00, $55, $54, $00, $00, $57, $94, $00, $00, $57, $94, $00, $00, $57, $94 ;0x0 (0x00005718-0x0000572C, Entry count: 0x14) [Unknown data]
	dc.l	$00005654, $00005654, $00005754, $000056D4, $00005794, $00005794 ;0x0 (0x0000572C-0x00005744, Entry count: 0x18)
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_930C
	dc.l	$00000000
	dc.w	$0107
	dc.w	$0007
loc_5754:
	dc.l	$000056D4
	dc.b	$00, $00, $55, $94 ;0x0 (0x00005758-0x0000575C, Entry count: 0x4) [Unknown data]
	dc.l	$00005594
	dc.l	$00005654
	dc.b	$00, $00, $56, $54, $00, $00, $56, $14 ;0x0 (0x00005764-0x0000576C, Entry count: 0x8) [Unknown data]
	dc.l	$00004F94
	dc.b	$00, $00, $4F, $94 ;0x0 (0x00005770-0x00005774, Entry count: 0x4) [Unknown data]
	dc.l	$00004F94
	dc.l	$00005614
	dc.b	$00, $00, $56, $14 ;0x0 (0x0000577C-0x00005780, Entry count: 0x4) [Unknown data]
	dc.l	$00005614
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_933A
	dc.l	$00000000
	dc.w	$011F
	dc.w	$001F
loc_5794:
	dc.l	$00005694
	dc.l	$00005254
	dc.b	$00, $00, $52, $54 ;0x0 (0x0000579C-0x000057A0, Entry count: 0x4) [Unknown data]
	dc.l	$000056D4, $00005714, $00005714, $00005614, $00005614, $00005614, $00005714, $00005714, $00005714 ;0x0 (0x000057A0-0x000057C4, Entry count: 0x24)
	dc.w	$0466
	dc.w	$0A01
	dc.l	loc_9516
	dc.l	$0000000C
	dc.w	$0107
	dc.w	$0037
	dc.l	$00005954
	dc.b	$00, $00, $59, $54, $00, $00, $59, $54 ;0x0 (0x000057D8-0x000057E0, Entry count: 0x8) [Unknown data]
	dc.l	$000057D4
	dc.b	$00, $00, $57, $D4, $00, $00, $57, $D4 ;0x0 (0x000057E4-0x000057EC, Entry count: 0x8) [Unknown data]
	dc.l	$00005914
	dc.b	$00, $00, $59, $14, $00, $00, $59, $14 ;0x0 (0x000057F0-0x000057F8, Entry count: 0x8) [Unknown data]
	dc.l	$000057D4
	dc.b	$00, $00, $57, $D4, $00, $00, $57, $D4 ;0x0 (0x000057FC-0x00005804, Entry count: 0x8) [Unknown data]
	dc.w	$0466
	dc.w	$0A00
	dc.l	loc_946C
	dc.l	$00000000
	dc.w	$0087
	dc.w	$001F
	dc.l	$00005914
	dc.b	$00, $00, $59, $14, $00, $00, $59, $14, $00, $00, $58, $14, $00, $00, $58, $14, $00, $00, $58, $14 ;0x0 (0x00005818-0x0000582C, Entry count: 0x14) [Unknown data]
	dc.l	$00005854
	dc.b	$00, $00, $58, $54, $00, $00, $58, $54, $00, $00, $58, $14, $00, $00, $58, $14, $00, $00, $58, $14 ;0x0 (0x00005830-0x00005844, Entry count: 0x14) [Unknown data]
	dc.w	$0466
	dc.w	$0A00
	dc.l	loc_921C
	dc.l	$00000002
	dc.w	$00B7
	dc.w	$001F
	dc.l	$00005814
	dc.b	$00, $00, $58, $14, $00, $00, $58, $14, $00, $00, $58, $54, $00, $00, $58, $54, $00, $00, $58, $54 ;0x0 (0x00005858-0x0000586C, Entry count: 0x14) [Unknown data]
	dc.l	$00005894
	dc.b	$00, $00, $58, $94, $00, $00, $58, $94, $00, $00, $58, $54, $00, $00, $58, $54, $00, $00, $58, $54 ;0x0 (0x00005870-0x00005884, Entry count: 0x14) [Unknown data]
	dc.w	$0466
	dc.w	$0A00
	dc.l	loc_921C
	dc.l	$00000003
	dc.w	$00CF
	dc.w	$001F
	dc.l	$00005854
	dc.b	$00, $00, $58, $54, $00, $00, $58, $54, $00, $00, $58, $94, $00, $00, $58, $94, $00, $00, $58, $94 ;0x0 (0x00005898-0x000058AC, Entry count: 0x14) [Unknown data]
	dc.l	$000058D4
	dc.b	$00, $00, $58, $D4, $00, $00, $58, $D4, $00, $00, $58, $94, $00, $00, $58, $94, $00, $00, $58, $94 ;0x0 (0x000058B0-0x000058C4, Entry count: 0x14) [Unknown data]
	dc.w	$0466
	dc.w	$0A00
	dc.l	loc_921C
	dc.l	$00000004
	dc.w	$00E7
	dc.w	$001F
	dc.l	$00005894
	dc.b	$00, $00, $58, $94, $00, $00, $58, $94, $00, $00, $58, $D4, $00, $00, $58, $D4, $00, $00, $58, $D4 ;0x0 (0x000058D8-0x000058EC, Entry count: 0x14) [Unknown data]
	dc.l	$00005954
	dc.b	$00, $00, $59, $54, $00, $00, $59, $54, $00, $00, $58, $D4, $00, $00, $58, $D4, $00, $00, $58, $D4 ;0x0 (0x000058F0-0x00005904, Entry count: 0x14) [Unknown data]
	dc.w	$0466
	dc.w	$0A00
	dc.l	loc_921C
	dc.l	$00000005
	dc.w	$00FF
	dc.w	$001F
	dc.l	$000057D4
	dc.b	$00, $00, $57, $D4, $00, $00, $57, $D4 ;0x0 (0x00005918-0x00005920, Entry count: 0x8) [Unknown data]
	dc.l	$00005914
	dc.b	$00, $00, $59, $14, $00, $00, $59, $14 ;0x0 (0x00005924-0x0000592C, Entry count: 0x8) [Unknown data]
	dc.l	$00005814
	dc.b	$00, $00, $58, $14, $00, $00, $58, $14, $00, $00, $59, $14, $00, $00, $59, $14, $00, $00, $59, $14 ;0x0 (0x00005930-0x00005944, Entry count: 0x14) [Unknown data]
	dc.w	$0466
	dc.w	$0A00
	dc.l	loc_921C
	dc.l	$00000001
	dc.w	$009F
	dc.w	$001F
	dc.l	$000058D4
	dc.b	$00, $00, $58, $D4, $00, $00, $58, $D4 ;0x0 (0x00005958-0x00005960, Entry count: 0x8) [Unknown data]
	dc.l	$00005954
	dc.b	$00, $00, $59, $54, $00, $00, $59, $54 ;0x0 (0x00005964-0x0000596C, Entry count: 0x8) [Unknown data]
	dc.l	$000057D4
	dc.b	$00, $00, $57, $D4, $00, $00, $57, $D4, $00, $00, $59, $54, $00, $00, $59, $54, $00, $00, $59, $54 ;0x0 (0x00005970-0x00005984, Entry count: 0x14) [Unknown data]
	dc.w	$0466
	dc.w	$0A00
	dc.l	loc_921C
	dc.l	$00000006
	dc.w	$0117
	dc.w	$001F
	dc.b	$00, $00, $4D, $94, $00, $00, $4D, $D4, $00, $00, $4E, $14, $00, $00, $4E, $54
	dc.b	$00, $00, $4E, $94, $00, $00, $4E, $D4, $00, $00, $4F, $14, $00, $00, $4F, $54 ;0x0 (0x00005994-0x00005A70, Entry count: 0xDC) [Unknown data]
	dc.b	$00, $00, $4F, $94, $00, $00, $4F, $D4, $00, $00, $50, $14, $00, $00, $50, $54
	dc.b	$00, $00, $50, $94, $00, $00, $50, $D4, $00, $00, $51, $14, $00, $00, $51, $54 ;0x20
	dc.b	$00, $00, $51, $94, $00, $00, $51, $D4, $00, $00, $52, $14, $00, $00, $52, $54
	dc.b	$00, $00, $52, $94, $00, $00, $52, $D4, $00, $00, $53, $14, $00, $00, $53, $94 ;0x40
	dc.b	$00, $00, $53, $D4, $00, $00, $54, $14, $00, $00, $54, $54, $00, $00, $54, $94
	dc.b	$00, $00, $54, $D4, $00, $00, $55, $14, $00, $00, $55, $54, $00, $00, $55, $94 ;0x60
	dc.b	$00, $00, $55, $D4, $00, $00, $56, $14, $00, $00, $57, $14, $00, $00, $57, $94
	dc.b	$00, $00, $00, $00, $00, $00, $57, $D4, $00, $00, $58, $14, $00, $00, $58, $54 ;0x80
	dc.b	$00, $00, $59, $14, $00, $00, $58, $94, $00, $00, $58, $D4, $00, $00, $59, $54
	dc.b	$00, $00, $00, $00, $00, $00, $56, $D4, $00, $00, $57, $54, $00, $00, $56, $54 ;0xA0
	dc.b	$00, $00, $56, $94, $00, $00, $00, $00, $00, $00, $57, $54, $00, $00, $00, $00
	dc.b	$00, $00, $56, $54, $00, $00, $00, $00, $00, $00, $00, $00 ;0xC0

loc_5A70:
	dc.w	$000A
	dc.w	$0080
	dc.l	loc_6B54
	dc.l	loc_5B54
	dc.l	loc_96FC
	dc.l	loc_971E
	dc.l	$00009C58
	dc.b	$00, $00, $59, $94, $00, $00, $5A, $48 ;0x0 (0x00005A88-0x00005A90, Entry count: 0x8) [Unknown data]
	dc.l	$51A00002
	dc.w	$048D
	
loc_5A96:
	dc.w	$000A
	dc.w	$0080
	dc.l	loc_7194
	dc.l	loc_5B54
	dc.l	loc_96FC
	dc.l	loc_971E
	dc.l	$00009C58
	dc.b	$00, $00, $59, $94, $00, $00, $5A, $64 ;0x0 (0x00005AAE-0x00005AB6, Entry count: 0x8) [Unknown data]
	dc.l	$51A00002
	dc.w	$048D
	
loc_5ABC:
	dc.w	$000A
	dc.w	$0080
	dc.l	loc_6E74
	dc.l	loc_5B54
	dc.l	loc_96FC
	dc.l	loc_971E
	dc.l	$00009C58
	dc.b	$00, $00, $59, $94, $00, $00, $5A, $5C ;0x0 (0x00005AD4-0x00005ADC, Entry count: 0x8) [Unknown data]
	dc.l	$51A00002
	dc.w	$048D
	dc.w	$000B
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x0 (0x00005AE4-0x00005B08, Entry count: 0x24) [Unknown data]
	dc.b	$00, $00, $00, $00 ;0x20
	dc.w	$0008
	dc.w	$0039
	dc.l	loc_7BB4
	dc.l	loc_74B4
	dc.l	loc_96FC
	dc.l	loc_971E
	dc.l	$00009C58
	dc.b	$00, $00, $5A, $28, $00, $00, $5A, $6C ;0x0 (0x00005B20-0x00005B28, Entry count: 0x8) [Unknown data]
	dc.l	$51A00002
	dc.w	$048D
	dc.w	$000E
	dc.w	$0039
	dc.l	loc_8554
	dc.l	loc_7E34
	dc.l	loc_96FC
	dc.l	loc_111E
	dc.l	$00009C58
	dc.b	$00, $00, $5A, $6C, $00, $00, $5A, $6C ;0x0 (0x00005B46-0x00005B4E, Entry count: 0x8) [Unknown data]
	dc.l	$40000003
	dc.w	$0600
loc_5B54:
	dc.w	$0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
	dc.w	$BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB ;0x0 (0x00005B54-0x00006B54, Entry count: 0x1000)
	dc.w	$2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222
	dc.w	$6666, $6666, $6666, $6666, $6666, $6666, $6666, $6666, $6666, $6666, $6666, $6666, $6666, $6666, $6666, $6666 ;0x20
	dc.w	$1111, $1111, $FF11, $F1F1, $F1F1, $F1F1, $FF11, $FF11, $F1F1, $F1F1, $FF11, $F1F1, $1111, $1111, $0000, $0000
	dc.w	$1111, $1110, $1FF1, $FF11, $F111, $F1F1, $F1F1, $F1F1, $F1F1, $F1F1, $1FF1, $FF11, $1111, $1110, $0000, $0000 ;0x40
	dc.w	$6666, $6666, $6666, $6666, $6666, $6666, $6666, $6666, $6444, $4444, $4555, $5F55, $5555, $FF55, $555F, $EFFF
	dc.w	$6666, $6666, $6666, $6666, $6666, $6666, $6666, $6666, $4444, $4466, $5555, $5546, $5555, $5556, $FFFF, $F556 ;0x60
	dc.w	$6666, $6666, $6666, $6666, $6666, $6666, $6666, $6666, $6644, $4444, $6455, $5555, $6555, $5555, $655F, $FFFF
	dc.w	$6666, $6666, $6666, $6666, $6666, $6666, $6666, $6666, $4444, $4446, $55F5, $5554, $55FF, $5555, $FFFE, $F555 ;0x80
	dc.w	$2222, $2222, $2222, $2222, $2222, $2222, $1112, $2222, $1112, $2222, $1112, $2222, $1112, $2222, $1112, $2222
	dc.w	$9999, $9999, $9999, $9999, $9999, $9999, $9999, $9999, $9999, $9999, $9999, $9999, $9999, $9999, $9999, $9999 ;0xA0
	dc.w	$AAAA, $AAAA, $AAAA, $AAAA, $AAAA, $AAAA, $AAAA, $AAAA, $AAAA, $AAAA, $AAAA, $AAAA, $AAAA, $AAAA, $AAAA, $AAAA
	dc.w	$AAAA, $AAAA, $AFFF, $FFFA, $AFFA, $AAAA, $AFFF, $FFAA, $AEEA, $AAAA, $AEEA, $AAAA, $AAAA, $AAAA, $AAAA, $AAAA ;0xC0
	dc.w	$CCCC, $CCEF, $CCCC, $CDFF, $CCBB, $BEFF, $CCBB, $BEFF, $CCBB, $BDEF, $CCBB, $BBEE, $CCBB, $BBDE, $CCBB, $BBBE
	dc.w	$FECC, $CCCC, $FFDC, $CCCA, $FFEA, $BBAA, $FEEA, $BBAA, $EEDA, $BBAA, $EEAA, $BBAA, $EDAB, $BBAA, $DAAB, $BBAA ;0xE0
	dc.w	$BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $AAAB, $BBBB, $AAAB, $BBBB, $AAAB, $BBBB, $AAAB, $BBBB, $AAAB, $BBBB
	dc.w	$6654, $2333, $6654, $1111, $DEDC, $1121, $DEDC, $111D, $AA98, $111D, $AA98, $111C, $AA98, $1121, $AA98, $1121 ;0x100
	dc.w	$3333, $3331, $1111, $1131, $DEED, $1131, $EEEE, $D131, $EEEE, $D131, $EEED, $C131, $DEDD, $1131, $CDDC, $1131
	dc.w	$1112, $2222, $1112, $2222, $1112, $2222, $1112, $2222, $1112, $2222, $1112, $2222, $1112, $2222, $1112, $2222 ;0x120
	dc.w	$3333, $3333, $3333, $3333, $3333, $3333, $3333, $3333, $3333, $3333, $3333, $3333, $3333, $3333, $3333, $3333
	dc.w	$55FE, $EEEE, $5FEE, $EEEE, $54DE, $EEEE, $554D, $EDDD, $5554, $DD44, $5555, $4D55, $6555, $5455, $6666, $6666 ;0x140
	dc.w	$EEEE, $F556, $EEEE, $F556, $EEEE, $D556, $DDDD, $D556, $4444, $4556, $5555, $5556, $5555, $5566, $6666, $6666
	dc.w	$655F, $EEEE, $655F, $EEEE, $655D, $EEEE, $655D, $DDDD, $6554, $4444, $6555, $5555, $6655, $5555, $6666, $6666 ;0x160
	dc.w	$EEEE, $EF55, $EEEE, $EEF5, $EEEE, $ED45, $DDDE, $D455, $44DD, $4555, $55D4, $5555, $5545, $5556, $6666, $6666
	dc.w	$1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1E11, $1111, $1EE1, $1111, $1ECE, $1111, $1ECC ;0x180
	dc.w	$1111, $1E11, $1111, $ECD1, $111E, $CCCD, $11EC, $CCD1, $1ECC, $CD11, $ECCC, $D111, $CCCD, $1111, $CCD1, $1111
	dc.w	$1111, $1111, $1111, $1111, $1111, $1111, $7111, $5555, $C555, $5111, $EEE1, $1111, $11EE, $EE11, $1111, $1EEE ;0x1A0
	dc.w	$1111, $1711, $1111, $1C11, $1555, $5111, $5511, $3111, $1113, $3111, $1113, $1111, $1133, $1111, $E131, $1111
	dc.w	$1111, $1111, $1188, $8888, $1881, $1118, $8811, $1111, $8111, $1111, $8111, $111E, $8811, $1EEE, $1881, $EE18 ;0x1C0
	dc.w	$1111, $1111, $1111, $1111, $8111, $1111, $8811, $1111, $1811, $1111, $EEEE, $1111, $881E, $EE11, $8111, $1EE1
	dc.w	$1111, $1111, $8888, $8888, $8811, $1118, $8811, $1118, $8811, $EEEE, $8855, $EE55, $8855, $EE88, $1155, $EE11 ;0x1E0
	dc.w	$1111, $1111, $8111, $1111, $8111, $1111, $8111, $1111, $EEEE, $E111, $555E, $E555, $811E, $E155, $111E, $E155
	dc.w	$9999, $9999, $9999, $9999, $9999, $9999, $7777, $7777, $9888, $8888, $9999, $9999, $9999, $9999, $9999, $9999 ;0x200
	dc.w	$9999, $9999, $9999, $9999, $9999, $9999, $7777, $7777, $8888, $8888, $9999, $9999, $9999, $9999, $9999, $9999
	dc.w	$9999, $9999, $9999, $9999, $9999, $9999, $7777, $7779, $8888, $8888, $9999, $9999, $9999, $9999, $9999, $9999 ;0x220
	dc.w	$AB66, $54CA, $BB65, $44CC, $BB65, $44CC, $BB65, $44CC, $BB65, $44CC, $BB65, $44CC, $BB65, $44CC, $BB44, $44CC
	dc.w	$CCBB, $BBBE, $CCBB, $BEFE, $CCBF, $FFEE, $CFEE, $EEEE, $CED4, $4444, $C445, $5555, $C455, $4444, $CAA5, $5555 ;0x240
	dc.w	$DABB, $BBAA, $EDDB, $BBAA, $DDDD, $DBAA, $EEEE, $DDDA, $4444, $4DDA, $5555, $544A, $4444, $554A, $5555, $5AAA
	dc.w	$AAAB, $BBBB, $AAAB, $BBBB, $AAAB, $BBBB, $AAAB, $BBBB, $AAAB, $BBBB, $AAAB, $BBBB, $AAAB, $BBBB, $AAAB, $BBBB ;0x260
	dc.w	$AA98, $1122, $AA98, $1111, $8777, $11EE, $8777, $EEEE, $2CB2, $E444, $2CB2, $4555, $3223, $5544, $1111, $1555
	dc.w	$1DD1, $1231, $1EE1, $1131, $DDDD, $DD11, $EEEE, $DDDD, $4444, $444D, $5555, $5554, $4444, $4455, $5555, $5551 ;0x280
	dc.w	$4444, $4444, $4444, $4444, $5555, $5555, $5555, $5555, $5555, $5555, $5555, $5555, $5555, $5555, $5555, $5555
	dc.w	$4444, $4455, $4455, $5555, $5445, $5555, $5544, $5555, $5554, $4555, $5555, $4455, $5555, $5445, $5555, $5544 ;0x2A0
	dc.w	$5544, $4444, $5555, $5544, $5555, $5445, $5555, $4455, $5554, $4555, $5544, $5555, $5445, $5555, $4455, $5555
	dc.w	$1111, $1ECC, $1111, $1ECC, $1111, $1DDD, $1111, $1111, $1111, $1111, $1111, $1111, $ED11, $1111, $DD11, $1111 ;0x2C0
	dc.w	$CD11, $1111, $CCD1, $1111, $DDDD, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111
	dc.w	$1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1113, $1111, $1173, $1111, $11C3, $1111, $11C1 ;0x2E0
	dc.w	$EEEE, $1117, $131E, $EEEC, $3311, $11EC, $3111, $1111, $3111, $1111, $1111, $1111, $1111, $1111, $1111, $1111
	dc.w	$1155, $E558, $155E, $E155, $551E, $1115, $511E, $E111, $5511, $E115, $1551, $EE55, $1155, $5EEE, $1111, $111E ;0x300
	dc.w	$1111, $11E1, $1111, $11EE, $5111, $111E, $5111, $11EE, $5111, $11E1, $1111, $1EE1, $111E, $EE11, $EEEE, $1111
	dc.w	$1155, $EE11, $1155, $EE11, $1155, $EE11, $1155, $EE11, $1155, $EE55, $1111, $EE11, $1111, $EE11, $1111, $EEEE ;0x320
	dc.w	$111E, $E155, $111E, $E155, $111E, $E155, $111E, $E155, $555E, $E555, $111E, $E111, $111E, $E111, $EEEE, $E111
	dc.w	$BBBA, $AAAA, $BBBA, $AAAA, $BBBA, $AAAA, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB ;0x340
	dc.w	$AAAA, $AAAA, $AAAA, $AAAA, $AAAA, $AAAA, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB
	dc.w	$AAAB, $BBBB, $AAAB, $BBBB, $AAAB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB, $BBBB ;0x360
	dc.w	$5555, $5555, $5555, $5555, $5555, $5555, $5555, $5555, $5555, $5555, $5555, $5555, $5555, $5555, $5555, $5555
	dc.w	$1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111 ;0x380
	dc.w	$2221, $1111, $2221, $1111, $2221, $1111, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222
	dc.w	$1111, $1111, $1111, $1111, $1111, $1111, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222 ;0x3A0
	dc.w	$1112, $2222, $1112, $2222, $1112, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222, $2222
	dc.w	$9999, $9999, $9777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $9777, $7777, $9988, $8888, $9999, $9999 ;0x3C0
	dc.w	$9999, $9999, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $8888, $8888, $9999, $9999
	dc.w	$9999, $9999, $7777, $7799, $7777, $7779, $7777, $7778, $7777, $7778, $7777, $7788, $8888, $8889, $9999, $9999 ;0x3E0
	dc.w	$CCCC, $CCCC, $CCCC, $CCCC, $CCBB, $BBBB, $CCBB, $BBBF, $CCBB, $BFFE, $CCBB, $65ED, $CCBB, $6AAE, $CCB6, $5ABE
	dc.w	$CC44, $44CC, $C446, $6BBA, $B456, $6AAA, $FF55, $5AAA, $FF5E, $AAAA, $FEEE, $A6AA, $EEE5, $66AA, $EEAA, $AAAA ;0x400
	dc.w	$6654, $2333, $6654, $1111, $DEDC, $2222, $DEDC, $2222, $AA98, $2222, $AA98, $2221, $AA98, $2216, $AA98, $2165
	dc.w	$3333, $3331, $1111, $1121, $2214, $4441, $2214, $6621, $1114, $6621, $EEEE, $6D21, $5EDD, $DD26, $1DDD, $D665 ;0x420
	dc.w	$4444, $4444, $4444, $4444, $4444, $4444, $4444, $4444, $4444, $4444, $4444, $4444, $4444, $4444, $4444, $4444
	dc.w	$7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777 ;0x440
	dc.w	$1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $111A, $1111, $11A9
	dc.w	$1111, $1660, $1111, $D654, $111D, $ED44, $11AE, $DDC1, $1A99, $DC11, $A998, $8111, $9988, $1111, $9881, $1111 ;0x460
	dc.w	$1111, $1111, $1111, $1111, $1111, $1111, $1111, $1115, $1111, $1155, $1111, $1555, $1111, $5555, $1115, $5555
	dc.w	$1111, $1111, $1551, $1111, $5555, $5111, $5555, $5551, $5555, $5555, $5555, $5554, $5555, $5544, $5555, $5441 ;0x480
	dc.w	$1111, $111C, $1111, $11C1, $1111, $1C11, $1111, $1C1E, $1111, $1CEB, $1111, $1EBB, $1111, $ECCB, $1111, $ECCC
	dc.w	$CC11, $1111, $11C1, $1111, $1E1C, $1111, $EBEC, $1111, $BBBC, $C111, $BBBC, $DC11, $BBDC, $DDC1, $BBEB, $EDDC ;0x4A0
	dc.w	$1311, $3111, $1131, $1113, $3111, $1311, $1111, $1111, $1311, $111C, $1111, $11CC, $1111, $11CD, $1111, $11CC
	dc.w	$CCC1, $1111, $1BC1, $1111, $1CC1, $1111, $CDCC, $1111, $DEDC, $C111, $CCCC, $CC11, $EEDD, $CC11, $CCCC, $CC11 ;0x4C0
	dc.w	$CCBA, $AAB3, $CCBB, $BB23, $CCBB, $BB22, $CCBB, $B332, $CCBB, $332A, $CCB3, $32AA, $CCD3, $2AAA, $CADD, $AAAA
	dc.w	$3333, $BBAA, $3333, $3BAA, $2233, $2AAA, $A332, $AAAA, $D32A, $ABAA, $DDAA, $BBAA, $ADAA, $AAAA, $AAAA, $AAAA ;0x4E0
	dc.w	$AA98, $2161, $AA98, $1651, $8777, $2111, $8777, $2213, $2CB2, $2132, $2CB2, $1321, $3222, $EE23, $1111, $1E11
	dc.w	$2EDD, $1121, $1333, $3321, $3222, $3221, $2113, $2131, $1EE2, $1231, $21E1, $2231, $3323, $3331, $1111, $1111 ;0x500
	dc.w	$8888, $8888, $8888, $8888, $8888, $8888, $8888, $8888, $8888, $8888, $8888, $8888, $8888, $8888, $8888, $8888
	dc.w	$1111, $1A99, $1111, $A998, $111A, $9988, $11A9, $9881, $1889, $8811, $1877, $8111, $CB77, $1111, $BB11, $1111 ;0x520
	dc.w	$8811, $1111, $8111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111, $1111
	dc.w	$1155, $5555, $1655, $5555, $6665, $5555, $6666, $6555, $6666, $6665, $1666, $6666, $1166, $6664, $1111, $6664 ;0x540
	dc.w	$5555, $4441, $5554, $4411, $5544, $4111, $5444, $1111, $4441, $1111, $4411, $1111, $4111, $1111, $1111, $1111
	dc.w	$1119, $AAA9, $11AA, $AA98, $19AA, $A98C, $1AA9, $A98C, $9A99, $988C, $AA98, $8811, $A981, $1111, $A811, $1111 ;0x560
	dc.w	$8DEC, $CEDD, $CEDB, $BDED, $CDED, $EEDE, $CDDE, $DEE1, $CCDD, $EDE1, $CDCD, $DE11, $1CDC, $D111, $1111, $1111
	dc.w	$1111, $11CD, $1111, $11CD, $1111, $11CD, $1111, $11CD, $1111, $11CD, $1111, $11CD, $1111, $11CD, $1111, $11CC ;0x580
	dc.w	$EEDD, $CC11, $EEDD, $CC11, $EEDD, $CC11, $EEDD, $CC11, $EEDD, $CC11, $EEDD, $CC11, $EEDD, $CC11, $CCCC, $CC11
	dc.w	$9777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $9777, $7777, $9988, $8888 ;0x5A0
	dc.w	$7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $7777, $8888, $8888
	dc.w	$7777, $7799, $7777, $7779, $7777, $7778, $7777, $7778, $7777, $7778, $7777, $7778, $7777, $7788, $8888, $8889 ;0x5C0
	dc.w	$CCCC, $CCCC, $CCCC, $CCCC, $CCCC, $CCCC, $CCCC, $CCCC, $CCCC, $CCCC, $CCCC, $CCCC, $CCCC, $CCCC, $CCCC, $CCCC
	dc.w	$DDDD, $DDDD, $DDDD, $DDDD, $DDDD, $DDDD, $DDDD, $DDDD, $DDDD, $DDDD, $DDDD, $DDDD, $DDDD, $DDDD, $DDDD, $DDDD ;0x5E0
	dc.w	$EEEE, $EEEE, $EEEE, $EEEE, $EEEE, $EEEE, $EEEE, $EEEE, $EEEE, $EEEE, $EEEE, $EEEE, $EEEE, $EEEE, $EEEE, $EEEE
	dc.w	$FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF ;0x600
	dc.w	$AAAA, $AAAA, $AAFF, $FFFA, $AFFA, $AAAA, $AAFF, $FFAA, $AAAA, $AEEA, $AEEE, $EEAA, $AAAA, $AAAA, $AAAA, $AAAA
	dc.w	$CCCC, $CCCC, $CCCC, $CCCC, $CCBB, $BBBB, $CCBF, $FFFF, $CCBF, $FAAF, $CCBF, $AABF, $CCBB, $ABBF, $CCBB, $BBBF ;0x620
	dc.w	$CCCC, $CCCC, $CCCC, $CCCA, $BBBB, $BBAA, $FFFF, $FBAA, $FAAF, $FAAA, $FABB, $FAAA, $FABB, $BAAA, $FABB, $BBAA
	dc.w	$CCCC, $CECC, $CCCC, $CCEC, $CCBB, $BBBE, $EEEE, $EEEE, $EDDD, $DDDD, $ED22, $2222, $1111, $1111, $1F11, $F1FF ;0x640
	dc.w	$CCEC, $CCCC, $CECB, $CCCA, $DBAB, $BBAA, $EEEE, $EEEE, $DDDD, $DDED, $2222, $22ED, $1111, $2111, $F1F1, $21F1
	dc.w	$FFAF, $FFFF, $AAAA, $AFFF, $FAAA, $FFFF, $FAFA, $FFFF, $FFFF, $FAFA, $FFFF, $FAAA, $AFFF, $AAAA, $FFFF, $FFAF ;0x660
	dc.w	$CCCC, $CCCC, $C222, $C222, $C222, $C222, $C222, $C222, $CCCC, $CCCC, $C222, $C222, $C222, $C222, $C222, $C222
	dc.w	$D777, $7777, $D777, $7777, $D777, $7777, $DDDD, $DDDD, $7777, $D777, $7777, $D777, $7777, $D777, $DDDD, $DDDD ;0x680
	dc.w	$9999, $CCCC, $9999, $CCCC, $9999, $CCCC, $9999, $CCCC, $CCCC, $9999, $CCCC, $9999, $CCCC, $9999, $CCCC, $9999
	dc.w	$1111, $1111, $1111, $1111, $1166, $6666, $2665, $5555, $66FF, $55FF, $65FF, $45FF, $65FF, $45FF, $65FF, $45FF ;0x6A0
	dc.w	$1111, $1111, $1111, $1111, $6666, $6666, $5555, $5555, $5FF5, $55FF, $4FFF, $55FF, $4FFF, $F5FF, $4FF4, $FFFF
	dc.w	$1111, $1111, $1111, $1111, $6666, $6666, $5555, $5555, $5FFF, $FF55, $4FF4, $FFF5, $4FF4, $5FF4, $4FF4, $5FF4 ;0x6C0
	dc.w	$1111, $1111, $1111, $1111, $6666, $6611, $5555, $5662, $5FFF, $F566, $FF44, $FF54, $FF45, $FF44, $FF45, $FF44
	dc.w	$1111, $1111, $1111, $1111, $1111, $1111, $2222, $2222, $2222, $2222, $1222, $2222, $1122, $2222, $1112, $2222 ;0x6E0
	dc.w	$CCBB, $BBBF, $CCBB, $BBBE, $CCBB, $BBBE, $CCBB, $BBBE, $CCBB, $BBEE, $CCBB, $BBBA, $CCAA, $AAAA, $CAAA, $AAAA
	dc.w	$FABB, $BBAA, $EABB, $BBAA, $EABB, $BBAA, $EABB, $BBAA, $EEBB, $BBAA, $AAAB, $BBAA, $AAAA, $AAAA, $AAAA, $AAAA ;0x700
	dc.w	$1FF1, $F1F1, $1FFF, $F1FF, $1E1E, $E1E1, $1E11, $E1EE, $1111, $1111, $ED22, $2222, $EEEE, $EEEE, $EDDD, $DDDD
	dc.w	$11F1, $11F1, $11F1, $F1F1, $11EE, $EEE1, $E11E, $1E11, $1111, $111D, $2222, $22ED, $EEEE, $EEED, $DDDD, $DDDD ;0x720
	dc.w	$65EE, $45EE, $65EE, $45EE, $655E, $EEE4, $4455, $4444, $1445, $5555, $1144, $4444, $1111, $1111, $1111, $1111
	dc.w	$4EE4, $5EEE, $4EE4, $55EE, $4EE4, $55EE, $5544, $5554, $5555, $5555, $4444, $4444, $1111, $1111, $1111, $1111 ;0x740
	dc.w	$4EE4, $5EE4, $4EE4, $EEE4, $4EEE, $EE44, $4544, $4445, $5555, $5555, $4444, $4444, $1111, $1111, $1111, $1111
	dc.w	$EE45, $EE44, $EE45, $EE44, $5EEE, $E444, $5544, $4444, $5555, $5441, $4444, $4411, $1111, $1111, $1111, $1111 ;0x760
	dc.w	$3333, $4444, $3114, $5555, $3145, $5555, $3455, $5555, $4555, $5555, $FFF5, $FFF5, $F444, $5F44, $FFF5, $5F45
	dc.w	$4444, $3331, $5555, $4131, $5555, $5431, $5555, $5541, $5555, $5554, $FFFF, $5FFF, $F44F, $4F4F, $F45F, $4FFF ;0x780
	dc.w	$64F4, $5E45, $EEF4, $5E45, $6444, $5545, $3655, $5555, $3165, $5555, $3116, $5555, $3333, $6666, $1111, $1111
	dc.w	$E45E, $4E45, $EEEE, $4E46, $5444, $4546, $5555, $5561, $5555, $5621, $5555, $6131, $6666, $2331, $1111, $1111 ;0x7A0
	dc.w	$CCCC, $CECC, $CCCC, $CCEC, $CCBB, $BBBE, $EEEE, $EEEE, $EDDD, $DDDD, $ED22, $2222, $1111, $1111, $FF1F, $11FF
	dc.w	$CCEC, $CCCC, $CECB, $CCCA, $DBAB, $BBAA, $EEEE, $EEEE, $DDDD, $DDED, $2222, $22ED, $1111, $1111, $1FFF, $1FFF ;0x7C0
	dc.w	$F11F, $11F1, $F11F, $11FF, $E11E, $11E1, $EE1E, $E1EE, $1111, $1111, $ED22, $2222, $EEEE, $EEEE, $EDDD, $DDDD
	dc.w	$1F1F, $1F1F, $1FFF, $1FF1, $1E1E, $1E1E, $1E1E, $1E1E, $1111, $1111, $2222, $22ED, $EEEE, $EEED, $DDDD, $DDDD ;0x7E0
loc_6B54:
	dc.b	$60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14
	dc.b	$60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14 ;0x0 (0x00006B54-0x00006E74, Entry count: 0x320) [Unknown data]
	dc.b	$60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14
	dc.b	$60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14 ;0x20
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $14
	dc.b	$60, $02, $60, $03, $60, $04, $60, $05, $60, $03, $60, $03, $60, $06, $60, $07 ;0x40
	dc.b	$60, $08, $60, $09, $60, $03, $60, $0A, $60, $02, $60, $02, $60, $02, $60, $02
	dc.b	$60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02 ;0x60
	dc.b	$60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0C, $60, $0D, $60, $0C
	dc.b	$60, $01, $60, $0E, $60, $0F, $60, $10, $20, $11, $20, $12, $60, $10, $60, $13 ;0x80
	dc.b	$60, $02, $60, $03, $00, $00, $00, $00, $60, $03, $60, $03, $60, $15, $60, $16
	dc.b	$60, $17, $60, $18, $60, $03, $60, $13, $20, $19, $20, $1A, $60, $0A, $20, $1B ;0xA0
	dc.b	$20, $1C, $60, $0A, $20, $1D, $20, $1E, $60, $0A, $20, $1F, $20, $20, $60, $0A
	dc.b	$60, $0B, $60, $0B, $60, $21, $60, $22, $60, $23, $60, $0C, $60, $24, $60, $0C ;0xC0
	dc.b	$60, $01, $60, $25, $60, $26, $60, $27, $20, $28, $20, $29, $60, $27, $60, $13
	dc.b	$60, $02, $60, $2A, $60, $2B, $60, $2C, $60, $2A, $60, $2A, $60, $2A, $60, $2A ;0xE0
	dc.b	$60, $2A, $60, $2A, $60, $2A, $60, $13, $20, $2D, $20, $2E, $60, $13, $20, $2F
	dc.b	$20, $30, $60, $13, $20, $31, $20, $32, $60, $13, $20, $33, $20, $34, $60, $13 ;0x100
	dc.b	$60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0C, $60, $24, $60, $0C
	dc.b	$60, $01, $60, $35, $60, $36, $60, $37, $60, $35, $60, $36, $60, $37, $60, $13 ;0x120
	dc.b	$60, $02, $60, $38, $00, $00, $00, $00, $00, $39, $00, $39, $00, $02, $00, $02
	dc.b	$00, $14, $00, $14, $60, $38, $60, $13, $60, $3A, $60, $3B, $60, $3C, $60, $3A ;0x140
	dc.b	$60, $3B, $60, $3C, $60, $3A, $60, $3B, $60, $3C, $60, $3A, $60, $3B, $60, $3C
	dc.b	$60, $0B, $60, $0B, $60, $3D, $60, $3E, $60, $3F, $60, $0C, $60, $24, $60, $0C ;0x160
	dc.b	$60, $01, $60, $40, $60, $41, $60, $10, $20, $42, $20, $43, $60, $10, $60, $13
	dc.b	$60, $02, $60, $38, $00, $44, $00, $44, $00, $38, $00, $38, $00, $03, $00, $03 ;0x180
	dc.b	$00, $45, $00, $45, $60, $38, $60, $13, $20, $46, $20, $47, $60, $0A, $20, $48
	dc.b	$20, $49, $60, $0A, $20, $4A, $20, $4B, $60, $0A, $20, $4C, $20, $4D, $60, $0A ;0x1A0
	dc.b	$60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0C, $60, $24, $60, $0C
	dc.b	$60, $01, $60, $4E, $60, $4F, $60, $27, $20, $50, $20, $51, $60, $27, $60, $13 ;0x1C0
	dc.b	$60, $02, $60, $38, $00, $52, $00, $52, $00, $0B, $00, $0B, $00, $0C, $00, $0C
	dc.b	$00, $01, $00, $01, $60, $38, $60, $13, $20, $53, $20, $54, $60, $13, $20, $55 ;0x1E0
	dc.b	$20, $56, $60, $13, $20, $57, $20, $58, $60, $13, $20, $59, $20, $5A, $60, $13
	dc.b	$60, $0B, $60, $0B, $60, $5B, $60, $5C, $60, $5D, $60, $0C, $60, $24, $60, $0C ;0x200
	dc.b	$60, $01, $60, $35, $60, $36, $60, $37, $60, $35, $60, $36, $60, $37, $60, $13
	dc.b	$60, $02, $60, $38, $00, $5E, $00, $5E, $00, $5F, $00, $5F, $00, $60, $00, $60 ;0x220
	dc.b	$00, $61, $00, $61, $60, $38, $60, $13, $60, $3A, $60, $3B, $60, $3C, $60, $3A
	dc.b	$60, $3B, $60, $3C, $60, $3A, $60, $3B, $60, $3C, $60, $3A, $60, $3B, $60, $3C ;0x240
	dc.b	$60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0C, $60, $62, $60, $0C
	dc.b	$60, $01, $60, $63, $60, $64, $60, $10, $60, $65, $60, $66, $60, $10, $60, $13 ;0x260
	dc.b	$60, $02, $60, $38, $00, $67, $00, $67, $00, $68, $00, $68, $00, $69, $00, $69
	dc.b	$00, $6A, $00, $6A, $60, $38, $60, $13, $60, $02, $60, $02, $60, $02, $60, $02 ;0x280
	dc.b	$60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02
	dc.b	$60, $3A, $60, $3B, $60, $6B, $60, $6C, $60, $6D, $60, $6E, $60, $6F, $60, $3B ;0x2A0
	dc.b	$60, $01, $60, $70, $60, $71, $60, $27, $60, $72, $60, $73, $60, $27, $60, $13
	dc.b	$60, $39, $60, $38, $60, $38, $60, $38, $60, $38, $60, $38, $60, $38, $60, $38 ;0x2C0
	dc.b	$60, $38, $60, $38, $60, $38, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39
	dc.b	$60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39 ;0x2E0
	dc.b	$60, $39, $60, $39, $60, $74, $60, $75, $60, $76, $60, $77, $60, $39, $60, $39
	dc.b	$60, $01, $60, $35, $60, $36, $60, $37, $60, $35, $60, $36, $60, $37, $60, $39 ;0x300
loc_6E74:
	dc.b	$60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14
	dc.b	$60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14 ;0x0 (0x00006E74-0x00007194, Entry count: 0x320) [Unknown data]
	dc.b	$60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14
	dc.b	$60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14 ;0x20
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $14
	dc.b	$60, $02, $60, $03, $60, $04, $60, $05, $60, $03, $60, $03, $60, $06, $60, $07 ;0x40
	dc.b	$60, $08, $60, $09, $60, $03, $60, $0A, $60, $02, $60, $02, $60, $02, $60, $02
	dc.b	$60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02 ;0x60
	dc.b	$60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0C, $60, $0D, $60, $0C
	dc.b	$60, $01, $60, $0E, $60, $0F, $60, $10, $60, $01, $60, $01, $60, $01, $60, $13 ;0x80
	dc.b	$60, $02, $60, $03, $00, $00, $00, $00, $60, $03, $60, $03, $60, $15, $60, $16
	dc.b	$60, $17, $60, $18, $60, $03, $60, $13, $20, $19, $20, $1A, $60, $0A, $20, $1B ;0xA0
	dc.b	$20, $1C, $60, $0A, $20, $1D, $20, $1E, $60, $0A, $20, $1F, $20, $20, $60, $0A
	dc.b	$60, $0B, $60, $0B, $60, $21, $60, $22, $60, $23, $60, $0C, $60, $24, $60, $0C ;0xC0
	dc.b	$60, $01, $60, $25, $60, $26, $60, $27, $60, $01, $60, $01, $60, $01, $60, $13
	dc.b	$60, $02, $60, $2A, $60, $2B, $60, $2C, $60, $2A, $60, $2A, $60, $2A, $60, $2A ;0xE0
	dc.b	$60, $2A, $60, $2A, $60, $2A, $60, $13, $20, $2D, $20, $2E, $60, $13, $20, $2F
	dc.b	$20, $30, $60, $13, $20, $31, $20, $32, $60, $13, $20, $33, $20, $34, $60, $13 ;0x100
	dc.b	$60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0C, $60, $24, $60, $0C
	dc.b	$60, $01, $60, $35, $60, $36, $60, $37, $60, $01, $60, $01, $60, $01, $60, $13 ;0x120
	dc.b	$60, $02, $60, $38, $00, $00, $00, $00, $00, $39, $00, $39, $00, $02, $00, $02
	dc.b	$00, $14, $00, $14, $60, $38, $60, $13, $60, $3A, $60, $3B, $60, $3C, $60, $3A ;0x140
	dc.b	$60, $3B, $60, $3C, $60, $3A, $60, $3B, $60, $3C, $60, $3A, $60, $3B, $60, $3C
	dc.b	$60, $0B, $60, $0B, $60, $3D, $60, $3E, $60, $3F, $60, $0C, $60, $24, $60, $0C ;0x160
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $78, $60, $79, $60, $10, $60, $13
	dc.b	$60, $02, $60, $38, $00, $44, $00, $44, $00, $38, $00, $38, $00, $03, $00, $03 ;0x180
	dc.b	$00, $45, $00, $45, $60, $38, $60, $13, $20, $46, $20, $47, $60, $0A, $20, $48
	dc.b	$20, $49, $60, $0A, $20, $4A, $20, $4B, $60, $0A, $20, $4C, $20, $4D, $60, $0A ;0x1A0
	dc.b	$60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0C, $60, $24, $60, $0C
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $7A, $60, $7B, $60, $27, $60, $13 ;0x1C0
	dc.b	$60, $02, $60, $38, $00, $52, $00, $52, $00, $0B, $00, $0B, $00, $0C, $00, $0C
	dc.b	$00, $01, $00, $01, $60, $38, $60, $13, $20, $53, $20, $54, $60, $13, $20, $55 ;0x1E0
	dc.b	$20, $56, $60, $13, $20, $57, $20, $58, $60, $13, $20, $59, $20, $5A, $60, $13
	dc.b	$60, $0B, $60, $0B, $60, $5B, $60, $5C, $60, $5D, $60, $0C, $60, $24, $60, $0C ;0x200
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $35, $60, $36, $60, $37, $60, $13
	dc.b	$60, $02, $60, $38, $00, $5E, $00, $5E, $00, $5F, $00, $5F, $00, $60, $00, $60 ;0x220
	dc.b	$00, $61, $00, $61, $60, $38, $60, $13, $60, $3A, $60, $3B, $60, $3C, $60, $3A
	dc.b	$60, $3B, $60, $3C, $60, $3A, $60, $3B, $60, $3C, $60, $3A, $60, $3B, $60, $3C ;0x240
	dc.b	$60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0C, $60, $62, $60, $0C
	dc.b	$60, $01, $60, $63, $60, $64, $60, $10, $60, $7C, $60, $7D, $60, $10, $60, $13 ;0x260
	dc.b	$60, $02, $60, $38, $00, $67, $00, $67, $00, $68, $00, $68, $00, $69, $00, $69
	dc.b	$00, $6A, $00, $6A, $60, $38, $60, $13, $60, $02, $60, $02, $60, $02, $60, $02 ;0x280
	dc.b	$60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02
	dc.b	$60, $3A, $60, $3B, $60, $3B, $60, $3B, $60, $3B, $60, $3B, $60, $3B, $60, $3B ;0x2A0
	dc.b	$60, $01, $60, $70, $60, $71, $60, $27, $60, $7E, $60, $7F, $60, $27, $60, $13
	dc.b	$60, $39, $60, $38, $60, $38, $60, $38, $60, $38, $60, $38, $60, $38, $60, $38 ;0x2C0
	dc.b	$60, $38, $60, $38, $60, $38, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39
	dc.b	$60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39 ;0x2E0
	dc.b	$60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39
	dc.b	$60, $01, $60, $35, $60, $36, $60, $37, $60, $35, $60, $36, $60, $37, $60, $39 ;0x300
loc_7194:
	dc.b	$60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14
	dc.b	$60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14 ;0x0 (0x00007194-0x000074B4, Entry count: 0x320) [Unknown data]
	dc.b	$60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14
	dc.b	$60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14 ;0x20
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $14
	dc.b	$60, $02, $60, $03, $60, $04, $60, $05, $60, $03, $60, $03, $60, $06, $60, $07 ;0x40
	dc.b	$60, $08, $60, $09, $60, $03, $60, $0A, $60, $02, $60, $02, $60, $02, $60, $02
	dc.b	$60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02 ;0x60
	dc.b	$60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0C, $60, $0D, $60, $0C
	dc.b	$60, $01, $60, $0E, $60, $0F, $60, $10, $60, $78, $60, $79, $60, $10, $60, $13 ;0x80
	dc.b	$60, $02, $60, $03, $00, $00, $00, $00, $60, $03, $60, $03, $60, $15, $60, $16
	dc.b	$60, $17, $60, $18, $60, $03, $60, $13, $20, $19, $20, $1A, $60, $0A, $20, $1B ;0xA0
	dc.b	$20, $1C, $60, $0A, $20, $1D, $20, $1E, $60, $0A, $20, $1F, $20, $20, $60, $0A
	dc.b	$60, $0B, $60, $0B, $60, $21, $60, $22, $60, $23, $60, $0C, $60, $24, $60, $0C ;0xC0
	dc.b	$60, $01, $60, $25, $60, $26, $60, $27, $60, $7A, $60, $7B, $60, $27, $60, $13
	dc.b	$60, $02, $60, $2A, $60, $2B, $60, $2C, $60, $2A, $60, $2A, $60, $2A, $60, $2A ;0xE0
	dc.b	$60, $2A, $60, $2A, $60, $2A, $60, $13, $20, $2D, $20, $2E, $60, $13, $20, $2F
	dc.b	$20, $30, $60, $13, $20, $31, $20, $32, $60, $13, $20, $33, $20, $34, $60, $13 ;0x100
	dc.b	$60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0C, $60, $24, $60, $0C
	dc.b	$60, $01, $60, $35, $60, $36, $60, $37, $60, $35, $60, $36, $60, $37, $60, $13 ;0x120
	dc.b	$60, $02, $60, $38, $00, $00, $00, $00, $00, $39, $00, $39, $00, $02, $00, $02
	dc.b	$00, $14, $00, $14, $60, $38, $60, $13, $60, $3A, $60, $3B, $60, $3C, $60, $3A ;0x140
	dc.b	$60, $3B, $60, $3C, $60, $3A, $60, $3B, $60, $3C, $60, $3A, $60, $3B, $60, $3C
	dc.b	$60, $0B, $60, $0B, $60, $3D, $60, $3E, $60, $3F, $60, $0C, $60, $24, $60, $0C ;0x160
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $13
	dc.b	$60, $02, $60, $38, $00, $44, $00, $44, $00, $38, $00, $38, $00, $03, $00, $03 ;0x180
	dc.b	$00, $45, $00, $45, $60, $38, $60, $13, $20, $46, $20, $47, $60, $0A, $20, $48
	dc.b	$20, $49, $60, $0A, $20, $4A, $20, $4B, $60, $0A, $20, $4C, $20, $4D, $60, $0A ;0x1A0
	dc.b	$60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0C, $60, $24, $60, $0C
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $13 ;0x1C0
	dc.b	$60, $02, $60, $38, $00, $52, $00, $52, $00, $0B, $00, $0B, $00, $0C, $00, $0C
	dc.b	$00, $01, $00, $01, $60, $38, $60, $13, $20, $53, $20, $54, $60, $13, $20, $55 ;0x1E0
	dc.b	$20, $56, $60, $13, $20, $57, $20, $58, $60, $13, $20, $59, $20, $5A, $60, $13
	dc.b	$60, $0B, $60, $0B, $60, $5B, $60, $5C, $60, $5D, $60, $0C, $60, $24, $60, $0C ;0x200
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $13
	dc.b	$60, $02, $60, $38, $00, $5E, $00, $5E, $00, $5F, $00, $5F, $00, $60, $00, $60 ;0x220
	dc.b	$00, $61, $00, $61, $60, $38, $60, $13, $60, $3A, $60, $3B, $60, $3C, $60, $3A
	dc.b	$60, $3B, $60, $3C, $60, $3A, $60, $3B, $60, $3C, $60, $3A, $60, $3B, $60, $3C ;0x240
	dc.b	$60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0B, $60, $0C, $60, $62, $60, $0C
	dc.b	$60, $01, $60, $63, $60, $64, $60, $10, $60, $7C, $60, $7D, $60, $10, $60, $13 ;0x260
	dc.b	$60, $02, $60, $38, $00, $67, $00, $67, $00, $68, $00, $68, $00, $69, $00, $69
	dc.b	$00, $6A, $00, $6A, $60, $38, $60, $13, $60, $02, $60, $02, $60, $02, $60, $02 ;0x280
	dc.b	$60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02
	dc.b	$60, $3A, $60, $3B, $60, $3B, $60, $3B, $60, $3B, $60, $3B, $60, $3B, $60, $3B ;0x2A0
	dc.b	$60, $01, $60, $70, $60, $71, $60, $27, $60, $7E, $60, $7F, $60, $27, $60, $13
	dc.b	$60, $39, $60, $38, $60, $38, $60, $38, $60, $38, $60, $38, $60, $38, $60, $38 ;0x2C0
	dc.b	$60, $38, $60, $38, $60, $38, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39
	dc.b	$60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39 ;0x2E0
	dc.b	$60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39, $60, $39
	dc.b	$60, $01, $60, $35, $60, $36, $60, $37, $60, $35, $60, $36, $60, $37, $60, $39 ;0x300
loc_74B4:
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x0 (0x000074B4-0x00007BB4, Entry count: 0x700) [Unknown data]
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33 ;0x20
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22 ;0x40
	dc.b	$55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55
	dc.b	$55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55 ;0x60
	dc.b	$55, $44, $44, $55, $55, $54, $44, $44, $55, $55, $54, $44, $55, $55, $55, $55
	dc.b	$55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55 ;0x80
	dc.b	$55, $55, $55, $55, $44, $44, $44, $44, $44, $44, $44, $44, $55, $55, $55, $55
	dc.b	$55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55 ;0xA0
	dc.b	$55, $66, $65, $55, $56, $66, $65, $55, $56, $66, $55, $55, $56, $66, $55, $55
	dc.b	$56, $44, $55, $55, $54, $44, $55, $55, $54, $44, $45, $55, $55, $44, $45, $55 ;0xC0
	dc.b	$FF, $55, $5F, $F5, $FF, $F5, $5F, $F4, $FF, $FF, $5F, $F4, $FF, $4F, $FF, $F4
	dc.b	$EE, $45, $EE, $E4, $EE, $45, $5E, $E4, $EE, $45, $5E, $E4, $54, $45, $55, $44 ;0xE0
	dc.b	$FF, $FF, $FF, $55, $FF, $44, $44, $45, $FF, $45, $55, $55, $FF, $FF, $F5, $55
	dc.b	$EE, $44, $44, $55, $EE, $45, $55, $55, $EE, $EE, $EE, $55, $54, $44, $44, $45 ;0x100
	dc.b	$FF, $55, $5F, $F5, $FF, $45, $5F, $F4, $FF, $45, $5F, $F4, $FF, $4F, $5F, $F4
	dc.b	$EE, $EE, $EE, $E4, $EE, $E4, $EE, $E4, $EE, $44, $5E, $E4, $54, $45, $55, $44 ;0x120
	dc.b	$FF, $FF, $F5, $55, $FF, $44, $FF, $55, $FF, $45, $FF, $45, $FF, $FF, $F4, $45
	dc.b	$EE, $44, $44, $55, $EE, $45, $55, $55, $EE, $45, $55, $55, $54, $45, $55, $55 ;0x140
	dc.b	$5F, $FF, $F5, $55, $55, $FF, $44, $55, $55, $FF, $45, $55, $55, $FF, $45, $55
	dc.b	$55, $EE, $45, $55, $55, $EE, $45, $55, $5E, $EE, $E5, $55, $55, $44, $44, $55 ;0x160
	dc.b	$5F, $FF, $FF, $55, $FF, $44, $44, $45, $FF, $45, $55, $55, $FF, $45, $55, $55
	dc.b	$EE, $45, $55, $55, $EE, $45, $55, $55, $5E, $EE, $EE, $55, $55, $44, $44, $45 ;0x180
	dc.b	$FF, $FF, $FF, $55, $54, $FF, $44, $45, $55, $FF, $45, $55, $55, $FF, $45, $55
	dc.b	$55, $EE, $45, $55, $55, $EE, $45, $55, $55, $EE, $45, $55, $55, $54, $45, $55 ;0x1A0
	dc.b	$FF, $55, $FF, $55, $FF, $45, $FF, $45, $FF, $45, $FF, $45, $FF, $45, $FF, $45
	dc.b	$EE, $45, $EE, $45, $EE, $45, $EE, $45, $5E, $EE, $E4, $45, $55, $44, $44, $55 ;0x1C0
	dc.b	$FF, $FF, $F5, $55, $FF, $44, $FF, $55, $FF, $45, $FF, $45, $FF, $FF, $F4, $45
	dc.b	$EE, $EE, $44, $55, $EE, $4E, $E5, $55, $EE, $45, $EE, $55, $54, $45, $54, $45 ;0x1E0
	dc.b	$11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11
	dc.b	$11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11 ;0x200
	dc.b	$55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55
	dc.b	$55, $55, $55, $55, $55, $55, $56, $66, $55, $56, $66, $66, $55, $66, $66, $55 ;0x220
	dc.b	$55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55
	dc.b	$55, $55, $55, $55, $66, $66, $66, $66, $66, $66, $66, $66, $55, $55, $55, $55 ;0x240
	dc.b	$AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB
	dc.b	$AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB ;0x260
	dc.b	$BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB
	dc.b	$BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB ;0x280
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $11, $12, $22, $22
	dc.b	$11, $12, $22, $22, $11, $12, $22, $22, $11, $12, $22, $22, $11, $12, $22, $22 ;0x2A0
	dc.b	$55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55
	dc.b	$55, $55, $55, $55, $66, $55, $55, $55, $66, $65, $55, $55, $56, $66, $55, $55 ;0x2C0
	dc.b	$BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $AA, $AB, $BB, $BB
	dc.b	$AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB ;0x2E0
	dc.b	$22, $22, $22, $21, $22, $11, $22, $13, $21, $AA, $11, $33, $1A, $AA, $A1, $33
	dc.b	$AA, $11, $AA, $11, $AA, $11, $AA, $1A, $AA, $AA, $AA, $1A, $AA, $11, $AA, $1A ;0x300
	dc.b	$12, $22, $22, $22, $31, $22, $22, $22, $33, $12, $21, $12, $11, $11, $1A, $A1
	dc.b	$AA, $A1, $AA, $AA, $A1, $11, $1A, $A1, $A1, $31, $1A, $A1, $A1, $33, $1A, $A1 ;0x320
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $33, $31, $33, $11, $33, $33, $11, $AA
	dc.b	$33, $33, $11, $11, $33, $31, $91, $18, $31, $11, $91, $1A, $33, $31, $9A, $AA ;0x340
	dc.b	$13, $33, $33, $33, $13, $33, $33, $33, $11, $13, $31, $33, $AA, $91, $13, $33
	dc.b	$11, $11, $13, $33, $11, $89, $91, $33, $11, $A9, $91, $11, $AA, $18, $91, $33 ;0x360
	dc.b	$CC, $CC, $C1, $11, $CC, $CC, $11, $DE, $CC, $CC, $1D, $EE, $11, $BC, $1D, $EE
	dc.b	$1E, $1B, $1D, $BB, $1D, $E1, $DD, $B1, $11, $1E, $ED, $DD, $CC, $11, $DE, $EE ;0x380
	dc.b	$BB, $1B, $CC, $CC, $11, $E1, $CC, $CC, $EE, $11, $C1, $BC, $E1, $1C, $1E, $1B
	dc.b	$E1, $C1, $ED, $E1, $D1, $1E, $DD, $D1, $EE, $E1, $11, $11, $EE, $11, $CC, $CC ;0x3A0
	dc.b	$31, $11, $3B, $BC, $18, $88, $13, $BB, $18, $81, $81, $33, $11, $11, $81, $33
	dc.b	$33, $31, $81, $33, $33, $31, $81, $33, $33, $31, $88, $11, $BB, $31, $88, $88 ;0x3C0
	dc.b	$CC, $CB, $CC, $CB, $BB, $CC, $CC, $CB, $B5, $CC, $5C, $B3, $3B, $B6, $5B, $33
	dc.b	$33, $BB, $B3, $33, $3B, $BB, $BB, $33, $11, $11, $BB, $B3, $88, $88, $11, $BB ;0x3E0
	dc.b	$11, $11, $11, $11, $11, $DD, $11, $11, $1C, $DD, $D1, $11, $1C, $CD, $D1, $11
	dc.b	$11, $CC, $11, $E1, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $13 ;0x400
	dc.b	$11, $11, $11, $11, $E1, $11, $11, $11, $11, $11, $1E, $11, $11, $11, $11, $11
	dc.b	$11, $11, $11, $11, $11, $33, $33, $31, $33, $33, $33, $33, $33, $33, $33, $33 ;0x420
	dc.b	$AA, $A1, $11, $AA, $AA, $1E, $65, $1A, $AA, $16, $15, $51, $A1, $15, $11, $51
	dc.b	$A1, $61, $51, $15, $A1, $11, $11, $11, $A1, $33, $33, $15, $A1, $11, $11, $11 ;0x440
	dc.b	$AA, $11, $1A, $AA, $A1, $E6, $51, $A9, $16, $61, $51, $99, $16, $11, $51, $19
	dc.b	$61, $15, $16, $18, $11, $11, $11, $18, $51, $33, $33, $18, $11, $11, $11, $18 ;0x460
	dc.b	$11, $12, $22, $22, $11, $12, $22, $22, $11, $12, $22, $22, $11, $12, $22, $22
	dc.b	$11, $12, $22, $22, $11, $12, $22, $22, $11, $12, $22, $22, $11, $12, $22, $22 ;0x480
	dc.b	$5F, $FF, $FF, $55, $FF, $44, $44, $45, $FF, $45, $55, $55, $5F, $FF, $F5, $55
	dc.b	$55, $44, $EE, $55, $55, $55, $EE, $45, $EE, $EE, $E4, $45, $54, $44, $44, $55 ;0x4A0
	dc.b	$FF, $55, $55, $55, $FF, $45, $55, $55, $FF, $45, $55, $55, $FF, $45, $55, $55
	dc.b	$EE, $45, $55, $55, $EE, $45, $55, $55, $EE, $EE, $EE, $55, $54, $44, $44, $45 ;0x4C0
	dc.b	$55, $66, $65, $55, $55, $56, $66, $55, $55, $55, $66, $65, $55, $55, $56, $66
	dc.b	$55, $55, $54, $44, $55, $55, $44, $45, $55, $54, $44, $55, $55, $44, $45, $55 ;0x4E0
	dc.b	$AA, $11, $AA, $1A, $11, $11, $11, $11, $22, $13, $31, $11, $21, $33, $33, $33
	dc.b	$21, $33, $31, $11, $13, $33, $11, $22, $13, $33, $12, $22, $11, $11, $12, $22 ;0x500
	dc.b	$A1, $33, $11, $AA, $11, $13, $31, $11, $11, $13, $31, $22, $33, $33, $33, $12
	dc.b	$11, $13, $33, $12, $22, $11, $33, $31, $22, $21, $33, $31, $22, $21, $11, $11 ;0x520
	dc.b	$33, $33, $19, $AA, $33, $33, $11, $99, $33, $31, $33, $11, $33, $33, $33, $33
	dc.b	$11, $13, $33, $33, $11, $11, $11, $33, $11, $11, $11, $11, $22, $22, $22, $22 ;0x540
	dc.b	$11, $19, $13, $33, $99, $91, $13, $33, $11, $13, $31, $33, $13, $33, $33, $33
	dc.b	$13, $33, $33, $33, $33, $33, $33, $33, $11, $11, $11, $11, $22, $22, $22, $22 ;0x560
	dc.b	$CC, $C1, $DE, $EE, $CC, $C1, $DE, $EE, $CC, $CC, $1D, $EE, $BB, $BB, $1D, $DD
	dc.b	$44, $44, $41, $DD, $44, $44, $44, $11, $44, $44, $44, $44, $44, $44, $44, $44 ;0x580
	dc.b	$EE, $1C, $CC, $CC, $E1, $11, $1C, $CC, $DE, $EE, $E1, $CC, $EE, $D1, $DE, $1B
	dc.b	$DD, $11, $11, $E1, $11, $44, $1E, $14, $44, $44, $11, $44, $44, $44, $44, $44 ;0x5A0
	dc.b	$BB, $B1, $18, $88, $BB, $BB, $18, $88, $BB, $BB, $11, $88, $22, $22, $21, $88
	dc.b	$22, $22, $21, $81, $77, $77, $71, $11, $77, $71, $18, $88, $11, $18, $88, $11 ;0x5C0
	dc.b	$88, $88, $88, $1B, $88, $88, $88, $81, $88, $88, $88, $81, $88, $88, $88, $81
	dc.b	$18, $11, $88, $81, $11, $18, $88, $11, $88, $88, $11, $17, $11, $11, $17, $77 ;0x5E0
	dc.b	$11, $1E, $11, $33, $11, $11, $12, $33, $11, $11, $12, $33, $1E, $11, $22, $33
	dc.b	$11, $11, $22, $23, $11, $11, $22, $23, $11, $11, $22, $22, $11, $11, $12, $22 ;0x600
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $33, $23, $33, $33, $33 ;0x620
	dc.b	$A1, $22, $22, $14, $A1, $11, $11, $15, $A1, $55, $55, $55, $A1, $11, $11, $15
	dc.b	$A1, $33, $33, $15, $A1, $33, $33, $15, $A1, $33, $33, $15, $A1, $11, $11, $11 ;0x640
	dc.b	$41, $22, $22, $18, $51, $11, $11, $18, $55, $55, $55, $18, $51, $11, $11, $18
	dc.b	$51, $22, $22, $18, $51, $22, $22, $18, $51, $22, $22, $18, $11, $11, $11, $18 ;0x660
	dc.b	$54, $44, $55, $55, $44, $45, $55, $55, $44, $55, $55, $55, $55, $55, $55, $55
	dc.b	$55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55, $55 ;0x680
	dc.b	$BB, $BA, $AA, $AA, $BB, $BA, $AA, $AA, $BB, $BA, $AA, $AA, $BB, $BB, $BB, $BB
	dc.b	$BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB ;0x6A0
	dc.b	$AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $BB, $BB, $BB, $BB
	dc.b	$BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB ;0x6C0
	dc.b	$AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB, $BB, $BB, $BB, $BB
	dc.b	$BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB ;0x6E0
loc_7BB4:
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01 ;0x0 (0x00007BB4-0x00007E34, Entry count: 0x280) [Unknown data]
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01 ;0x20
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01
	dc.b	$60, $02, $60, $03, $70, $04, $70, $05, $70, $05, $70, $05, $70, $05, $70, $05 ;0x40
	dc.b	$70, $05, $70, $05, $70, $05, $70, $05, $70, $05, $70, $05, $78, $04, $60, $03
	dc.b	$60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02 ;0x60
	dc.b	$60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02
	dc.b	$60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02 ;0x80
	dc.b	$60, $02, $60, $03, $70, $06, $60, $07, $60, $08, $60, $09, $60, $03, $60, $0A
	dc.b	$60, $0B, $60, $0C, $60, $0D, $60, $0E, $60, $0F, $60, $08, $78, $06, $60, $03 ;0xA0
	dc.b	$60, $10, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02
	dc.b	$60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02 ;0xC0
	dc.b	$60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02, $60, $02
	dc.b	$60, $02, $60, $03, $70, $11, $70, $12, $70, $12, $70, $12, $70, $12, $70, $12 ;0xE0
	dc.b	$70, $12, $70, $12, $70, $12, $70, $12, $70, $12, $70, $12, $78, $11, $60, $03
	dc.b	$60, $13, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14 ;0x100
	dc.b	$60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14
	dc.b	$60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $14, $60, $15 ;0x120
	dc.b	$60, $02, $60, $02, $60, $10, $60, $10, $60, $03, $60, $11, $60, $12, $60, $12
	dc.b	$60, $12, $60, $12, $60, $12, $60, $12, $60, $12, $60, $12, $60, $16, $60, $03 ;0x140
	dc.b	$60, $13, $20, $00, $20, $00, $60, $17, $20, $1A, $20, $1B, $60, $17, $20, $1C
	dc.b	$20, $1D, $60, $17, $20, $1E, $20, $1F, $60, $17, $20, $20, $20, $21, $60, $17 ;0x160
	dc.b	$20, $22, $20, $23, $60, $17, $20, $18, $20, $19, $60, $17, $60, $14, $60, $24
	dc.b	$60, $02, $60, $02, $60, $02, $60, $02, $60, $03, $60, $06, $60, $03, $60, $25 ;0x180
	dc.b	$60, $08, $60, $26, $60, $08, $60, $0C, $60, $0D, $60, $03, $60, $27, $60, $03
	dc.b	$60, $13, $20, $00, $20, $00, $60, $13, $20, $2A, $20, $2B, $60, $13, $20, $2C ;0x1A0
	dc.b	$20, $2D, $60, $13, $20, $2E, $20, $2F, $60, $13, $20, $30, $20, $31, $60, $13
	dc.b	$20, $32, $20, $33, $60, $13, $20, $28, $20, $29, $60, $13, $60, $14, $60, $24 ;0x1C0
	dc.b	$60, $02, $60, $02, $60, $02, $60, $02, $60, $03, $60, $04, $60, $05, $60, $05
	dc.b	$60, $05, $60, $05, $60, $05, $60, $05, $60, $05, $60, $05, $60, $34, $60, $03 ;0x1E0
	dc.b	$60, $13, $60, $35, $60, $36, $60, $37, $60, $35, $60, $36, $60, $37, $60, $35
	dc.b	$60, $36, $60, $37, $60, $35, $60, $36, $60, $37, $60, $35, $60, $36, $60, $37 ;0x200
	dc.b	$60, $35, $60, $36, $60, $37, $60, $35, $60, $36, $60, $37, $60, $14, $60, $24
	dc.b	$60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10 ;0x220
	dc.b	$60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10
	dc.b	$60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10 ;0x240
	dc.b	$60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10
	dc.b	$60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10, $60, $10 ;0x260
loc_7E34:
	dc.b	$00, $00, $03, $33, $00, $00, $33, $00, $00, $00, $30, $03, $00, $03, $00, $30
	dc.b	$30, $33, $00, $30, $30, $03, $00, $00, $03, $00, $03, $00, $00, $30, $30, $00 ;0x0 (0x00007E34-0x00008554, Entry count: 0x720) [Unknown data]
	dc.b	$CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC
	dc.b	$CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC ;0x20
	dc.b	$BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB
	dc.b	$BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB ;0x40
	dc.b	$BB, $33, $33, $33, $B3, $33, $33, $33, $33, $32, $22, $22, $33, $22, $22, $22
	dc.b	$33, $22, $22, $22, $33, $22, $2D, $DD, $33, $22, $22, $DD, $33, $22, $22, $DD ;0x60
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $22, $22, $22, $22, $22, $22, $2D, $DD
	dc.b	$2D, $DD, $D2, $11, $D2, $11, $11, $22, $11, $22, $2F, $F2, $12, $22, $FF, $11 ;0x80
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $22, $2D, $DD, $22, $DD, $D2, $11, $12
	dc.b	$11, $11, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $DD, $DD, $DD ;0xA0
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $22, $22, $22, $22, $22, $22, $22, $22
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $22, $DD, $DD, $DD, $DD, $D1, $11, $1D ;0xC0
	dc.b	$33, $33, $33, $BB, $33, $33, $33, $3B, $22, $22, $23, $31, $22, $22, $22, $11
	dc.b	$22, $22, $22, $11, $22, $22, $22, $11, $DD, $22, $22, $11, $D1, $12, $22, $11 ;0xE0
	dc.b	$BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $AB, $BB, $BB, $BB
	dc.b	$AA, $BB, $BB, $BB, $AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB ;0x100
	dc.b	$BB, $33, $33, $33, $B3, $33, $33, $33, $33, $32, $22, $22, $33, $22, $22, $22
	dc.b	$33, $22, $22, $22, $33, $22, $22, $DD, $33, $22, $2D, $D1, $33, $22, $DD, $11 ;0x120
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $22, $22, $22, $22, $22, $22, $DD, $DD
	dc.b	$DD, $DD, $D1, $11, $D1, $11, $11, $22, $11, $22, $22, $22, $22, $22, $22, $22 ;0x140
	dc.b	$33, $33, $33, $33, $33, $33, $FF, $33, $22, $22, $2F, $F2, $FF, $FF, $FF, $FF
	dc.b	$11, $11, $1E, $E1, $22, $22, $EE, $11, $22, $22, $21, $12, $22, $22, $22, $22 ;0x160
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $22, $22, $22, $22, $2D, $DD, $22, $22
	dc.b	$12, $1D, $DD, $DD, $22, $22, $11, $1D, $22, $22, $22, $22, $22, $22, $22, $22 ;0x180
	dc.b	$33, $33, $33, $BB, $33, $33, $33, $3B, $22, $22, $23, $31, $22, $22, $22, $11
	dc.b	$22, $22, $22, $11, $DD, $22, $22, $11, $1D, $D2, $22, $11, $22, $DD, $22, $11 ;0x1A0
	dc.b	$BB, $33, $33, $33, $B3, $33, $33, $33, $33, $32, $22, $22, $33, $22, $22, $22
	dc.b	$33, $22, $22, $22, $33, $22, $22, $FF, $33, $22, $22, $2F, $33, $2F, $FF, $FF ;0x1C0
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $22, $22, $22, $22, $22, $22, $22, $22
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $F2, $22, $22, $22, $FF, $2D, $DD, $DD ;0x1E0
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $22, $22, $22, $22, $22, $22, $22, $22
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $DD, $DD, $DD, $DD ;0x200
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $22, $22, $22, $22, $22, $22, $22, $22
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $2F, $DD, $DD, $D2, $FF ;0x220
	dc.b	$33, $33, $33, $BB, $33, $33, $33, $3B, $22, $22, $23, $31, $22, $22, $22, $11
	dc.b	$22, $22, $22, $11, $FF, $22, $22, $11, $F1, $12, $22, $11, $FF, $FF, $F2, $11 ;0x240
	dc.b	$BB, $33, $33, $33, $B3, $33, $33, $33, $33, $32, $22, $22, $33, $22, $22, $22
	dc.b	$33, $22, $22, $22, $33, $22, $22, $22, $33, $22, $22, $2E, $33, $22, $22, $EE ;0x260
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $22, $22, $22, $22, $22, $22, $22, $22
	dc.b	$22, $EE, $EE, $EE, $EE, $E1, $11, $1E, $E1, $11, $22, $22, $11, $22, $22, $22 ;0x280
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $22, $22, $22, $22, $22, $22, $22, $22
	dc.b	$22, $22, $22, $22, $EE, $22, $22, $22, $1E, $E2, $22, $22, $22, $EE, $22, $22 ;0x2A0
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $22, $22, $22, $22, $22, $22, $22, $22
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22 ;0x2C0
	dc.b	$33, $33, $33, $BB, $33, $33, $33, $3B, $22, $22, $23, $31, $22, $22, $22, $11
	dc.b	$22, $22, $22, $11, $22, $EE, $22, $11, $2E, $E1, $12, $11, $EE, $11, $22, $11 ;0x2E0
	dc.b	$BB, $33, $33, $33, $B3, $33, $33, $33, $33, $32, $22, $22, $33, $22, $22, $22
	dc.b	$33, $2F, $FF, $F2, $33, $2F, $F1, $11, $33, $2F, $F1, $22, $33, $2F, $FF, $22 ;0x300
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $22, $22, $22, $22, $22, $22, $22, $22
	dc.b	$2F, $FF, $22, $FF, $FF, $11, $F2, $FF, $FF, $12, $F1, $FF, $FF, $12, $F1, $FF ;0x320
	dc.b	$33, $33, $33, $33, $33, $33, $33, $33, $22, $22, $22, $22, $22, $22, $22, $22
	dc.b	$22, $2F, $F2, $22, $12, $2F, $F1, $22, $12, $2F, $F1, $22, $12, $2F, $F1, $22 ;0x340
	dc.b	$33, $33, $33, $BB, $33, $33, $33, $3B, $22, $22, $23, $31, $22, $22, $22, $11
	dc.b	$22, $22, $F2, $11, $12, $22, $F1, $11, $12, $22, $F1, $11, $1F, $22, $F1, $11 ;0x360
	dc.b	$33, $22, $22, $2D, $33, $22, $22, $2D, $33, $22, $22, $22, $33, $22, $22, $22
	dc.b	$33, $22, $22, $22, $33, $12, $22, $22, $B1, $11, $11, $11, $BB, $11, $11, $11 ;0x380
	dc.b	$D2, $2F, $FF, $FF, $D1, $22, $EE, $11, $DD, $22, $2E, $E2, $DD, $12, $22, $11
	dc.b	$2D, $DD, $DD, $DD, $22, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11 ;0x3A0
	dc.b	$FF, $F1, $11, $11, $11, $11, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22
	dc.b	$DD, $DD, $DD, $DD, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11 ;0x3C0
	dc.b	$11, $11, $22, $2D, $22, $22, $22, $DD, $22, $22, $22, $DD, $22, $22, $2D, $D1
	dc.b	$DD, $DD, $DD, $D1, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11 ;0x3E0
	dc.b	$D1, $22, $22, $11, $11, $22, $22, $11, $12, $22, $22, $11, $12, $22, $22, $11
	dc.b	$22, $22, $22, $11, $22, $22, $21, $11, $11, $11, $11, $1A, $11, $11, $11, $AA ;0x400
	dc.b	$AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB
	dc.b	$AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB, $AA, $AB, $BB, $BB ;0x420
	dc.b	$33, $22, $DD, $12, $33, $22, $2D, $D2, $33, $22, $22, $DD, $33, $22, $22, $21
	dc.b	$33, $22, $22, $22, $33, $12, $22, $22, $B1, $11, $11, $11, $BB, $11, $11, $11 ;0x440
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $D2, $22, $22, $22, $DD, $DD, $D2, $22
	dc.b	$21, $11, $DD, $D2, $22, $22, $21, $11, $11, $11, $11, $11, $11, $11, $11, $11 ;0x460
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $22, $FF, $22, $22, $2F, $F1, $12, $22
	dc.b	$FF, $FF, $FF, $FF, $2E, $E1, $11, $11, $11, $EE, $11, $11, $11, $11, $11, $11 ;0x480
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $2D, $22, $2D, $DD, $DD
	dc.b	$DD, $DD, $11, $11, $11, $11, $12, $22, $11, $11, $11, $11, $11, $11, $11, $11 ;0x4A0
	dc.b	$22, $DD, $12, $11, $2D, $D1, $12, $11, $DD, $11, $22, $11, $11, $12, $22, $11
	dc.b	$12, $22, $22, $11, $22, $22, $21, $11, $11, $11, $11, $1A, $11, $11, $11, $AA ;0x4C0
	dc.b	$33, $22, $11, $1E, $33, $22, $22, $EE, $33, $22, $22, $21, $33, $22, $22, $22
	dc.b	$33, $22, $22, $22, $33, $12, $22, $22, $B1, $11, $11, $11, $BB, $11, $11, $11 ;0x4E0
	dc.b	$E1, $12, $11, $11, $11, $22, $22, $22, $12, $22, $22, $22, $22, $22, $22, $22
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $11, $11, $11, $11, $11, $11, $11, $11 ;0x500
	dc.b	$11, $11, $11, $11, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $11, $11, $11, $11, $11, $11, $11, $11 ;0x520
	dc.b	$11, $11, $11, $2E, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $11, $11, $11, $11, $11, $11, $11, $11 ;0x540
	dc.b	$E1, $11, $11, $11, $EE, $22, $22, $11, $21, $12, $22, $11, $22, $22, $22, $11
	dc.b	$22, $22, $22, $11, $22, $22, $21, $11, $11, $11, $11, $1A, $11, $11, $11, $AA ;0x560
	dc.b	$33, $22, $2E, $E1, $33, $22, $EE, $11, $33, $2E, $E1, $12, $33, $22, $11, $22
	dc.b	$33, $22, $22, $22, $33, $12, $22, $22, $B1, $11, $11, $11, $BB, $11, $11, $11 ;0x580
	dc.b	$12, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $11, $11, $11, $11, $11, $11, $11, $11 ;0x5A0
	dc.b	$22, $2E, $E2, $22, $22, $22, $EE, $22, $22, $22, $2E, $EE, $22, $22, $22, $1E
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $11, $11, $11, $11, $11, $11, $11, $11 ;0x5C0
	dc.b	$22, $22, $22, $2E, $22, $22, $22, $EE, $22, $22, $EE, $E1, $EE, $EE, $E1, $11
	dc.b	$11, $11, $11, $22, $22, $22, $22, $22, $11, $11, $11, $11, $11, $11, $11, $11 ;0x5E0
	dc.b	$E1, $12, $22, $11, $11, $22, $22, $11, $12, $22, $22, $11, $22, $22, $22, $11
	dc.b	$22, $22, $22, $11, $22, $22, $21, $11, $11, $11, $11, $1A, $11, $11, $11, $AA ;0x600
	dc.b	$33, $2E, $E1, $12, $33, $2E, $E1, $22, $33, $2E, $E1, $22, $33, $22, $11, $22
	dc.b	$33, $22, $22, $22, $33, $12, $22, $22, $B1, $11, $11, $11, $BB, $11, $11, $11 ;0x620
	dc.b	$EE, $12, $E1, $EE, $EE, $12, $E1, $EE, $2E, $EE, $21, $EE, $22, $11, $12, $21
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $11, $11, $11, $11, $11, $11, $11, $11 ;0x640
	dc.b	$12, $2E, $E1, $22, $12, $2E, $E1, $22, $EE, $2E, $EE, $E2, $11, $12, $11, $11
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $11, $11, $11, $11, $11, $11, $11, $11 ;0x660
	dc.b	$EE, $12, $E1, $EE, $EE, $12, $E1, $EE, $2E, $EE, $21, $2E, $22, $11, $12, $22
	dc.b	$22, $22, $22, $22, $22, $22, $22, $22, $11, $11, $11, $11, $11, $11, $11, $11 ;0x680
	dc.b	$1E, $12, $E1, $11, $1E, $1E, $21, $11, $E2, $E2, $12, $11, $11, $21, $22, $11
	dc.b	$22, $22, $22, $11, $22, $22, $21, $11, $11, $11, $11, $1A, $11, $11, $11, $AA ;0x6A0
	dc.b	$AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA
	dc.b	$AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA ;0x6C0
	dc.b	$BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB
	dc.b	$BB, $BB, $BB, $FF, $BB, $BB, $BF, $FB, $BB, $BB, $BF, $BB, $BB, $BB, $FF, $BB ;0x6E0
	dc.b	$BF, $FB, $FB, $BB, $BB, $FF, $FB, $BB, $BB, $BF, $BB, $BB, $BB, $BB, $BB, $BB
	dc.b	$BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB ;0x700
loc_8554:
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x0 (0x00008554-0x000089B4, Entry count: 0x460) [Unknown data]
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x20
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x40
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x60
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x80
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0xA0
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0xC0
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0xE0
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x100
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x120
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x140
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x160
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x180
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x1A0
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x1C0
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x1E0
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x200
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x220
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x240
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x260
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x280
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x2A0
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x2C0
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x2E0
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x300
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01 ;0x320
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01 ;0x340
	dc.b	$60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01, $60, $01
	dc.b	$60, $02, $60, $02, $60, $02, $60, $03, $60, $04, $60, $05, $60, $06, $60, $07 ;0x360
	dc.b	$60, $08, $60, $02, $60, $09, $60, $0A, $60, $0B, $60, $0C, $60, $0D, $60, $08
	dc.b	$60, $02, $60, $0E, $60, $0F, $60, $10, $60, $11, $60, $12, $60, $08, $60, $02 ;0x380
	dc.b	$60, $13, $60, $14, $60, $15, $60, $16, $60, $17, $60, $08, $60, $02, $60, $18
	dc.b	$60, $19, $60, $1A, $60, $19, $60, $1B, $60, $08, $60, $02, $60, $02, $60, $02 ;0x3A0
	dc.b	$60, $02, $60, $02, $60, $02, $60, $1C, $60, $1D, $60, $1E, $60, $1F, $60, $20
	dc.b	$60, $21, $60, $02, $60, $22, $60, $23, $60, $24, $60, $25, $60, $26, $60, $21 ;0x3C0
	dc.b	$60, $02, $60, $27, $60, $28, $60, $29, $60, $2A, $60, $2B, $60, $21, $60, $02
	dc.b	$60, $2C, $60, $2D, $60, $2E, $60, $2F, $60, $30, $60, $21, $60, $02, $60, $31 ;0x3E0
	dc.b	$60, $32, $60, $33, $60, $34, $60, $35, $60, $21, $60, $02, $60, $02, $60, $02
	dc.b	$60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36 ;0x400
	dc.b	$60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36
	dc.b	$60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36 ;0x420
	dc.b	$60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36
	dc.b	$60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36, $60, $36 ;0x440
loc_89B4:
	dc.b	$FF, $FF, $FF, $FF, $F0, $00, $00, $00, $F0, $00, $00, $00, $F0, $00, $00, $00
	dc.b	$F0, $00, $00, $00, $F0, $00, $00, $00, $F0, $00, $00, $00, $F0, $00, $00, $00 ;0x0 (0x000089B4-0x00008A74, Entry count: 0xC0) [Unknown data]
	dc.b	$F0, $00, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x20
	dc.b	$FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x40
	dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x60
	dc.b	$FF, $00, $00, $00, $0F, $00, $00, $00, $0F, $00, $00, $00, $0F, $00, $00, $00
	dc.b	$0F, $00, $00, $00, $0F, $00, $00, $00, $0F, $00, $00, $00, $0F, $00, $00, $00 ;0x80
	dc.b	$0F, $00, $00, $00, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0xA0

loc_8A74:
	dc.w	$FFFF, $FFFF, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000
	dc.w	$F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000 ;0x0 (0x00008A74-0x00008B94, Entry count: 0x120)
	dc.w	$F000, $0000, $FFFF, $FFFF, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
	dc.w	$FFFF, $FFFF, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ;0x20
	dc.w	$0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
	dc.w	$0000, $0000, $FFFF, $FFFF, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ;0x40
	dc.w	$FF00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000
	dc.w	$0F00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000 ;0x60
	dc.w	$0F00, $0000, $FF00, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ;0x80
loc_8B94:
	dc.w	$FFFF, $FFFF, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000
	dc.w	$F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $FFFF, $FFFF, $0000, $0000, $0000, $0000 ;0x0 (0x00008B94-0x00008C94, Entry count: 0x100)
	dc.w	$FFFF, $FFFF, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
	dc.w	$0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $FFFF, $FFFF, $0000, $0000, $0000, $0000 ;0x20
	dc.w	$FFFF, $FFFF, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
	dc.w	$0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $FFFF, $FFFF, $0000, $0000, $0000, $0000 ;0x40
	dc.w	$FFFF, $FFFF, $0000, $000F, $0000, $000F, $0000, $000F, $0000, $000F, $0000, $000F, $0000, $000F, $0000, $000F
	dc.w	$0000, $000F, $0000, $000F, $0000, $000F, $0000, $000F, $0000, $000F, $FFFF, $FFFF, $0000, $0000, $0000, $0000 ;0x60
loc_8C94:
	dc.w	$0000, $0000, $0000, $000F, $0000, $000F, $0000, $000F, $0000, $000F, $0000, $000F, $0000, $000F, $0FFF, $FFF0
	dc.w	$0FFF, $FFF0, $0000, $000F, $0000, $000F, $0000, $000F, $0000, $000F, $0000, $000F, $0000, $000F, $0000, $0000 ;0x0 (0x00008C94-0x00008D14, Entry count: 0x80)
	dc.w	$0000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $0FFF, $FFF0
	dc.w	$0FFF, $FFF0, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $0000, $0000 ;0x20
loc_8D14:
	dc.w	$0000, $7770, $0007, $7110, $0007, $1170, $0077, $1700, $7771, $1700, $1171, $7000, $7111, $7000, $0717, $0000 ;0x0 (0x00008D14-0x00008D34, Entry count: 0x20)
loc_8D34:
	dc.w	$6666, $6666, $6666, $6666, $6600, $0000, $6600, $0000, $6600, $0000, $6600, $0000, $6600, $0000, $6600, $0000
	dc.w	$6600, $0000, $6600, $0000, $6600, $0000, $6600, $0000, $6600, $0000, $6600, $0000, $6600, $0000, $6600, $0000 ;0x0 (0x00008D34-0x00008E54, Entry count: 0x120)
	dc.w	$6600, $0000, $6600, $0000, $6666, $6666, $6666, $6666, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
	dc.w	$6666, $6666, $6666, $6666, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ;0x20
	dc.w	$0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
	dc.w	$0000, $0000, $0000, $0000, $6666, $6666, $6666, $6666, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ;0x40
	dc.w	$6666, $0000, $6666, $0000, $0066, $0000, $0066, $0000, $0066, $0000, $0066, $0000, $0066, $0000, $0066, $0000
	dc.w	$0066, $0000, $0066, $0000, $0066, $0000, $0066, $0000, $0066, $0000, $0066, $0000, $0066, $0000, $0066, $0000 ;0x60
	dc.w	$0066, $0000, $0066, $0000, $6666, $0000, $6666, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ;0x80
loc_8E54:
	dc.w	$FFFF, $FFFF, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000, $F000, $0000
	dc.w	$F000, $0000, $FFFF, $FFFF, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ;0x0 (0x00008E54-0x00008F54, Entry count: 0x100)
	dc.w	$FFFF, $FFFF, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
	dc.w	$0000, $0000, $FFFF, $FFFF, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ;0x20
	dc.w	$FFFF, $FFFF, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
	dc.w	$0000, $0000, $FFFF, $FFFF, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ;0x40
	dc.w	$FF00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000, $0F00, $0000
	dc.w	$0F00, $0000, $FF00, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ;0x60

loc_8F54:
	dc.l	loc_8F74
	dc.l	loc_8F94
	dc.l	loc_8FB4
	dc.l	loc_8FD4
	dc.l	loc_8FF4
	dc.l	loc_9014
	dc.l	loc_9034
	dc.l	loc_9054
	
loc_8F74:
	dc.b	$00, $00 ;0x0 (0x00008F74-0x00008F76, Entry count: 0x2) [Unknown data]
	dc.w	$0EC6
	dc.b	$0E, $66, $08, $00, $0E, $6E, $08, $08, $06, $6E, $00, $08, $06, $E4, $00, $80
	dc.b	$06, $EE, $00, $66, $0E, $EE, $08, $88, $04, $44, $00, $00 ;0x0 (0x00008F78-0x00008F94, Entry count: 0x1C) [Unknown data]
	
loc_8F94:
	dc.w	$0000
	dc.w	$0E8E, $084C, $0008, $0E82, $0C22, $0E4A, $0804, $04CE, $0268, $0AAC, $0668, $0EEE, $08C6, $0260, $0000 ;0x0 (0x00008F96-0x00008FB4, Entry count: 0x1E)
	
loc_8FB4:
	dc.w	$0000
	dc.w	$0EA8, $0C64, $0822, $00AC, $0046, $044E, $0008, $06E8, $0080, $06CE, $0268, $0EEE, $0888, $0444, $0000 ;0x0 (0x00008FB6-0x00008FD4, Entry count: 0x1E)
	
loc_8FD4:
	dc.w	$0000
	dc.w	$0E8C, $0C8E, $084C, $0EE8, $0AA4, $0AEA, $04A4, $0EAE, $0C4A, $0EAA, $0E44, $0EEE, $08EE, $04AA, $0000 ;0x0 (0x00008FD6-0x00008FF4, Entry count: 0x1E)
	
loc_8FF4:
	dc.w	$0000
	dc.w	$0ECA, $0E88, $0C22, $0C8E, $080A, $022C, $0006, $02E8, $0082, $008E, $0048, $0EEE, $0AAA, $0666, $0000 ;0x0 (0x00008FF6-0x00009014, Entry count: 0x1E)
	
loc_9014:
	dc.w	$0000
	dc.w	$0AEA, $04C4, $0282, $04EE, $0288, $0E66, $0822, $0EE8, $0AA2, $088E, $022C, $0EEE, $0E8C, $0A48, $0000 ;0x0 (0x00009016-0x00009034, Entry count: 0x1E)
	
loc_9034:
	dc.w	$0000
	dc.w	$0EEA, $0EAA, $0E00, $0EAE, $0E0E, $0CAE, $000E, $0AEA, $00E0, $0AEE, $02AE, $0EEE, $0CCC, $0888, $0000 ;0x0 (0x00009036-0x00009054, Entry count: 0x1E)
	
loc_9054:
	dc.w	$0000
	dc.w	$0E8E, $0C0A, $0604, $0CAA, $0866, $08E8, $0282, $044C, $0028, $0ACE, $068A, $0EEE, $0AAE, $066A, $0000 ;0x0 (0x00009056-0x00009074, Entry count: 0x1E)


loc_9074:
	clr.w	($FF0036).l
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	$8(a6), a4
	move.l	$38(a4), d0
	move.w	d0, ($FF0042).l
	move.w	($FF0042).l, d0
	clr.l	d1
	move.w	($FF00C0).l, d1
	lea	(loc_8F54).l, a3
	lsl.l	#2, d1
	adda.l	d1, a3
	movea.l	(a3), a4
	lsl.l	#1, d0
	adda.l	d0, a4
	move.l	#$C03E0000, (a0)
	move.w	(a4), (a2)
	bsr.w	loc_9DDE
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	move.w	#1, ($FF0036).l
	jmp	(a3)
loc_90D0:
	clr.w	($FF0036).l
	link	a6, #0
	movem.l	a5/a4/d2/d1/d0, -(sp)
	movea.l	$8(a6), a4
	move.l	$38(a4), d0
	move.l	#0, d1
	move.w	($FF00C0).l, d1
	add.l	d1, d0
	bpl.w	loc_9102
	addi.l	#8, d0
	bra.w	loc_9112
loc_9102:
	cmpi.l	#8, d0
	blt.w	loc_9112
	subi.l	#8, d0
loc_9112:
	move.w	d0, ($FF00C0).l
	move.w	($FF00C0).l, d1
	lea	(loc_8F54).l, a3
	lsl.l	#2, d0
	adda.l	d0, a3
	clr.l	d5
	move.w	($FF0064).l, d5
	movea.l	#$5F8, a5
	lsl.w	#1, d5
	adda.l	d5, a5
	movea.l	(a3), a4
	adda.l	#2, a4
	move.w	#$E, d1
	move.l	#$C0000000, (a0)
	move.w	(a5), (a2)
loc_914E:
	move.w	(a4)+, (a2)
	dbf	d1, loc_914E
	clr.l	d0
	clr.l	d1
	move.w	($FF0042).l, d0
	move.w	($FF00C0).l, d1
	lea	(loc_8F54).l, a3
	lsl.l	#2, d1
	adda.l	d1, a3
	movea.l	(a3), a4
	lsl.l	#1, d0
	adda.l	d0, a4
	move.l	#$C03E0000, (a0)
	move.w	(a4), (a2)
	movem.l	(sp)+, d0/d1/a4/a5
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	move.w	#1, ($FF0036).l
	jmp	(a3)
loc_9192:
	link	a6, #0
	movem.l	a4/d2/d1/d0, -(sp)
	movea.l	$8(a6), a4
	move.l	$38(a4), d0
	clr.l	d1
	move.w	($FF0064).l, d1
	add.l	d1, d0
	bpl.w	loc_91B8
	move.l	#$F, d0	;Predicted (Code-scan)
	bra.s	loc_91C4	;Predicted (Code-scan)
loc_91B8:
	cmpi.l	#$10, d0
	blt.w	loc_91C4
	clr.l	d0
loc_91C4:
	move.w	d0, ($FF0064).l
	move.l	#$C0000000, (a0)
	movea.w	#$5F8, a3
	lsl.w	#1, d0
	adda.l	d0, a3
	move.w	(a3), (a2)
	cmpi.w	#0, ($FF0042).l
	bne.w	loc_920E
	clr.l	d0	;Predicted (Code-scan)
	clr.l	d1	;Predicted (Code-scan)
	move.w	($FF0042).l, d0	;Predicted (Code-scan)
	move.w	($FF00C0).l, d1	;Predicted (Code-scan)
	lea	(loc_8F54).l, a3	;Predicted (Code-scan)
	lsl.l	#2, d1	;Predicted (Code-scan)
	adda.l	d1, a3	;Predicted (Code-scan)
	movea.l	(a3), a4	;Predicted (Code-scan)
	lsl.l	#1, d0	;Predicted (Code-scan)
	adda.l	d0, a4	;Predicted (Code-scan)
	move.l	#$C03E0000, (a0)	;Predicted (Code-scan)
	move.w	(a4), (a2)	;Predicted (Code-scan)
loc_920E:
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	jmp	(a3)
loc_921C:
	clr.w	($FF0036).l
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	$8(a6), a4
	move.l	$38(a4), d0
	clr.w	($FF0064).l
	move.l	#$C0000000, (a0)
	movea.w	#$5F8, a3
	move.w	(a3), (a2)
	cmpi.w	#0, ($FF0042).l
	beq.w	loc_9260
	cmpi.w	#$C, ($FF0042).l
	beq.w	loc_9260
	bra.w	loc_9268
loc_9260:
	move.w	#$F, ($FF0042).l	;Predicted (Code-scan)
loc_9268:
	subi.w	#1, d0
	lsl.l	#2, d0
	movea.l	d0, a4
	adda.l	#$1791E, a4
	movea.l	(a4), a4
	jsr	(loc_3420).l
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	move.w	#1, ($FF0036).l
	jmp	(a3)
loc_9294:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	$8(a6), a4
	move.l	$38(a4), d0
	cmpi.l	#$AA20, ($FF0060).l
	bne.w	loc_92EE
	jsr	(loc_1106).l
	jsr	(loc_AACC).l
	move.w	#$1C, -(sp)
	jsr	(loc_9600).l
	jsr	(loc_9454).l
	move.l	#$9600, ($FF0060).l
	move.l	#$5654, ($FF0058).l
	move.w	#$A, ($FF003C).l
	bra.w	loc_92FE
loc_92EE:
	jsr	(loc_1106).l
	move.l	a6, -(sp)
	jsr	(loc_AB2A).l
	movea.l	(sp)+, a6
loc_92FE:
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	jmp	(a3)
loc_930C:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	$8(a6), a4
	move.l	$38(a4), d0
	move.l	#$5AE2, ($FF005C).l
	jsr	(loc_3962).l
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	jmp	(a3)
loc_933A:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	$8(a6), a4
	move.l	$38(a4), d0
	cmpi.l	#loc_ABDC, ($FF0060).l
	bne.w	loc_939A
	move.w	#$1C, -(sp)
	jsr	(loc_9600).l
	move.l	a6, -(sp)
	movea.l	($FF0096).l, a3
	jsr	(a3)
	jsr	(loc_AD5C).l
	movea.l	(sp)+, a6
	jsr	(loc_9454).l
	move.l	#$9600, ($FF0060).l
	move.l	#$5754, ($FF0058).l
	move.w	#$B, ($FF003C).l
	bra.w	loc_93D2
loc_939A:
	move.l	a6, -(sp)
	bsr.w	loc_963E
	move.l	#$5B2E, -(sp)
	move.l	#loc_56D4, -(sp)
	bsr.w	loc_9794
	jsr	(loc_444A).l
	move.l	#$5B2E, ($FF005C).l
	jsr	(loc_3A52).l
	move.l	#$ADD4, $00FF0026
	movea.l	(sp)+, a6
loc_93D2:
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	jmp	(a3)
loc_93E0:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	$8(a6), a4
	move.l	$38(a4), d0
	bsr.w	loc_963E
	move.l	#$5B2E, -(sp)
	move.l	#loc_56D4, -(sp)
	bsr.w	loc_9794
	jsr	(loc_444A).l
	move.l	#$5B2E, ($FF005C).l
	jsr	(loc_3A52).l
	move.l	#$3D86, $00FF0026
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	jmp	(a3)
loc_9432:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	$8(a6), a4
	move.l	$38(a4), d0
	bsr.w	loc_9454
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	jmp	(a3)
loc_9454:
	move.l	#$40000000, (a0)
	movea.l	#$FF32B4, a3
	move.w	#$45FF, d0
loc_9464:
	move.w	(a3)+, (a2)
	dbf	d0, loc_9464
	rts
loc_946C:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	$8(a6), a4
	move.l	$38(a4), d0
	cmpi.l	#$9600, ($FF0060).l
	bne.w	loc_9490
	jsr	(loc_5CE).l
loc_9490:
	jsr	(loc_5BA).l
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	jmp	(a3)
loc_94A4:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	$8(a6), a4
	move.l	$38(a4), d0
	cmpi.l	#$9600, ($FF0060).l
	beq.w	loc_94CC
	jsr	(loc_5BA).l
	bra.w	loc_94E0
loc_94CC:
	bsr.w	loc_963E
	move.l	#$5B08, -(sp)
	move.l	#$57D4, -(sp)
	bsr.w	loc_9794
loc_94E0:
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	jmp	(a3)
loc_94EE:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	$8(a6), a4
	move.l	$38(a4), d0
	move.w	d0, ($FF0040).l
	bsr.w	loc_9E48
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	jmp	(a3)
loc_9516:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	$8(a6), a4
	move.l	$38(a4), d0
	move.w	d0, -(sp)
	bsr.w	loc_9F7A
	cmpi.b	#5, d0
	bne.w	loc_9542
	move.l	#$16A2, ($FF0096).l
	bra.w	loc_95F2
loc_9542:
	cmpi.b	#6, d0
	bne.w	loc_9558
	move.l	#$1844, ($FF0096).l
	bra.w	loc_95F2
loc_9558:
	cmpi.b	#4, d0
	bne.w	loc_956E
	move.l	#$1784, ($FF0096).l
	bra.w	loc_95F2
loc_956E:
	cmpi.b	#1, d0
	bne.w	loc_9584
	move.l	#$1B24, ($FF0096).l
	bra.w	loc_95F2
loc_9584:
	cmpi.b	#2, d0
	bne.w	loc_959A
	move.l	#$1D70, ($FF0096).l
	bra.w	loc_95F2
loc_959A:
	cmpi.b	#0, d0
	bne.w	loc_95B0
	move.l	#$21A4, ($FF0096).l
	bra.w	loc_95F2
loc_95B0:
	cmpi.b	#7, d0
	bne.w	loc_95C6
	move.l	#$2CA8, ($FF0096).l
	bra.w	loc_95F2
loc_95C6:
	cmpi.b	#3, d0
	bne.w	loc_95DC
	move.l	#$2D82, ($FF0096).l
	bra.w	loc_95F2
loc_95DC:
	cmpi.b	#$C, d0
	bne.w	loc_95F2
	move.l	#$4AD0, ($FF0096).l
	bra.w	loc_95F2
loc_95F2:
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	jmp	(a3)
loc_9600:
	link	a6, #0
	movem.l	a4/a1/d3/d2/d1/d0, -(sp)
	move.w	$8(a6), d0
	lsl.w	#6, d0
	move.l	#$60000003, (a0)
	moveq	#0, d1
	moveq	#0, d2
loc_9618:
	move.w	d2, (a2)
	addq.w	#1, d1
	addq.w	#1, d2
	move.w	d1, d3
	andi.w	#$3F, d3
	bne.w	loc_962C
	subi.w	#$18, d2
loc_962C:
	dbf	d0, loc_9618
	movem.l	(sp)+, d0/d1/d2/d3/a1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#2, a7
	jmp	(a3)
loc_963E:
	link	a6, #0
	movem.l	a4/a1/d3/d2/d1/d0, -(sp)
	jsr	(loc_1106).l
	movea.l	($FF005C).l, a3
	_move.w	0(a3), -(sp)
	movea.l	($FF0060).l, a3
	jsr	(a3)
	cmpi.l	#loc_5ABC, ($FF005C).l
	bne.w	loc_9676
	jsr	(loc_AE9C).l
	bra.w	loc_968A
loc_9676:
	cmpi.l	#$5A96, ($FF005C).l
	bne.w	loc_968A
	jsr	(loc_AB80).l
loc_968A:
	cmpi.l	#$9600, ($FF0060).l
	bne.w	loc_969E
	jsr	(loc_5CE).l
loc_969E:
	cmpi.l	#$5AE2, ($FF005C).l
	bne.w	loc_96BA
	move.l	#$5714, ($FF0058).l
	bra.w	loc_96D6
loc_96BA:
	cmpi.l	#$5B08, ($FF005C).l
	bne.w	loc_96D6
	move.l	#$5614, ($FF0058).l
	bra.w	loc_96D6
loc_96D6:
	cmpi.l	#$9600, ($FF0060).l
	bne.w	loc_96EE
	move.l	#$5A70, ($FF005C).l
loc_96EE:
	movem.l	(sp)+, d0/d1/d2/d3/a1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#0, a7
	jmp	(a3)
loc_96FC:
	move.w	#$3F, d0
loc_9700:
	move.w	(a5)+, d3
	add.w	d2, d3
	move.w	d3, (a2)
	addq.w	#1, d1
	move.w	d1, d3
	andi.w	#$3F, d3
	bne.w	loc_9718
	suba.l	#$30, a5
loc_9718:
	dbf	d0, loc_9700
	rts
loc_971E:
	lea	(loc_89B4).l, a1
	moveq	#$5F, d0
	move.l	#$4C000002, (a0)
loc_972C:
	move.w	(a1)+, (a2)
	dbf	d0, loc_972C
	lea	(loc_8A74).l, a1
	move.w	#$8F, d0
loc_973C:
	move.w	(a1)+, (a2)
	dbf	d0, loc_973C
	lea	(loc_8B94).l, a1
	move.w	#$7F, d0
loc_974C:
	move.w	(a1)+, (a2)
	dbf	d0, loc_974C
	lea	(loc_8C94).l, a1
	move.w	#$3F, d0
loc_975C:
	move.w	(a1)+, (a2)
	dbf	d0, loc_975C
	lea	(loc_8D14).l, a1
	move.w	#$F, d0
loc_976C:
	move.w	(a1)+, (a2)
	dbf	d0, loc_976C
	lea	(loc_8D34).l, a1
	move.w	#$8F, d0
loc_977C:
	move.w	(a1)+, (a2)
	dbf	d0, loc_977C
	lea	(loc_8E54).l, a1
	move.w	#$7F, d0
loc_978C:
	move.w	(a1)+, (a2)
	dbf	d0, loc_978C
	rts
loc_9794:
	link	a6, #0
	movem.l	a5/a4/a1/d4/d3/d2/d1/d0, -(sp)
	movea.l	$C(a6), a4
	movea.l	$10(a4), a3
	jsr	(a3)
	cmpi.w	#0, ($FF000E).l
	beq.w	loc_9848
	move.l	#$A078, ($FF008C).l	;Predicted (Code-scan)
	move.l	#$9FC2, ($FF009E).l	;Predicted (Code-scan)
	move.l	#$A122, ($FF00A2).l	;Predicted (Code-scan)
	move.l	#$9D36, ($FF0084).l	;Predicted (Code-scan)
	lea	(loc_111E).l, a3	;Predicted (Code-scan)
	move.l	a3, ($FF0088).l	;Predicted (Code-scan)
	move.l	a3, ($FF0070).l	;Predicted (Code-scan)
	move.l	a3, ($FF0074).l	;Predicted (Code-scan)
	move.l	a3, ($FF0068).l	;Predicted (Code-scan)
	move.l	a3, ($FF006C).l	;Predicted (Code-scan)
	move.l	a3, ($FF009A).l	;Predicted (Code-scan)
	move.l	a3, ($FF0080).l	;Predicted (Code-scan)
	move.l	a3, ($FF007C).l	;Predicted (Code-scan)
	movea.l	$C(a6), a4	;Predicted (Code-scan)
	move.l	a4, ($FF005C).l	;Predicted (Code-scan)
	bsr.w	loc_A122	;Predicted (Code-scan)
	cmpa.l	#$5B08, a4	;Predicted (Code-scan)
	beq.w	loc_9836	;Predicted (Code-scan)
	move.l	#$9BA4, ($FF0078).l	;Predicted (Code-scan)
	bra.w	loc_983E	;Predicted (Code-scan)
loc_9836:
	move.l	$14(a4), ($FF0078).l	;Predicted (Code-scan)
loc_983E:
	clr.w	($FF0094).l	;Predicted (Code-scan)
	bra.w	loc_98F4	;Predicted (Code-scan)
loc_9848:
	move.l	#$111E, ($FF008C).l
	move.l	#$111E, ($FF0088).l
	move.l	#$9FC2, ($FF009E).l
	move.l	#$111E, ($FF009A).l
	movea.l	$8(a6), a4
	move.l	a4, ($FF0058).l
	lea	(loc_9974).l, a3
	move.l	a3, ($FF0070).l
	lea	(loc_9A00).l, a3
	move.l	a3, ($FF0074).l
	lea	(loc_9A8C).l, a3
	move.l	a3, ($FF0068).l
	lea	(loc_9B18).l, a3
	move.l	a3, ($FF006C).l
	lea	(loc_9BA4).l, a3
	move.l	a3, ($FF007C).l
	lea	(loc_9D36).l, a3
	move.l	a3, ($FF0084).l
	lea	(loc_9C10).l, a3
	move.l	a3, ($FF0080).l
	movea.l	$8(a6), a4
	move.l	a4, -(sp)
	jsr	(loc_9D9C).l
	movea.l	$C(a6), a4
	move.l	a4, ($FF005C).l
	movea.l	$14(a4), a3
	move.l	a3, ($FF0078).l
	clr.w	($FF0094).l
loc_98F4:
	move.l	$20(a4), (a0)
	move.w	$2(a4), d0
	lsl.l	#4, d0
	movea.l	$8(a4), a1
loc_9902:
	move.w	(a1)+, (a2)
	dbf	d0, loc_9902
	move.l	#$60000003, (a0)
	clr.w	d1
	movea.l	$4(a4), a5
	move.w	$24(a4), d2
	_move.w	0(a4), d4
	subi.w	#1, d4
	movea.l	$C(a4), a1
loc_9924:
	jsr	(a1)
	dbf	d4, loc_9924
	move.w	($FF003C).l, -(sp)
	bsr.w	loc_9F7A
	cmpi.w	#0, ($FF000E).l
	bne.w	loc_9948
	bsr.w	loc_9EA0
	bra.w	loc_995E
loc_9948:
	cmpi.l	#$5B08, ($FF005C).l	;Predicted (Code-scan)
	beq.w	loc_995E	;Predicted (Code-scan)
	bsr.w	loc_9F24	;Predicted (Code-scan)
	bsr.w	loc_9F48	;Predicted (Code-scan)
loc_995E:
	bsr.w	loc_9DDE
	bsr.w	loc_9E48
	movem.l	(sp)+, d0/d1/d2/d3/d4/a1/a4/a5
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#8, a7
	jmp	(a3)
loc_9974:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	($FF0058).l, a4
	move.l	($FF00B0).l, d0
	sub.l	($FF00B4).l, d0
	cmpi.l	#$10, d0
	blt.w	loc_99F2
	move.l	($FF00B0).l, ($FF00B4).l
	cmpi.l	#$5A96, ($FF005C).l
	bne.w	loc_99B8
	movea.l	$4(a4), a4
	bra.w	loc_99D2
loc_99B8:
	cmpi.l	#loc_5ABC, ($FF005C).l
	bne.w	loc_99CE
	movea.l	$8(a4), a4
	bra.w	loc_99D2
loc_99CE:
	_movea.l	0(a4), a4
loc_99D2:
	move.l	a4, -(sp)
	jsr	(loc_9D9C).l
	move.l	#1, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	move.l	a4, ($FF0058).l
loc_99F2:
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#0, a7
	jmp	(a3)
loc_9A00:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	($FF0058).l, a4
	move.l	($FF00B0).l, d0
	sub.l	($FF00B4).l, d0
	cmpi.l	#$10, d0
	blt.w	loc_9A7E
	move.l	($FF00B0).l, ($FF00B4).l
	cmpi.l	#$5A96, ($FF005C).l
	bne.w	loc_9A44
	movea.l	$1C(a4), a4
	bra.w	loc_9A5E
loc_9A44:
	cmpi.l	#loc_5ABC, ($FF005C).l
	bne.w	loc_9A5A
	movea.l	$20(a4), a4
	bra.w	loc_9A5E
loc_9A5A:
	movea.l	$18(a4), a4
loc_9A5E:
	move.l	a4, -(sp)
	jsr	(loc_9D9C).l
	move.l	#1, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	move.l	a4, ($FF0058).l
loc_9A7E:
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#0, a7
	jmp	(a3)
loc_9A8C:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	($FF0058).l, a4
	move.l	($FF00B0).l, d0
	sub.l	($FF00B4).l, d0
	cmpi.l	#$10, d0
	blt.w	loc_9B0A
	move.l	($FF00B0).l, ($FF00B4).l
	cmpi.l	#$5A96, ($FF005C).l
	bne.w	loc_9AD0
	movea.l	$10(a4), a4
	bra.w	loc_9AEA
loc_9AD0:
	cmpi.l	#loc_5ABC, ($FF005C).l
	bne.w	loc_9AE6
	movea.l	$14(a4), a4
	bra.w	loc_9AEA
loc_9AE6:
	movea.l	$C(a4), a4
loc_9AEA:
	move.l	a4, -(sp)
	jsr	(loc_9D9C).l
	move.l	#1, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	move.l	a4, ($FF0058).l
loc_9B0A:
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#0, a7
	jmp	(a3)
loc_9B18:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	($FF0058).l, a4
	move.l	($FF00B0).l, d0
	sub.l	($FF00B4).l, d0
	cmpi.l	#$10, d0
	blt.w	loc_9B96
	move.l	($FF00B0).l, ($FF00B4).l
	cmpi.l	#$5A96, ($FF005C).l
	bne.w	loc_9B5C
	movea.l	$28(a4), a4
	bra.w	loc_9B76
loc_9B5C:
	cmpi.l	#loc_5ABC, ($FF005C).l
	bne.w	loc_9B72
	movea.l	$2C(a4), a4
	bra.w	loc_9B76
loc_9B72:
	movea.l	$24(a4), a4
loc_9B76:
	move.l	a4, -(sp)
	jsr	(loc_9D9C).l
	move.l	#1, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	move.l	a4, ($FF0058).l
loc_9B96:
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#0, a7
	jmp	(a3)
loc_9BA4:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	($FF0058).l, a4
	cmpa.l	#0, a4
	beq.w	loc_9C02
	move.l	($FF00B0).l, d0
	sub.l	($FF00B4).l, d0
	cmpi.l	#$10, d0
	blt.w	loc_9C02
	move.l	($FF00B0).l, ($FF00B4).l
	move.l	#4, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	cmpi.l	#0, $34(a4)
	beq.w	loc_9C02
	move.l	a4, -(sp)
	movea.l	$34(a4), a3
	jsr	(a3)
loc_9C02:
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#0, a7
	jmp	(a3)
loc_9C10:
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	($FF0058).l, a4
	move.l	($FF00B0).l, d0
	sub.l	($FF00B4).l, d0
	cmpi.l	#$10, d0
	blt.w	loc_9C4A
	move.l	($FF00B0).l, ($FF00B4).l
	jsr	(loc_F2C).l
	jsr	(loc_9EA0).l
loc_9C4A:
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#0, a7
	jmp	(a3)
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	movea.l	($FF0058).l, a4
	move.l	($FF00B0).l, d0
	sub.l	($FF00B4).l, d0
	cmpi.l	#$10, d0
	blt.w	loc_9D28
	move.l	($FF00B0).l, ($FF00B4).l
	cmpi.l	#0, $34(a4)
	beq.w	loc_9D28
	cmpa.l	#$5714, a4
	beq.w	loc_9CE4
	cmpa.l	#loc_56D4, a4
	beq.w	loc_9CE4
	cmpa.l	#$5614, a4
	beq.w	loc_9CE4
	cmpa.l	#$5754, a4
	beq.w	loc_9CE4
	cmpa.l	#$5654, a4
	beq.w	loc_9CE4
	cmpi.l	#$5694, ($FF0058).l
	beq.w	loc_9CD6
	bsr.w	loc_963E
loc_9CD6:
	move.l	#3, -(sp)
	move.w	#1, d4
	bra.w	loc_9CEE
loc_9CE4:
	move.l	#4, -(sp)
	move.w	#0, d4
loc_9CEE:
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	move.l	a4, -(sp)
	movea.l	$34(a4), a3
	jsr	(a3)
	cmpi.l	#$5694, ($FF0058).l
	bne.w	loc_9D14
	bsr.w	loc_963E
loc_9D14:
	cmpi.w	#0, d4
	beq.w	loc_9D28
	move.l	a6, -(sp)
	movea.l	($FF0096).l, a3
	jsr	(a3)
	movea.l	(sp)+, a6
loc_9D28:
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#0, a7
	jmp	(a3)
loc_9D36:
	clr.w	($FF0036).l
	link	a6, #0
	movem.l	a4/d1/d0, -(sp)
	move.l	($FF00B0).l, d0
	sub.l	($FF00B4).l, d0
	cmpi.l	#$10, d0
	blt.w	loc_9D86
	move.l	($FF00B0).l, ($FF00B4).l
	move.l	a6, -(sp)
	move.l	#3, -(sp)
	jsr	(loc_A3E2).l
	adda.l	#4, a7
	bsr.w	loc_963E
	movea.l	($FF0096).l, a3
	jsr	(a3)
	movea.l	(sp)+, a6
loc_9D86:
	movem.l	(sp)+, d0/d1/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#0, a7
	move.w	#1, ($FF0036).l
	jmp	(a3)
loc_9D9C:
	link	a6, #0
	movem.l	a4/d0, -(sp)
	movea.l	$8(a6), a4
	move.l	#$5C000003, (a0)
	move.w	$3E(a4), d0
	addi.w	#$80, d0
	move.w	d0, (a2)
	move.w	$32(a4), (a2)
	move.w	$30(a4), d0
	ori.w	#$C000, d0
	move.w	d0, (a2)
	move.w	$3C(a4), d0
	addi.w	#$80, d0
	move.w	d0, (a2)
	movem.l	(sp)+, d0/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#4, a7
	jmp	(a3)
loc_9DDE:
	link	a6, #0
	movem.l	a4/d7/d6/d5/d4/d3/d2/d1/d0, -(sp)
	move.w	#$94, d0
	move.w	($FF0042).l, d1
	andi.w	#3, d1
	lsl.w	#4, d1
	add.w	d1, d0
	move.w	($FF0042).l, d1
	andi.w	#$FFFC, d1
	lsl.w	#1, d1
	addi.w	#$A0, d1
	move.l	#$5C080003, (a0)
	move.w	d1, (a2)
	move.w	#2, (a2)
	move.w	#$C47B, (a2)
	move.w	d0, (a2)
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/d6/d7/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#0, a7
	jmp	(a3)
loc_9E28:
	move.l	$38(a4), d2
	cmp.w	($FF0040).l, d2
	bne.w	loc_9E46
	move.w	$3E(a4), d1
	addi.w	#$82, d1
	move.w	$3C(a4), d0
	addi.w	#$75, d0
loc_9E46:
	rts
loc_9E48:
	link	a6, #0
	movem.l	a4/d7/d6/d5/d4/d3/d2/d1/d0, -(sp)
	clr.w	d0
	movea.l	#$5554, a4
	bsr.w	loc_9E28
	cmpi.w	#0, d0
	bne.w	loc_9E80
	movea.l	#$5594, a4
	bsr.w	loc_9E28
	cmpi.w	#0, d0
	bne.w	loc_9E80
	movea.l	#$55D4, a4
	bsr.w	loc_9E28
loc_9E80:
	move.l	#$5C100003, (a0)
	move.w	d1, (a2)
	move.w	#3, (a2)
	move.w	#$C47B, (a2)
	move.w	d0, (a2)
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/d6/d7/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#0, a7
	jmp	(a3)
loc_9EA0:
	link	a6, #0
	movem.l	a4/d7/d6/d5/d4/d3/d2/d1/d0, -(sp)
	cmpi.l	#$5A70, ($FF005C).l
	beq.w	loc_9ED6
	cmpi.l	#$5A96, ($FF005C).l
	beq.w	loc_9ED6
	cmpi.l	#loc_5ABC, ($FF005C).l
	beq.w	loc_9ED6
	bra.w	loc_9F16
loc_9ED6:
	moveq	#6, d0
loc_9ED8:
	move.l	d0, d1
	lsl.l	#6, d1
	addi.l	#$1E, d1
	lsl.l	#1, d1
	lsl.l	#8, d1
	lsl.l	#8, d1
	addi.l	#$60000003, d1
	move.l	d1, (a0)
	move.w	#6, d2
	sub.l	d0, d2
	cmp.w	($FF0044).l, d2
	ble.w	loc_9F08
	move.w	#$648E, (a2)
	bra.w	loc_9F0C
loc_9F08:
	move.w	#$64B1, (a2)
loc_9F0C:
	subq.w	#1, d0
	cmpi.w	#1, d0
	bgt.w	loc_9ED8
loc_9F16:
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/d6/d7/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#0, a7
	jmp	(a3)
loc_9F24:
	movem.l	d1/d0, -(sp)	;Predicted (Code-scan)
	move.l	#$60BC0003, d1	;Predicted (Code-scan)
	move.w	#6, d0	;Predicted (Code-scan)
loc_9F32:
	move.l	d1, (a0)	;Predicted (Code-scan)
	move.w	#$6499, (a2)	;Predicted (Code-scan)
	addi.l	#$800000, d1	;Predicted (Code-scan)
	dbf	d0, loc_9F32	;Predicted (Code-scan)
	movem.l	(sp)+, d0/d1	;Predicted (Code-scan)
	rts	;Predicted (Code-scan)
loc_9F48:
	movem.l	d2/d1/d0, -(sp)	;Predicted (Code-scan)
	move.l	#$61180003, d2	;Predicted (Code-scan)
	move.w	#2, d0	;Predicted (Code-scan)
loc_9F56:
	move.w	#2, d1	;Predicted (Code-scan)
loc_9F5A:
	move.l	d2, (a0)	;Predicted (Code-scan)
	move.w	#$648F, (a2)	;Predicted (Code-scan)
	addi.l	#$20000, d2	;Predicted (Code-scan)
	dbf	d1, loc_9F5A	;Predicted (Code-scan)
	addi.l	#$7A0000, d2	;Predicted (Code-scan)
	dbf	d0, loc_9F56	;Predicted (Code-scan)
	movem.l	(sp)+, d0/d1/d2	;Predicted (Code-scan)
	rts	;Predicted (Code-scan)
loc_9F7A:
	link	a6, #0
	movem.l	a5/a4/d7/d6/d5/d4/d3/d2/d1/d0, -(sp)
	move.w	$8(a6), d0
	lsl.w	#2, d0
	movea.l	#$4D60, a5
	adda.l	d0, a5
	movea.l	(a5), a4
	move.l	#$5C180003, (a0)
	move.w	$3E(a4), d0
	addi.w	#$7F, d0
	move.w	d0, (a2)
	move.w	#$A00, (a2)
	move.w	#$C47C, (a2)
	move.w	$3C(a4), d0
	addi.w	#$7F, d0
	move.w	d0, (a2)
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/d6/d7/a4
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#2, a7
	jmp	(a3)
loc_9FC2:
	movem.l	a3/d0, -(sp)
	clr.l	d0
	move.b	$00FF0054, d0
	cmpi.b	#2, d0
	bgt.w	loc_9FE0
	addq.b	#1, $00FF0054
	bra.w	loc_A020
loc_9FE0:
	clr.b	$00FF0054
	cmpi.w	#$E, $00FF0054
	blt.w	loc_9FFC
	clr.w	$00FF0054
	bra.w	loc_A002
loc_9FFC:
	addq.w	#1, $00FF0054
loc_A002:
	move.w	$00FF0054, d0
	movea.l	#$5F8, a3
	adda.l	#$40, a3
	lsl.l	#1, d0
	adda.l	d0, a3
	move.l	#$C05E0000, (a0)
	move.w	(a3), (a2)
loc_A020:
	movem.l	(sp)+, d0/a3
	rts
	dc.b	$0C, $40, $04, $60, $66, $00, $00, $0C, $32, $3C, $00, $10, $34, $3C, $00, $08
	dc.b	$4E, $75, $0C, $40, $04, $66, $66, $00, $00, $0C, $32, $3C, $00, $10, $34, $3C ;0x0 (0x0000A026-0x0000A122, Entry count: 0xFC) [Unknown data]
	dc.b	$00, $10, $4E, $75, $0C, $40, $04, $85, $66, $00, $00, $0C, $32, $3C, $00, $18
	dc.b	$34, $3C, $00, $0A, $4E, $75, $0C, $40, $04, $6F, $66, $00, $00, $0C, $32, $3C ;0x20
	dc.b	$00, $1E, $34, $3C, $00, $0C, $4E, $75, $32, $3C, $00, $0A, $34, $3C, $00, $0A
	dc.b	$4E, $75, $48, $E7, $FC, $0E, $42, $45, $28, $79, $00, $FF, $00, $5C, $2A, $6C ;0x40
	dc.b	$00, $18, $2C, $5D, $BD, $FC, $00, $00, $00, $00, $67, $00, $00, $26, $30, $2E
	dc.b	$00, $30, $61, $00, $FF, $8C, $38, $2E, $00, $3E, $52, $44, $36, $2E, $00, $3C ;0x60
	dc.b	$52, $43, $61, $00, $00, $F2, $0C, $45, $00, $00, $67, $00, $FF, $D6, $60, $00
	dc.b	$00, $44, $2A, $6C, $00, $1C, $2C, $5D, $BD, $FC, $00, $00, $00, $00, $67, $00 ;0x80
	dc.b	$00, $26, $30, $2E, $00, $30, $61, $00, $FF, $58, $38, $2E, $00, $3E, $52, $44
	dc.b	$36, $2E, $00, $3C, $52, $43, $61, $00, $00, $BE, $0C, $45, $00, $00, $67, $00 ;0xA0
	dc.b	$FF, $D6, $60, $00, $00, $10, $61, $00, $00, $62, $42, $B9, $00, $FF, $00, $58
	dc.b	$60, $00, $00, $24, $20, $BC, $5C, $00, $00, $03, $06, $44, $00, $7F, $34, $84 ;0xC0
	dc.b	$34, $AE, $00, $32, $00, $40, $C0, $00, $34, $80, $06, $43, $00, $7F, $34, $83
	dc.b	$23, $CE, $00, $FF, $00, $58, $4C, $DF, $70, $3F, $4E, $75 ;0xE0
loc_A122:
	move.l	#$5C000003, (a0)	;Predicted (Code-scan)
	move.w	#0, (a2)	;Predicted (Code-scan)
	cmpi.l	#$5B08, ($FF005C).l	;Predicted (Code-scan)
	beq.w	loc_A142	;Predicted (Code-scan)
	move.w	#1, (a2)	;Predicted (Code-scan)
	bra.w	loc_A146	;Predicted (Code-scan)
loc_A142:
	move.w	#0, (a2)	;Predicted (Code-scan)
loc_A146:
	move.w	#0, (a2)	;Predicted (Code-scan)
	move.w	#0, (a2)	;Predicted (Code-scan)
	rts	;Predicted (Code-scan)
	dc.b	$48, $E7, $80, $00, $20, $BC, $5C, $00, $00, $03, $30, $39, $00, $FF, $00, $06
	dc.b	$06, $40, $00, $78, $34, $80, $0C, $B9, $00, $00, $5B, $08, $00, $FF, $00, $5C ;0x0 (0x0000A150-0x0000A1DC, Entry count: 0x8C) [Unknown data]
	dc.b	$67, $00, $00, $0A, $34, $BC, $05, $01, $60, $00, $00, $06, $34, $BC, $05, $00
	dc.b	$30, $3C, $04, $77, $00, $40, $C0, $00, $34, $80, $30, $39, $00, $FF, $00, $04 ;0x20
	dc.b	$06, $40, $00, $78, $34, $80, $4C, $DF, $00, $01, $4E, $75, $48, $A7, $78, $00
	dc.b	$D2, $43, $D4, $44, $B6, $79, $00, $FF, $00, $04, $6C, $00, $00, $28, $B2, $79 ;0x40
	dc.b	$00, $FF, $00, $04, $6D, $00, $00, $1E, $B8, $79, $00, $FF, $00, $06, $6C, $00
	dc.b	$00, $14, $B4, $79, $00, $FF, $00, $06, $6D, $00, $00, $0A, $3A, $3C, $00, $01 ;0x60
	dc.b	$60, $00, $00, $04, $42, $45, $4C, $9F, $00, $1E, $4E, $75 ;0x80
loc_A1DC:
	dc.l	loc_A208	;Predicted
	dc.l	loc_A21A
	dc.l	loc_A224
	dc.l	loc_A24A
	dc.l	loc_A270
	dc.l	loc_A27E
	dc.l	loc_A288
	dc.l	loc_A292
	dc.l	loc_A29C
	dc.l	loc_A2A6
	dc.b	$00, $00, $A3, $04 ;0x0 (0x0000A204-0x0000A208, Entry count: 0x4) [Unknown data]
loc_A208:
	dc.b	$00, $00, $A3, $0E, $2A, $DD, $00, $03, $2B, $9C, $00, $03, $2A, $DD, $00, $03, $00, $00 ;0x0 (0x0000A208-0x0000A21A, Entry count: 0x12) [Unknown data]
loc_A21A:
	dc.l	loc_A32A
	dc.b	$27, $10, $00, $08, $00, $00 ;0x0 (0x0000A21E-0x0000A224, Entry count: 0x6) [Unknown data]
loc_A224:
	dc.l	loc_A30E
	dc.w	$2269, $000F, $22B4, $0000, $2309, $0000, $2337, $0000, $239C, $0000, $240D, $0000, $248C, $0000, $2A69, $0000 ;0x0 (0x0000A228-0x0000A248, Entry count: 0x20)
	dc.b	$00, $00 ;0x0 (0x0000A248-0x0000A24A, Entry count: 0x2) [Unknown data]
loc_A24A:
	dc.l	loc_A30E
	dc.w	$2A69, $000F, $248C, $0000, $240D, $0000, $239C, $0000, $2337, $0000, $2309, $0000, $22B4, $0000, $2269, $0000 ;0x0 (0x0000A24E-0x0000A26E, Entry count: 0x20)
	dc.b	$00, $00 ;0x0 (0x0000A26E-0x0000A270, Entry count: 0x2) [Unknown data]
loc_A270:
	dc.l	loc_A346
	dc.w	$2B9C, $0005, $2B9C, $0005 ;0x0 (0x0000A274-0x0000A27C, Entry count: 0x8)
	dc.b	$00, $00 ;0x0 (0x0000A27C-0x0000A27E, Entry count: 0x2) [Unknown data]
loc_A27E:
	dc.l	loc_A362
	dc.b	$1A, $69, $00, $06, $00, $00 ;0x0 (0x0000A282-0x0000A288, Entry count: 0x6) [Unknown data]
loc_A288:
	dc.l	loc_A37E
	dc.b	$2A, $69, $00, $05, $00, $00 ;0x0 (0x0000A28C-0x0000A292, Entry count: 0x6) [Unknown data]
loc_A292:
	dc.l	loc_A37E
	dc.b	$2A, $69, $00, $0A, $00, $00 ;0x0 (0x0000A296-0x0000A29C, Entry count: 0x6) [Unknown data]
loc_A29C:
	dc.l	loc_A39A
	dc.b	$1A, $69, $00, $05, $00, $00 ;0x0 (0x0000A2A0-0x0000A2A6, Entry count: 0x6) [Unknown data]
loc_A2A6:
	dc.l	loc_A30E
	dc.w	$1A69, $000A, $1AB4, $000A, $1B09, $000A, $1B37, $000A, $1B9C, $000A, $1C0D, $000A, $1C8C, $000A, $2269, $000A
	dc.w	$22B4, $000A, $2309, $000A, $2337, $000A, $239C, $000A, $240D, $000A, $248C, $000A, $2A69, $000A, $2AB4, $000A ;0x0 (0x0000A2AA-0x0000A302, Entry count: 0x58)
	dc.w	$2B09, $000A, $2B37, $000A, $2B9C, $000A, $2C0D, $000A, $2C8C, $000A, $3269, $000A ;0x20
	dc.b	$00, $00, $00, $00, $A3, $B6, $32, $69, $00, $B4, $00, $00 ;0x0 (0x0000A302-0x0000A30E, Entry count: 0xC) [Unknown data]
loc_A30E:
	dc.b	$07, $00, $32, $E0, $00, $23, $5F, $05, $02, $11, $03, $26, $5F, $05, $02, $11
	dc.b	$7D, $1E, $99, $05, $02, $11, $31, $00, $94, $07, $02, $A6 ;0x0 (0x0000A30E-0x0000A32A, Entry count: 0x1C)
loc_A32A:
	dc.b	$0F, $00, $07, $C7, $01, $3C, $15, $13, $00, $FF, $01, $3C, $15, $13, $00, $FF
	dc.b	$00, $04, $15, $13, $00, $FF, $00, $04, $15, $13, $00, $FF ;0x0 (0x0000A32A-0x0000A346, Entry count: 0x1C)
loc_A346:
	dc.b	$09, $00, $03, $F5, $70, $7F, $5F, $1D, $1F, $90, $71, $00, $1F, $00, $18, $03
	dc.b	$61, $2B, $5D, $0F, $1F, $F3, $70, $00, $15, $13, $0C, $06 ;0x0 (0x0000A346-0x0000A362, Entry count: 0x1C)
loc_A362:
	dc.b	$07, $00, $3A, $C7, $71, $00, $5E, $81, $01, $1D, $72, $00, $53, $8F, $00, $E9
	dc.b	$60, $7F, $5D, $8F, $1F, $FF, $70, $00, $1F, $80, $0C, $06 ;0x0 (0x0000A362-0x0000A37E, Entry count: 0x1C)
loc_A37E:
	dc.b	$04, $00, $3E, $E0, $0F, $00, $1C, $1C, $01, $01, $00, $7F, $0F, $0F, $01, $17
	dc.b	$00, $00, $1D, $9C, $01, $06, $00, $7F, $0B, $11, $01, $07 ;0x0 (0x0000A37E-0x0000A39A, Entry count: 0x1C)
loc_A39A:
	dc.b	$0C, $00, $0E, $C7, $01, $0F, $1E, $81, $01, $01, $01, $00, $1F, $10, $01, $EF
	dc.b	$03, $00, $19, $09, $0A, $65, $01, $00, $19, $09, $0A, $65 ;0x0 (0x0000A39A-0x0000A3B6, Entry count: 0x1C)
	dc.b	$01, $00, $3D, $E7, $0F, $00, $1F, $1F, $01, $0E, $00, $7F, $1F, $10, $01, $F5
	dc.b	$0F, $00, $1F, $1F, $0A, $79, $0F, $00, $06, $16, $08, $19, $02, $69, $02, $B4 ;0x0 (0x0000A3B6-0x0000A3E2, Entry count: 0x2C) [Unknown data]
	dc.b	$03, $09, $03, $37, $03, $9C, $04, $0D, $04, $8F, $0A, $69 ;0x20
loc_A3E2:
	cmpi.b	#0, $00FF00F9
	bne.w	loc_A4C2
	link	a6, #-24
	movem.l	a1/a0/d2/d1/d0, -(a6)
	move.l	$20(sp), d0
	lea	(loc_A1DC).l, a0
	lsl.l	#2, d0
	adda.l	d0, a0
	movea.l	(a0), a0
	movea.l	(a0)+, a1
	move.l	a0, d0
	move.l	d0, $00FF01DE
	jsr	(loc_A55E).l
	move.b	#$22, $00A04000
	move.b	(a1)+, $00A04001
	jsr	(loc_A55E).l
	move.b	#$27, $00A04000
	move.b	(a1)+, $00A04001
	jsr	(loc_A55E).l
	move.b	#$B2, $00A04002
	move.b	(a1)+, $00A04003
	jsr	(loc_A55E).l
	move.b	#$B6, $00A04002
	move.b	(a1)+, $00A04003
	move.l	#3, d0
	move.l	#5, d1
	move.l	#$32, d2
loc_A472:
	jsr	(loc_A55E).l
	move.b	d2, $00A04002
	move.b	(a1)+, $00A04003
	addi.b	#$10, d2
	dbf	d1, loc_A472
	subi.b	#$60, d2
	addi.b	#4, d2
	move.l	#5, d1
	dbf	d0, loc_A472
	jsr	(loc_A55E).l
	move.b	#$28, $00A04000
	move.b	#6, $00A04001
	movem.l	(a6)+, d0/d1/d2/a0/a1
	unlk	a6
	move.b	#1, $00FF00F9
loc_A4C2:
	rts
loc_A4C4:
	cmpi.b	#0, $00FF00F9
	beq.w	loc_A54C
	movea.l	$00FF01DE, a0
	cmpi.w	#0, $00FF01E2
	beq.w	loc_A4EE
	subi.w	#1, $00FF01E2
	bra.w	loc_A54C
loc_A4EE:
	jsr	(loc_A584).l
	move.w	(a0)+, d0
	cmpi.w	#0, d0
	bne.w	loc_A502
	bra.w	loc_A544
loc_A502:
	ror.l	#8, d0
	jsr	(loc_A55E).l
	move.b	#$A6, $00A04002
	move.b	d0, $00A04003
	rol.l	#8, d0
	jsr	(loc_A55E).l
	move.b	#$A2, $00A04002
	move.b	d0, $00A04003
	move.w	(a0)+, $00FF01E2
	move.l	a0, $00FF01DE
	jsr	(loc_A56C).l
	bra.w	loc_A54C
loc_A544:
	move.b	#0, $00FF00F9
loc_A54C:
	rts
loc_A54E:
	jsr	(loc_A584).l
	move.b	#0, $00FF00F9
	rts
loc_A55E:
	btst	#7, $00A04000
	bne.w	loc_A55E
	rts
loc_A56C:
	jsr	(loc_A55E).l
	move.b	#$28, $00A04000
	move.b	#$F6, $00A04001
	rts
loc_A584:
	jsr	(loc_A55E).l
	move.b	#$28, $00A04000
	move.b	#6, $00A04001
	rts
loc_A59C:
	dc.b	$00, $00 ;0x0 (0x0000A59C-0x0000A59E, Entry count: 0x2) [Unknown data]
	dc.b	$32, $C0, $02, $02, $96, $16, $02, $F1, $03, $26, $5F, $05, $02, $11, $7D, $2D
	dc.b	$99, $05, $02, $11, $31, $0A, $94, $07, $02, $A6 ;0x0 (0x0000A59E-0x0000A5B8, Entry count: 0x1A)
	dc.b	$1F, $FF, $1F, $FF, $1F, $FF, $1F, $FF, $0F, $00, $08, $00 ;0x0 (0x0000A5B8-0x0000A5C4, Entry count: 0xC) [Unknown data]
	dc.b	$17, $A3, $32, $01, $CD, $00, $00, $08, $22, $10, $87, $80, $01, $08, $32, $10
	dc.b	$08, $00, $00, $08, $52, $10, $88, $80, $00, $08 ;0x0 (0x0000A5C4-0x0000A5DE, Entry count: 0x1A)
	dc.b	$1F, $FF, $1F, $FF, $1F, $FF, $1F, $FF, $0F, $00, $08, $00 ;0x0 (0x0000A5DE-0x0000A5EA, Entry count: 0xC) [Unknown data]
	dc.b	$17, $63, $32, $01, $CD, $00, $00, $08, $22, $10, $87, $80, $01, $08, $32, $10
	dc.b	$08, $00, $00, $08, $52, $10, $88, $80, $00, $08 ;0x0 (0x0000A5EA-0x0000A604, Entry count: 0x1A)
	dc.b	$1F, $FF, $1F, $FF, $1F, $FF, $1F, $FF, $0F, $00, $0A, $00 ;0x0 (0x0000A604-0x0000A610, Entry count: 0xC) [Unknown data]
	dc.b	$17, $C2, $00, $10, $19, $00, $00, $0F, $00, $10, $1C, $00, $00, $68, $00, $10
	dc.b	$1B, $00, $00, $0F, $00, $10, $19, $06, $00, $2F ;0x0 (0x0000A610-0x0000A62A, Entry count: 0x1A)
	dc.b	$1F, $FF, $1F, $FF, $1F, $FF, $1F, $FF, $0F, $00, $00, $00, $00, $F5, $7F, $00
	dc.b	$1F, $9F, $1F, $0F, $00, $00, $1F, $8F, $1F, $F0, $7F, $00, $1F, $9F, $1F, $0F ;0x0 (0x0000A62A-0x0000A65C, Entry count: 0x32) [Unknown data]
	dc.b	$00, $10, $1F, $1F, $0A, $0F, $1F, $FF, $1F, $FF, $1F, $FF, $1F, $FF, $0F, $00, $0F, $00 ;0x20
	dc.b	$3B, $C6, $0F, $00, $1D, $8D, $0D, $00, $7F, $00, $1F, $80, $0D, $00, $0F, $00
	dc.b	$1F, $85, $12, $20, $36, $0C, $1F, $90, $1F, $AF ;0x0 (0x0000A65C-0x0000A676, Entry count: 0x1A)
	dc.b	$1F, $FF, $1F, $FF, $1F, $FF, $1F, $FF, $0F, $00 ;0x0 (0x0000A676-0x0000A680, Entry count: 0xA) [Unknown data]
loc_A680:
	movem.l	a5/a4/a3/a2/a1/a0/d7/d6/d5/d4/d3/d2/d1/d0, -(sp)
	move.b	#0, $00FF01EA
	move.b	#1, $00FF00F7
	move.b	#1, $00FF00F6
	lea	(loc_1F2AE).l, a0
	lea	$00FF00FA, a1
	move.w	#$5E, d0
loc_A6AC:
	move.w	(a0)+, (a1)+
	dbf	d0, loc_A6AC
	move.w	#$100, ($A11100).l
loc_A6BA:
	btst	#0, ($A11100).l
	bne.w	loc_A6BA
	lea	$00FF00FA, a1
	move.w	#4, d0
loc_A6D0:
	move.b	$E(a1), d3
	move.b	$C(a1), d1
	ext.w	d3
	mulu.w	#$26, d3
	lea	(loc_A59C).l, a4
	adda.l	d3, a4
	ext.w	d1
	cmpi.w	#3, d1
	bge.s	loc_A6F6
	lea	$00A04000, a5
	bra.s	loc_A6FE
loc_A6F6:
	lea	$00A04002, a5
	subq.w	#3, d1
loc_A6FE:
	btst	#7, $00A04000
	bne.w	loc_A6FE
	move.b	#$22, $00A04000
	move.b	(a4)+, $00A04001
	addq.l	#1, a4
loc_A71A:
	btst	#7, $00A04000
	bne.w	loc_A71A
	move.b	#$27, $00A04000
	move.b	#0, $00A04001
	move.b	#$B0, d6
	move.b	(a4)+, d7
	jsr	(loc_A7D2).l
	move.b	#$B4, d6
	move.b	(a4)+, d7
	jsr	(loc_A7D2).l
	moveq	#3, d2
	move.b	#$30, d4
loc_A754:
	moveq	#5, d3
loc_A756:
	move.b	d4, d6
	move.b	(a4)+, d7
	jsr	(loc_A7D2).l
	addi.b	#$10, d4
	dbf	d3, loc_A756
	subi.b	#$5C, d4
	dbf	d2, loc_A754
	lea	$26(a1), a1
	dbf	d0, loc_A6D0
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/d6/d7/a0/a1/a2/a3/a4/a5
	rts
loc_A77E:
	ext.w	d1
	cmpi.w	#3, d1
	bge.s	loc_A790
	lea	$00A04000, a5
	move.w	d1, d2
	bra.s	loc_A79C
loc_A790:
	lea	$00A04002, a5
	move.w	d1, d2
	addq.w	#1, d2
	subq.w	#3, d1
loc_A79C:
	move.b	#$A4, d6
	move.b	d4, d7
	jsr	(loc_A7D2).l
	move.b	#$A0, d6
	move.b	d5, d7
	jsr	(loc_A7D2).l
	andi.b	#7, d2
	ori.b	#$F0, d2
	jsr	(loc_A7E4).l
	move.b	#$28, $00A04000
	move.b	d2, $00A04001
	rts
loc_A7D2:
	add.b	d1, d6
loc_A7D4:
	btst	#7, (a5)
	bne.w	loc_A7D4
	move.b	d6, (a5)
	move.b	d7, $1(a5)
	rts
loc_A7E4:
	btst	#7, (a5)
	bne.w	loc_A7E4
	rts
loc_A7EE:
	cmpi.w	#3, d1
	blt.s	loc_A7F6
	addq.b	#1, d1
loc_A7F6:
	andi.b	#7, d1
loc_A7FA:
	btst	#7, $00A04000
	bne.w	loc_A7FA
	move.b	#$28, $00A04000
	move.b	d1, $00A04001
	rts
loc_A816:
	dc.b	$00, $00, $00, $00 ;0x0 (0x0000A816-0x0000A81A, Entry count: 0x4) [Unknown data]
loc_A81A:
	tst.b	$00FF01EA
	beq.w	loc_A986
	movem.l	a6/a5/a4/a3/a2/a1/a0/d7/d6/d5/d4/d3/d2/d1/d0, -(sp)
	lea	$00FF00FA, a0
	move.w	#4, d0
	move.b	#0, $00FF00F8
loc_A83A:
	move.l	$4(a0), d1
	beq.w	loc_A93C
	move.b	#1, $00FF00F8
	movea.l	d1, a1
	tst.b	$F(a0)
	bgt.w	loc_A938
loc_A854:
	move.b	(a1)+, d1
	blt.w	loc_A92C
	bne.w	loc_A876
	move.b	$C(a0), d1
	ext.w	d1
	jsr	(loc_A7EE).l
	clr.l	$4(a0)
	clr.b	$12(a0)
	bra.w	loc_A93C
loc_A876:
	subq.b	#1, d1
	bne.w	loc_A8A2
	move.b	$C(a0), d1
	move.b	$E(a0), d3
	move.b	(a1)+, d4
	move.b	(a1)+, d5
	move.b	d4, $10(a0)
	move.b	d5, $11(a0)
	move.b	#1, $12(a0)
	ext.w	d1
	jsr	(loc_A77E).l
	bra.w	loc_A924
loc_A8A2:
	subq.b	#1, d1
	bne.w	loc_A8BC
	move.b	$C(a0), d1
	ext.w	d1
	jsr	(loc_A7EE).l
	clr.b	$12(a0)
	bra.w	loc_A924
loc_A8BC:
	subq.b	#3, d1	;Predicted (Code-scan)
	bne.w	loc_A8DE	;Predicted (Code-scan)
	move.b	$14(a0), d1	;Predicted (Code-scan)
	ext.w	d1	;Predicted (Code-scan)
	move.w	d1, d2	;Predicted (Code-scan)
	add.w	d2, d2	;Predicted (Code-scan)
	move.b	(a1)+, $16(A0,d2.w)	;Predicted (Code-scan)
	move.b	(a1)+, $17(A0,d2.w)	;Predicted (Code-scan)
	addq.w	#1, d1	;Predicted (Code-scan)
	move.b	d1, $14(a0)	;Predicted (Code-scan)
	bra.w	loc_A924	;Predicted (Code-scan)
loc_A8DE:
	subq.b	#1, d1	;Predicted (Code-scan)
	bne.w	loc_A914	;Predicted (Code-scan)
	move.b	(a1)+, d1	;Predicted (Code-scan)
	lsl.w	#8, d1	;Predicted (Code-scan)
	move.b	(a1)+, d1	;Predicted (Code-scan)
	move.b	$14(a0), d2	;Predicted (Code-scan)
	ext.w	d2	;Predicted (Code-scan)
	add.w	d2, d2	;Predicted (Code-scan)
	move.b	$14(A0,d2.w), d3	;Predicted (Code-scan)
	lsl.w	#8, d3	;Predicted (Code-scan)
	move.b	$15(A0,d2.w), d3	;Predicted (Code-scan)
	subq.w	#1, d3	;Predicted (Code-scan)
	ble.w	loc_A924	;Predicted (Code-scan)
	move.b	d3, $15(A0,d2.w)	;Predicted (Code-scan)
	lsr.w	#8, d3	;Predicted (Code-scan)
	move.b	d3, $14(A0,d2.w)	;Predicted (Code-scan)
	lea	$3(a1,d1.w), a1	;Predicted (Code-scan)
	bra.w	loc_A924	;Predicted (Code-scan)
loc_A914:
	subq.b	#2, d1	;Predicted (Code-scan)
	bne.w	loc_A924	;Predicted (Code-scan)
	move.b	(a1)+, d1	;Predicted (Code-scan)
	lsl.w	#8, d1	;Predicted (Code-scan)
	move.b	(a1)+, d1	;Predicted (Code-scan)
	lea	(a1,d1.w), a1	;Predicted (Code-scan)
loc_A924:
	move.l	a1, $4(a0)
	bra.w	loc_A854
loc_A92C:
	andi.b	#$7F, d1
	move.b	d1, $F(a0)
	move.l	a1, $4(a0)
loc_A938:
	subq.b	#1, $F(a0)
loc_A93C:
	lea	$26(a0), a0
	dbf	d0, loc_A83A
	tst.b	$00FF00F8
	bne.w	loc_A982
	tst.b	$00FF00F7
	bne.w	loc_A982
	tst.b	$00FF00F6
	beq.w	loc_A97C
	clr.b	$00FF00F6
	lea	$00FF00FA, a0
	moveq	#4, d0
loc_A970:
	move.l	$8(a0), (a0)
	lea	$26(a0), a0
	dbf	d0, loc_A970
loc_A97C:
	jsr	(loc_A988).l
loc_A982:
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/d6/d7/a0/a1/a2/a3/a4/a5/a6
loc_A986:
	rts
loc_A988:
	movem.l	a0/d0, -(sp)
	move.b	#1, $00FF01EA
	lea	$00FF00FA, a0
	move.w	#4, d0
	move.b	#0, $00FF00F7
loc_A9A6:
	move.l	(a0), $4(a0)
	lea	$26(a0), a0
	dbf	d0, loc_A9A6
	movem.l	(sp)+, d0/a0
	rts
loc_A9B8:
	movem.l	a1/a0/d0, -(sp)
	lea	$00FF00FA, a0
	move.w	#4, d0
	lea	(loc_A816).l, a1
	move.b	#1, $00FF00F7
loc_A9D4:
	move.l	a1, $4(a0)
	lea	$26(a0), a0
	dbf	d0, loc_A9D4
	movem.l	(sp)+, d0/a0/a1
	rts
loc_A9E6:
	movem.l	d1/d0, -(sp)
	moveq	#4, d0
	moveq	#0, d1
	move.b	#0, $00FF01EA
loc_A9F6:
	jsr	(loc_A55E).l
	move.b	#$28, $00A04000
	move.b	d1, $00A04001
	addq.b	#1, d1
	dbf	d0, loc_A9F6
	movem.l	(sp)+, d0/d1
	rts
loc_AA16:
	move.b	#1, $00FF01EA
	rts
loc_AA20:
	link	a6, #0
	movem.l	a5/a4/d7/d6/d5/d4/d3/d2/d1/d0, -(sp)
	move.w	$8(a6), d5
	moveq	#$1F, d0
	move.l	#$7C000002, (a0)
loc_AA34:
	move.w	#$2222, (a2)
	dbf	d0, loc_AA34
	move.l	#$60000003, (a0)
	clr.w	d4
	move.w	#9, d1
loc_AA48:
	move.w	#$3F, d0
loc_AA4C:
	move.w	#$45E0, (a2)
	dbf	d0, loc_AA4C
	addq.w	#1, d4
	cmp.w	d4, d5
	ble.w	loc_AABE
	dbf	d1, loc_AA48
	move.w	#7, d1
loc_AA64:
	move.w	#$F, d0
loc_AA68:
	move.w	#$45E0, (a2)
	dbf	d0, loc_AA68
	move.w	#$11, d2
	sub.w	d1, d2
	mulu.w	#$28, d2
	addi.w	#$10, d2
	move.w	#7, d0
loc_AA82:
	move.w	d2, (a2)
	addq.w	#1, d2
	dbf	d0, loc_AA82
	move.w	#$27, d0
loc_AA8E:
	move.w	#$45E0, (a2)
	dbf	d0, loc_AA8E
	addq.w	#1, d4
	cmp.w	d4, d5
	ble.w	loc_AABE
	dbf	d1, loc_AA64
	move.w	#9, d1
loc_AAA6:
	move.w	#$3F, d0
loc_AAAA:
	move.w	#$45E0, (a2)
	dbf	d0, loc_AAAA
	addq.w	#1, d4
	cmp.w	d4, d5
	ble.w	loc_AABE
	dbf	d1, loc_AAA6
loc_AABE:
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/d6/d7/a4/a5
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#2, a7
	jmp	(a3)
loc_AACC:
	move.w	#$80, $00FF0022
	move.w	#$50, $00FF0024
	movea.l	#$FF0A00, a4
	jsr	(loc_33D2).l
	jsr	(loc_AAF0).l
	rts
loc_AAF0:
	movea.l	#$50000003, a1
	movea.l	#$FF0A00, a3
	move.l	a3, $00FF00C6
	jsr	(loc_323C).l
	move.l	#$FF0A00, $00FF00C6
	jsr	(loc_104A).l
	move.l	#$AAF0, ($FF0096).l
	jsr	(loc_304C).l
	rts
loc_AB2A:
	move.w	#$1C, -(sp)
	jsr	(loc_AA20).l
	cmpi.l	#$9600, ($FF0060).l
	bne.w	loc_AB48
	jsr	(loc_5CE).l
loc_AB48:
	jsr	(loc_5BA).l
	movea.l	#$FF0A00, a4
	move.w	#$80, $00FF0022
	move.w	#$50, $00FF0024
	jsr	(loc_327A).l
	bsr.w	loc_AB80
	jsr	(loc_16A2).l
	move.l	#$AA20, ($FF0060).l
	rts
loc_AB80:
	move.w	#$A, ($FF0038).l
	move.w	($FF0042).l, -(sp)
	addi.w	#1, ($FF0042).l
	cmpi.w	#$10, ($FF0042).l
	blt.w	loc_ABAA
	subi.w	#$F, ($FF0042).l
loc_ABAA:
	move.w	($FF0040).l, -(sp)
	move.w	#1, ($FF0040).l
	move.w	#$7F, -(sp)
	move.w	#$4F, -(sp)
	move.w	#$C0, -(sp)
	move.w	#$90, -(sp)
	jsr	(loc_1CF6).l
	move.w	(sp)+, ($FF0040).l
	move.w	(sp)+, ($FF0042).l
	rts
loc_ABDC:
	link	a6, #0
	movem.l	a5/a4/d7/d6/d5/d4/d3/d2/d1/d0, -(sp)
	move.w	$8(a6), d5
	moveq	#$1F, d0
	move.l	#$7C000002, (a0)
loc_ABF0:
	move.w	#$2222, (a2)
	dbf	d0, loc_ABF0
	move.l	#$60000003, (a0)
	clr.w	d4
	move.w	#7, d1
loc_AC04:
	move.w	#$3F, d0
loc_AC08:
	move.w	#$45E0, (a2)
	dbf	d0, loc_AC08
	addq.w	#1, d4
	cmp.w	d4, d5
	ble.w	loc_AC50
	dbf	d1, loc_AC04
	move.w	#$F, d6
	move.w	#7, d1
loc_AC24:
	bsr.w	loc_AC5E
	addq.w	#1, d4
	cmp.w	d4, d5
	ble.w	loc_AC50
	dbf	d1, loc_AC24
	move.w	#$B, d1
loc_AC38:
	move.w	#$3F, d0
loc_AC3C:
	move.w	#$45E0, (a2)
	dbf	d0, loc_AC3C
	addq.w	#1, d4
	cmp.w	d4, d5
	ble.w	loc_AC50
	dbf	d1, loc_AC38
loc_AC50:
	movem.l	(sp)+, d0/d1/d2/d3/d4/d5/d6/d7/a4/a5
	unlk	a6
	movea.l	(sp)+, a3
	adda.w	#2, a7
	jmp	(a3)
loc_AC5E:
	move.w	#0, d0
loc_AC62:
	move.w	#$45E0, (a2)
	dbf	d0, loc_AC62
	move.w	d6, d2
	sub.w	d1, d2
	mulu.w	#$28, d2
	addi.w	#1, d2
	move.w	#7, d0
loc_AC7A:
	move.w	d2, (a2)
	addq.w	#1, d2
	dbf	d0, loc_AC7A
	move.w	#1, d0
loc_AC86:
	move.w	#$45E0, (a2)
	dbf	d0, loc_AC86
	move.w	d6, d2
	sub.w	d1, d2
	mulu.w	#$28, d2
	addi.w	#$B, d2
	move.w	#7, d0
loc_AC9E:
	move.w	d2, (a2)
	addq.w	#1, d2
	dbf	d0, loc_AC9E
	move.w	#1, d0
loc_ACAA:
	move.w	#$45E0, (a2)
	dbf	d0, loc_ACAA
	move.w	d6, d2
	sub.w	d1, d2
	mulu.w	#$28, d2
	addi.w	#$15, d2
	move.w	#7, d0
loc_ACC2:
	move.w	d2, (a2)
	addq.w	#1, d2
	dbf	d0, loc_ACC2
	move.w	#1, d0
loc_ACCE:
	move.w	#$45E0, (a2)
	dbf	d0, loc_ACCE
	move.w	d6, d2
	sub.w	d1, d2
	mulu.w	#$28, d2
	addi.w	#$1F, d2
	move.w	#7, d0
loc_ACE6:
	move.w	d2, (a2)
	addq.w	#1, d2
	dbf	d0, loc_ACE6
	move.w	#$18, d0
loc_ACF2:
	move.w	#$45E0, (a2)
	dbf	d0, loc_ACF2
	rts
loc_ACFC:
	movea.l	#$FF1214, a3
	movea.l	#$54000002, a1
	jsr	(loc_323C).l
	movea.l	#$FF1A14, a3
	movea.l	#$5C000002, a1
	jsr	(loc_323C).l
	movea.l	#$FF2214, a3
	movea.l	#$64000002, a1
	jsr	(loc_323C).l
	movea.l	#$FF2A14, a3
	movea.l	#$6C000002, a1
	jsr	(loc_323C).l
	jsr	(loc_104A).l
	move.l	#$ACFC, ($FF0096).l
	jsr	(loc_B07A).l
	rts
loc_AD5C:
	move.w	#8, $00FF0022
	move.w	#$40, $00FF0024
	movea.l	#$FF1214, a4
	jsr	(loc_33D2).l
	move.w	#$58, $00FF0022
	move.w	#$40, $00FF0024
	movea.l	#$FF1A14, a4
	jsr	(loc_33D2).l
	move.w	#$A8, $00FF0022
	move.w	#$40, $00FF0024
	movea.l	#$FF2214, a4
	jsr	(loc_33D2).l
	move.w	#$F8, $00FF0022
	move.w	#$40, $00FF0024
	movea.l	#$FF2A14, a4
	jsr	(loc_33D2).l
	jsr	(loc_ACFC).l
	rts
	move.w	#$1C, -(sp)
	jsr	(loc_ABDC).l
	cmpi.l	#$9600, ($FF0060).l
	bne.w	loc_ADF2
	jsr	(loc_5CE).l	;Predicted (Code-scan)
loc_ADF2:
	jsr	(loc_5BA).l
	movea.l	$00FF00C2, a5
	movea.l	(a5)+, a4
	bsr.w	loc_31D2
	movea.l	#$FF01EC, a4
	move.w	#8, $00FF0022
	move.w	#$40, $00FF0024
	jsr	(loc_327A).l
	movea.l	(a5)+, a4
	bsr.w	loc_31D2
	movea.l	#$FF01EC, a4
	move.w	#$58, $00FF0022
	move.w	#$40, $00FF0024
	jsr	(loc_327A).l
	movea.l	(a5)+, a4
	bsr.w	loc_31D2
	movea.l	#$FF01EC, a4
	move.w	#$A8, $00FF0022
	move.w	#$40, $00FF0024
	jsr	(loc_327A).l
	movea.l	(a5)+, a4
	bsr.w	loc_31D2
	movea.l	#$FF01EC, a4
	move.w	#$F8, $00FF0022
	move.w	#$40, $00FF0024
	jsr	(loc_327A).l
	jsr	(loc_16A2).l
	bsr.w	loc_AE9C
	move.l	#loc_ABDC, ($FF0060).l
	rts
loc_AE9C:
	move.w	#1, ($FF0038).l
	move.w	($FF0042).l, -(sp)
	move.w	#$12, ($FF0042).l
	move.w	($FF0040).l, -(sp)
	move.w	#1, ($FF0040).l
	move.w	#7, -(sp)
	move.w	#$3F, -(sp)
	move.w	#$48, -(sp)
	move.w	#$80, -(sp)
	jsr	(loc_1CF6).l
	move.w	#$57, -(sp)
	move.w	#$3F, -(sp)
	move.w	#$98, -(sp)
	move.w	#$80, -(sp)
	jsr	(loc_1CF6).l
	move.w	#$A7, -(sp)
	move.w	#$3F, -(sp)
	move.w	#$E8, -(sp)
	move.w	#$80, -(sp)
	jsr	(loc_1CF6).l
	move.w	#$F7, -(sp)
	move.w	#$3F, -(sp)
	move.w	#$138, -(sp)
	move.w	#$80, -(sp)
	jsr	(loc_1CF6).l
	move.w	#$13, ($FF0042).l
	move.w	#6, -(sp)
	move.w	#$3E, -(sp)
	move.w	#$49, -(sp)
	move.w	#$81, -(sp)
	jsr	(loc_1CF6).l
	move.w	#$56, -(sp)
	move.w	#$3E, -(sp)
	move.w	#$99, -(sp)
	move.w	#$81, -(sp)
	jsr	(loc_1CF6).l
	move.w	#$A6, -(sp)
	move.w	#$3E, -(sp)
	move.w	#$E9, -(sp)
	move.w	#$81, -(sp)
	jsr	(loc_1CF6).l
	move.w	#$F6, -(sp)
	move.w	#$3E, -(sp)
	move.w	#$139, -(sp)
	move.w	#$81, -(sp)
	jsr	(loc_1CF6).l
	move.w	(sp)+, ($FF0040).l
	move.w	(sp)+, ($FF0042).l
	clr.w	($FF0038).l
	rts
loc_AF8C:
	clr.l	d2
	moveq	#7, d0
loc_AF90:
	asl.l	#4, d0
	move.b	d0, ($A10003).l
	asr.l	#4, d0
	nop
	nop
	nop
	move.b	($A10003).l, d1
	andi.b	#$F, d1
	asl.l	#4, d2
	or.b	d1, d2
	dbf	d0, loc_AF90
	move.l	d2, $00FF0010
	rts
loc_AFBA:
	move.l	$00FF0010, d0	;Predicted (Code-scan)
	clr.w	d1	;Predicted (Code-scan)
	move.w	d1, ($FF0008).l	;Predicted (Code-scan)
	move.w	d1, ($FF000A).l	;Predicted (Code-scan)
	move.w	d1, ($FF000C).l	;Predicted (Code-scan)
	lsr.l	#8, d0	;Predicted (Code-scan)
	lsr.l	#1, d0	;Predicted (Code-scan)
	ROXL.w	#1, d1	;Predicted (Code-scan)
	lsl.w	#4, d1	;Predicted (Code-scan)
	lsr.l	#1, d0	;Predicted (Code-scan)
	ROXL	($FF000C).l	;Predicted (Code-scan)
	lsr.l	#1, d0	;Predicted (Code-scan)
	ROXL	($FF000A).l	;Predicted (Code-scan)
	lsr.l	#1, d0	;Predicted (Code-scan)
	ROXL	($FF0008).l	;Predicted (Code-scan)
	move.b	d0, d2	;Predicted (Code-scan)
	andi.b	#$F, d2	;Predicted (Code-scan)
	or.b	d2, d1	;Predicted (Code-scan)
	lsl.w	#4, d1	;Predicted (Code-scan)
	lsr.l	#4, d0	;Predicted (Code-scan)
	move.b	d0, d2	;Predicted (Code-scan)
	andi.b	#$F, d2	;Predicted (Code-scan)
	or.b	d2, d1	;Predicted (Code-scan)
	cmpi.w	#0, ($FF0056).l	;Predicted (Code-scan)
	beq.w	loc_B01A	;Predicted (Code-scan)
	move.w	d1, ($FF0004).l	;Predicted (Code-scan)
loc_B01A:
	clr.w	d1	;Predicted (Code-scan)
	lsr.l	#4, d0	;Predicted (Code-scan)
	move.b	d0, d2	;Predicted (Code-scan)
	andi.b	#$F, d2	;Predicted (Code-scan)
	or.b	d2, d1	;Predicted (Code-scan)
	lsl.w	#4, d1	;Predicted (Code-scan)
	lsr.l	#4, d0	;Predicted (Code-scan)
	andi.b	#$F, d0	;Predicted (Code-scan)
	or.b	d0, d1	;Predicted (Code-scan)
	cmpi.w	#0, ($FF0056).l	;Predicted (Code-scan)
	beq.w	loc_B042	;Predicted (Code-scan)
	move.w	d1, ($FF0006).l	;Predicted (Code-scan)
loc_B042:
	rts	;Predicted (Code-scan)
loc_B044:
	move.b	#$70, ($A10009).l
	bsr.w	loc_AF8C
	clr.w	($FF000E).l
	move.l	$00FF0010, d0
	cmpi.b	#$3C, d0
	bne.w	loc_B06E
	move.w	#$FFFF, ($FF000E).l	;Predicted (Code-scan)
	rts	;Predicted (Code-scan)
loc_B06E:
	move.b	#$40, ($A10009).l
	rts
	dc.b	$4E, $75 ;0x0 (0x0000B078-0x0000B07A, Entry count: 0x2) [Unknown data]
loc_B07A:
	move.w	#9, ($FF003C).l
	move.l	#$E0000, ($FF002E).l
	move.l	#$500000, ($FF0032).l
	move.w	#$E, ($FF0004).l
	move.w	#$50, ($FF0006).l
	move.w	#$84A0, $00FF0022
	clr.w	$00FF001E
	clr.w	$00FF0024
	bsr.w	loc_B0FE
	move.l	#$B0FE, ($FF008C).l
	move.l	#$111E, ($FF0078).l
	move.l	#$B1FA, ($FF009E).l
	move.l	#$B170, ($FF0090).l
	cmpi.w	#4, $00FF00CA
	beq.w	loc_B0FC
	clr.w	($FF0056).l
	bsr.w	loc_B2A8
loc_B0FC:
	rts
loc_B0FE:
	move.l	d0, -(sp)
	move.l	#$5C000003, (a0)
	move.w	($FF0004).l, d2
	move.w	($FF0006).l, d1
	move.w	#$F01, d0
	move.w	$00FF0022, d3
	move.w	#1, d4
	move.w	$00FF001A, d5
	cmp.w	($FF0004).l, d5
	blt.w	loc_B156
	bgt.w	loc_B140
	cmpi.w	#0, $00FF0024
	beq.w	loc_B156
loc_B140:
	ori.w	#$800, d3
	jsr	(loc_B18A).l
	move.w	#1, $00FF0024
	bra.w	loc_B162
loc_B156:
	jsr	(loc_3166).l
	clr.w	$00FF0024
loc_B162:
	move.w	($FF0004).l, $00FF001A
	move.l	(sp)+, d0
	rts
	move.w	#$64, ($FF0004).l
	move.w	#$64, ($FF0006).l
	move.w	#1, ($FF0056).l
	rts
loc_B18A:
	addi.w	#$80, d1
	move.w	d1, (a2)
	move.w	d0, (a2)
	addi.w	#1, d0
	addi.w	#$10, d3
	move.w	d3, (a2)
	subi.w	#$10, d3
	addi.w	#$80, d2
	move.w	d2, (a2)
	move.w	d1, (a2)
	move.w	d0, (a2)
	addi.w	#1, d0
	move.w	d3, (a2)
	addi.w	#$30, d3
	addi.w	#$20, d2
	move.w	d2, (a2)
	addi.w	#$20, d1
	move.w	d1, (a2)
	move.w	d0, (a2)
	addi.w	#1, d0
	move.w	d3, (a2)
	subi.w	#$10, d3
	subi.w	#$20, d2
	move.w	d2, (a2)
	move.w	d1, (a2)
	addi.w	#$20, d2
	cmpi.w	#0, d4
	bne.w	loc_B1F0
	move.w	d0, (a2)	;Predicted (Code-scan)
	addi.w	#1, d0	;Predicted (Code-scan)
	move.w	d3, (a2)	;Predicted (Code-scan)
	addi.w	#$10, d3	;Predicted (Code-scan)
	move.w	d2, (a2)	;Predicted (Code-scan)
	rts	;Predicted (Code-scan)
loc_B1F0:
	move.w	#$F00, (a2)
	move.w	d3, (a2)
	move.w	d2, (a2)
	rts
loc_B1FA:
	cmpi.w	#4, $00FF00CA
	beq.w	loc_B26C
	movea.l	$00FF0026, a1
	move.l	$4(a1), d1
	add.l	d1, ($FF002E).l
	move.l	($FF002E).l, d1
	lsr.l	#8, d1
	lsr.l	#8, d1
	move.w	d1, ($FF0004).l
	move.l	$8(a1), d1
	add.l	d1, ($FF0032).l
	move.l	($FF0032).l, d1
	lsr.l	#8, d1
	lsr.l	#8, d1
	move.w	d1, ($FF0006).l
	subi.l	#1, $00FF002A
	bne.w	loc_B26C
	addi.l	#$C, $00FF0026
	movea.l	$00FF0026, a1
	move.l	(a1), $00FF002A
	bne.w	loc_B26C
	bsr.w	loc_B2A8
loc_B26C:
	addi.w	#1, $00FF001E
	cmpi.w	#$A, $00FF001E
	bne.w	loc_B2A6
	clr.w	$00FF001E
	addi.w	#$40, $00FF0022
	cmpi.w	#$85A0, $00FF0022
	bne.w	loc_B2A2
	move.w	#$84A0, $00FF0022
loc_B2A2:
	bsr.w	loc_B0FE
loc_B2A6:
	rts
loc_B2A8:
	move.w	$00FF00CA, d1
	lsl.w	#2, d1
	movea.l	#$B2CC, a1
	adda.w	d1, a1
	move.l	(a1), $00FF0026
	movea.l	$00FF0026, a1
	move.l	(a1), $00FF002A
	rts
	dc.l	$0000B87C, $0000B6F8, $0000B2DC, $0000B304, $00000102, $00010000, $00000000, $00000120, $FFFF0000, $00000000, $0000001E, $00010000, $00000000 ;0x0 (0x0000B2CC-0x0000B300, Entry count: 0x34)
	dc.b	$00, $00, $00, $00 ;0x0 (0x0000B300-0x0000B304, Entry count: 0x4) [Unknown data]
	dc.l	$0000000A, $0000199A, $FFFF0000, $0000000A, $00003333, $FFFF0000, $0000000B, $00005D17
	dc.l	$FFFF1746, $0000000C, $00009555, $FFFF2AAB, $0000000D, $0000B136, $FFFF3B14, $0000000A
	dc.l	$0000B333, $FFFF4CCD, $00000009, $0000E38E, $FFFFAAAB, $00000009, $0000E38E, $00005555
	dc.l	$0000000A, $0000B333, $0000B333, $0000000D, $0000B136, $0000C4EC, $0000000C, $00009555 ;0x0 (0x0000B304-0x0000B8AC, Entry count: 0x5A8)
	dc.l	$0000D555, $0000000B, $00005D17, $0000E8BA, $0000000A, $00003333, $00010000, $0000000A
	dc.l	$0000199A, $00010000, $0000000A, $0000199A, $00010000, $0000000A, $00003333, $00010000
	dc.l	$0000000B, $00005D17, $0000E8BA, $0000000C, $00009555, $0000D555, $0000000D, $0000B136
	dc.l	$0000C4EC, $0000000A, $0000B333, $0000B333, $00000009, $0000E38E, $00005555, $00000009 ;0x20
	dc.l	$0000E38E, $FFFFAAAB, $0000000A, $0000B333, $FFFF4CCD, $0000000D, $0000B136, $FFFF3B14
	dc.l	$0000000C, $00009555, $FFFF2AAB, $0000000B, $00005D17, $FFFF1746, $0000000A, $00003333
	dc.l	$FFFF0000, $0000000A, $0000199A, $FFFF0000, $0000000A, $0000199A, $FFFF0000, $0000000A
	dc.l	$00003333, $FFFF0000, $0000000B, $00005D17, $FFFF1746, $0000000C, $00009555, $FFFF2AAB ;0x40
	dc.l	$0000000D, $0000B136, $FFFF3B14, $0000000A, $0000B333, $FFFF4CCD, $00000009, $0000E38E
	dc.l	$FFFFAAAB, $00000009, $0000E38E, $00005555, $0000000A, $0000B333, $0000B333, $0000000D
	dc.l	$0000B136, $0000C4EC, $0000000C, $00009555, $0000D555, $0000000B, $00005D17, $0000E8BA
	dc.l	$0000000A, $00003333, $00010000, $0000000A, $0000199A, $00010000, $0000000A, $FFFFE660 ;0x60
	dc.l	$00010000, $0000000A, $FFFFCCCD, $00010000, $0000000B, $FFFFA2E9, $0000E8BA, $0000000C
	dc.l	$FFFF6AAB, $0000D555, $0000000D, $FFFF4EC5, $0000C4EC, $0000000A, $FFFF4CCD, $0000B333
	dc.l	$00000009, $FFFF1C72, $00005555, $00000009, $FFFF1C72, $FFFFAAAB, $0000000A, $FFFF4CCD
	dc.l	$FFFF4CCD, $0000000D, $FFFF4EC5, $FFFF3B14, $0000000C, $FFFF6AAB, $FFFF2AAB, $0000000B ;0x80
	dc.l	$FFFFA2E9, $FFFF1746, $0000000A, $FFFFCCCD, $FFFF0000, $0000000A, $FFFFE660, $FFFF0000
	dc.l	$0000000A, $FFFFE660, $FFFF0000, $0000000A, $FFFFCCCD, $FFFF0000, $0000000B, $FFFFA2E9
	dc.l	$FFFF1746, $0000000C, $FFFF6AAB, $FFFF2AAB, $0000000D, $FFFF4EC5, $FFFF3B14, $0000000A
	dc.l	$FFFF4CCD, $FFFF4CCD, $00000009, $FFFF1C72, $FFFFAAAB, $00000009, $FFFF1C72, $00005555 ;0xA0
	dc.l	$0000000A, $FFFF4CCD, $0000B333, $0000000D, $FFFF4EC5, $0000C4EC, $0000000C, $FFFF6AAB
	dc.l	$0000D555, $0000000B, $FFFFA2E9, $0000E8BA, $0000000A, $FFFFCCCD, $00010000, $0000000A
	dc.l	$FFFFE660, $00010000, $0000000A, $FFFFE660, $00010000, $0000000A, $FFFFCCCD, $00010000
	dc.l	$0000000B, $FFFFA2E9, $0000E8BA, $0000000C, $FFFF6AAB, $0000D555, $0000000D, $FFFF4EC5 ;0xC0
	dc.l	$0000C4EC, $0000000A, $FFFF4CCD, $0000B333, $00000009, $FFFF1C72, $00005555, $00000009
	dc.l	$FFFF1C72, $FFFFAAAB, $0000000A, $FFFF4CCD, $FFFF4CCD, $0000000D, $FFFF4EC5, $FFFF3B14
	dc.l	$0000000C, $FFFF6AAB, $FFFF2AAB, $0000000B, $FFFFA2E9, $FFFF1746, $0000000A, $FFFFCCCD
	dc.l	$FFFF0000, $0000000A, $FFFFE660, $FFFF0000, $00000000, $00000016, $000068BA, $FFFF1746 ;0xE0
	dc.l	$0000000E, $00008000, $FFFF2492, $0000000F, $0000AAAB, $FFFF4444, $0000000C, $0000D555
	dc.l	$FFFF6AAB, $00000015, $0000DB6E, $FFFF85DC, $00000010, $00010000, $FFFFD000, $00000016
	dc.l	$00010000, $FFFFF45D, $00000016, $00010000, $FFFFF45D, $00000016, $00010000, $00000BA3
	dc.l	$00000016, $00010000, $00000BA3, $00000010, $00010000, $00003000, $00000015, $0000DB6E ;0x100
	dc.l	$00007A24, $0000000C, $0000D555, $00009555, $0000000F, $0000AAAB, $0000BBBC, $0000000E
	dc.l	$00008000, $0000DB6E, $00000016, $000068BA, $0000E8BA, $00000016, $FFFF9746, $0000E8BA
	dc.l	$0000000E, $FFFF8000, $0000DB6E, $0000000F, $FFFF5555, $0000BBBC, $0000000C, $FFFF2AAB
	dc.l	$00009555, $00000015, $FFFF2492, $00007A24, $00000010, $FFFF0000, $00003000, $00000016 ;0x120
	dc.l	$FFFF0000, $00000BA3, $00000016, $FFFF0000, $00000BA3, $00000016, $FFFF0000, $FFFFF45D
	dc.l	$00000016, $FFFF0000, $FFFFF45D, $00000010, $FFFF0000, $FFFFD000, $00000015, $FFFF2492
	dc.l	$FFFF85DC, $0000000C, $FFFF2AAB, $FFFF6AAB, $0000000F, $FFFF5555, $FFFF4444, $0000000E
	dc.l	$FFFF8000, $FFFF2492, $00000016, $FFFF9746, $FFFF1746, $00000000, $00000068, $0000A276 ;0x140
	dc.l	$FFFF3B14, $000000C1, $0000E973, $00006A1D, $00000046, $FFFFA0EA, $0000EDB7, $0000009D
	dc.l	$FFFF9E2A, $FFFF1391 ;0x160
	dc.b	$00, $00, $00, $DC, $FF, $FF, $3A, $2F, $00, $00, $A2, $E9, $00, $00, $00, $78
	dc.b	$00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $7A, $FF, $FF, $21, $93 ;0x0 (0x0000B8AC-0x0000B8D4, Entry count: 0x28) [Unknown data]
	dc.b	$FF, $FF, $82, $19, $00, $00, $00, $00 ;0x20
loc_B8D4:
	dc.w	$0000, $0000, $0000, $0000, $0000, $0000, $0000, $000E, $0000, $00E1, $0000, $0E1F, $0000, $E1FF, $000E, $1FFF
	dc.w	$00E1, $FFFF, $0E1F, $FFFF, $E11F, $FFFB, $E191, $FFBB, $E199, $1BB1, $E118, $811E, $1F11, $11E0, $F1EE, $EE00 ;0x0 (0x0000B8D4-0x0000B954, Entry count: 0x80)
	dc.w	$00EE, $0000, $0E11, $E000, $E155, $1E00, $1456, $51E0, $CD45, $541E, $CED4, $441E, $FCDC, $41E0, $FFBB, $1E00
	dc.w	$FBB1, $E000, $BB1E, $0000, $B1E0, $0000, $1E00, $0000, $E000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ;0x20
loc_B954:
	dc.w	$0000, $000E, $0000, $00EC, $0000, $00EC, $0000, $0E1C, $0000, $E1BC, $000E, $1DBC, $00E1, $DEEC, $0E1D, $EEDC
	dc.w	$E1DE, $EDDD, $E1EE, $DDDC, $E1ED, $DDCC, $0E1D, $DCCC, $00E1, $CCCB, $000E, $1CBB, $0000, $E111, $0000, $0EEE ;0x0 (0x0000B954-0x0000B9D4, Entry count: 0x80)
	dc.w	$EE00, $0000, $CCE0, $0000, $ECE0, $0000, $ECE0, $0000, $1CE0, $0000, $B1E0, $0000, $BB1E, $EE00, $FFFF, $FFE0
	dc.w	$CCFF, $FFFE, $CCB1, $FFFE, $CBB1, $1FFE, $BB1E, $1FFE, $B1E0, $01FE, $1E00, $01FE, $E000, $0010, $0000, $00F0 ;0x20
loc_B9D4:
	dc.w	$A063, $0000, $30A0, $060E, $6003, $A03E, $30A0, $000E, $A036, $00E1, $6000, $0E1D, $0000, $0E11, $0000, $0E1C
	dc.w	$0000, $0E1C, $0000, $0E1C, $0000, $0E1C, $0000, $0E1C, $0000, $0E1C, $0000, $0E1C, $0000, $0E11, $0000, $0EEE ;0x0 (0x0000B9D4-0x0000BA54, Entry count: 0x80)
	dc.w	$EE00, $0000, $11E0, $0000, $F1E0, $0000, $11E0, $0000, $EE1E, $0000, $EED1, $E000, $1111, $E000, $D111, $E000
	dc.w	$1FF1, $E000, $1FF1, $E000, $1FF1, $E000, $1FF1, $E000, $D111, $E000, $DDC1, $E000, $1111, $E000, $EEEE, $E000 ;0x20
loc_BA54:
	dc.w	$EEEE, $EEE0, $EBBB, $BBEB, $EB00, $00EB, $EB00, $00EB, $EB00, $00EB, $EB00, $00EB, $EEEE, $EEEB, $0BBB, $BBBB
	dc.w	$0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ;0x0 (0x0000BA54-0x0000BAD4, Entry count: 0x80)
	dc.w	$0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
	dc.w	$0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ;0x20
loc_BAD4:
	dc.w	$0000, $0000, $0000, $0000, $0000, $00EE, $0000, $00EB, $0000, $00EB, $0000, $00EB, $00EE, $EEEB, $00EB, $BBBB
	dc.w	$00EB, $FFFF, $00EE, $EEEF, $000B, $BBEB, $0000, $00EB, $0000, $00EB, $0000, $00EE, $0000, $000B, $0000, $0000 ;0x0 (0x0000BAD4-0x0000BB54, Entry count: 0x80)
	dc.w	$0000, $0000, $0000, $0000, $EE00, $0000, $BEB0, $0000, $FEB0, $0000, $FEB0, $0000, $FEEE, $EE00, $FFBB, $BEB0
	dc.w	$FFFF, $FEB0, $FEEE, $EEB0, $FEBB, $BBB0, $FEB0, $0000, $FEB0, $0000, $EEB0, $0000, $BBB0, $0000, $0000, $0000 ;0x20
loc_BB54:
	dc.w	$000E, $E000, $00E1, $1E00, $0E11, $11E0, $E111, $111E, $EEE1, $1EEE, $00E1, $1E00, $00E1, $1E00, $00EE, $EE00
	dc.w	$0000, $EE00, $0EEE, $11E0, $EE11, $11E0, $00E1, $111E, $00E1, $1EEE, $0E11, $E00E, $EE11, $E000, $00EE, $0000 ;0x0 (0x0000BB54-0x0000BC14, Entry count: 0xC0)
	dc.w	$00EE, $EEEE, $00E1, $111E, $000E, $111E, $00E1, $111E, $0E11, $1E1E, $E111, $E0EE, $0E1E, $0000, $00E0, $0000
	dc.w	$00EE, $E000, $000E, $1EE0, $000E, $111E, $0EE1, $111E, $E111, $11E0, $E11E, $E1E0, $0EE0, $0EE0, $0E00, $0E00 ;0x20
	dc.w	$000E, $E000, $000E, $1E00, $EEEE, $11E0, $E111, $111E, $E111, $111E, $EEEE, $11E0, $000E, $1E00, $000E, $E000
	dc.w	$0000, $0000, $000B, $B000, $00BF, $FB00, $0BFF, $FFB0, $0BFF, $FFB0, $00BF, $FB00, $000B, $B000, $0000, $0000 ;0x40
	dc.l	loc_F752
	dc.l	loc_FAC5
	dc.l	loc_16053
	dc.l	loc_10D4D
	dc.l	loc_16DF7
	dc.l	loc_D7B3
	dc.l	loc_1431E
	dc.l	loc_10694
	dc.l	loc_CE78
	dc.l	loc_DE79
	dc.l	loc_C6C0
	dc.l	loc_E11C
	dc.l	loc_E4B2
	dc.l	loc_C082
	dc.l	loc_F154
	dc.l	loc_13A19	;Predicted
	dc.l	loc_14E4E	;Predicted
	dc.l	loc_D5B8	;Predicted
	dc.l	loc_12C5A	;Predicted
	dc.l	loc_10462	;Predicted
	dc.l	loc_1243C	;Predicted
	dc.l	loc_C86A	;Predicted
	dc.l	loc_1595B	;Predicted
	dc.l	loc_F474	;Predicted
	dc.l	loc_FE4A	;Predicted
	dc.l	loc_C4DD	;Predicted
	dc.l	loc_BE47	;Predicted
	dc.l	loc_11B86	;Predicted
	dc.l	loc_11963	;Predicted
	dc.l	loc_120E4	;Predicted
	dc.l	loc_114B0	;Predicted
	dc.l	loc_E60A	;Predicted
	dc.l	loc_12908	;Predicted
	dc.l	loc_E279	;Predicted
	dc.l	loc_13355	;Predicted
	dc.l	loc_10AB0	;Predicted
	dc.l	loc_DAD5	;Predicted
	dc.l	loc_EF13	;Predicted
	dc.l	loc_11150	;Predicted
	dc.l	loc_D3C9	;Predicted
	dc.l	loc_16AA7	;Predicted
	dc.l	loc_DC92	;Predicted
	dc.l	loc_ED53	;Predicted
	dc.l	loc_10165	;Predicted
	dc.l	loc_BCE0	;Predicted
	dc.l	loc_EB6A	;Predicted
	dc.l	loc_E931	;Predicted
	dc.l	loc_102B5	;Predicted
	dc.l	loc_CB4B	;Predicted
	dc.l	loc_11E72	;Predicted
	dc.b	$00, $FF, $0A, $00 ;0x0 (0x0000BCDC-0x0000BCE0, Entry count: 0x4) [Unknown data]
loc_BCE0:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x0000BCE0-0x0000BE47, Entry count: 0x167) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $F3, $0F, $0F, $0F, $0A, $F1, $A1, $F4, $0F, $0F, $0F, $07, $F1, $A4
	dc.b	$F4, $0F, $0F, $0F, $03, $F1, $A8, $F4, $0F, $0F, $0F, $00, $F1, $AB, $F2, $0F ;0x40
	dc.b	$0F, $0D, $F2, $AD, $F1, $0F, $0F, $08, $F4, $AA, $B1, $A1, $F1, $0F, $0F, $04
	dc.b	$F5, $AD, $B1, $A1, $F1, $0F, $0F, $01, $F4, $AC, $B2, $A1, $B2, $A1, $F1, $0F ;0x60
	dc.b	$0D, $F4, $AD, $B9, $A1, $F1, $0F, $0D, $F1, $AE, $B4, $A3, $B2, $A1, $F2, $0F
	dc.b	$0D, $F1, $A1, $B1, $A7, $B5, $A2, $F1, $A0, $B1, $A1, $F5, $0F, $0C, $F1, $A0 ;0x80
	dc.b	$B2, $A4, $B5, $A2, $F3, $A1, $B0, $A0, $F5, $0F, $0D, $F1, $A1, $B1, $A1, $B6
	dc.b	$A2, $F6, $A2, $F4, $0F, $0F, $F1, $A0, $B8, $A2, $F8, $A1, $F5, $0F, $0F, $F1 ;0xA0
	dc.b	$A1, $B6, $A1, $FF, $F1, $0F, $0E, $F4, $A0, $B4, $A2, $FF, $F1, $0F, $0E, $F5
	dc.b	$A1, $B1, $A2, $FF, $F2, $0F, $0F, $00, $F5, $A0, $B0, $A1, $FB, $00, $F6, $0F ;0xC0
	dc.b	$0F, $02, $F4, $A2, $FB, $02, $F5, $0F, $0F, $02, $F4, $A1, $FA, $04, $F4, $0F
	dc.b	$0F, $04, $FE, $07, $F2, $0F, $0F, $05, $FC, $09, $F1, $0F, $0F, $07, $FA, $0F ;0xE0
	dc.b	$0F, $0F, $04, $F8, $0F, $0F, $0F, $07, $F6, $0F, $0F, $0F, $08, $F4, $0F, $0F
	dc.b	$0F, $0B, $F2, $0F, $0F, $0F, $0C, $F1, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x100
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x120
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x140
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0A ;0x160
loc_BE47:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x0000BE47-0x0000C082, Entry count: 0x23B) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0A, $F4, $0F, $0F, $0F, $06, $F3, $E4, $F4, $0F, $0F, $0E
	dc.b	$F2, $E4, $F2, $E5, $F1, $0F, $0F, $0B, $F0, $E3, $FB, $E2, $F1, $0F, $0F, $08 ;0x20
	dc.b	$F0, $E1, $FF, $F1, $E1, $F1, $0F, $0F, $05, $F0, $E1, $FF, $F3, $E0, $F5, $0F
	dc.b	$0F, $01, $F0, $E0, $FF, $F6, $E4, $F1, $0F, $0F, $F0, $E0, $FF, $F8, $E4, $F0 ;0x40
	dc.b	$0F, $0D, $F0, $E1, $FD, $E7, $F3, $E3, $F0, $0F, $0D, $F0, $E0, $FB, $E2, $F8
	dc.b	$E6, $F0, $0F, $0D, $F0, $E0, $F9, $E1, $F9, $E0, $F5, $E1, $F0, $0F, $0D, $F0 ;0x60
	dc.b	$E0, $F8, $E0, $FA, $E0, $F6, $E0, $F1, $08, $F1, $0F, $02, $F0, $E0, $F0, $03
	dc.b	$F3, $E0, $F9, $E0, $F6, $E1, $F1, $07, $F0, $E0, $F0, $0F, $03, $F0, $05, $F1 ;0x80
	dc.b	$E0, $F9, $E0, $F7, $E0, $F0, $E0, $F0, $07, $F0, $E0, $F0, $0F, $03, $F0, $05
	dc.b	$F0, $E0, $FA, $E0, $F6, $E1, $F1, $E0, $F0, $06, $F0, $E0, $F0, $05, $F1, $0F ;0xA0
	dc.b	$02, $F0, $E0, $F9, $E0, $F7, $E0, $F2, $E0, $F0, $05, $F0, $E1, $F0, $04, $F0
	dc.b	$E0, $F0, $0F, $02, $FA, $E0, $F7, $E1, $F2, $E0, $F0, $05, $F0, $E1, $F0, $03 ;0xC0
	dc.b	$F0, $E1, $F0, $0F, $08, $F3, $E0, $F8, $E1, $F2, $E0, $F0, $05, $F0, $E1, $F4
	dc.b	$E1, $F0, $0F, $0A, $F1, $E0, $F8, $E1, $F4, $E0, $F2, $02, $F0, $E4, $F2, $E0 ;0xE0
	dc.b	$F0, $0F, $0A, $F1, $E0, $F8, $E1, $F5, $E1, $F3, $E2, $70, $F0, $E1, $F2, $0F
	dc.b	$0B, $F1, $E0, $F8, $E4, $F0, $EA, $70, $60, $F0, $E0, $F2, $0F, $0B, $F0, $E0 ;0x100
	dc.b	$FD, $E8, $F0, $E6, $F1, $70, $F0, $0F, $0A, $F0, $E0, $FF, $E2, $D0, $E2, $F0
	dc.b	$E8, $F1, $0F, $0A, $FF, $F0, $E2, $D2, $E1, $F1, $E5, $F0, $E1, $F2, $0F, $0C ;0x120
	dc.b	$FC, $E2, $D2, $E1, $F4, $E5, $F5, $00, $F2, $0F, $06, $FA, $E2, $D2, $E3, $F5
	dc.b	$E1, $F3, $E1, $F2, $E2, $F0, $0F, $06, $F9, $E2, $D2, $E5, $FB, $E5, $F0, $0F ;0x140
	dc.b	$06, $F9, $E2, $D3, $E3, $F8, $E4, $F2, $E2, $F0, $0F, $03, $F3, $E1, $F5, $E3
	dc.b	$D1, $E4, $F6, $E2, $F6, $E2, $F0, $0F, $03, $F1, $E2, $F6, $E9, $FE, $E0, $F0 ;0x160
	dc.b	$E0, $F3, $0F, $03, $F1, $E2, $F7, $E6, $FE, $E1, $F1, $E0, $F2, $E0, $F0, $0F
	dc.b	$02, $FF, $FF, $F1, $E0, $F3, $E0, $F2, $E0, $F0, $0F, $03, $FF, $FE, $E1, $F4 ;0x180
	dc.b	$E0, $F2, $E0, $F0, $0F, $03, $FF, $FD, $E0, $F5, $E0, $F3, $E0, $F0, $0F, $04
	dc.b	$FF, $FA, $E1, $F6, $E0, $F3, $E0, $F0, $0F, $04, $FF, $F9, $E0, $F7, $E0, $F4 ;0x1A0
	dc.b	$E0, $F0, $0F, $04, $FF, $F0, $E0, $F5, $E1, $F6, $E1, $F5, $E0, $F0, $0F, $03
	dc.b	$FF, $F0, $E1, $F2, $E2, $F7, $E0, $F7, $E0, $F0, $0F, $03, $FF, $E2, $F0, $00 ;0x1C0
	dc.b	$F3, $03, $F1, $E1, $F7, $E0, $F0, $0F, $03, $F6, $07, $F4, $09, $FB, $E0, $F0
	dc.b	$0F, $03, $F3, $0B, $F2, $0E, $F6, $E0, $F0, $0F, $04, $F0, $0F, $0F, $02, $F2 ;0x1E0
	dc.b	$E1, $F0, $0F, $0F, $0F, $08, $F0, $E2, $F1, $0F, $0F, $0F, $07, $F5, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x200
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $05 ;0x220
loc_C082:
	dc.b	$0F, $04, $FD, $0F, $0F, $0D, $F3, $60, $41, $C9, $D0, $F2, $0F, $0F, $08, $F1
	dc.b	$62, $C0, $D2, $C1, $DB, $F1, $0F, $0F, $04, $F1, $62, $C2, $D0, $50, $D2, $52 ;0x0 (0x0000C082-0x0000C4DD, Entry count: 0x45B)
	dc.b	$76, $D2, $C0, $F0, $0F, $0F, $01, $F1, $62, $C2, $D1, $56, $79, $D1, $E0, $F0
	dc.b	$0F, $0F, $F0, $62, $C2, $D1, $70, $56, $7B, $D0, $E1, $F0, $0F, $0C, $F1, $61 ;0x20
	dc.b	$C2, $D1, $71, $55, $7E, $D0, $E0, $D0, $F0, $0F, $0A, $F0, $40, $61, $D0, $C0
	dc.b	$D1, $73, $54, $7F, $70, $E1, $F0, $0F, $09, $F0, $41, $C0, $D2, $74, $54, $7F ;0x40
	dc.b	$71, $D0, $E0, $D0, $F0, $0F, $07, $F0, $41, $C1, $D0, $76, $53, $7F, $73, $E1
	dc.b	$F0, $0F, $06, $F0, $41, $C2, $D0, $50, $75, $52, $77, $5A, $71, $E1, $F0, $0F ;0x60
	dc.b	$06, $F0, $40, $C2, $D0, $52, $74, $51, $74, $5F, $50, $D0, $E1, $F0, $0F, $04
	dc.b	$F0, $40, $C2, $D0, $55, $72, $50, $72, $5F, $53, $D1, $E0, $F0, $0F, $03, $F0 ;0x80
	dc.b	$40, $C2, $D0, $50, $7C, $5F, $53, $D1, $E0, $F0, $0F, $03, $F0, $C2, $D0, $78
	dc.b	$50, $B1, $76, $5F, $D1, $E0, $F0, $0F, $02, $F0, $60, $C0, $D1, $77, $51, $70 ;0xA0
	dc.b	$F0, $B1, $79, $59, $F5, $0F, $02, $F0, $C0, $D0, $78, $51, $71, $F1, $B1, $7B
	dc.b	$50, $F5, $B4, $E0, $F0, $0F, $01, $F0, $C0, $D0, $76, $53, $72, $F1, $B1, $7A ;0xC0
	dc.b	$F0, $B5, $E6, $F0, $0F, $F0, $60, $C0, $D0, $74, $54, $73, $50, $F1, $B0, $50
	dc.b	$78, $F0, $B0, $E7, $73, $E1, $F0, $0E, $F0, $C0, $D0, $74, $55, $73, $51, $F0 ;0xE0
	dc.b	$B1, $50, $77, $F0, $B0, $E2, $79, $E0, $F0, $0E, $F0, $C0, $D0, $73, $55, $74
	dc.b	$51, $F1, $B1, $50, $77, $F0, $B0, $E0, $7A, $E0, $F0, $0E, $F0, $C0, $D0, $72 ;0x100
	dc.b	$56, $74, $52, $F1, $B1, $50, $76, $F0, $B0, $E0, $7A, $E0, $F0, $0E, $F0, $C0
	dc.b	$D0, $71, $56, $75, $53, $F1, $B1, $50, $75, $F0, $B0, $E0, $7B, $E0, $F0, $0D ;0x120
	dc.b	$F0, $D0, $72, $56, $76, $53, $F1, $B1, $50, $74, $F0, $B0, $E0, $7B, $E0, $F0
	dc.b	$0D, $F0, $D0, $71, $56, $77, $54, $F1, $B1, $50, $73, $F0, $B0, $E0, $7B, $E0 ;0x140
	dc.b	$F0, $0D, $F0, $E0, $70, $57, $77, $55, $F1, $B0, $51, $72, $F0, $B0, $E0, $7C
	dc.b	$E0, $F0, $0C, $F0, $E0, $58, $77, $56, $F0, $B1, $51, $72, $F0, $B0, $E0, $7B ;0x160
	dc.b	$E0, $F0, $0C, $F0, $E0, $57, $78, $56, $F1, $B1, $51, $70, $D0, $F0, $B0, $E0
	dc.b	$7B, $E0, $F0, $0D, $F0, $57, $78, $57, $F1, $B0, $A0, $50, $E1, $F0, $B0, $E0 ;0x180
	dc.b	$7B, $E0, $F0, $0D, $F0, $57, $76, $F0, $71, $57, $F0, $B1, $A0, $D0, $E0, $F0
	dc.b	$B0, $E0, $7C, $E0, $F0, $0C, $F0, $E0, $56, $75, $F0, $C0, $F0, $70, $58, $F0 ;0x1A0
	dc.b	$B1, $A0, $E0, $F0, $B0, $E0, $7C, $E0, $F1, $0C, $F0, $56, $75, $F0, $D0, $F0
	dc.b	$70, $57, $D1, $F0, $B1, $A0, $F1, $B0, $E0, $7A, $61, $B1, $F2, $09, $F0, $D0 ;0x1C0
	dc.b	$54, $76, $F0, $D0, $F0, $70, $55, $D4, $F0, $B1, $A0, $F0, $B0, $E0, $77, $66
	dc.b	$B2, $F2, $07, $F0, $D0, $53, $76, $F0, $D0, $F0, $71, $51, $D5, $E1, $F1, $B0 ;0x1E0
	dc.b	$A0, $F0, $B0, $E0, $72, $6E, $B2, $F1, $06, $F0, $D1, $51, $76, $F0, $D0, $F0
	dc.b	$D1, $E2, $D2, $E1, $F3, $B1, $A0, $F0, $B0, $6F, $64, $B0, $E0, $F0, $06, $F0 ;0x200
	dc.b	$E2, $D6, $F0, $D0, $F0, $D0, $E1, $F0, $E3, $F1, $02, $F1, $B1, $A0, $F0, $B1
	dc.b	$6F, $61, $70, $B0, $E0, $F0, $07, $F1, $E2, $D4, $F0, $D0, $F0, $E1, $F0, $00 ;0x220
	dc.b	$F4, $04, $F1, $B1, $A0, $F0, $E0, $B1, $6D, $71, $F0, $B1, $E0, $F0, $08, $F1
	dc.b	$E5, $F0, $D0, $F5, $73, $F1, $02, $F2, $B1, $A0, $F0, $E1, $B2, $67, $72, $F1 ;0x240
	dc.b	$00, $F0, $B0, $E0, $F0, $0A, $F6, $D0, $F0, $7A, $F0, $00, $F0, $B0, $E0, $F1
	dc.b	$B1, $A0, $F1, $E2, $B1, $61, $73, $F2, $02, $F0, $B0, $E0, $F0, $07, $F4, $73 ;0x260
	dc.b	$F0, $D0, $F0, $7B, $F1, $B0, $E0, $F2, $B1, $A0, $F3, $E1, $B0, $E0, $F3, $05
	dc.b	$F0, $B1, $E0, $F0, $01, $F4, $73, $F5, $D0, $FD, $70, $F1, $01, $F1, $B0, $A0 ;0x280
	dc.b	$F0, $02, $F1, $B0, $E0, $F0, $09, $F0, $B0, $E0, $F0, $00, $F0, $60, $76, $F0
	dc.b	$EF, $E4, $F0, $70, $F1, $00, $F1, $B1, $A0, $F0, $02, $F0, $B1, $E0, $F0, $08 ;0x2A0
	dc.b	$F0, $B0, $E0, $F0, $01, $F0, $61, $74, $F0, $E0, $DF, $D4, $F0, $71, $F0, $00
	dc.b	$F1, $B1, $A0, $F0, $02, $F0, $B0, $E0, $F0, $09, $F1, $03, $F0, $63, $71, $F0 ;0x2C0
	dc.b	$E0, $D1, $E0, $F0, $E0, $D0, $E7, $F0, $D0, $E0, $F0, $E0, $D1, $F0, $72, $F3
	dc.b	$B1, $A0, $F0, $01, $F0, $B0, $E0, $F0, $0F, $00, $F0, $63, $70, $F0, $E0, $D5 ;0x2E0
	dc.b	$F8, $D5, $F0, $74, $F2, $B0, $F0, $02, $F0, $B0, $E0, $F0, $0F, $01, $F0, $63
	dc.b	$F0, $E0, $D1, $E0, $F0, $E0, $DA, $E0, $F0, $E0, $D1, $F0, $75, $F2, $03, $F0 ;0x300
	dc.b	$B1, $E0, $F0, $0F, $01, $F0, $62, $F0, $E0, $D0, $F1, $E0, $F0, $E0, $D0, $E5
	dc.b	$F0, $D0, $F1, $E0, $F0, $E0, $D0, $F0, $75, $61, $F0, $03, $F0, $B1, $E0, $F0 ;0x320
	dc.b	$0F, $02, $F0, $61, $F0, $E0, $D0, $F0, $E0, $F0, $E0, $F0, $D0, $E0, $F0, $E1
	dc.b	$F0, $E0, $F0, $D0, $F0, $E0, $F0, $E0, $F0, $D0, $F0, $73, $64, $F1, $02, $F7 ;0x340
	dc.b	$0F, $F0, $60, $F0, $E0, $D0, $F1, $E0, $F0, $E0, $D0, $E5, $F0, $D0, $F1, $E0
	dc.b	$F0, $E0, $D0, $F0, $63, $71, $64, $F0, $01, $F2, $60, $A0, $C0, $80, $20, $F1 ;0x360
	dc.b	$0E, $F1, $E0, $D1, $F2, $D1, $F6, $D1, $F2, $D1, $F0, $65, $70, $64, $F2, $60
	dc.b	$A2, $C1, $81, $20, $F0, $0E, $F1, $D6, $E0, $F0, $E0, $F0, $E0, $F0, $E0, $D6 ;0x380
	dc.b	$F0, $66, $71, $62, $F1, $60, $A2, $C3, $81, $30, $F0, $0E, $FF, $F5, $71, $67
	dc.b	$71, $F1, $61, $A2, $C3, $82, $30, $F0, $0E, $F0, $61, $7F, $72, $6A, $F0, $70 ;0x3A0
	dc.b	$60, $A3, $C4, $81, $90, $F0, $0F, $F0, $62, $77, $6F, $62, $F1, $61, $A3, $C4
	dc.b	$81, $90, $30, $F0, $0F, $F0, $64, $71, $6F, $65, $F0, $70, $61, $A3, $C4, $80 ;0x3C0
	dc.b	$91, $30, $F0, $0F, $00, $F0, $64, $71, $6F, $62, $71, $F0, $71, $60, $A3, $C4
	dc.b	$80, $91, $30, $F0, $0F, $01, $F0, $64, $71, $6C, $74, $61, $F1, $70, $60, $A3 ;0x3E0
	dc.b	$C4, $92, $30, $F0, $0F, $02, $F0, $64, $72, $66, $74, $66, $F0, $71, $A3, $C3
	dc.b	$D0, $92, $F0, $0F, $04, $F0, $65, $71, $61, $74, $6A, $F1, $71, $A2, $C2, $D0 ;0x400
	dc.b	$92, $30, $F0, $0F, $05, $F0, $65, $73, $6A, $F3, $00, $F1, $70, $B1, $A0, $D3
	dc.b	$91, $30, $F0, $0F, $07, $F0, $6F, $F3, $05, $F1, $70, $B2, $D1, $91, $30, $F0 ;0x420
	dc.b	$0F, $09, $F0, $6A, $F3, $0A, $F2, $70, $B0, $D0, $90, $30, $F1, $0F, $0B, $F0
	dc.b	$65, $F3, $0F, $00, $F5, $0F, $0E, $F5, $0F, $0F, $02 ;0x440
loc_C4DD:
	dc.b	$0F, $0F, $0F, $0F, $02, $F3, $0F, $0F, $0F, $09, $F6, $0F, $0F, $0F, $07, $F8
	dc.b	$0F, $0F, $0F, $06, $F8, $0F, $0F, $0F, $06, $F9, $0F, $0F, $0F, $05, $F9, $0F ;0x0 (0x0000C4DD-0x0000C6C0, Entry count: 0x1E3) [Unknown data]
	dc.b	$0F, $0F, $05, $FA, $0F, $0F, $0F, $05, $F9, $0F, $0F, $0F, $06, $F1, $00, $F5
	dc.b	$0F, $0F, $0F, $09, $F5, $0F, $0F, $0F, $0A, $F4, $0F, $0F, $0F, $0A, $F5, $0F ;0x20
	dc.b	$0F, $0F, $0A, $F4, $0F, $0F, $0F, $0A, $F4, $0F, $0F, $0F, $0A, $F4, $0F, $0F
	dc.b	$0F, $0B, $F4, $0F, $0F, $0F, $0A, $F4, $0F, $0F, $0F, $0A, $F4, $0F, $0F, $0F ;0x40
	dc.b	$0B, $F4, $0C, $F7, $0F, $0F, $05, $F4, $08, $FE, $0F, $0F, $03, $F3, $05, $FF
	dc.b	$F3, $0F, $0F, $01, $F4, $02, $FF, $F6, $0F, $0F, $00, $F4, $00, $FF, $F9, $0C ;0x60
	dc.b	$F0, $0F, $02, $FF, $FF, $F0, $02, $F1, $04, $F2, $0F, $01, $FF, $FF, $F2, $00
	dc.b	$F3, $02, $F3, $0F, $00, $FF, $FF, $F9, $00, $F4, $0F, $FF, $FF, $FF, $0E, $FF ;0x80
	dc.b	$FF, $FF, $F1, $0D, $FF, $FF, $FF, $F2, $0C, $FF, $FF, $FF, $F3, $0B, $FF, $FF
	dc.b	$FF, $F3, $0A, $FF, $FF, $FF, $F5, $09, $FF, $FF, $FD, $90, $F4, $80, $F0, $09 ;0xA0
	dc.b	$FF, $FF, $FC, $91, $F0, $90, $F4, $09, $FF, $FF, $FD, $80, $D0, $F6, $07, $FF
	dc.b	$FF, $FF, $F2, $E1, $F2, $07, $FF, $F3, $00, $FF, $FE, $E0, $F1, $E0, $07, $FF ;0xC0
	dc.b	$F3, $02, $FF, $FE, $E1, $06, $FF, $F4, $04, $FF, $F2, $E1, $F4, $70, $F0, $E0
	dc.b	$00, $E0, $06, $FF, $F4, $05, $FE, $E3, $F0, $E0, $F0, $72, $F0, $00, $E0, $00 ;0xE0
	dc.b	$E0, $06, $FF, $F3, $07, $FB, $E1, $F1, $E0, $F0, $E0, $F4, $03, $E0, $05, $FA
	dc.b	$00, $F8, $08, $FD, $E0, $F0, $E0, $F1, $0E, $FA, $00, $F7, $09, $FC, $E0, $F1 ;0x100
	dc.b	$E0, $F2, $0D, $F9, $01, $F7, $0A, $FA, $E0, $F1, $E0, $F3, $0D, $F8, $02, $F6
	dc.b	$0B, $FC, $E0, $F4, $0D, $F7, $03, $F6, $0B, $FC, $E0, $F4, $0D, $F6, $05, $F4 ;0x120
	dc.b	$0D, $FF, $F2, $0D, $F5, $05, $F4, $0D, $F9, $00, $F7, $0D, $F5, $06, $F3, $0E
	dc.b	$F7, $02, $F6, $0D, $F4, $07, $F3, $0F, $F6, $03, $F6, $0D, $F3, $08, $F3, $0E ;0x140
	dc.b	$F7, $02, $F6, $0D, $F3, $08, $F3, $0F, $F6, $03, $F6, $0D, $F2, $08, $F3, $0F
	dc.b	$00, $F5, $04, $F5, $0D, $F3, $07, $F3, $0F, $01, $F5, $04, $F4, $0D, $F3, $08 ;0x160
	dc.b	$F3, $0F, $01, $F4, $05, $F4, $0C, $F3, $08, $F5, $0F, $00, $F4, $04, $F4, $0C
	dc.b	$F3, $08, $F6, $0F, $00, $F3, $05, $F4, $0B, $F5, $07, $F3, $E0, $F0, $E0, $0F ;0x180
	dc.b	$F4, $05, $F3, $0B, $F6, $07, $F1, $00, $E0, $F0, $E0, $0F, $00, $F3, $05, $F5
	dc.b	$0A, $F1, $E0, $F0, $E0, $F0, $E0, $0F, $0D, $F3, $05, $F3, $E0, $F0, $E0, $0A ;0x1A0
	dc.b	$F0, $E0, $F0, $E0, $F0, $E0, $0F, $0D, $F5, $04, $F1, $00, $E0, $F0, $E0, $0F
	dc.b	$0F, $0E, $F1, $E0, $F0, $E0, $F0, $E0, $0F, $0F, $0F, $09, $F0, $E0, $F0, $E0 ;0x1C0
	dc.b	$F0, $E0, $09 ;0x1E0
loc_C6C0:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $03, $F8 ;0x0 (0x0000C6C0-0x0000C86A, Entry count: 0x1AA)
	dc.b	$0F, $0F, $0F, $03, $F2, $78, $F1, $0F, $0F, $0F, $F1, $7D, $F1, $0F, $0F, $0C
	dc.b	$F0, $73, $62, $7A, $F0, $0F, $0F, $0A, $F0, $72, $66, $79, $F0, $0F, $0F, $08 ;0x20
	dc.b	$F0, $72, $65, $7C, $F0, $0F, $0F, $06, $F0, $72, $64, $7F, $F0, $0F, $0F, $04
	dc.b	$F0, $72, $64, $7F, $70, $F0, $0F, $0F, $04, $F0, $72, $63, $7F, $72, $F0, $0F ;0x40
	dc.b	$0F, $02, $F0, $75, $60, $7F, $73, $F0, $0F, $0F, $02, $F0, $7F, $7A, $F0, $0F
	dc.b	$0F, $02, $F0, $7F, $7B, $F0, $0F, $0F, $00, $F0, $7F, $7C, $F0, $0F, $0F, $00 ;0x60
	dc.b	$F0, $7F, $7C, $F0, $0F, $0F, $00, $F0, $7F, $7C, $F0, $0F, $0F, $00, $F0, $7F
	dc.b	$7C, $F0, $0F, $0F, $00, $F0, $7F, $7B, $F1, $0F, $0F, $00, $F0, $7F, $7B, $F0 ;0x80
	dc.b	$0F, $0F, $02, $F0, $7F, $7A, $F0, $0F, $0F, $02, $F0, $7F, $79, $F1, $0F, $0F
	dc.b	$02, $F0, $7F, $79, $F0, $0F, $0F, $03, $F0, $7F, $78, $F1, $0F, $0F, $04, $F0 ;0xA0
	dc.b	$7F, $76, $F1, $0F, $0F, $05, $F0, $7F, $75, $F1, $0F, $0F, $07, $F0, $7F, $73
	dc.b	$F1, $0F, $0F, $08, $F0, $7F, $72, $F1, $0F, $0F, $0A, $F0, $7F, $F2, $0F, $0F ;0xC0
	dc.b	$0B, $F0, $7D, $F2, $0F, $0F, $0D, $F0, $D1, $76, $F5, $0F, $0F, $0E, $F0, $62
	dc.b	$D0, $F6, $0F, $0F, $0F, $03, $F0, $71, $61, $F0, $0F, $0F, $0F, $0A, $F0, $72 ;0xE0
	dc.b	$F0, $0F, $0F, $0F, $09, $F0, $E0, $D0, $F1, $0F, $0F, $0F, $0A, $F0, $D0, $F0
	dc.b	$0F, $0F, $0F, $08, $F3, $D0, $F0, $0F, $0F, $0F, $05, $F3, $D3, $E0, $F0, $0F ;0x100
	dc.b	$0F, $0F, $04, $F0, $D3, $E0, $F3, $0F, $0F, $0F, $04, $F0, $D0, $E0, $F3, $0F
	dc.b	$0F, $0F, $07, $F0, $D0, $F1, $0F, $0F, $0F, $0A, $F0, $D0, $E0, $F0, $0F, $0F ;0x120
	dc.b	$0F, $0B, $F0, $D0, $F0, $0F, $0F, $0F, $0C, $F0, $E0, $D0, $F0, $0F, $0F, $0F
	dc.b	$0C, $F0, $E0, $D0, $F0, $0F, $0F, $0F, $0C, $F0, $D0, $F0, $0F, $0F, $0F, $0C ;0x140
	dc.b	$F0, $D0, $F0, $0F, $0F, $0F, $0B, $F0, $D0, $F0, $0F, $0F, $0F, $0B, $F1, $D0
	dc.b	$F0, $0F, $0F, $0F, $09, $F1, $D1, $F0, $0F, $0F, $0F, $07, $F2, $D1, $F1, $0F ;0x160
	dc.b	$0F, $0F, $07, $F0, $D2, $F1, $0F, $0F, $0F, $08, $F0, $D0, $F2, $0F, $0F, $0F
	dc.b	$0B, $F0, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $05 ;0x1A0
loc_C86A:
	dc.b	$0F, $0F, $02, $F2, $0F, $0F, $0F, $0C, $F0, $C0, $D0, $F0, $0F, $0F, $0F, $0A
	dc.b	$F1, $C0, $D0, $F1, $0F, $0F, $0F, $08, $F0, $C0, $F0, $C0, $D0, $F2, $0F, $0F ;0x0 (0x0000C86A-0x0000CB4B, Entry count: 0x2E1) [Unknown data]
	dc.b	$0F, $06, $F0, $C1, $F0, $C0, $D0, $F0, $C0, $F0, $0F, $0F, $0F, $05, $F0, $C2
	dc.b	$F0, $C0, $D0, $F0, $C1, $F0, $0F, $0F, $0F, $03, $F0, $C3, $F0, $C0, $D0, $F0 ;0x20
	dc.b	$C2, $F0, $0F, $0F, $0F, $01, $F0, $C4, $F0, $C0, $D0, $F0, $D0, $C2, $F0, $0F
	dc.b	$0F, $0F, $F0, $C5, $F0, $C0, $D0, $F0, $D0, $C2, $F0, $0F, $0F, $0E, $F0, $C6 ;0x40
	dc.b	$F0, $C0, $D0, $F1, $C3, $F0, $0F, $0F, $0C, $F0, $C7, $F0, $C0, $D0, $F1, $C4
	dc.b	$F0, $0F, $0F, $0B, $F0, $C7, $F0, $C0, $D0, $F1, $C5, $F0, $0F, $0F, $09, $F0 ;0x60
	dc.b	$C8, $F0, $C0, $D0, $F1, $D0, $C4, $F0, $0F, $0F, $08, $F0, $C9, $F0, $C0, $D0
	dc.b	$F1, $D0, $C5, $F0, $0F, $0F, $06, $F0, $CA, $F0, $C0, $D0, $F1, $D0, $C6, $F0 ;0x80
	dc.b	$0F, $0F, $04, $F0, $CB, $F0, $C0, $D0, $F1, $D0, $C6, $F0, $0F, $0F, $03, $F0
	dc.b	$10, $CB, $F0, $C0, $D0, $F1, $D0, $C7, $F0, $0F, $0F, $01, $F0, $11, $CB, $F0 ;0xA0
	dc.b	$C0, $D0, $F1, $D0, $C8, $F0, $0F, $0F, $F0, $13, $CA, $F0, $C0, $D0, $F1, $D0
	dc.b	$C8, $F0, $0F, $0E, $F0, $15, $C9, $F0, $C0, $D0, $F1, $D0, $C9, $F0, $0F, $0C ;0xC0
	dc.b	$F0, $17, $C8, $F0, $C0, $D0, $F1, $D0, $CA, $F0, $0F, $0A, $F0, $19, $C7, $F0
	dc.b	$C0, $D0, $F1, $D1, $C9, $F0, $0F, $09, $F0, $1B, $C6, $F0, $C0, $D0, $F1, $D1 ;0xE0
	dc.b	$CA, $F0, $0F, $07, $F0, $1D, $C5, $F0, $C0, $D0, $F1, $D1, $CB, $F0, $0F, $05
	dc.b	$F0, $1F, $C4, $F0, $C0, $D0, $F1, $D1, $CB, $F0, $0F, $04, $F0, $80, $1F, $10 ;0x100
	dc.b	$C3, $F0, $C0, $D0, $F1, $D1, $CC, $F0, $0F, $02, $F0, $81, $1F, $12, $C1, $F0
	dc.b	$C0, $D0, $F1, $D1, $CD, $F0, $0F, $01, $F0, $82, $1F, $12, $C0, $F0, $C0, $D0 ;0x120
	dc.b	$F1, $D1, $CE, $F0, $0F, $F0, $84, $1F, $11, $E0, $F0, $C0, $D0, $F1, $D1, $CE
	dc.b	$F0, $0E, $F0, $86, $1F, $10, $E0, $F0, $C0, $D0, $F1, $D1, $CF, $F0, $0C, $F0 ;0x140
	dc.b	$88, $1F, $E0, $F0, $C0, $D0, $F0, $D2, $CF, $C0, $F0, $0A, $F0, $8A, $1E, $E0
	dc.b	$F0, $C0, $D0, $F0, $D2, $CF, $C1, $F0, $08, $F0, $8D, $1C, $E0, $F0, $C0, $D0 ;0x160
	dc.b	$F0, $D1, $CF, $C2, $F0, $07, $F0, $8F, $12, $E9, $F0, $C0, $D0, $F0, $D1, $C4
	dc.b	$DE, $F0, $05, $F0, $D0, $83, $9B, $E2, $F9, $D2, $F0, $D0, $C0, $D4, $FF, $04 ;0x180
	dc.b	$F0, $95, $FF, $C8, $D0, $C0, $D3, $F4, $0D, $F0, $05, $F0, $D0, $F4, $CF, $DC
	dc.b	$F1, $0F, $02, $F2, $02, $F0, $C6, $DF, $F9, $D2, $F0, $0D, $F5, $C0, $D1, $F0 ;0x1A0
	dc.b	$01, $F0, $D6, $F6, $E0, $F7, $02, $F6, $C0, $D1, $FE, $C5, $F0, $E0, $F0, $02
	dc.b	$F7, $05, $F0, $D0, $FA, $D6, $C2, $D3, $CA, $F5, $D1, $F0, $0F, $F1, $D0, $F0 ;0x1C0
	dc.b	$DB, $CB, $D1, $E0, $D8, $C3, $D1, $F1, $02, $FC, $CF, $DB, $B1, $E0, $B5, $D0
	dc.b	$C5, $D1, $F0, $02, $F0, $D1, $CA, $D0, $E0, $DB, $E0, $D0, $BB, $CE, $D1, $F1 ;0x1E0
	dc.b	$03, $F0, $E0, $F9, $B1, $E0, $BB, $E0, $B0, $CF, $C9, $D2, $F0, $04, $F0, $D0
	dc.b	$C0, $B7, $CF, $CF, $C9, $D3, $F1, $04, $F0, $D1, $CF, $CF, $CE, $D4, $70, $F1 ;0x200
	dc.b	$05, $F0, $D1, $CF, $CF, $C3, $DA, $74, $F1, $06, $F0, $D2, $C3, $21, $CB, $DF
	dc.b	$D0, $76, $10, $20, $71, $20, $70, $10, $70, $F1, $10, $07, $F0, $D3, $27, $D7 ;0x220
	dc.b	$7A, $2A, $10, $21, $C0, $10, $C0, $11, $70, $11, $22, $05, $2F, $2F, $25, $C1
	dc.b	$10, $20, $C1, $14, $20, $10, $21, $C0, $20, $C0, $23, $02, $2F, $2C, $12, $20 ;0x240
	dc.b	$10, $21, $17, $C0, $21, $10, $C0, $2A, $02, $27, $03, $24, $10, $22, $11, $20
	dc.b	$11, $21, $10, $20, $10, $C1, $21, $10, $C2, $10, $C1, $21, $12, $2D, $0B, $25 ;0x260
	dc.b	$10, $25, $10, $22, $13, $21, $10, $2F, $29, $0C, $2A, $10, $24, $10, $2C, $02
	dc.b	$29, $0F, $07, $2F, $23, $02, $23, $01, $2D, $0F, $03, $2F, $22, $03, $24, $03 ;0x280
	dc.b	$26, $0F, $0C, $2F, $20, $03, $23, $04, $26, $0F, $0D, $2F, $02, $21, $02, $27
	dc.b	$0F, $0F, $03, $29, $02, $23, $01, $25, $0F, $0F, $09, $27, $03, $21, $00, $23 ;0x2A0
	dc.b	$0F, $0F, $0D, $28, $01, $21, $00, $24, $0F, $0F, $0F, $00, $24, $02, $20, $00
	dc.b	$22, $0F, $0F, $0F, $04, $22, $00, $22, $01, $20, $0F, $0F, $0F, $09, $21, $0F ;0x2C0
	dc.b	$09 ;0x2E0
loc_CB4B:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x0000CB4B-0x0000CE78, Entry count: 0x32D) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $6D, $F0, $D0, $6D, $F0, $D0, $0F, $0F, $62, $71, $60, $70, $F0, $60, $F1
	dc.b	$70, $60, $70, $F0, $D0, $62, $71, $60, $70, $F0, $60, $F1, $70, $60, $70, $F0 ;0x40
	dc.b	$D0, $0F, $0F, $60, $70, $60, $F1, $70, $61, $70, $60, $70, $60, $70, $F1, $D0
	dc.b	$60, $70, $60, $F1, $70, $61, $70, $60, $70, $60, $70, $F1, $D0, $0F, $0F, $61 ;0x60
	dc.b	$F0, $60, $F1, $60, $70, $61, $F0, $70, $F0, $70, $F0, $E0, $61, $F0, $60, $F1
	dc.b	$60, $70, $61, $F0, $70, $F0, $70, $F0, $E0, $0F, $0F, $60, $F1, $70, $60, $70 ;0x80
	dc.b	$F1, $70, $F1, $60, $F2, $D0, $60, $F1, $70, $60, $70, $F1, $70, $F1, $60, $F2
	dc.b	$D0, $0F, $0F, $60, $70, $F0, $60, $70, $F0, $70, $F0, $60, $71, $F0, $60, $F1 ;0xA0
	dc.b	$D0, $60, $70, $F0, $60, $70, $F0, $70, $F0, $60, $71, $F0, $60, $F1, $E0, $0F
	dc.b	$0F, $FE, $D0, $FE, $E0, $0F, $0F, $E0, $D0, $E1, $D0, $E0, $D2, $E0, $D1, $E0 ;0xC0
	dc.b	$D6, $E0, $D1, $E0, $D0, $E0, $D0, $E1, $D0, $E1, $0F, $0F, $65, $F0, $D0, $FD
	dc.b	$E0, $D0, $67, $0F, $0F, $60, $F1, $70, $60, $70, $F0, $D0, $F0, $61, $71, $60 ;0xE0
	dc.b	$70, $F0, $60, $F1, $70, $60, $70, $E0, $D0, $62, $71, $60, $70, $F0, $0F, $0F
	dc.b	$70, $60, $70, $60, $70, $F1, $D0, $F0, $70, $60, $F1, $70, $61, $70, $60, $70 ;0x100
	dc.b	$60, $70, $F0, $E0, $D0, $60, $70, $60, $F1, $70, $61, $0F, $0F, $61, $F0, $70
	dc.b	$F0, $70, $F0, $E0, $F0, $60, $F0, $60, $F1, $60, $70, $61, $F0, $70, $F0, $70 ;0x120
	dc.b	$E1, $61, $F0, $60, $F1, $60, $70, $0F, $0F, $70, $F1, $60, $F2, $D0, $F2, $70
	dc.b	$60, $70, $F1, $70, $F1, $60, $F1, $E0, $D0, $60, $F1, $70, $60, $70, $F1, $0F ;0x140
	dc.b	$0F, $60, $71, $F0, $60, $F1, $E0, $F0, $70, $F0, $60, $70, $F0, $70, $F0, $60
	dc.b	$71, $F0, $60, $F0, $E0, $D0, $60, $70, $F0, $60, $70, $F0, $70, $F0, $0F, $0F ;0x160
	dc.b	$F6, $E0, $F0, $ED, $D0, $F7, $0F, $0F, $D0, $E0, $D0, $E1, $DB, $E0, $D6, $E0
	dc.b	$D1, $E1, $D1, $0F, $0F, $6D, $F0, $D0, $6D, $F0, $D0, $0F, $0F, $62, $71, $60 ;0x180
	dc.b	$70, $F0, $60, $F1, $70, $60, $70, $F0, $D0, $62, $71, $60, $70, $F0, $60, $F1
	dc.b	$70, $60, $70, $F0, $D0, $0F, $0F, $60, $70, $60, $F1, $70, $61, $70, $60, $70 ;0x1A0
	dc.b	$60, $70, $F1, $D0, $60, $70, $60, $F1, $70, $61, $70, $60, $70, $60, $70, $F1
	dc.b	$D0, $0F, $0F, $61, $F0, $60, $F1, $60, $70, $61, $F0, $70, $F0, $70, $F0, $E0 ;0x1C0
	dc.b	$61, $F0, $60, $F1, $60, $70, $61, $F0, $70, $F0, $70, $F0, $E0, $0F, $0F, $60
	dc.b	$F1, $70, $60, $70, $F1, $70, $F1, $60, $F2, $D0, $60, $F1, $70, $60, $70, $F1 ;0x1E0
	dc.b	$70, $F1, $60, $F2, $D0, $0F, $0F, $60, $70, $F0, $60, $70, $F0, $70, $F0, $60
	dc.b	$71, $F0, $60, $F1, $E0, $60, $70, $F0, $60, $70, $F0, $70, $F0, $60, $71, $F0 ;0x200
	dc.b	$60, $F1, $D0, $0F, $0F, $FE, $E0, $FE, $D0, $0F, $0F, $D3, $E0, $D0, $E3, $D1
	dc.b	$E0, $D0, $E1, $D1, $E0, $D0, $E0, $D3, $E0, $D1, $E0, $D2, $0F, $0F, $F5, $E0 ;0x220
	dc.b	$D0, $6D, $F0, $D0, $F7, $0F, $0F, $60, $F1, $70, $60, $70, $E0, $D0, $62, $71
	dc.b	$60, $70, $F0, $60, $F1, $70, $60, $70, $F0, $D0, $F0, $61, $71, $60, $70, $F0 ;0x240
	dc.b	$0F, $0F, $70, $60, $70, $60, $70, $F0, $E0, $D0, $60, $70, $60, $F1, $70, $61
	dc.b	$70, $60, $70, $60, $70, $F1, $D0, $F0, $70, $60, $F1, $70, $61, $0F, $0F, $61 ;0x260
	dc.b	$F0, $70, $F0, $70, $E0, $D0, $61, $F0, $60, $F1, $60, $70, $61, $F0, $70, $F0
	dc.b	$70, $F0, $E0, $F0, $60, $F0, $60, $F1, $60, $70, $0F, $0F, $70, $F1, $60, $F1 ;0x280
	dc.b	$E0, $D0, $60, $F1, $70, $60, $70, $F1, $70, $F1, $60, $F2, $D0, $F2, $70, $60
	dc.b	$70, $F1, $0F, $0F, $60, $71, $F0, $60, $F0, $E0, $D0, $60, $70, $F0, $60, $70 ;0x2A0
	dc.b	$F0, $70, $F0, $60, $71, $F0, $60, $F1, $E0, $F0, $70, $F0, $60, $70, $F0, $70
	dc.b	$F0, $0F, $0F, $E6, $D0, $FE, $E0, $F0, $E6, $0F, $0F, $D0, $E0, $D1, $E0, $D1 ;0x2C0
	dc.b	$E2, $D2, $E1, $D1, $E0, $D1, $E0, $D0, $E1, $D3, $E0, $D2, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x2E0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x300
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x320
loc_CE78:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $00, $F0, $0F, $0F, $0F, $07, $F0, $04, $F0, $A0
	dc.b	$F0, $03, $F0, $0F, $0F, $0F, $00, $F0, $A0, $F0, $03, $F0, $A1, $F0, $01, $F0 ;0x0 (0x0000CE78-0x0000D3C9, Entry count: 0x551)
	dc.b	$A0, $F0, $0F, $0F, $0A, $F0, $03, $F0, $A1, $F0, $02, $F0, $A1, $F0, $01, $F0
	dc.b	$A1, $F0, $01, $F0, $0F, $0F, $05, $F0, $A0, $F0, $02, $F0, $A1, $F0, $01, $F0 ;0x20
	dc.b	$A0, $C0, $A0, $F0, $01, $F0, $A1, $F0, $00, $F0, $A0, $F0, $0F, $0F, $04, $F0
	dc.b	$A1, $F0, $00, $F0, $A0, $C0, $A0, $F0, $01, $F0, $A0, $C0, $A0, $F0, $00, $F0 ;0x40
	dc.b	$A0, $C0, $A0, $F0, $00, $F0, $A1, $F0, $0F, $0F, $03, $F0, $A1, $F0, $00, $F0
	dc.b	$A0, $C0, $A0, $F0, $02, $F0, $A0, $F0, $01, $F0, $A0, $C0, $A0, $F0, $00, $F0 ;0x60
	dc.b	$A1, $F0, $0F, $0F, $02, $F0, $A0, $C0, $A0, $F0, $00, $F1, $A0, $F0, $02, $F0
	dc.b	$70, $60, $F0, $02, $F0, $A0, $F0, $00, $F0, $A0, $C0, $A0, $F0, $0F, $0F, $02 ;0x80
	dc.b	$F0, $A0, $C0, $A0, $F1, $A0, $70, $60, $F0, $02, $F0, $40, $70, $F0, $01, $F0
	dc.b	$70, $A0, $F0, $00, $F0, $A0, $C0, $A0, $F0, $0F, $0F, $03, $F0, $A0, $F0, $00 ;0xA0
	dc.b	$F0, $A1, $70, $F0, $02, $F0, $A0, $40, $F0, $01, $F0, $40, $A1, $F0, $00, $F0
	dc.b	$A0, $F0, $0F, $0F, $03, $F0, $70, $60, $F0, $00, $F0, $A1, $40, $F0, $01, $F0 ;0xC0
	dc.b	$70, $A1, $F0, $01, $F0, $60, $A1, $F1, $70, $60, $F0, $0F, $0F, $03, $F0, $40
	dc.b	$70, $F1, $A0, $C0, $A0, $60, $F0, $00, $F0, $61, $A1, $60, $F0, $00, $F0, $A0 ;0xE0
	dc.b	$C0, $A0, $F1, $40, $70, $F0, $0F, $0F, $03, $F0, $60, $40, $F1, $A0, $C0, $A0
	dc.b	$70, $F1, $60, $70, $A0, $C0, $A0, $60, $70, $F1, $A0, $C0, $A0, $F1, $60, $40 ;0x100
	dc.b	$F0, $0F, $0F, $03, $F0, $70, $60, $90, $F1, $A0, $60, $40, $80, $90, $61, $A0
	dc.b	$C0, $A0, $60, $70, $80, $90, $60, $A0, $90, $F1, $70, $60, $90, $F0, $0F, $0F ;0x120
	dc.b	$00, $F1, $80, $40, $70, $91, $70, $60, $70, $60, $92, $61, $A0, $71, $80, $91
	dc.b	$70, $60, $91, $80, $40, $70, $91, $F1, $0F, $09, $F4, $80, $91, $60, $40, $91 ;0x140
	dc.b	$40, $70, $40, $70, $C0, $D1, $C0, $70, $60, $40, $70, $D0, $C1, $40, $70, $90
	dc.b	$D0, $90, $60, $40, $91, $80, $90, $F3, $0F, $04, $F0, $70, $61, $70, $80, $92 ;0x160
	dc.b	$70, $60, $90, $D0, $60, $40, $60, $40, $C1, $D0, $C0, $40, $70, $60, $C3, $60
	dc.b	$40, $C2, $70, $60, $90, $80, $91, $70, $61, $70, $F0, $0F, $02, $F0, $61, $70 ;0x180
	dc.b	$60, $70, $60, $91, $D0, $40, $70, $C1, $70, $60, $70, $60, $C3, $60, $40, $D2
	dc.b	$C1, $70, $60, $C2, $40, $70, $C1, $90, $61, $70, $60, $70, $60, $F0, $0F, $00 ;0x1A0
	dc.b	$F0, $60, $70, $62, $70, $60, $70, $D0, $C0, $60, $40, $D1, $40, $70, $C0, $D3
	dc.b	$C0, $70, $60, $C0, $D3, $40, $70, $D1, $C0, $60, $40, $C1, $60, $70, $62, $70 ;0x1C0
	dc.b	$60, $70, $F0, $0F, $F0, $60, $71, $60, $71, $60, $70, $D1, $70, $60, $D1, $60
	dc.b	$40, $D5, $40, $70, $D0, $C3, $60, $40, $D1, $C0, $70, $60, $C1, $60, $71, $60 ;0x1E0
	dc.b	$71, $60, $70, $F0, $0E, $F0, $C0, $61, $72, $61, $70, $C0, $D0, $C1, $D1, $70
	dc.b	$60, $D1, $C0, $D1, $C0, $60, $40, $D3, $C0, $70, $60, $C0, $D5, $61, $72, $61 ;0x200
	dc.b	$70, $C0, $F0, $0D, $F0, $C1, $62, $80, $90, $71, $D0, $C1, $D2, $40, $70, $D4
	dc.b	$C0, $70, $60, $C4, $40, $70, $C4, $D1, $C0, $60, $80, $90, $61, $71, $C0, $F0 ;0x220
	dc.b	$0D, $F0, $C2, $70, $80, $92, $C0, $90, $C3, $D0, $60, $40, $C4, $D0, $40, $70
	dc.b	$C0, $D0, $C2, $60, $40, $C5, $90, $C0, $80, $92, $71, $C1, $F0, $0D, $F0, $D0 ;0x240
	dc.b	$C3, $91, $C0, $90, $80, $90, $C3, $70, $60, $D1, $C2, $70, $60, $40, $70, $C3
	dc.b	$70, $60, $D4, $90, $80, $90, $C0, $91, $D0, $C2, $E0, $F0, $0D, $F0, $D0, $C0 ;0x260
	dc.b	$D1, $C0, $D1, $82, $91, $C4, $D3, $61, $70, $60, $70, $60, $C3, $D4, $82, $91
	dc.b	$D1, $C0, $D0, $C0, $D0, $E0, $F0, $0E, $F0, $C0, $D1, $C2, $90, $80, $92, $D0 ;0x280
	dc.b	$80, $90, $D0, $C3, $60, $70, $62, $70, $60, $70, $D3, $C0, $80, $90, $C0, $90
	dc.b	$80, $92, $C1, $D2, $E0, $F0, $0F, $F0, $C6, $92, $D0, $80, $92, $C0, $80, $90 ;0x2A0
	dc.b	$D0, $60, $71, $60, $71, $60, $70, $C0, $80, $90, $D0, $80, $92, $C0, $92, $D2
	dc.b	$C0, $D1, $E0, $F0, $0F, $F0, $D0, $C2, $D0, $C1, $D3, $C0, $91, $D0, $80, $92 ;0x2C0
	dc.b	$61, $72, $61, $70, $80, $92, $C0, $91, $D4, $C2, $D1, $E1, $F0, $0E, $F0, $C0
	dc.b	$D2, $E0, $D0, $C2, $D2, $C0, $D1, $C1, $91, $D1, $64, $71, $D0, $91, $D3, $C0 ;0x2E0
	dc.b	$D0, $C0, $D0, $C3, $D0, $E2, $D0, $F0, $0D, $F0, $C0, $D2, $E0, $D2, $C4, $D0
	dc.b	$C0, $D0, $C0, $D2, $C1, $74, $D3, $C1, $D0, $C5, $E0, $C0, $E0, $D0, $E2, $D0 ;0x300
	dc.b	$F0, $0D, $F0, $C1, $D1, $E0, $D0, $E3, $C2, $E0, $D1, $C5, $D4, $C3, $D1, $C4
	dc.b	$D0, $E0, $C0, $E4, $D1, $F0, $0D, $F0, $C2, $DD, $C2, $D0, $C0, $E1, $D0, $C1 ;0x320
	dc.b	$E0, $C1, $E0, $D2, $C1, $D1, $E1, $D0, $E4, $D0, $E0, $F0, $0D, $F0, $D1, $C2
	dc.b	$D3, $E0, $D0, $E0, $D0, $E1, $D0, $E0, $D4, $E2, $D4, $E1, $D0, $C0, $D3, $E5 ;0x340
	dc.b	$D2, $E0, $F0, $0E, $F0, $D0, $C2, $D9, $E0, $D0, $E2, $D0, $E4, $D0, $ED, $C0
	dc.b	$E1, $D1, $E1, $F0, $0E, $F0, $D0, $C3, $DF, $D5, $E1, $D4, $E1, $D2, $E6, $F0 ;0x360
	dc.b	$0F, $F0, $E0, $D2, $C1, $D1, $C1, $D0, $C0, $DF, $D8, $C0, $D0, $E2, $D0, $E1
	dc.b	$D0, $F0, $0E, $F0, $C0, $D1, $E0, $D0, $C4, $E0, $C2, $D0, $C0, $D4, $C1, $D5 ;0x380
	dc.b	$C1, $D6, $C0, $D3, $C0, $E2, $D0, $F0, $0D, $F0, $C0, $D1, $E0, $D1, $C3, $E0
	dc.b	$D1, $C1, $D1, $C6, $D3, $C3, $D3, $C0, $D3, $C0, $E4, $D0, $F0, $0D, $F0, $C0 ;0x3A0
	dc.b	$D0, $C0, $D1, $E0, $D1, $C0, $D3, $C2, $D1, $E0, $C5, $D0, $C9, $E0, $D2, $E6
	dc.b	$D0, $F0, $0D, $F0, $D0, $C1, $D5, $E2, $D1, $C4, $D0, $E1, $C3, $D1, $C2, $D0 ;0x3C0
	dc.b	$C2, $D3, $E0, $D0, $E4, $D0, $E0, $F0, $0C, $F1, $D0, $C1, $D2, $C0, $D0, $E0
	dc.b	$D5, $C1, $D2, $E1, $D1, $C4, $E0, $D2, $E0, $C1, $E3, $D0, $E3, $C0, $E1, $F1 ;0x3E0
	dc.b	$09, $F1, $22, $C5, $D4, $E1, $D1, $E1, $D0, $E1, $D6, $E2, $D0, $E7, $D0, $E1
	dc.b	$C0, $D1, $E0, $32, $F1, $06, $F0, $24, $D0, $C0, $D0, $C2, $D1, $C1, $D2, $E2 ;0x400
	dc.b	$D4, $E7, $D1, $E0, $D3, $C0, $E0, $D2, $C0, $D2, $E0, $34, $F0, $04, $F0, $25
	dc.b	$D3, $E0, $C1, $D0, $C1, $DF, $D8, $C4, $D2, $E0, $D0, $E0, $35, $F0, $02, $F0 ;0x420
	dc.b	$25, $C0, $D4, $E0, $D1, $C0, $D0, $C1, $D4, $C3, $D9, $C0, $D2, $C1, $D3, $E4
	dc.b	$D0, $35, $F0, $01, $F0, $25, $C0, $D5, $C0, $D0, $C1, $D0, $C2, $D0, $C3, $D0 ;0x440
	dc.b	$C2, $D5, $C3, $D0, $C2, $E0, $D2, $E4, $D0, $35, $F0, $00, $F0, $26, $C0, $DA
	dc.b	$E0, $C6, $D0, $C0, $D0, $C2, $D1, $C1, $D0, $C6, $D0, $E7, $D0, $36, $F1, $26 ;0x460
	dc.b	$D0, $C2, $D4, $E1, $D3, $C1, $D6, $C4, $E2, $C1, $D1, $E1, $D1, $E5, $D0, $E0
	dc.b	$36, $F1, $26, $DE, $E0, $D0, $E2, $D1, $E0, $D0, $C0, $D1, $C0, $D0, $E2, $D2 ;0x480
	dc.b	$E0, $D1, $E1, $D1, $E1, $D1, $E1, $36, $F1, $30, $26, $D2, $C2, $DF, $D2, $E0
	dc.b	$D0, $E1, $D0, $E0, $D0, $E2, $D1, $C1, $E2, $C0, $D1, $E0, $37, $F1, $30, $27 ;0x4A0
	dc.b	$D3, $C1, $D1, $C0, $DF, $DA, $C0, $D3, $E2, $38, $F0, $00, $F0, $30, $27, $D0
	dc.b	$E0, $D1, $C0, $D1, $C0, $D8, $C0, $DB, $C4, $D0, $C0, $E0, $D0, $E2, $38, $F0 ;0x4C0
	dc.b	$01, $F0, $31, $28, $D2, $E0, $D1, $C5, $D2, $C1, $D2, $C3, $D2, $C2, $E0, $C0
	dc.b	$D3, $E1, $3A, $F0, $02, $F0, $31, $29, $D3, $E0, $D2, $C0, $D0, $C1, $E0, $C4 ;0x4E0
	dc.b	$D1, $C1, $D0, $C2, $E0, $D2, $E3, $3B, $F0, $04, $F0, $32, $2B, $D2, $E0, $D1
	dc.b	$C0, $D5, $E0, $D3, $E0, $D1, $E4, $3E, $F0, $06, $F1, $32, $2E, $D2, $EC, $3F ;0x500
	dc.b	$31, $F1, $09, $F1, $32, $2F, $26, $3F, $35, $F1, $0D, $F1, $33, $2F, $2B, $3B
	dc.b	$F1, $0F, $01, $F2, $34, $2F, $2B, $34, $F2, $0F, $06, $F3, $37, $2D, $37, $F3 ;0x520
	dc.b	$0F, $0D, $F5, $3F, $31, $F5, $0F, $0F, $07, $FF, $F1, $0F, $0F, $0F, $0F, $0F
	dc.b	$06 ;0x540
loc_D3C9:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x0000D3C9-0x0000D5B8, Entry count: 0x1EF) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $01, $F2, $0F, $0F, $0F, $06, $F3, $00, $F0, $21, $F2, $0F, $0F, $0F ;0x40
	dc.b	$03, $F5, $24, $F2, $0F, $0F, $0E, $F5, $B1, $F0, $21, $32, $21, $F2, $0F, $0B
	dc.b	$FF, $F2, $D0, $F1, $B2, $F2, $34, $21, $F2, $0F, $07, $F1, $70, $66, $F1, $A2 ;0x60
	dc.b	$F3, $C0, $F0, $D0, $F1, $B2, $F0, $01, $F0, $35, $21, $F2, $0F, $03, $F1, $70
	dc.b	$60, $F7, $B3, $F3, $C2, $F0, $E0, $F1, $B0, $F6, $35, $20, $30, $F4, $0E, $F0 ;0x80
	dc.b	$70, $61, $F7, $B3, $F5, $C0, $D0, $F0, $E0, $FB, $35, $F0, $72, $F4, $09, $F1
	dc.b	$70, $61, $F8, $B2, $F5, $D2, $F2, $92, $F0, $93, $F3, $33, $F0, $70, $64, $70 ;0xA0
	dc.b	$F3, $05, $F1, $70, $69, $FB, $D0, $F3, $93, $F4, $71, $F1, $31, $F0, $69, $70
	dc.b	$F2, $03, $F1, $70, $6F, $60, $F1, $61, $FE, $72, $F2, $76, $65, $70, $F2, $01 ;0xC0
	dc.b	$FF, $F5, $6F, $F4, $67, $74, $63, $70, $F1, $00, $F1, $75, $F6, $74, $FF, $FF
	dc.b	$F0, $61, $73, $61, $70, $F0, $00, $F0, $75, $F8, $73, $F1, $70, $F2, $7D, $F0 ;0xE0
	dc.b	$75, $F9, $60, $73, $F2, $74, $F2, $E4, $F2, $72, $F1, $7F, $71, $F0, $74, $F1
	dc.b	$E4, $F1, $71, $F2, $70, $F5, $72, $F1, $E1, $F2, $E1, $F1, $72, $F1, $7F, $71 ;0x100
	dc.b	$F0, $73, $F1, $E1, $F2, $E1, $F1, $73, $FA, $E1, $F0, $C0, $D1, $F0, $E1, $FF
	dc.b	$FD, $E1, $F0, $D1, $C0, $F0, $E1, $F0, $73, $F1, $60, $F0, $00, $F5, $E0, $F0 ;0x120
	dc.b	$C1, $D2, $F0, $E0, $F0, $74, $F1, $7E, $F0, $74, $F0, $E0, $F0, $D2, $C1, $F0
	dc.b	$E0, $F4, $71, $F0, $02, $F4, $E0, $F0, $D1, $C0, $D1, $F0, $E0, $F1, $74, $F1 ;0x140
	dc.b	$7D, $F0, $74, $F0, $E0, $F0, $D1, $C0, $D1, $F0, $E0, $F0, $73, $F1, $03, $F1
	dc.b	$E1, $F0, $E0, $F0, $D2, $E1, $FF, $FF, $E0, $F0, $E1, $D2, $F7, $05, $F3, $E1 ;0x160
	dc.b	$F0, $D1, $E0, $F5, $EF, $E8, $F1, $E1, $F0, $E0, $D1, $F4, $E1, $F1, $09, $F8
	dc.b	$00, $FF, $FB, $00, $FC, $0C, $F6, $0F, $0F, $F6, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x1A0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x1C0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $09 ;0x1E0
loc_D5B8:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x0000D5B8-0x0000D7B3, Entry count: 0x1FB) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $02, $F5, $0F, $0F, $0F, $07, $F1, $A4, $B0, $F0, $0F, $0F, $0F, $05
	dc.b	$F1, $B1, $A1, $B1, $F1, $01, $F2, $0F, $0F, $0F, $00, $F0, $B3, $A0, $B0, $F0 ;0x40
	dc.b	$30, $F2, $A0, $F0, $E0, $F0, $0F, $0F, $0F, $F0, $B3, $A0, $B0, $C0, $30, $A2
	dc.b	$B0, $F2, $0F, $0F, $0F, $F0, $B2, $A0, $F0, $B7, $F0, $0F, $0F, $0F, $00, $F0 ;0x60
	dc.b	$B2, $F0, $B8, $F0, $0F, $0F, $0F, $00, $F0, $B2, $F0, $B2, $F0, $B3, $F0, $0F
	dc.b	$0F, $0F, $F1, $70, $F2, $B4, $F3, $0F, $0F, $0F, $F0, $B0, $F0, $60, $70, $F1 ;0x80
	dc.b	$B2, $F0, $B1, $F0, $0F, $0F, $0F, $00, $F0, $B2, $F0, $60, $71, $F5, $0F, $0F
	dc.b	$0F, $01, $F0, $B2, $A0, $F1, $72, $F1, $0F, $0F, $0F, $02, $F0, $B4, $A1, $F1 ;0xA0
	dc.b	$D0, $C0, $F1, $0F, $0F, $0F, $00, $F1, $B5, $A1, $F0, $D1, $F1, $0F, $0F, $0F
	dc.b	$F0, $B0, $F0, $B6, $A1, $F1, $A0, $F0, $0F, $0F, $0E, $F0, $B1, $F1, $B5, $A3 ;0xC0
	dc.b	$B0, $F0, $0F, $0F, $0E, $F0, $B2, $F1, $B5, $A2, $B0, $F0, $0F, $0F, $0D, $F0
	dc.b	$BB, $A2, $F0, $0F, $0F, $0E, $F0, $BB, $A1, $B0, $F0, $0F, $0F, $0D, $F0, $BB ;0xE0
	dc.b	$F0, $A1, $B0, $F0, $0F, $0F, $05, $F1, $05, $F0, $B5, $F0, $B4, $F0, $A0, $B1
	dc.b	$F0, $0F, $0F, $03, $F1, $B1, $F0, $03, $F0, $B6, $F0, $B4, $F0, $B2, $F0, $0F ;0x100
	dc.b	$0F, $02, $F0, $B4, $F0, $01, $F0, $B1, $A3, $B1, $F1, $B3, $F0, $B2, $F0, $0F
	dc.b	$0F, $02, $F0, $B1, $F0, $B1, $F0, $00, $F0, $B4, $F0, $A3, $F0, $B3, $F0, $B2 ;0x120
	dc.b	$F0, $0F, $0F, $03, $F2, $B1, $F0, $00, $F0, $B5, $F0, $A2, $F1, $B2, $F0, $B2
	dc.b	$F0, $0F, $0F, $05, $F0, $B1, $F1, $B6, $F1, $A2, $F0, $B1, $F1, $B2, $F0, $0F ;0x140
	dc.b	$0F, $05, $F0, $B1, $F1, $B7, $F0, $A1, $B0, $F0, $B1, $F1, $B2, $F0, $0F, $0F
	dc.b	$05, $F0, $B1, $F1, $B7, $F0, $B1, $F1, $B1, $F2, $B1, $F0, $0F, $0F, $06, $F0 ;0x160
	dc.b	$B0, $F1, $B7, $F4, $B1, $F2, $B1, $F1, $0F, $0F, $05, $F0, $B1, $F1, $B5, $F1
	dc.b	$B0, $F2, $B0, $F3, $B1, $F2, $0F, $0F, $05, $F0, $B1, $F0, $B9, $F2, $B1, $F1 ;0x180
	dc.b	$B1, $F0, $B1, $F0, $0F, $0F, $05, $F4, $B3, $F0, $B2, $F1, $B3, $F0, $B0, $F0
	dc.b	$B1, $E0, $F0, $0F, $0F, $0A, $F9, $B0, $E0, $B0, $E0, $F6, $0F, $0F, $0F, $03 ;0x1A0
	dc.b	$F5, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x1C0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0A ;0x1E0
loc_D7B3:
	dc.b	$0F, $0F, $00, $F1, $0F, $0F, $0F, $0C, $F0, $B1, $F0, $0F, $0F, $0F, $08, $F1
	dc.b	$00, $F2, $0F, $0F, $0F, $08, $F0, $B1, $F1, $B0, $F0, $0F, $0F, $0F, $07, $F0 ;0x0 (0x0000D7B3-0x0000DAD5, Entry count: 0x322)
	dc.b	$B0, $F1, $B1, $F0, $00, $F1, $01, $F2, $0F, $0F, $0F, $F0, $B0, $F0, $01, $F1
	dc.b	$00, $F0, $B1, $F2, $B0, $F0, $0F, $0F, $0F, $F0, $B0, $F5, $B0, $F1, $B2, $F1 ;0x20
	dc.b	$0F, $0F, $0F, $F0, $B7, $F0, $00, $F2, $0F, $0F, $0F, $00, $F0, $B2, $A4, $B1
	dc.b	$F0, $0F, $0F, $0F, $01, $F4, $E2, $F5, $0F, $0F, $0E, $F6, $E0, $D0, $C0, $D0 ;0x40
	dc.b	$E0, $F5, $0F, $0F, $0F, $00, $F0, $B2, $F1, $E1, $F6, $0F, $0F, $0F, $F0, $B1
	dc.b	$A0, $F0, $A1, $F2, $B2, $F1, $0F, $0F, $0F, $00, $F0, $B0, $A0, $F1, $A6, $B0 ;0x60
	dc.b	$F0, $0F, $0F, $0F, $00, $F0, $B1, $A2, $F2, $B0, $A2, $B0, $F0, $0F, $0F, $0F
	dc.b	$00, $F0, $B1, $A9, $B0, $F0, $0F, $0F, $0F, $F0, $B1, $A2, $B0, $F0, $B0, $A5 ;0x80
	dc.b	$B0, $F0, $0F, $0F, $0D, $F0, $B2, $AB, $B0, $F0, $0F, $0F, $0B, $F1, $B2, $AD
	dc.b	$B0, $F1, $0F, $0F, $07, $F1, $B2, $AF, $A1, $B0, $F1, $0F, $0F, $04, $F0, $B2 ;0xA0
	dc.b	$AF, $A5, $B0, $F1, $0F, $0F, $00, $F1, $B1, $AF, $A4, $B0, $A3, $B0, $F1, $0F
	dc.b	$0D, $F0, $B2, $AF, $A6, $B0, $F0, $A3, $B0, $F1, $0F, $0A, $F0, $B2, $AF, $A8 ;0xC0
	dc.b	$B0, $F0, $A4, $B0, $F0, $0F, $08, $F0, $B2, $AF, $AA, $B0, $F0, $A4, $B0, $F0
	dc.b	$0F, $06, $F0, $B2, $AF, $AC, $B0, $F0, $A4, $B0, $F0, $0F, $04, $F0, $B2, $A6 ;0xE0
	dc.b	$B3, $AF, $A3, $B0, $F0, $B0, $A3, $B0, $F0, $0F, $02, $F0, $B3, $A3, $B0, $F2
	dc.b	$B1, $AF, $A5, $B0, $F0, $B0, $A3, $B0, $F0, $0F, $01, $F1, $B3, $A1, $B0, $F0 ;0x100
	dc.b	$B4, $AF, $A6, $B0, $F0, $A4, $F0, $0F, $02, $F1, $B2, $A2, $B0, $F0, $B3, $AF
	dc.b	$A7, $F0, $B0, $A2, $B0, $F0, $0F, $03, $F1, $B2, $A2, $F1, $B1, $AF, $A8, $B0 ;0x120
	dc.b	$F0, $A2, $F1, $0F, $04, $F1, $B2, $A1, $B0, $F0, $B1, $AF, $A9, $F0, $B0, $A0
	dc.b	$B0, $F0, $0F, $06, $F1, $B1, $A2, $F0, $B2, $AE, $B0, $A8, $B0, $F0, $B0, $F1 ;0x140
	dc.b	$0F, $07, $F1, $B1, $A0, $B0, $F0, $B3, $AB, $B0, $F0, $A9, $B0, $F0, $B0, $F0
	dc.b	$0F, $08, $F0, $B1, $A1, $B0, $F0, $B4, $A9, $B0, $F0, $B2, $A7, $B0, $F0, $B0 ;0x160
	dc.b	$F0, $0F, $07, $F0, $B1, $A1, $B0, $F1, $B6, $AF, $A3, $B1, $F0, $A1, $F0, $0F
	dc.b	$05, $F0, $B1, $A0, $B1, $F3, $B7, $AF, $A0, $B1, $F0, $B0, $A2, $F1, $0F, $03 ;0x180
	dc.b	$F1, $B0, $F8, $B8, $AB, $B2, $F1, $B3, $A1, $F0, $0F, $03, $F9, $70, $F1, $BB
	dc.b	$A3, $B3, $F5, $B3, $F0, $0F, $06, $F6, $72, $F2, $BE, $F2, $60, $F1, $01, $F3 ;0x1A0
	dc.b	$0F, $07, $F1, $71, $F3, $72, $FF, $F0, $63, $F1, $0F, $0C, $F1, $73, $FD, $71
	dc.b	$62, $F0, $32, $F0, $61, $F0, $30, $F1, $0F, $0B, $F1, $73, $F0, $31, $FA, $64 ;0x1C0
	dc.b	$F0, $33, $F1, $30, $F0, $60, $F0, $0F, $0B, $F2, $71, $F1, $33, $F0, $62, $F0
	dc.b	$33, $F0, $62, $F0, $31, $F2, $32, $F0, $60, $F0, $0F, $0B, $F5, $33, $F0, $64 ;0x1E0
	dc.b	$F0, $33, $F2, $31, $F0, $62, $F0, $32, $F1, $0F, $0A, $F5, $34, $F0, $64, $F0
	dc.b	$37, $F0, $70, $63, $F0, $31, $F1, $0F, $0A, $F7, $33, $F0, $62, $F0, $35, $F3 ;0x200
	dc.b	$64, $F0, $30, $F0, $61, $F0, $0F, $09, $F4, $72, $F0, $33, $F2, $32, $F5, $31
	dc.b	$F0, $62, $F0, $30, $F0, $62, $F0, $0F, $0A, $F2, $74, $F0, $34, $F7, $34, $F2 ;0x220
	dc.b	$31, $F0, $62, $F0, $0F, $0B, $F2, $73, $F0, $33, $F1, $60, $70, $F4, $30, $F2
	dc.b	$36, $F0, $60, $F1, $0F, $0D, $F3, $70, $F0, $33, $F0, $63, $F4, $62, $F0, $36 ;0x240
	dc.b	$F2, $0F, $0E, $F0, $B0, $F5, $31, $F0, $61, $F4, $70, $63, $F0, $31, $F4, $0F
	dc.b	$0F, $00, $F0, $B5, $F6, $01, $F9, $B0, $F1, $0F, $0F, $01, $F3, $A1, $B1, $F0 ;0x260
	dc.b	$0B, $F1, $B2, $A0, $B0, $F1, $0F, $0F, $01, $F0, $C1, $E0, $F3, $E0, $F0, $0B
	dc.b	$F0, $B1, $A1, $F3, $0F, $0F, $F0, $C0, $E1, $D0, $F0, $C1, $E0, $F1, $0A, $F5 ;0x280
	dc.b	$E1, $F2, $0F, $0D, $F5, $C0, $E1, $D0, $F0, $C0, $F0, $09, $F1, $E3, $FB, $0F
	dc.b	$04, $F2, $E3, $F2, $D0, $E0, $F0, $C0, $F0, $09, $F5, $E0, $C1, $D1, $F3, $C2 ;0x2A0
	dc.b	$F1, $0F, $01, $F1, $E2, $D1, $E0, $D0, $C0, $F5, $09, $F1, $C0, $D0, $F1, $C0
	dc.b	$F0, $D0, $C0, $F3, $C4, $D0, $F0, $0F, $F1, $E2, $D0, $C2, $D1, $C0, $F1, $E0 ;0x2C0
	dc.b	$C0, $F0, $08, $F2, $C0, $D0, $F2, $C0, $E0, $C0, $F2, $D0, $E2, $D0, $C1, $F1
	dc.b	$0E, $F2, $E1, $D0, $C5, $F0, $E0, $F1, $09, $F0, $D0, $FB, $E4, $D0, $C0, $E0 ;0x2E0
	dc.b	$F0, $0E, $F0, $E0, $F9, $C1, $F0, $0B, $F0, $D0, $C3, $D1, $E1, $F9, $C0, $F0
	dc.b	$0E, $F1, $E3, $D2, $C2, $F1, $0D, $F7, $E2, $D2, $C4, $F1, $0F, $FA, $0F, $07 ;0x300
	dc.b	$FB, $06 ;0x320
loc_DAD5:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x0000DAD5-0x0000DC92, Entry count: 0x1BD) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $01, $F8, $0F, $0F, $0F, $06, $F0, $D4
	dc.b	$F0, $0F, $0F, $0F, $08, $F0, $E5, $F0, $0F, $0F, $0F, $07, $F0, $D1, $E0, $D3 ;0x40
	dc.b	$F3, $06, $F1, $0F, $0F, $0A, $F0, $D1, $E0, $D4, $F9, $B0, $F7, $0F, $0F, $04
	dc.b	$F0, $D1, $E0, $D4, $FF, $F1, $0F, $0F, $04, $F0, $D1, $E0, $D5, $F0, $C2, $D3 ;0x60
	dc.b	$F3, $0F, $0F, $07, $F2, $D1, $E0, $D6, $F0, $C2, $D0, $C1, $D3, $F3, $0B, $F7
	dc.b	$0F, $F0, $E0, $F0, $D1, $E0, $D7, $F0, $C1, $D0, $C5, $D3, $F4, $02, $F3, $32 ;0x80
	dc.b	$24, $F1, $0D, $F0, $E0, $F0, $D2, $E0, $D7, $F0, $C1, $D0, $C6, $F9, $C2, $F0
	dc.b	$34, $24, $F1, $0C, $F2, $D1, $E0, $D8, $F9, $CD, $F2, $34, $22, $30, $F0, $0A ;0xA0
	dc.b	$70, $FE, $CD, $D8, $C3, $F2, $36, $F2, $06, $70, $61, $F0, $E1, $F0, $CB, $DF
	dc.b	$CB, $F6, $C1, $D0, $F3, $02, $61, $C0, $F0, $E1, $F0, $DF, $DF, $D1, $CC, $D0 ;0xC0
	dc.b	$C4, $D0, $F1, $00, $70, $61, $FC, $DF, $DD, $C7, $D0, $C6, $D0, $F0, $00, $70
	dc.b	$F1, $DB, $FF, $F9, $DF, $D0, $F3, $03, $F2, $E7, $D1, $F0, $C3, $D0, $CB, $D3 ;0xE0
	dc.b	$F0, $E2, $FF, $F1, $08, $F0, $C6, $D1, $F1, $C3, $D0, $CA, $D2, $F1, $E1, $DB
	dc.b	$F0, $0F, $F0, $C5, $D1, $F0, $01, $F0, $C3, $D0, $C7, $D3, $F0, $EF, $F0, $0F ;0x100
	dc.b	$00, $F0, $C3, $D1, $F0, $02, $F0, $D4, $C6, $D2, $FF, $F2, $0F, $01, $F0, $C2
	dc.b	$D1, $F0, $03, $F0, $C3, $D0, $C5, $D2, $F0, $0F, $0F, $04, $F5, $05, $F0, $C2 ;0x120
	dc.b	$D0, $C3, $D2, $F1, $0F, $0F, $0F, $F2, $C3, $D0, $C1, $D2, $F0, $0F, $0F, $0F
	dc.b	$01, $F0, $A1, $F0, $D6, $F1, $0F, $0F, $0F, $02, $FA, $A0, $F5, $0F, $0F, $0E ;0x140
	dc.b	$F0, $AF, $F1, $0F, $0F, $0B, $FA, $B0, $F5, $0F, $0F, $0D, $F0, $B1, $F0, $06
	dc.b	$F1, $0F, $0F, $0F, $02, $F2, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x160
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0C ;0x1A0
loc_DC92:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x0000DC92-0x0000DE79, Entry count: 0x1E7) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0B, $F5, $0F, $0F, $0F, $06, $F2, $B5, $F1, $0F, $0F, $0F, $02, $F1, $BA
	dc.b	$F2, $00, $F1, $0F, $0F, $0A, $F1, $BD, $F2, $0F, $0F, $0B, $F0, $BF, $B0, $F4 ;0x40
	dc.b	$0F, $0F, $07, $F0, $BF, $B6, $F1, $0F, $0F, $04, $F0, $BF, $B9, $F0, $0F, $0F
	dc.b	$03, $F0, $BF, $BA, $F0, $0F, $0F, $01, $F0, $BF, $B0, $F0, $B9, $F0, $0F, $0F ;0x60
	dc.b	$01, $F0, $BE, $F2, $B0, $F0, $B8, $F0, $0F, $0F, $00, $F0, $BC, $F3, $B1, $F1
	dc.b	$B7, $F0, $0F, $0F, $F0, $BB, $F2, $71, $F0, $B0, $F0, $60, $F1, $B6, $F0, $0F ;0x80
	dc.b	$0F, $F0, $B9, $F2, $72, $F2, $62, $F0, $B6, $F0, $0F, $0F, $F0, $B7, $F2, $73
	dc.b	$60, $F0, $65, $F1, $B4, $F0, $0F, $0E, $F0, $B6, $F2, $71, $F3, $70, $61, $F3 ;0xA0
	dc.b	$61, $F2, $B2, $F0, $0F, $0C, $F1, $B3, $F1, $B0, $F0, $61, $F0, $70, $F0, $C0
	dc.b	$30, $20, $72, $61, $C0, $30, $20, $F0, $60, $F0, $61, $F0, $B0, $F1, $0F, $0D ;0xC0
	dc.b	$F6, $B0, $F1, $60, $F0, $70, $C1, $31, $C0, $71, $60, $C1, $31, $C0, $60, $F0
	dc.b	$60, $F1, $B0, $F0, $0F, $0F, $04, $F0, $B0, $F1, $60, $F0, $71, $C2, $60, $70 ;0xE0
	dc.b	$62, $C2, $61, $F0, $60, $F1, $B0, $F0, $0F, $0F, $04, $F0, $B0, $F0, $71, $60
	dc.b	$70, $63, $71, $6A, $F0, $B0, $F0, $0F, $0F, $04, $F0, $B0, $F0, $71, $60, $70 ;0x100
	dc.b	$63, $71, $6A, $F0, $B0, $F0, $0F, $0F, $04, $F0, $B1, $F0, $70, $60, $70, $63
	dc.b	$F0, $6A, $F0, $B1, $F0, $0F, $0F, $04, $F1, $B0, $F0, $73, $63, $F2, $67, $F0 ;0x120
	dc.b	$B0, $F1, $0F, $0F, $05, $F0, $B1, $F1, $71, $64, $F0, $70, $65, $F1, $B1, $F0
	dc.b	$0F, $0F, $06, $F1, $B1, $F1, $71, $60, $70, $64, $70, $62, $F1, $B1, $F1, $0F ;0x140
	dc.b	$0F, $07, $F1, $B0, $F1, $72, $60, $F4, $63, $F1, $B0, $F1, $0F, $0F, $09, $F0
	dc.b	$B1, $F1, $71, $68, $F1, $B1, $F0, $0F, $0F, $0A, $F1, $B0, $F1, $72, $61, $F1 ;0x160
	dc.b	$63, $F1, $B0, $F1, $0F, $0F, $0B, $F4, $71, $61, $70, $63, $F5, $0F, $0F, $0E
	dc.b	$F2, $71, $64, $F2, $0F, $0F, $0F, $04, $F1, $71, $62, $F1, $0F, $0F, $0F, $07 ;0x180
	dc.b	$F6, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x1A0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x1C0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0A ;0x1E0
loc_DE79:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $06, $F4 ;0x0 (0x0000DE79-0x0000E11C, Entry count: 0x2A3)
	dc.b	$0F, $0F, $0F, $07, $F2, $74, $F0, $0F, $0F, $01, $F8, $0A, $F0, $72, $60, $74
	dc.b	$F0, $0F, $0F, $F0, $43, $60, $73, $F1, $07, $F0, $70, $64, $74, $F0, $0F, $0D ;0x20
	dc.b	$F0, $43, $60, $76, $F0, $00, $F3, $00, $F0, $70, $64, $75, $F0, $0F, $0D, $F0
	dc.b	$C3, $60, $F2, $74, $F0, $62, $70, $F0, $60, $43, $F1, $75, $F0, $0F, $0D, $F0 ;0x40
	dc.b	$43, $60, $F0, $01, $F1, $74, $61, $70, $10, $60, $42, $F2, $74, $F0, $0F, $0E
	dc.b	$F0, $43, $60, $F0, $02, $F1, $73, $61, $70, $20, $60, $41, $22, $75, $F0, $0F ;0x60
	dc.b	$0F, $F0, $43, $60, $F2, $12, $72, $61, $70, $60, $42, $11, $75, $10, $F3, $0F
	dc.b	$0C, $F1, $64, $72, $22, $72, $60, $70, $60, $41, $20, $76, $25, $F4, $0F, $03 ;0x80
	dc.b	$F3, $12, $67, $75, $60, $78, $1C, $F2, $0D, $F2, $29, $68, $70, $60, $77, $2F
	dc.b	$21, $F0, $0A, $F1, $1F, $7B, $40, $1F, $12, $32, $F0, $08, $F0, $30, $2F, $21 ;0xA0
	dc.b	$42, $72, $41, $70, $45, $2C, $35, $F0, $08, $F0, $30, $24, $19, $45, $72, $42
	dc.b	$63, $45, $16, $37, $F0, $08, $F0, $30, $2B, $45, $62, $22, $42, $60, $22, $62 ;0xC0
	dc.b	$45, $60, $3A, $F0, $08, $F0, $30, $29, $45, $61, $15, $43, $15, $61, $41, $62
	dc.b	$70, $39, $F0, $08, $F0, $30, $28, $61, $40, $63, $27, $40, $63, $25, $31, $61 ;0xE0
	dc.b	$72, $38, $F0, $0A, $F0, $31, $26, $62, $70, $31, $21, $16, $61, $15, $35, $73
	dc.b	$38, $F0, $0A, $F0, $30, $20, $32, $23, $62, $70, $30, $2F, $37, $73, $38, $F0 ;0x100
	dc.b	$0A, $F0, $30, $22, $32, $21, $62, $70, $30, $28, $13, $3A, $73, $38, $F0, $0A
	dc.b	$F0, $30, $25, $31, $70, $61, $70, $30, $2A, $3C, $72, $39, $F0, $0A, $F0, $30 ;0x120
	dc.b	$27, $71, $60, $70, $30, $2A, $3C, $72, $39, $F0, $0A, $F0, $30, $28, $73, $31
	dc.b	$28, $3B, $73, $39, $F0, $0A, $F0, $30, $28, $61, $71, $34, $25, $3B, $73, $39 ;0x140
	dc.b	$F0, $0A, $F0, $30, $28, $62, $70, $30, $21, $34, $22, $3B, $73, $39, $F0, $0A
	dc.b	$F0, $30, $28, $62, $70, $30, $24, $3F, $30, $73, $39, $F0, $0A, $F0, $30, $28 ;0x160
	dc.b	$62, $70, $30, $27, $3D, $73, $39, $F0, $0A, $F0, $30, $28, $62, $70, $30, $29
	dc.b	$3B, $73, $39, $F0, $0B, $F0, $30, $27, $62, $70, $30, $29, $3B, $73, $38, $F0 ;0x180
	dc.b	$0C, $F0, $30, $27, $62, $70, $30, $29, $3B, $73, $38, $F0, $0C, $F0, $30, $27
	dc.b	$62, $70, $30, $29, $3B, $73, $38, $F0, $0C, $F0, $30, $27, $62, $70, $30, $29 ;0x1A0
	dc.b	$3B, $73, $38, $F0, $0C, $F0, $30, $27, $62, $70, $30, $29, $3B, $73, $38, $F0
	dc.b	$0C, $F0, $30, $27, $62, $70, $30, $29, $3B, $73, $38, $F0, $0C, $F0, $30, $27 ;0x1C0
	dc.b	$62, $70, $30, $29, $3B, $73, $38, $F0, $0C, $F0, $30, $27, $62, $70, $30, $29
	dc.b	$3B, $73, $38, $F0, $0C, $F0, $30, $27, $62, $70, $30, $29, $3B, $73, $38, $F0 ;0x1E0
	dc.b	$0C, $F0, $30, $27, $62, $70, $30, $29, $3B, $73, $38, $F0, $0C, $F0, $30, $27
	dc.b	$62, $70, $30, $29, $3B, $73, $38, $F0, $0C, $F0, $30, $27, $62, $70, $30, $29 ;0x200
	dc.b	$3B, $73, $38, $F0, $0D, $F0, $31, $25, $62, $70, $30, $29, $3B, $73, $37, $F0
	dc.b	$0F, $F1, $31, $23, $62, $70, $30, $29, $3B, $73, $34, $F2, $0F, $02, $F1, $31 ;0x220
	dc.b	$21, $62, $70, $30, $29, $3B, $73, $32, $F1, $0F, $07, $F1, $31, $70, $61, $70
	dc.b	$30, $29, $3B, $73, $F2, $0F, $0B, $F1, $71, $60, $70, $30, $29, $3B, $71, $F1 ;0x240
	dc.b	$0F, $0F, $00, $F1, $71, $31, $28, $3B, $F1, $0F, $0F, $04, $F3, $31, $26, $38
	dc.b	$F2, $0F, $0F, $0A, $F1, $32, $23, $36, $F1, $0F, $0F, $0F, $F2, $31, $21, $33 ;0x260
	dc.b	$F2, $0F, $0F, $0F, $04, $F1, $33, $F1, $0F, $0F, $0F, $09, $F3, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x280
	dc.b	$0F, $0F, $0E ;0x2A0
loc_E11C:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x0000E11C-0x0000E279, Entry count: 0x15D)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0A, $F8, $0F, $0F, $0F, $04, $F1, $A8, $F1, $0F, $0F ;0x40
	dc.b	$0F, $00, $F1, $AC, $F1, $0F, $0F, $0D, $F0, $AF, $A0, $F0, $0F, $0F, $0B, $F0
	dc.b	$AF, $A2, $F0, $0F, $0F, $09, $F0, $AF, $A4, $F0, $0F, $0F, $07, $F0, $AF, $A6 ;0x60
	dc.b	$F0, $0F, $0F, $05, $F0, $A6, $F1, $A6, $F1, $A6, $F0, $0F, $0F, $04, $F0, $A5
	dc.b	$F3, $A4, $F3, $A5, $F0, $0F, $0F, $03, $F0, $A6, $F3, $A4, $F3, $A6, $F0, $0F ;0x80
	dc.b	$0F, $02, $F0, $A7, $F1, $A6, $F1, $A7, $F0, $0F, $0F, $02, $F0, $AF, $AA, $F0
	dc.b	$0F, $0F, $02, $F0, $AF, $AA, $F0, $0F, $0F, $02, $F0, $AF, $AA, $F0, $0F, $0F ;0xA0
	dc.b	$02, $F0, $A5, $F0, $AC, $F0, $A5, $F0, $0F, $0F, $03, $F0, $A3, $F1, $AC, $F1
	dc.b	$A3, $F0, $0F, $0F, $04, $F0, $A4, $F1, $AA, $F1, $A4, $F0, $0F, $0F, $05, $F0 ;0xC0
	dc.b	$A4, $F2, $A6, $F2, $A4, $F0, $0F, $0F, $07, $F0, $A4, $FA, $A4, $F0, $0F, $0F
	dc.b	$09, $F0, $A5, $F6, $A5, $F0, $0F, $0F, $0B, $F0, $AF, $A0, $F0, $0F, $0F, $0D ;0xE0
	dc.b	$F1, $AC, $F1, $0F, $0F, $0F, $00, $F1, $A8, $F1, $0F, $0F, $0F, $04, $F8, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x100
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x120
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0B ;0x140
loc_E279:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x0000E279-0x0000E4B2, Entry count: 0x239) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $07, $F1, $0F
	dc.b	$0F, $0F, $0C, $F0, $E1, $F0, $0F, $0F, $0F, $0A, $F0, $E3, $F1, $0F, $0F, $0F ;0x20
	dc.b	$08, $F0, $E5, $F1, $0F, $0F, $0F, $07, $F0, $E5, $F3, $0F, $0F, $0F, $03, $F0
	dc.b	$E7, $F5, $0F, $0F, $0F, $01, $F0, $E7, $F7, $0F, $0F, $0D, $F0, $E8, $F8, $0F ;0x40
	dc.b	$0F, $0D, $F0, $E8, $F8, $0F, $0F, $05, $F0, $06, $F0, $E7, $F9, $0F, $0F, $01
	dc.b	$F0, $00, $F0, $D0, $F1, $01, $F0, $01, $F0, $E6, $FA, $0F, $0F, $00, $F0, $D0 ;0x60
	dc.b	$F1, $D2, $F1, $D0, $F3, $E3, $FC, $0F, $0F, $00, $F0, $D2, $F1, $D6, $FF, $F0
	dc.b	$0F, $0F, $00, $F0, $E0, $F0, $E0, $D3, $E1, $DF, $F4, $0F, $0F, $00, $F0, $E1 ;0x80
	dc.b	$D0, $E0, $D3, $EA, $D8, $E0, $F1, $0F, $0F, $00, $F0, $E1, $D1, $E1, $D6, $EA
	dc.b	$D3, $E0, $F1, $0F, $0F, $00, $F0, $E3, $DC, $E6, $D2, $E0, $F1, $0F, $0F, $01 ;0xA0
	dc.b	$F1, $E6, $D8, $E5, $D2, $E0, $F1, $0F, $0F, $03, $F2, $E9, $D1, $E5, $D2, $E1
	dc.b	$F7, $0F, $0F, $00, $F7, $E9, $D2, $E0, $F1, $E0, $D2, $E0, $F2, $0F, $0F, $04 ;0xC0
	dc.b	$F3, $E9, $D0, $E1, $F0, $E0, $D1, $E1, $F3, $0F, $0F, $04, $F2, $E6, $F2, $E3
	dc.b	$F0, $E0, $D0, $E1, $D0, $F4, $0F, $0F, $03, $F2, $E3, $F2, $B0, $D1, $B0, $E0 ;0xE0
	dc.b	$F1, $E1, $D0, $E0, $D1, $60, $F3, $0F, $0F, $02, $F4, $E0, $F1, $B0, $D1, $B0
	dc.b	$D1, $B1, $F2, $E0, $D0, $E0, $D1, $71, $F0, $A1, $F0, $0F, $0F, $00, $F9, $B0 ;0x100
	dc.b	$D0, $B1, $E1, $F4, $D0, $E1, $D2, $A1, $B0, $F0, $0F, $0F, $00, $F2, $B0, $D0
	dc.b	$B0, $FB, $01, $F2, $E2, $F0, $E2, $F0, $0F, $0F, $F2, $D0, $B0, $D1, $F2, $B0 ;0x120
	dc.b	$F2, $E1, $F0, $06, $F4, $E1, $F0, $0F, $0D, $F3, $B0, $D1, $F3, $D0, $B1, $F0
	dc.b	$E1, $F0, $0B, $F0, $E0, $F0, $0F, $0D, $F2, $D0, $F6, $B0, $D1, $E0, $F0, $E0 ;0x140
	dc.b	$F0, $0D, $F0, $0F, $0D, $F1, $D1, $E2, $F3, $D0, $B2, $F0, $E1, $F0, $0F, $0F
	dc.b	$0A, $F2, $D0, $E3, $F2, $00, $F0, $D1, $E0, $F0, $D0, $E0, $F2, $0F, $0F, $08 ;0x160
	dc.b	$F2, $D0, $E3, $F1, $01, $F0, $D0, $B1, $E0, $F0, $E1, $F0, $A0, $B0, $F2, $0F
	dc.b	$0F, $04, $F1, $D1, $E4, $F0, $02, $F0, $E2, $A0, $B0, $F3, $A2, $B0, $F0, $0F ;0x180
	dc.b	$0F, $02, $F1, $D1, $E1, $D0, $E1, $F1, $03, $F3, $A0, $B0, $F2, $A0, $F0, $A1
	dc.b	$F0, $0F, $0F, $01, $F1, $D1, $E1, $D0, $E2, $F0, $07, $F0, $B0, $A1, $B0, $F2 ;0x1A0
	dc.b	$A0, $B0, $F0, $0F, $0F, $01, $F1, $D0, $E1, $D0, $E3, $F0, $07, $F0, $A0, $F0
	dc.b	$A1, $B0, $F0, $A0, $B0, $F0, $0F, $0F, $01, $F1, $D0, $E1, $D0, $E3, $F0, $09 ;0x1C0
	dc.b	$F1, $A1, $B0, $F2, $0F, $0F, $02, $F1, $D0, $E1, $D0, $E2, $F0, $0A, $F0, $A1
	dc.b	$B0, $F0, $0F, $0F, $06, $F1, $D0, $E2, $F1, $0C, $F0, $B0, $F0, $0F, $0F, $09 ;0x1E0
	dc.b	$F3, $0F, $F0, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x200
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0D ;0x220
loc_E4B2:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x0000E4B2-0x0000E60A, Entry count: 0x158)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $07, $F3, $08
	dc.b	$F3, $0F, $0F, $0C, $F1, $73, $F1, $04, $F1, $73, $F1, $0F, $0F, $09, $F0, $77 ;0x40
	dc.b	$F0, $02, $F0, $77, $F0, $0F, $0F, $07, $F0, $79, $F0, $00, $F0, $79, $F0, $0F
	dc.b	$0F, $06, $F0, $79, $F0, $00, $F0, $79, $F0, $0F, $0F, $05, $F0, $7B, $F0, $7B ;0x60
	dc.b	$F0, $0F, $0F, $04, $F0, $7B, $F0, $7B, $F0, $0F, $0F, $04, $F0, $7F, $78, $F0
	dc.b	$0F, $0F, $04, $F0, $7F, $78, $F0, $0F, $0F, $04, $F0, $7F, $78, $F0, $0F, $0F ;0x80
	dc.b	$04, $F0, $7F, $78, $F0, $0F, $0F, $05, $F0, $7F, $76, $F0, $0F, $0F, $06, $F0
	dc.b	$7F, $76, $F0, $0F, $0F, $07, $F0, $7F, $74, $F0, $0F, $0F, $08, $F0, $7F, $74 ;0xA0
	dc.b	$F0, $0F, $0F, $09, $F0, $7F, $72, $F0, $0F, $0F, $0B, $F0, $7F, $70, $F0, $0F
	dc.b	$0F, $0D, $F0, $7E, $F0, $0F, $0F, $0F, $F0, $7C, $F0, $0F, $0F, $0F, $01, $F0 ;0xC0
	dc.b	$7A, $F0, $0F, $0F, $0F, $03, $F0, $78, $F0, $0F, $0F, $0F, $05, $F0, $76, $F0
	dc.b	$0F, $0F, $0F, $07, $F0, $74, $F0, $0F, $0F, $0F, $09, $F0, $72, $F0, $0F, $0F ;0xE0
	dc.b	$0F, $0B, $F0, $70, $F0, $0F, $0F, $0F, $0D, $F0, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x100
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x120
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0E ;0x140
loc_E60A:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $00, $F3, $0F, $0F, $0F
	dc.b	$0A, $F3, $A0, $F1, $02, $F1, $0F, $0F, $0F, $01, $F2, $B1, $F1, $A1, $F0, $00 ;0x0 (0x0000E60A-0x0000E931, Entry count: 0x327) [Unknown data]
	dc.b	$F0, $B0, $F0, $0F, $0F, $0F, $00, $F0, $A1, $F0, $B0, $F0, $B1, $F3, $B1, $F0
	dc.b	$0F, $0F, $0F, $F1, $A1, $F0, $B0, $F1, $B6, $F0, $0F, $0F, $0F, $F0, $A0, $F0 ;0x20
	dc.b	$A0, $F0, $B0, $F1, $B5, $F0, $0F, $0F, $0F, $F0, $A1, $F1, $B6, $C1, $B1, $F0
	dc.b	$0F, $0F, $0C, $F1, $A0, $F0, $A0, $F0, $B8, $C1, $B1, $F0, $0F, $0F, $0A, $F0 ;0x40
	dc.b	$A2, $F1, $B5, $F2, $B0, $C1, $F2, $0F, $0F, $0A, $F0, $A0, $F0, $A0, $F0, $B6
	dc.b	$F1, $B2, $C0, $F0, $B0, $F0, $0F, $0F, $09, $F0, $A1, $F0, $A0, $F0, $BB, $C1 ;0x60
	dc.b	$B0, $F0, $0F, $0F, $09, $F0, $A0, $F0, $A0, $F0, $B5, $F0, $B6, $C0, $B1, $F0
	dc.b	$0F, $0F, $07, $F0, $A1, $F1, $B6, $F0, $B7, $C0, $B0, $F0, $07, $F2, $0F, $0A ;0x80
	dc.b	$F1, $A0, $F0, $A0, $F0, $B7, $F1, $B9, $F0, $04, $F1, $A2, $F1, $0F, $07, $F0
	dc.b	$A2, $F0, $A0, $F0, $B8, $F1, $B4, $F1, $B2, $F0, $02, $F0, $A6, $F0, $01, $F6 ;0xA0
	dc.b	$0B, $F1, $A3, $F1, $B9, $F3, $B3, $F0, $B2, $F0, $01, $F0, $A4, $F1, $A1, $F1
	dc.b	$B6, $F1, $06, $F3, $A0, $F0, $A0, $F0, $A0, $F0, $B9, $F1, $01, $F1, $B6, $F0 ;0xC0
	dc.b	$00, $F0, $A4, $F1, $00, $F1, $BA, $F6, $B2, $F0, $A0, $F0, $A0, $F1, $BA, $F0
	dc.b	$04, $F0, $B0, $F0, $B2, $F0, $01, $F0, $A4, $F0, $01, $F0, $BF, $B6, $F2, $BB ;0xE0
	dc.b	$F1, $04, $F0, $B1, $F2, $01, $F0, $A4, $F1, $00, $F0, $BF, $BF, $B6, $F0, $06
	dc.b	$F3, $02, $F0, $A4, $F0, $01, $F0, $BF, $BF, $B6, $F0, $0D, $F0, $A4, $F0, $00 ;0x100
	dc.b	$F0, $BF, $BF, $B7, $F0, $0D, $F0, $A4, $F2, $BF, $BF, $B7, $F0, $0D, $F0, $A5
	dc.b	$F1, $BF, $BF, $B6, $F1, $0D, $F0, $A5, $F1, $BA, $F0, $BF, $BA, $F0, $0E, $F0 ;0x120
	dc.b	$A6, $F0, $BA, $F0, $BB, $F0, $BC, $F1, $0E, $F0, $A6, $F0, $BA, $F0, $BA, $F0
	dc.b	$BD, $F1, $0E, $F0, $A6, $F0, $BA, $F0, $BA, $F0, $BD, $F1, $0E, $F0, $A6, $F0 ;0x140
	dc.b	$B9, $F2, $B9, $F0, $BC, $F1, $0F, $00, $F0, $A4, $F2, $B8, $F3, $B8, $F0, $B8
	dc.b	$F0, $B1, $F2, $0F, $00, $F0, $A4, $F2, $B7, $F6, $B7, $F0, $B7, $F4, $0F, $01 ;0x160
	dc.b	$F0, $A4, $F3, $B5, $F1, $B1, $F8, $B2, $F0, $B6, $F5, $0F, $02, $F0, $A3, $F1
	dc.b	$00, $F1, $B3, $F1, $B2, $F0, $01, $FA, $B4, $F2, $B1, $F1, $0F, $02, $F0, $A3 ;0x180
	dc.b	$F0, $01, $F1, $B3, $F0, $B2, $F0, $07, $F5, $B4, $F1, $B2, $F0, $0F, $03, $F0
	dc.b	$A2, $F1, $02, $F0, $B3, $F0, $B0, $F1, $0E, $F0, $B3, $F1, $B2, $F0, $0F, $03 ;0x1A0
	dc.b	$F0, $A2, $F1, $02, $F0, $B3, $F0, $B0, $F0, $0F, $F0, $B3, $F1, $B2, $F0, $0F
	dc.b	$03, $F0, $A2, $F0, $03, $F0, $B3, $F1, $0F, $00, $F0, $B2, $F0, $00, $F0, $B2 ;0x1C0
	dc.b	$F0, $0F, $02, $F0, $A2, $F1, $03, $F0, $B2, $F2, $0F, $00, $F0, $B2, $F0, $00
	dc.b	$F0, $B2, $F0, $0F, $02, $F0, $A1, $F1, $04, $F0, $B2, $F1, $0F, $01, $F0, $B2 ;0x1E0
	dc.b	$F0, $00, $F0, $B1, $F1, $0F, $01, $F0, $A1, $F1, $04, $F0, $B3, $F1, $0F, $01
	dc.b	$F0, $B2, $F2, $B1, $F0, $0F, $02, $F3, $05, $F0, $B2, $F1, $0F, $01, $F0, $B3 ;0x200
	dc.b	$F1, $B2, $F0, $0F, $0C, $F0, $B2, $F1, $0F, $01, $F0, $B3, $F1, $B2, $F0, $0F
	dc.b	$0C, $F1, $B1, $F1, $0F, $01, $F0, $B2, $F0, $00, $F1, $B1, $F0, $0F, $0D, $F0 ;0x220
	dc.b	$B1, $F0, $0F, $02, $F1, $B1, $F0, $01, $F0, $B1, $F0, $0F, $0D, $F0, $B1, $F0
	dc.b	$0F, $03, $F0, $B1, $F0, $01, $F0, $B1, $F0, $0F, $0D, $F0, $B2, $F0, $0F, $01 ;0x240
	dc.b	$F0, $B2, $F0, $01, $F0, $B1, $F0, $0F, $0D, $F0, $B2, $F0, $0F, $01, $F0, $B2
	dc.b	$F0, $01, $F0, $B1, $F0, $0F, $0C, $F2, $B1, $F0, $0F, $01, $F0, $B2, $F0, $01 ;0x260
	dc.b	$F0, $B1, $F0, $0F, $0C, $F0, $D0, $F0, $B1, $F0, $0F, $01, $F0, $B2, $F0, $01
	dc.b	$F0, $C0, $B0, $F0, $0F, $0C, $F0, $D0, $F0, $B0, $C0, $F1, $0F, $00, $F0, $C0 ;0x280
	dc.b	$B1, $F0, $00, $F0, $D0, $C1, $F0, $0F, $0C, $F0, $D0, $F0, $C1, $F1, $0F, $F0
	dc.b	$C2, $F0, $01, $F0, $D1, $C0, $F0, $0F, $0C, $F0, $E0, $F0, $C2, $F0, $0F, $F0 ;0x2A0
	dc.b	$D0, $C1, $F0, $01, $F1, $D0, $C0, $F0, $0F, $0C, $F0, $E0, $F0, $D0, $C1, $F0
	dc.b	$0F, $F0, $D1, $C0, $F0, $02, $F0, $D0, $C1, $F0, $0F, $0B, $F0, $E0, $F0, $D0 ;0x2C0
	dc.b	$E1, $F1, $0E, $F1, $D0, $C1, $F0, $01, $F0, $D0, $E1, $F0, $0F, $0B, $F2, $E3
	dc.b	$F0, $0F, $F0, $D0, $E1, $F1, $00, $F0, $E3, $F0, $0F, $0C, $F0, $E3, $F0, $0F ;0x2E0
	dc.b	$F0, $E3, $F0, $00, $F0, $E3, $F0, $0F, $0D, $F4, $0F, $F0, $E3, $F0, $01, $F4
	dc.b	$0F, $0F, $0F, $03, $F4, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x300
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $07 ;0x320
loc_E931:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $09, $FB, $0F, $0F, $0F, $F3, $7B, $F3, $0F, $0F, $08 ;0x0 (0x0000E931-0x0000EB6A, Entry count: 0x239) [Unknown data]
	dc.b	$F2, $7F, $73, $F2, $0F, $0F, $02, $F2, $7F, $79, $F2, $0F, $0E, $F0, $7F, $7F
	dc.b	$F0, $0F, $0B, $F1, $7F, $7F, $71, $F1, $0F, $07, $F1, $7D, $F9, $7D, $F1, $0F ;0x20
	dc.b	$04, $F0, $7B, $F3, $09, $F3, $7B, $F0, $0F, $02, $F0, $79, $F2, $0F, $01, $F2
	dc.b	$79, $F0, $0F, $00, $F0, $78, $F1, $0F, $07, $F1, $78, $F0, $0E, $F0, $77, $F1 ;0x40
	dc.b	$0F, $0B, $F1, $77, $F0, $0C, $F0, $77, $F0, $0F, $0F, $F0, $77, $F0, $0A, $F0
	dc.b	$77, $F0, $0F, $0E, $F1, $79, $F0, $08, $F0, $77, $F0, $0F, $0E, $F0, $7C, $F0 ;0x60
	dc.b	$07, $F0, $76, $F0, $0F, $0E, $F0, $7D, $F0, $06, $F0, $76, $F0, $0F, $0D, $F1
	dc.b	$77, $F0, $76, $F0, $04, $F0, $76, $F0, $0F, $0D, $F0, $77, $F1, $00, $F0, $76 ;0x80
	dc.b	$F0, $03, $F0, $76, $F0, $0F, $0C, $F0, $77, $F0, $02, $F0, $76, $F0, $03, $F0
	dc.b	$75, $F0, $0F, $0B, $F1, $77, $F0, $04, $F0, $75, $F0, $02, $F0, $76, $F0, $0F ;0xA0
	dc.b	$0A, $F0, $77, $F1, $05, $F0, $76, $F0, $01, $F0, $75, $F0, $0F, $09, $F1, $77
	dc.b	$F0, $08, $F0, $75, $F0, $01, $F0, $75, $F0, $0F, $08, $F0, $78, $F0, $09, $F0 ;0xC0
	dc.b	$75, $F0, $00, $F0, $76, $F0, $0F, $07, $F0, $77, $F1, $0A, $F0, $76, $F1, $75
	dc.b	$F0, $0F, $06, $F1, $77, $F0, $0D, $F0, $75, $F1, $75, $F0, $0F, $05, $F0, $77 ;0xE0
	dc.b	$F1, $0E, $F0, $75, $F1, $75, $F0, $0F, $04, $F0, $77, $F0, $0F, $00, $F0, $75
	dc.b	$F1, $75, $F0, $0F, $02, $F1, $77, $F0, $0F, $01, $F0, $75, $F1, $75, $F0, $0F ;0x100
	dc.b	$01, $F0, $77, $F1, $0F, $02, $F0, $75, $F1, $75, $F0, $0F, $00, $F0, $77, $F0
	dc.b	$0F, $04, $F0, $75, $F1, $75, $F0, $0E, $F1, $77, $F0, $0F, $05, $F0, $75, $F1 ;0x120
	dc.b	$75, $F0, $0D, $F0, $77, $F1, $0F, $06, $F0, $75, $F1, $76, $F0, $0A, $F1, $77
	dc.b	$F0, $0F, $07, $F0, $76, $F0, $00, $F0, $75, $F0, $09, $F0, $78, $F0, $0F, $08 ;0x140
	dc.b	$F0, $75, $F0, $01, $F0, $75, $F0, $08, $F0, $77, $F1, $0F, $09, $F0, $75, $F0
	dc.b	$01, $F0, $76, $F0, $05, $F1, $77, $F0, $0F, $0A, $F0, $76, $F0, $02, $F0, $75 ;0x160
	dc.b	$F0, $04, $F0, $77, $F1, $0F, $0B, $F0, $75, $F0, $03, $F0, $76, $F0, $02, $F0
	dc.b	$77, $F0, $0F, $0C, $F0, $76, $F0, $03, $F0, $76, $F0, $00, $F1, $77, $F0, $0F ;0x180
	dc.b	$0D, $F0, $76, $F0, $04, $F0, $76, $F0, $77, $F1, $0F, $0D, $F0, $76, $F0, $06
	dc.b	$F0, $7D, $F0, $0F, $0E, $F0, $76, $F0, $07, $F0, $7C, $F0, $0F, $0E, $F0, $77 ;0x1A0
	dc.b	$F0, $08, $F0, $79, $F1, $0F, $0E, $F0, $77, $F0, $0A, $F0, $77, $F0, $0F, $0F
	dc.b	$F0, $77, $F0, $0C, $F0, $77, $F1, $0F, $0B, $F1, $77, $F0, $0E, $F0, $78, $F1 ;0x1C0
	dc.b	$0F, $07, $F1, $78, $F0, $0F, $00, $F0, $79, $F2, $0F, $01, $F2, $79, $F0, $0F
	dc.b	$02, $F0, $7B, $F3, $09, $F3, $7B, $F0, $0F, $04, $F1, $7D, $F9, $7D, $F1, $0F ;0x1E0
	dc.b	$07, $F1, $7F, $7F, $71, $F1, $0F, $0B, $F0, $7F, $7F, $F0, $0F, $0E, $F2, $7F
	dc.b	$79, $F2, $0F, $0F, $02, $F2, $7F, $73, $F2, $0F, $0F, $08, $F3, $7B, $F3, $0F ;0x200
	dc.b	$0F, $0F, $FB, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $09 ;0x220
loc_EB6A:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x0000EB6A-0x0000ED53, Entry count: 0x1E9) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $06, $F1, $0F, $0F, $0F, $0C, $F0, $C1, $F0, $0F, $0F, $0F, $0A, $F0 ;0x20
	dc.b	$C3, $F0, $0F, $0F, $0F, $03, $F1, $03, $F0, $C2, $D0, $F0, $0F, $0F, $0F, $02
	dc.b	$F0, $C1, $F0, $01, $F0, $C2, $D1, $F0, $0F, $0F, $0F, $01, $F0, $C2, $D0, $F0 ;0x40
	dc.b	$00, $F0, $C2, $D0, $F0, $0F, $0F, $0E, $F0, $02, $F0, $C2, $D0, $F1, $C2, $D1
	dc.b	$F0, $0F, $0F, $0D, $F0, $C0, $F0, $01, $F0, $C1, $D1, $F1, $C2, $D0, $F0, $0F ;0x60
	dc.b	$0F, $0D, $F0, $C2, $F0, $00, $F0, $C1, $D0, $F1, $C2, $D1, $F0, $0F, $0F, $0D
	dc.b	$F0, $C2, $F1, $C1, $D1, $F1, $C2, $D0, $F0, $0F, $0F, $0E, $F0, $C2, $F1, $C1 ;0x80
	dc.b	$D0, $F1, $C2, $D1, $F0, $0F, $0F, $0E, $F0, $C1, $D0, $F1, $C0, $D1, $F1, $C1
	dc.b	$D1, $F0, $0F, $0F, $0F, $F0, $C1, $D0, $F1, $C0, $D0, $F1, $C1, $D1, $F0, $0F ;0xA0
	dc.b	$0F, $0F, $00, $F0, $C1, $D0, $F0, $C1, $D0, $F1, $C0, $D1, $F0, $0F, $0F, $0F
	dc.b	$01, $F0, $C1, $D0, $F0, $C0, $D1, $F0, $C1, $D0, $F0, $0F, $0F, $0F, $02, $F0 ;0xC0
	dc.b	$C0, $D1, $F0, $C0, $D0, $C2, $F3, $0F, $0F, $0F, $01, $F0, $C0, $D0, $C2, $D0
	dc.b	$C6, $F1, $0F, $0F, $0F, $F0, $C0, $D0, $C8, $D0, $C2, $F1, $0F, $0F, $0C, $F0 ;0xE0
	dc.b	$CA, $D2, $C3, $F0, $0F, $0F, $0B, $F0, $C9, $D1, $F0, $D2, $C2, $F0, $0F, $0F
	dc.b	$0A, $F0, $C7, $D1, $F1, $00, $F1, $D1, $C1, $F0, $0F, $0F, $0A, $F0, $C6, $D1 ;0x100
	dc.b	$F0, $04, $F0, $D0, $C1, $F0, $0F, $0F, $09, $F0, $C6, $D1, $F0, $05, $F0, $D1
	dc.b	$C1, $F0, $0F, $0F, $08, $F0, $C6, $D1, $F0, $05, $F0, $D2, $C0, $F0, $0F, $0F ;0x120
	dc.b	$08, $F0, $C6, $D1, $F0, $06, $F3, $0F, $0F, $08, $F0, $C7, $D2, $F0, $05, $F0
	dc.b	$C2, $F0, $0F, $0F, $06, $F1, $D0, $C5, $D1, $C1, $D0, $F5, $C3, $D0, $F0, $0F ;0x140
	dc.b	$0F, $04, $F0, $D4, $C2, $D3, $C8, $D2, $F0, $0F, $0F, $04, $F0, $D0, $C2, $D9
	dc.b	$C4, $D4, $F0, $0F, $0F, $05, $F1, $C3, $DF, $D0, $F1, $0F, $0F, $07, $F1, $C2 ;0x160
	dc.b	$D0, $F0, $DC, $F1, $0F, $0F, $0A, $F1, $C0, $D2, $F0, $D7, $F3, $0F, $0F, $0D
	dc.b	$F1, $D2, $F8, $0F, $0F, $0F, $01, $F1, $D3, $F0, $0F, $0F, $0F, $09, $F1, $D1 ;0x180
	dc.b	$F0, $0F, $0F, $0F, $0B, $F2, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x1A0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x1C0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $06 ;0x1E0
loc_ED53:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x0000ED53-0x0000EF13, Entry count: 0x1C0) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0B, $F0, $02, $F3, $0F, $0F, $0F, $05, $F1, $01, $F1, $B3, $F2, $0F, $0F
	dc.b	$0F, $01, $F1, $00, $F1, $B8, $F2, $0F, $0F, $0A, $F1, $00, $F0, $B0, $F1, $BD ;0x40
	dc.b	$F0, $0F, $0F, $08, $F0, $00, $F2, $BF, $B1, $F0, $0F, $0F, $08, $F3, $BF, $B2
	dc.b	$F0, $0F, $0F, $05, $F1, $BF, $B6, $F0, $0F, $0F, $04, $F0, $BF, $B9, $F0, $0F ;0x60
	dc.b	$0F, $02, $F0, $BF, $BA, $F0, $0F, $0F, $01, $F0, $BC, $F0, $B2, $F0, $B9, $F0
	dc.b	$0F, $0F, $01, $F0, $BC, $F1, $B2, $F1, $B8, $F0, $0F, $0F, $F0, $BD, $F3, $B1 ;0x80
	dc.b	$F1, $B7, $F0, $0F, $0F, $F0, $BC, $F1, $71, $F1, $B1, $F1, $B6, $F0, $0F, $0F
	dc.b	$F0, $BA, $F2, $70, $61, $71, $F4, $B6, $F0, $0F, $0E, $F0, $B6, $F2, $B0, $F0 ;0xA0
	dc.b	$71, $61, $71, $F4, $70, $F1, $B5, $F0, $0F, $0D, $F1, $B4, $F0, $62, $F1, $74
	dc.b	$F0, $C0, $31, $F0, $71, $F3, $B2, $F2, $0F, $0D, $F0, $B4, $F0, $60, $F0, $61 ;0xC0
	dc.b	$F0, $74, $C1, $31, $70, $60, $70, $F1, $00, $F4, $0F, $0F, $F1, $B3, $F0, $71
	dc.b	$F0, $60, $73, $61, $70, $C1, $70, $62, $F0, $0F, $0F, $07, $F0, $B3, $F0, $72 ;0xE0
	dc.b	$60, $72, $63, $70, $65, $F0, $0F, $0F, $06, $F1, $B2, $F0, $72, $60, $71, $6C
	dc.b	$F0, $0F, $0F, $06, $F0, $B2, $F1, $74, $6C, $F0, $0F, $0F, $06, $F0, $B3, $F0 ;0x100
	dc.b	$71, $F0, $71, $68, $71, $F1, $0F, $0F, $07, $F0, $B3, $F2, $73, $64, $70, $61
	dc.b	$F1, $0F, $0F, $09, $F0, $B4, $F1, $74, $62, $70, $F0, $62, $F0, $0F, $0F, $09 ;0x120
	dc.b	$F0, $B3, $F2, $75, $63, $F3, $0F, $0F, $08, $F0, $B4, $F3, $74, $65, $70, $F0
	dc.b	$0F, $0F, $09, $F1, $B1, $F1, $01, $F1, $74, $63, $F1, $0F, $0F, $0B, $F3, $03 ;0x140
	dc.b	$F1, $73, $63, $70, $F0, $0F, $0F, $0F, $04, $F2, $72, $63, $F0, $0F, $0F, $0F
	dc.b	$06, $F2, $72, $60, $F1, $0F, $0F, $0F, $08, $F5, $0F, $0F, $0F, $0F, $0F, $0F ;0x160
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $09 ;0x1A0
loc_EF13:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x0000EF13-0x0000F154, Entry count: 0x241) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $06, $FF, $F9, $0F, $0F, $04, $F0, $6F, $69, $F1, $0F ;0x20
	dc.b	$0F, $03, $F8, $6F, $F3, $0F, $0F, $04, $FF, $FB, $0F, $0F, $04, $FF, $FB, $0F
	dc.b	$0F, $05, $F0, $70, $FF, $70, $F7, $0F, $0F, $04, $F0, $70, $FF, $70, $F8, $0F ;0x40
	dc.b	$0F, $03, $F0, $70, $F0, $00, $FD, $70, $F9, $0F, $0F, $02, $F0, $70, $F0, $01
	dc.b	$FC, $70, $FA, $09, $F3, $0F, $03, $F0, $70, $F0, $03, $FA, $70, $FB, $06, $F1 ;0x60
	dc.b	$A3, $F1, $0F, $01, $F0, $70, $F0, $04, $F9, $70, $FC, $04, $F0, $A7, $F0, $0F
	dc.b	$F1, $70, $F0, $03, $F4, $B2, $F2, $70, $FC, $00, $F0, $02, $F0, $A8, $F0, $0E ;0x80
	dc.b	$F0, $71, $F0, $03, $F0, $92, $F5, $71, $F0, $21, $FA, $D0, $F0, $00, $F0, $A9
	dc.b	$F0, $0E, $F0, $70, $F1, $04, $F2, $B0, $F0, $60, $F2, $70, $F1, $22, $F6, $01 ;0xA0
	dc.b	$F0, $D0, $F0, $00, $F0, $AA, $F0, $0D, $F0, $70, $F0, $00, $F9, $61, $F1, $70
	dc.b	$F0, $20, $F4, $70, $F0, $B2, $F0, $00, $F0, $D0, $F0, $00, $F0, $AA, $F0, $0D ;0xC0
	dc.b	$F0, $70, $F2, $A1, $F1, $70, $F1, $B0, $F4, $70, $F1, $74, $F0, $A2, $B1, $F1
	dc.b	$D0, $F0, $00, $F0, $AA, $F0, $09, $F4, $70, $F0, $A2, $F4, $B2, $F1, $20, $F0 ;0xE0
	dc.b	$70, $F0, $74, $60, $F0, $A3, $F2, $D0, $F0, $00, $F0, $AA, $F0, $06, $F7, $70
	dc.b	$FB, $21, $F1, $70, $F0, $72, $62, $F0, $C2, $A0, $F1, $B0, $F1, $01, $F0, $AA ;0x100
	dc.b	$F0, $00, $F5, $65, $F0, $70, $F0, $74, $F7, $70, $F0, $70, $F0, $71, $63, $F0
	dc.b	$C3, $F1, $B0, $F1, $01, $FE, $6A, $F0, $70, $F0, $7D, $F0, $70, $F0, $70, $64 ;0x120
	dc.b	$F0, $A3, $F4, $00, $F0, $B7, $F2, $6C, $71, $F0, $70, $F0, $7D, $F0, $70, $F0
	dc.b	$65, $F0, $A3, $F2, $C1, $F0, $00, $F0, $B9, $F0, $66, $76, $F0, $70, $F0, $7D ;0x140
	dc.b	$F0, $70, $F0, $65, $F0, $A3, $F2, $D1, $F0, $01, $FB, $77, $FF, $F9, $64, $F0
	dc.b	$B3, $F1, $B0, $F1, $02, $F2, $7F, $F0, $6F, $69, $F1, $62, $F0, $B3, $F1, $B0 ;0x160
	dc.b	$F1, $04, $F5, $7B, $F8, $6F, $F4, $70, $F0, $B3, $F2, $C0, $F0, $06, $F0, $00
	dc.b	$F8, $78, $FF, $FF, $F2, $C0, $F0, $06, $F0, $05, $FB, $75, $F6, $70, $F5, $70 ;0x180
	dc.b	$F5, $70, $F7, $C0, $F0, $04, $F2, $0D, $FC, $73, $F0, $70, $F1, $71, $F0, $70
	dc.b	$F3, $73, $F6, $C0, $F0, $03, $F3, $0F, $04, $FB, $70, $F3, $70, $FE, $C0, $F0 ;0x1A0
	dc.b	$04, $F1, $0F, $0F, $00, $F1, $70, $F2, $70, $FF, $0F, $0F, $0A, $F3, $70, $FE
	dc.b	$0F, $0F, $0B, $F0, $D2, $F1, $00, $F1, $0F, $0F, $0F, $05, $F0, $D0, $E0, $F0 ;0x1C0
	dc.b	$E1, $F3, $0F, $0F, $0F, $04, $F0, $D0, $E0, $F2, $E1, $F3, $0F, $0F, $0F, $03
	dc.b	$F0, $D0, $E0, $F2, $E1, $F4, $0F, $0F, $0F, $03, $F0, $E1, $F0, $E1, $F5, $0F ;0x1E0
	dc.b	$0F, $0F, $04, $F0, $E2, $F6, $0F, $0F, $0F, $05, $F8, $0F, $0F, $0F, $0A, $F3
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x200
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x220
	dc.b	$0D ;0x240
loc_F154:
	dc.b	$0F, $0F, $F6, $0F, $0F, $0F, $03, $F4, $C6, $F0, $0F, $0F, $0F, $01, $F0, $A3
	dc.b	$C0, $A3, $C3, $F0, $0F, $0F, $0F, $F0, $A0, $F0, $A0, $C1, $A5, $C3, $F0, $0F ;0x0 (0x0000F154-0x0000F474, Entry count: 0x320)
	dc.b	$0F, $0D, $F0, $A0, $F0, $A2, $C0, $B0, $A5, $C2, $F0, $0F, $0F, $0D, $F1, $A4
	dc.b	$B2, $A3, $C1, $A0, $F0, $0F, $0F, $0E, $F0, $A0, $F0, $B0, $F3, $31, $F0, $A4 ;0x20
	dc.b	$F0, $0F, $0F, $0E, $F0, $A0, $B1, $A0, $B0, $F1, $31, $F0, $A4, $F0, $0F, $0F
	dc.b	$0E, $F0, $A1, $B3, $31, $F0, $B0, $A3, $F0, $0F, $0F, $0F, $00, $F0, $A0, $B6 ;0x40
	dc.b	$A3, $F0, $0F, $0F, $0F, $01, $F0, $A1, $B7, $F1, $0F, $0F, $0F, $03, $F0, $A0
	dc.b	$B1, $F0, $B4, $F0, $0F, $0F, $0F, $00, $F5, $B2, $F0, $B2, $F1, $0F, $0F, $0D ;0x60
	dc.b	$F2, $33, $F1, $B3, $F3, $0F, $0F, $0C, $F1, $21, $33, $F0, $20, $F0, $B4, $F3
	dc.b	$0F, $0F, $08, $F2, $21, $35, $F0, $20, $F0, $B4, $F0, $10, $F0, $20, $F2, $0F ;0x80
	dc.b	$0F, $03, $F1, $22, $37, $F0, $20, $F0, $B3, $F0, $11, $F0, $23, $F1, $0F, $0F
	dc.b	$00, $F2, $21, $34, $F0, $32, $F0, $21, $F3, $11, $F0, $26, $F0, $0F, $0E, $F0 ;0xA0
	dc.b	$12, $F0, $35, $F1, $32, $F0, $20, $14, $F0, $23, $32, $21, $F0, $0F, $0C, $F0
	dc.b	$B0, $F1, $11, $F0, $33, $F2, $33, $F5, $22, $35, $21, $F0, $0F, $09, $F1, $B2 ;0xC0
	dc.b	$F1, $11, $F0, $30, $F5, $37, $22, $37, $20, $F1, $0F, $07, $F0, $B4, $F2, $20
	dc.b	$F4, $00, $F2, $3B, $F0, $34, $21, $F0, $0F, $07, $F0, $B3, $F3, $21, $F1, $03 ;0xE0
	dc.b	$F1, $3B, $F1, $34, $20, $F1, $0F, $05, $F0, $B2, $F2, $00, $F3, $06, $F1, $3A
	dc.b	$F2, $33, $21, $F0, $0F, $05, $F0, $B2, $F0, $0E, $F1, $3A, $F9, $0F, $04, $F0 ;0x100
	dc.b	$B1, $F0, $0F, $F3, $38, $F2, $15, $F0, $0F, $04, $F0, $B1, $F0, $0F, $00, $F4
	dc.b	$37, $F0, $21, $F5, $0F, $03, $F0, $B2, $F0, $0F, $00, $F6, $34, $F7, $B0, $F0 ;0x120
	dc.b	$0F, $03, $F0, $B1, $F0, $0F, $00, $F2, $E2, $FC, $B2, $F0, $0F, $02, $F0, $B2
	dc.b	$F0, $0E, $F1, $E6, $F9, $30, $F0, $B3, $F0, $0F, $00, $F1, $B3, $F0, $0B, $F1 ;0x140
	dc.b	$E6, $F0, $E8, $F1, $30, $F1, $B2, $F0, $0F, $00, $F0, $B4, $F0, $09, $F1, $E8
	dc.b	$F1, $E1, $F0, $E5, $F3, $B2, $F0, $0F, $00, $F0, $B3, $F1, $08, $F1, $EA, $F2 ;0x160
	dc.b	$E6, $F1, $00, $F0, $B2, $F0, $0F, $01, $F1, $B0, $F1, $08, $F0, $D1, $F1, $E8
	dc.b	$F2, $E6, $F1, $00, $F0, $B2, $F0, $0F, $03, $F1, $08, $F3, $D1, $F0, $E5, $F8 ;0x180
	dc.b	$E2, $F1, $00, $F0, $B2, $F0, $0F, $0D, $F0, $B2, $F1, $D0, $F0, $E4, $F4, $D4
	dc.b	$F0, $E1, $F2, $B2, $F1, $0F, $0B, $F2, $B4, $F0, $D0, $F0, $E1, $F2, $01, $F6 ;0x1A0
	dc.b	$D0, $F0, $E0, $F0, $00, $F0, $B2, $F0, $0F, $0B, $F0, $D0, $C1, $F0, $B3, $F0
	dc.b	$D0, $F3, $03, $F0, $B4, $F4, $00, $F0, $B1, $F2, $0F, $09, $F0, $D0, $C2, $F1 ;0x1C0
	dc.b	$B1, $F4, $05, $F0, $B5, $F4, $B5, $F0, $0F, $08, $F0, $D1, $C1, $F7, $05, $F3
	dc.b	$B3, $F2, $00, $F0, $B0, $F0, $B3, $F0, $0F, $09, $F0, $D2, $F3, $08, $F1, $C2 ;0x1E0
	dc.b	$F1, $B1, $F2, $00, $F3, $B2, $F0, $0F, $0A, $F3, $B2, $F0, $07, $F0, $C4, $D0
	dc.b	$F3, $04, $F2, $B0, $F0, $0F, $0B, $F1, $B4, $F0, $06, $F0, $D0, $C2, $D1, $F0 ;0x200
	dc.b	$09, $F1, $0F, $0D, $F0, $B5, $F0, $05, $F0, $D4, $F0, $0F, $0F, $0A, $F1, $B4
	dc.b	$C0, $F0, $05, $F4, $B0, $F0, $0F, $0F, $0A, $F1, $B1, $C2, $F0, $05, $F0, $B5 ;0x220
	dc.b	$F0, $0F, $0F, $0A, $F1, $C0, $D1, $C1, $F0, $05, $F0, $B4, $F0, $0F, $0F, $0B
	dc.b	$F1, $D2, $C0, $F0, $05, $F0, $B4, $F0, $0F, $0F, $0C, $F1, $D2, $C0, $F1, $04 ;0x240
	dc.b	$F0, $B3, $C0, $F0, $0F, $0F, $0C, $F1, $D1, $F1, $C0, $F0, $03, $F0, $C4, $F0
	dc.b	$0F, $0F, $0D, $F3, $C1, $D0, $F0, $03, $F0, $D2, $C0, $F0, $0F, $0F, $0E, $F1 ;0x260
	dc.b	$C2, $D1, $F0, $02, $F0, $D2, $F1, $0F, $0F, $0C, $F4, $C0, $D0, $C0, $D1, $F0
	dc.b	$02, $F5, $0F, $0F, $08, $F2, $E1, $F1, $D1, $C2, $D0, $F0, $02, $F0, $C2, $D0 ;0x280
	dc.b	$F0, $0F, $0F, $07, $F0, $E3, $F2, $D1, $C2, $F0, $D0, $F3, $C2, $D0, $F0, $0F
	dc.b	$0F, $06, $F0, $E2, $F1, $D1, $C4, $F0, $D4, $F1, $D1, $C0, $F2, $0F, $0F, $04 ;0x2A0
	dc.b	$F1, $E0, $F0, $D0, $C5, $F1, $D5, $F0, $C0, $D0, $C0, $D0, $F0, $E1, $F2, $0F
	dc.b	$0F, $02, $F2, $D1, $C1, $F2, $E0, $D5, $F0, $C0, $D0, $C1, $D0, $F0, $E4, $F0 ;0x2C0
	dc.b	$0F, $0F, $03, $F7, $D5, $F0, $C3, $D1, $F0, $E5, $F0, $0F, $0F, $02, $F0, $70
	dc.b	$D0, $70, $F1, $00, $F4, $D0, $E0, $F0, $D4, $F0, $E5, $F1, $0F, $0F, $02, $F0 ;0x2E0
	dc.b	$71, $60, $F1, $05, $F8, $E3, $F2, $0F, $0F, $04, $F3, $0A, $F0, $70, $D0, $70
	dc.b	$F5, $0F, $0F, $0F, $05, $F0, $71, $60, $F1, $0F, $0F, $0F, $0A, $F3, $0F, $07 ;0x300
loc_F474:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0B, $F7, $0F, $0F, $0F, $04, $F2, $D7, $F2, $0F, $0F, $0F, $F1, $E3, $D9 ;0x0 (0x0000F474-0x0000F752, Entry count: 0x2DE) [Unknown data]
	dc.b	$F1, $0F, $0F, $0C, $F0, $D4, $F0, $E0, $DA, $F0, $0F, $0F, $0A, $F0, $D6, $F0
	dc.b	$DB, $F0, $0F, $0F, $08, $F0, $D7, $F0, $E0, $DB, $F0, $0F, $0F, $06, $F0, $D7 ;0x20
	dc.b	$F0, $D0, $F0, $DC, $F0, $0F, $0F, $05, $F0, $D1, $C2, $D1, $F0, $D2, $E0, $D6
	dc.b	$C2, $D1, $F0, $0F, $0F, $04, $F0, $D0, $C6, $D9, $C6, $D0, $F0, $0F, $0F, $03 ;0x40
	dc.b	$F0, $C8, $D7, $C8, $F0, $0F, $0F, $02, $F0, $D0, $CA, $D3, $CA, $D0, $F0, $0F
	dc.b	$0F, $01, $F0, $CF, $CB, $F0, $0F, $0F, $01, $F0, $D0, $C3, $E2, $CB, $E2, $C3 ;0x60
	dc.b	$D0, $F0, $0F, $0F, $00, $F0, $D1, $C2, $E0, $F2, $E1, $C7, $E1, $F2, $E0, $C2
	dc.b	$D1, $F0, $0F, $0F, $F0, $C1, $D0, $C0, $E0, $F5, $E0, $C1, $D1, $C1, $E0, $F5 ;0x80
	dc.b	$E0, $C0, $D0, $C1, $F0, $0F, $0F, $00, $F0, $C0, $D0, $E0, $F3, $72, $F0, $E0
	dc.b	$D3, $E0, $F0, $72, $F3, $E0, $D0, $C0, $F0, $0F, $0F, $01, $F0, $D3, $F1, $71 ;0xA0
	dc.b	$60, $71, $F0, $D0, $C1, $D0, $F0, $71, $60, $71, $F1, $D3, $F0, $0F, $0F, $01
	dc.b	$F0, $C0, $D2, $F1, $70, $60, $A0, $60, $70, $D0, $C3, $D0, $70, $60, $A0, $60 ;0xC0
	dc.b	$70, $F1, $D2, $C0, $F0, $0F, $0F, $01, $F0, $C0, $D3, $F1, $70, $60, $70, $F0
	dc.b	$D0, $C0, $E1, $C0, $D0, $F0, $70, $60, $70, $F1, $D3, $C0, $F0, $0F, $0F, $02 ;0xE0
	dc.b	$F0, $C1, $D2, $F3, $D1, $C0, $F1, $C0, $D1, $F3, $D2, $C1, $F0, $0F, $0F, $04
	dc.b	$F0, $C2, $D3, $C0, $D0, $C1, $F1, $C1, $D0, $C0, $D3, $C2, $F0, $0F, $0F, $06 ;0x100
	dc.b	$F1, $C5, $D0, $C0, $E0, $F1, $E0, $C0, $D0, $C5, $F1, $0F, $0F, $08, $F0, $C4
	dc.b	$D1, $C0, $F3, $C0, $D1, $C4, $F0, $0F, $0F, $0A, $F0, $C2, $D2, $C0, $F0, $C1 ;0x120
	dc.b	$F0, $C0, $D2, $C2, $F0, $0F, $0F, $0C, $F0, $C0, $D0, $F0, $D0, $C7, $D0, $F0
	dc.b	$D0, $C0, $F0, $0F, $0F, $0D, $F0, $C0, $D0, $F0, $C9, $F0, $D0, $C0, $F0, $0F ;0x140
	dc.b	$0F, $0D, $F0, $C0, $D0, $F1, $C1, $F3, $C1, $F1, $D0, $C0, $F0, $0F, $0F, $02
	dc.b	$F2, $08, $F0, $C0, $FB, $C0, $F0, $08, $F2, $0F, $06, $F0, $D2, $F0, $07, $F0 ;0x160
	dc.b	$C0, $D0, $F0, $C1, $F0, $C1, $F0, $C1, $F0, $D0, $C0, $F0, $07, $F0, $D2, $F0
	dc.b	$0F, $04, $F0, $D4, $F0, $06, $F0, $C0, $D1, $C1, $F0, $C1, $F0, $C1, $D1, $C0 ;0x180
	dc.b	$F0, $06, $F0, $D4, $F0, $0F, $03, $F0, $D4, $F0, $07, $F0, $C0, $D1, $C1, $D1
	dc.b	$C1, $D1, $C0, $F0, $07, $F0, $D4, $F0, $0F, $02, $F0, $D6, $F0, $06, $F0, $C1 ;0x1A0
	dc.b	$D0, $C1, $D1, $C1, $D0, $C1, $F0, $06, $F0, $D6, $F0, $0F, $00, $F0, $D3, $C0
	dc.b	$D3, $F1, $05, $F0, $C9, $F0, $05, $F1, $D3, $C0, $D3, $F0, $0F, $F0, $D0, $C1 ;0x1C0
	dc.b	$D7, $F1, $04, $F0, $C2, $D1, $C2, $F0, $04, $F1, $D7, $C1, $D0, $F0, $0F, $F0
	dc.b	$C3, $D1, $C0, $D5, $F1, $03, $F7, $03, $F1, $D5, $C0, $D1, $C3, $F0, $0F, $00 ;0x1E0
	dc.b	$F0, $C1, $F1, $C4, $D4, $F1, $0B, $F1, $D4, $C4, $F1, $C1, $F0, $0F, $02, $F1
	dc.b	$01, $F1, $C4, $D4, $F1, $07, $F1, $D4, $C4, $F1, $01, $F1, $0F, $09, $F1, $C4 ;0x200
	dc.b	$D4, $F1, $03, $F1, $D4, $C4, $F1, $0F, $0F, $01, $F1, $C4, $D4, $F3, $D4, $C4
	dc.b	$F1, $0F, $0F, $05, $F1, $C4, $D4, $E1, $D2, $C4, $F1, $0F, $0F, $09, $F1, $C4 ;0x220
	dc.b	$D4, $E1, $C3, $F1, $0F, $0F, $0D, $F1, $C4, $D4, $E1, $F1, $0F, $0F, $0F, $F1
	dc.b	$E1, $C4, $D4, $F1, $0F, $0F, $0D, $F1, $D3, $E1, $C4, $D4, $F1, $0F, $0F, $05 ;0x240
	dc.b	$F2, $00, $F1, $D4, $C2, $E1, $C4, $D4, $F1, $00, $F2, $0F, $0E, $F0, $D2, $F0
	dc.b	$D4, $C4, $F3, $C4, $D4, $F0, $D2, $F0, $0F, $0C, $F0, $D7, $C4, $F1, $03, $F1 ;0x260
	dc.b	$C4, $D7, $F0, $0F, $0B, $F0, $D6, $C3, $F1, $07, $F1, $C3, $D6, $F0, $0F, $0C
	dc.b	$F0, $D2, $C4, $F1, $0B, $F1, $C4, $D2, $F0, $0F, $0E, $F0, $D0, $C3, $F1, $0F ;0x280
	dc.b	$F1, $C3, $D0, $F0, $0F, $0F, $F0, $C4, $F0, $0F, $01, $F0, $C4, $F0, $0F, $0F
	dc.b	$00, $F0, $C2, $F0, $0F, $03, $F0, $C2, $F0, $0F, $0F, $02, $F2, $0F, $05, $F2 ;0x2A0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $01 ;0x2C0
loc_F752:
	dc.b	$0F, $F7, $0F, $0F, $0F, $05, $F1, $27, $F3, $0F, $0F, $0F, $00, $F0, $38, $24
	dc.b	$F1, $0F, $0F, $0F, $F2, $39, $22, $F1, $0F, $0F, $0E, $F4, $11, $20, $35, $22 ;0x0 (0x0000F752-0x0000FAC5, Entry count: 0x373)
	dc.b	$F1, $0F, $0F, $0D, $F3, $10, $31, $21, $35, $22, $F1, $07, $F4, $0F, $0F, $F2
	dc.b	$20, $30, $B0, $31, $21, $35, $22, $F2, $02, $F1, $23, $30, $F0, $0F, $0F, $F2 ;0x20
	dc.b	$30, $B2, $31, $20, $35, $24, $F2, $22, $32, $F0, $0F, $0F, $00, $F2, $30, $A0
	dc.b	$B2, $31, $20, $33, $29, $34, $F0, $0F, $0F, $01, $F1, $30, $A0, $B3, $39, $24 ;0x40
	dc.b	$35, $F0, $0F, $0F, $01, $F1, $30, $A1, $B0, $34, $13, $34, $23, $33, $F0, $0F
	dc.b	$0F, $00, $F2, $31, $A1, $34, $11, $32, $21, $33, $20, $35, $F0, $0F, $0E, $F1 ;0x60
	dc.b	$21, $33, $F0, $33, $20, $10, $35, $20, $36, $21, $30, $F0, $0F, $0C, $F1, $22
	dc.b	$33, $F1, $33, $20, $31, $D3, $31, $20, $34, $20, $31, $20, $F0, $0F, $0B, $F0 ;0x80
	dc.b	$22, $34, $F1, $34, $20, $30, $D0, $C2, $D1, $30, $20, $36, $D0, $31, $F0, $0F
	dc.b	$09, $F0, $21, $36, $F1, $36, $C4, $D0, $31, $20, $32, $20, $30, $D2, $20, $F0 ;0xA0
	dc.b	$0F, $08, $F0, $20, $37, $F2, $35, $C6, $31, $20, $34, $C1, $D0, $30, $F0, $0F
	dc.b	$07, $F0, $20, $38, $F2, $36, $C1, $F0, $C2, $D0, $30, $20, $34, $C1, $D0, $30 ;0xC0
	dc.b	$F0, $0F, $06, $F0, $20, $39, $F3, $35, $C0, $F0, $C0, $F0, $C2, $36, $C2, $30
	dc.b	$F0, $0F, $05, $F0, $20, $34, $F9, $35, $C0, $F0, $E0, $F0, $C2, $35, $C3, $30 ;0xE0
	dc.b	$F0, $0F, $05, $F0, $32, $FF, $F0, $32, $F0, $E0, $F0, $C2, $D0, $34, $C2, $30
	dc.b	$F0, $0F, $05, $F0, $20, $30, $FF, $F0, $B1, $F1, $30, $F2, $C3, $33, $F0, $C2 ;0x100
	dc.b	$30, $F0, $0F, $05, $F0, $30, $FF, $B1, $A1, $B1, $F0, $30, $F0, $C5, $31, $F1
	dc.b	$C2, $30, $F0, $0F, $05, $F3, $06, $F5, $B0, $A5, $B1, $C8, $F0, $C2, $30, $F0 ;0x120
	dc.b	$0F, $0F, $01, $F0, $20, $31, $F1, $B0, $A2, $F2, $A1, $B1, $C4, $B1, $C0, $F1
	dc.b	$30, $F0, $0F, $0F, $01, $F0, $20, $33, $F0, $B0, $A1, $F1, $A5, $B6, $F0, $E1 ;0x140
	dc.b	$F1, $0F, $0F, $00, $F0, $20, $34, $F1, $B0, $A0, $B1, $F1, $A8, $B0, $F4, $0F
	dc.b	$0F, $00, $F0, $20, $36, $F1, $B0, $A0, $B2, $F2, $A3, $B3, $F3, $0F, $0F, $00 ;0x160
	dc.b	$F0, $20, $35, $F3, $BF, $B0, $F0, $0F, $0F, $00, $F0, $20, $34, $F7, $BC, $F1
	dc.b	$0F, $0F, $01, $F0, $20, $32, $FD, $B6, $F1, $0F, $0F, $02, $F0, $20, $32, $FF ;0x180
	dc.b	$F5, $0F, $0F, $04, $F0, $20, $31, $F5, $02, $F5, $B2, $32, $F0, $0F, $0F, $05
	dc.b	$F0, $20, $30, $F3, $03, $F5, $B1, $A2, $B1, $30, $F2, $0F, $0F, $03, $F0, $30 ;0x1A0
	dc.b	$F2, $04, $F0, $B0, $A0, $B0, $F1, $B0, $A5, $B1, $30, $A1, $F1, $0F, $0F, $01
	dc.b	$F0, $30, $F0, $05, $F0, $A2, $B0, $F0, $B0, $A6, $B2, $30, $B0, $A1, $F1, $0F ;0x1C0
	dc.b	$0F, $F1, $05, $F0, $A1, $B1, $F0, $30, $B0, $A7, $B1, $30, $B2, $A1, $F0, $0F
	dc.b	$0F, $05, $F0, $A1, $B1, $F1, $B0, $A8, $B2, $30, $B2, $A0, $B0, $F0, $0F, $0F ;0x1E0
	dc.b	$03, $F0, $A1, $B1, $F1, $30, $B0, $A8, $B2, $30, $F1, $B2, $F0, $0F, $0F, $03
	dc.b	$F0, $A0, $B1, $F2, $30, $B0, $A7, $B3, $30, $F1, $A0, $B1, $F0, $0F, $0F, $03 ;0x200
	dc.b	$F0, $B0, $A0, $B0, $F1, $31, $B1, $A6, $B3, $F1, $A0, $B1, $F0, $0F, $0F, $04
	dc.b	$F0, $B1, $A1, $F1, $31, $B1, $A4, $B3, $30, $F1, $A0, $B1, $F0, $0F, $0F, $05 ;0x220
	dc.b	$F0, $B1, $A1, $B0, $F0, $30, $B3, $A0, $B5, $F1, $C0, $B2, $F2, $0F, $0F, $03
	dc.b	$F1, $B1, $A1, $C0, $D0, $30, $B8, $30, $F0, $D4, $C0, $D1, $F0, $0F, $0F, $02 ;0x240
	dc.b	$F2, $C0, $B0, $A0, $C0, $D0, $31, $B6, $30, $F1, $D0, $C2, $D0, $C1, $D0, $F0
	dc.b	$0F, $0F, $02, $F1, $D1, $C1, $D2, $32, $B2, $31, $F2, $D0, $C4, $D0, $F0, $0F ;0x260
	dc.b	$0F, $03, $F1, $D0, $C0, $D1, $C1, $D0, $35, $F2, $30, $F0, $D2, $C1, $D0, $F0
	dc.b	$0F, $0F, $04, $F0, $D3, $C0, $D2, $31, $F4, $31, $20, $30, $F1, $D2, $F0, $0F ;0x280
	dc.b	$0F, $05, $F0, $D0, $C3, $D1, $31, $F0, $03, $F0, $31, $20, $31, $F3, $0F, $0F
	dc.b	$07, $F0, $D1, $C0, $D1, $32, $F0, $04, $F0, $30, $21, $30, $F0, $0F, $0F, $0B ;0x2A0
	dc.b	$F1, $D1, $32, $F0, $05, $F0, $31, $20, $30, $F0, $0F, $0F, $0D, $F1, $32, $F0
	dc.b	$04, $F1, $31, $20, $30, $F1, $0F, $0F, $0C, $F1, $32, $F1, $02, $F0, $C0, $F0 ;0x2C0
	dc.b	$31, $20, $30, $C1, $F0, $0F, $0F, $0A, $F0, $C1, $31, $F1, $D0, $F0, $01, $F0
	dc.b	$C0, $F5, $C1, $F0, $0F, $0F, $08, $F0, $C1, $F3, $C0, $D0, $F0, $01, $F0, $D0 ;0x2E0
	dc.b	$C5, $D0, $F0, $0F, $0F, $0A, $F0, $C4, $D2, $F0, $00, $F0, $C0, $D7, $F1, $0F
	dc.b	$0F, $06, $F1, $D0, $C1, $D4, $71, $F0, $71, $C1, $D3, $70, $C0, $D1, $F1, $0F ;0x300
	dc.b	$0F, $02, $F1, $D0, $C0, $D1, $C1, $D1, $73, $F0, $77, $D0, $C1, $60, $71, $F2
	dc.b	$0F, $0C, $F2, $70, $60, $70, $D3, $7E, $D3, $63, $71, $F1, $0F, $08, $F1, $70 ;0x320
	dc.b	$63, $71, $D2, $7E, $E3, $72, $62, $71, $F0, $0F, $06, $F0, $71, $61, $74, $D0
	dc.b	$E1, $76, $F0, $75, $E3, $78, $F0, $0F, $05, $F0, $7A, $E2, $74, $F0, $00, $F1 ;0x340
	dc.b	$73, $D3, $76, $F1, $0F, $06, $F0, $7B, $D2, $70, $F2, $03, $FE, $0F, $09, $FF
	dc.b	$0F, $0F, $03 ;0x360
loc_FAC5:
	dc.b	$0F, $F7, $0F, $0F, $0F, $05, $F1, $27, $F3, $0F, $0F, $0F, $00, $F0, $38, $24
	dc.b	$F1, $0F, $0F, $0F, $F2, $39, $22, $F1, $0F, $0F, $0E, $F4, $11, $20, $35, $22 ;0x0 (0x0000FAC5-0x0000FE4A, Entry count: 0x385)
	dc.b	$F1, $0F, $0F, $0D, $F3, $10, $31, $21, $35, $22, $F1, $07, $F4, $0F, $0F, $F2
	dc.b	$20, $30, $B0, $31, $21, $35, $22, $F2, $02, $F1, $23, $30, $F0, $0F, $0F, $F2 ;0x20
	dc.b	$30, $B2, $31, $20, $35, $24, $F2, $22, $32, $F0, $0F, $0F, $00, $F2, $30, $A0
	dc.b	$B2, $31, $20, $33, $29, $34, $F0, $0F, $0F, $01, $F1, $30, $A0, $B3, $39, $24 ;0x40
	dc.b	$35, $F0, $0F, $0F, $01, $F1, $30, $A1, $B0, $34, $13, $34, $23, $33, $F0, $0F
	dc.b	$09, $F3, $02, $F2, $31, $A1, $34, $11, $32, $21, $33, $20, $35, $F0, $0F, $08 ;0x60
	dc.b	$F0, $D0, $C2, $F2, $21, $33, $F0, $33, $20, $10, $35, $20, $36, $21, $30, $F0
	dc.b	$0F, $08, $F0, $D0, $C3, $21, $34, $F1, $33, $20, $31, $D3, $31, $20, $34, $20 ;0x80
	dc.b	$31, $20, $F0, $0F, $08, $F0, $D1, $C2, $35, $F1, $34, $20, $30, $D0, $C2, $D1
	dc.b	$30, $20, $36, $D0, $31, $F0, $0F, $08, $F0, $D1, $C2, $34, $F1, $36, $C4, $D0 ;0xA0
	dc.b	$31, $20, $32, $20, $30, $D2, $20, $F0, $0F, $08, $F0, $20, $D0, $C2, $33, $F2
	dc.b	$35, $C6, $31, $20, $34, $C1, $D0, $30, $F0, $0F, $07, $F0, $20, $30, $D1, $C1 ;0xC0
	dc.b	$D0, $32, $F2, $36, $C1, $F0, $C2, $D0, $30, $20, $34, $C1, $D0, $30, $F0, $0F
	dc.b	$06, $F0, $33, $D3, $C2, $F3, $35, $C0, $F0, $C0, $F0, $C2, $36, $C2, $30, $F0 ;0xE0
	dc.b	$0F, $05, $F0, $20, $34, $D0, $C5, $F2, $35, $C0, $F0, $E0, $F0, $C2, $35, $C3
	dc.b	$30, $F0, $0F, $05, $F0, $32, $F1, $D0, $C1, $D3, $C1, $F5, $32, $F0, $E0, $F0 ;0x100
	dc.b	$C2, $D0, $34, $C2, $30, $F0, $0F, $05, $F0, $20, $30, $F3, $D0, $C4, $D2, $F3
	dc.b	$B1, $F1, $30, $F2, $C3, $33, $F0, $C2, $30, $F0, $0F, $05, $F0, $30, $F3, $D0 ;0x120
	dc.b	$C2, $D1, $C1, $D1, $C0, $F0, $B1, $A1, $B1, $F0, $30, $F0, $C5, $31, $F1, $C2
	dc.b	$30, $F0, $0F, $05, $F3, $00, $F0, $D0, $C4, $D0, $C0, $D0, $C1, $B0, $A5, $B1 ;0x140
	dc.b	$C8, $F0, $C2, $30, $F0, $0F, $0B, $F0, $D1, $C0, $D0, $C2, $D3, $B0, $A2, $F2
	dc.b	$A1, $B1, $C4, $B1, $C0, $F1, $30, $F0, $0F, $0D, $F0, $D3, $C0, $D2, $F1, $B0 ;0x160
	dc.b	$A1, $F1, $A5, $B6, $F0, $E1, $F1, $0F, $0D, $F0, $D5, $C1, $D0, $F1, $B0, $A0
	dc.b	$B1, $F1, $A8, $B0, $F4, $0F, $0F, $F0, $D3, $C2, $D0, $30, $F1, $B0, $A0, $B2 ;0x180
	dc.b	$F2, $A3, $B3, $F3, $0F, $0F, $00, $F0, $D2, $C0, $D1, $30, $F3, $BF, $B0, $F0
	dc.b	$0F, $0F, $00, $F0, $20, $30, $E2, $D0, $C1, $F5, $BC, $F1, $0F, $0F, $01, $F0 ;0x1A0
	dc.b	$20, $D3, $C2, $F9, $B6, $F1, $0F, $0F, $02, $F0, $20, $31, $D2, $C1, $D0, $FF
	dc.b	$F0, $0F, $0F, $04, $F0, $20, $31, $F0, $B1, $A1, $F0, $01, $F6, $B2, $32, $F0 ;0x1C0
	dc.b	$0F, $0F, $05, $F0, $20, $30, $F2, $B1, $A0, $F0, $00, $F0, $A0, $F3, $B1, $A2
	dc.b	$B1, $30, $F3, $0F, $0F, $02, $F0, $30, $F1, $00, $F0, $B1, $A0, $F1, $B0, $A1 ;0x1E0
	dc.b	$30, $F0, $B0, $A5, $B1, $30, $A2, $F1, $0F, $0F, $00, $F0, $30, $F0, $01, $F0
	dc.b	$B1, $A1, $B1, $A1, $30, $B0, $A6, $B2, $30, $B1, $A1, $F0, $0F, $0F, $F1, $03 ;0x200
	dc.b	$F0, $B1, $A0, $B1, $A0, $31, $B0, $A7, $B1, $30, $B3, $A0, $F0, $0F, $0F, $04
	dc.b	$F0, $B1, $A1, $B1, $30, $B0, $A8, $B2, $30, $F0, $B2, $A0, $F0, $0F, $0F, $04 ;0x220
	dc.b	$F0, $B1, $A1, $B0, $30, $B0, $A8, $B2, $30, $F1, $B2, $F0, $0F, $0F, $05, $F0
	dc.b	$B2, $31, $B0, $A7, $B3, $30, $F1, $A0, $B1, $F0, $0F, $0F, $04, $F4, $31, $B1 ;0x240
	dc.b	$A6, $B3, $F2, $A0, $B1, $F0, $0F, $0F, $04, $F0, $30, $F3, $31, $B1, $A4, $B3
	dc.b	$30, $F1, $A0, $B1, $F0, $0F, $0F, $04, $F0, $33, $F1, $31, $B3, $A0, $B5, $F1 ;0x260
	dc.b	$C0, $B2, $F2, $0F, $0F, $02, $F0, $34, $F1, $31, $B8, $30, $F0, $D4, $C0, $D1
	dc.b	$F0, $0F, $0F, $01, $F0, $31, $F5, $31, $B6, $30, $F1, $D0, $C2, $D0, $C1, $D0 ;0x280
	dc.b	$F0, $0F, $0F, $01, $F0, $30, $F0, $02, $F3, $32, $B2, $31, $F2, $D0, $C4, $D0
	dc.b	$F0, $0F, $0F, $02, $F1, $02, $F0, $31, $F2, $35, $F0, $70, $F1, $D2, $C1, $D0 ;0x2A0
	dc.b	$F0, $0F, $0F, $08, $F0, $30, $F0, $30, $F2, $32, $F0, $D1, $72, $F1, $D2, $F0
	dc.b	$0F, $0F, $08, $F0, $30, $F1, $31, $F0, $31, $20, $30, $F1, $D1, $72, $F4, $0F ;0x2C0
	dc.b	$0F, $07, $F0, $30, $F0, $00, $F1, $30, $F0, $31, $20, $30, $F1, $D0, $E0, $72
	dc.b	$F0, $0F, $0F, $0A, $F2, $02, $F1, $31, $20, $30, $F2, $D0, $E0, $72, $F0, $0F ;0x2E0
	dc.b	$0F, $0E, $F3, $31, $20, $30, $F1, $D0, $E1, $72, $F0, $0F, $0F, $0E, $F0, $C0
	dc.b	$F1, $30, $20, $30, $F0, $C0, $F0, $E1, $73, $F0, $0F, $0F, $0E, $F0, $D0, $C1 ;0x300
	dc.b	$F3, $C1, $F0, $73, $F0, $0F, $0F, $0E, $F1, $D1, $C4, $D0, $F0, $E1, $D1, $E0
	dc.b	$F0, $0F, $0F, $0D, $F0, $71, $C0, $D6, $70, $F1, $D1, $E0, $F0, $0F, $0F, $0D ;0x320
	dc.b	$F0, $73, $C1, $D1, $72, $C0, $D0, $F2, $0F, $0F, $0D, $F0, $79, $D0, $C2, $D0
	dc.b	$70, $F2, $0F, $0F, $0B, $F0, $78, $D2, $70, $63, $71, $F1, $0F, $0F, $0A, $F0 ;0x340
	dc.b	$76, $E2, $74, $62, $71, $F0, $0F, $0F, $09, $F1, $74, $E2, $78, $61, $70, $F0
	dc.b	$0F, $0F, $0A, $F1, $72, $D2, $7B, $F0, $0F, $0F, $0C, $F6, $77, $F2, $0F, $0F ;0x360
	dc.b	$0F, $04, $F7, $0F, $06 ;0x380
loc_FE4A:
	dc.b	$D0, $0F, $01, $D0, $0F, $01, $D0, $09, $D0, $0C, $D0, $00, $D1, $0F, $00, $D0
	dc.b	$0F, $00, $D0, $09, $D0, $0B, $D0, $03, $D0, $0F, $D0, $0F, $00, $D0, $08, $D0 ;0x0 (0x0000FE4A-0x00010165, Entry count: 0x31B) [Unknown data]
	dc.b	$0B, $D0, $05, $D1, $0E, $D0, $0F, $D0, $08, $D0, $0A, $D0, $08, $D0, $0D, $D4
	dc.b	$07, $D4, $07, $D0, $0A, $D0, $0A, $D0, $0A, $D1, $00, $D0, $02, $D7, $03, $D2 ;0x20
	dc.b	$05, $D0, $09, $D0, $0C, $DA, $03, $D0, $0D, $D0, $01, $D1, $02, $D0, $09, $D0
	dc.b	$0F, $D0, $0C, $D0, $0C, $D0, $03, $D5, $06, $D0, $0F, $01, $D1, $0B, $D0, $0B ;0x40
	dc.b	$D0, $06, $D0, $01, $D6, $0F, $04, $D0, $09, $D1, $00, $D6, $03, $D0, $05, $D0
	dc.b	$07, $D1, $0F, $05, $D1, $05, $D1, $01, $D0, $06, $D5, $04, $D0, $06, $D0, $00 ;0x60
	dc.b	$D0, $0F, $07, $D5, $04, $D0, $09, $D0, $00, $D1, $01, $D0, $06, $D0, $02, $D0
	dc.b	$0F, $07, $D0, $08, $D0, $09, $D0, $02, $D2, $05, $D0, $03, $D0, $0F, $08, $D1 ;0x80
	dc.b	$07, $D0, $08, $D0, $03, $D3, $02, $D0, $05, $D0, $0F, $09, $D0, $05, $D6, $02
	dc.b	$D0, $04, $D0, $02, $D1, $00, $D0, $05, $D0, $03, $D1, $0F, $04, $D1, $00, $D2 ;0xA0
	dc.b	$01, $D0, $03, $D4, $03, $D0, $04, $D1, $06, $D0, $00, $D1, $0F, $08, $D0, $05
	dc.b	$D0, $05, $D0, $00, $D0, $01, $D0, $04, $D0, $00, $D0, $06, $D1, $0F, $0B, $D0 ;0xC0
	dc.b	$05, $D0, $04, $D0, $01, $D2, $03, $D0, $02, $D0, $03, $D1, $00, $D0, $0F, $0C
	dc.b	$D1, $02, $D4, $01, $D0, $02, $D1, $02, $D0, $03, $D0, $01, $D1, $02, $D0, $0F ;0xE0
	dc.b	$0E, $D2, $01, $D0, $01, $D2, $02, $D0, $00, $D0, $00, $D0, $05, $D1, $05, $D0
	dc.b	$0F, $0E, $D0, $03, $D0, $02, $D0, $01, $D0, $02, $D0, $04, $D2, $06, $D0, $0F ;0x100
	dc.b	$0F, $D0, $03, $D0, $01, $D3, $01, $D0, $00, $D0, $01, $D1, $02, $D0, $05, $D0
	dc.b	$0F, $0F, $00, $D1, $01, $D3, $01, $D2, $02, $D1, $04, $D0, $06, $D0, $0F, $0F ;0x120
	dc.b	$01, $D3, $00, $D2, $00, $D0, $00, $D2, $01, $D0, $04, $D0, $05, $D0, $0F, $0F
	dc.b	$02, $D0, $01, $D1, $00, $D1, $00, $D2, $03, $D0, $03, $D0, $03, $D4, $0F, $0F ;0x140
	dc.b	$00, $D1, $00, $D5, $02, $D0, $03, $D8, $01, $D0, $0F, $0F, $02, $D0, $00, $D0
	dc.b	$00, $D2, $01, $D8, $03, $D0, $03, $D0, $0F, $0F, $03, $D0, $01, $D5, $00, $D0 ;0x160
	dc.b	$01, $D0, $02, $D0, $03, $D0, $03, $D0, $0F, $0F, $03, $D0, $02, $D1, $03, $D0
	dc.b	$01, $D0, $02, $D0, $03, $D0, $03, $D0, $0F, $0F, $03, $D0, $03, $D3, $01, $D0 ;0x180
	dc.b	$01, $D0, $01, $D0, $03, $D0, $03, $D0, $0F, $0F, $03, $D0, $03, $D2, $00, $D2
	dc.b	$01, $D0, $02, $D0, $02, $D0, $03, $D0, $0F, $0F, $03, $D0, $04, $D3, $00, $D3 ;0x1A0
	dc.b	$02, $D0, $02, $D0, $03, $D0, $0F, $0F, $03, $D0, $05, $D1, $00, $D0, $02, $D2
	dc.b	$00, $D0, $02, $D0, $04, $D0, $0F, $0F, $02, $D0, $06, $D0, $00, $D0, $01, $D0 ;0x1C0
	dc.b	$02, $D2, $02, $D0, $03, $D0, $0F, $0F, $02, $D0, $07, $D0, $02, $D0, $03, $D0
	dc.b	$00, $D3, $03, $D0, $0F, $0F, $02, $D0, $08, $D0, $01, $D0, $02, $D0, $04, $D2 ;0x1E0
	dc.b	$01, $D0, $0F, $0F, $02, $D0, $09, $D1, $03, $D0, $04, $D0, $01, $D2, $0F, $0F
	dc.b	$02, $D0, $0A, $D0, $02, $D0, $04, $D0, $04, $D2, $0F, $0F, $00, $D0, $0B, $D0 ;0x200
	dc.b	$01, $D0, $04, $D0, $04, $D0, $0F, $0F, $02, $D0, $0C, $D1, $04, $D0, $05, $D0
	dc.b	$0F, $0F, $02, $D0, $0D, $D0, $04, $D0, $04, $D0, $0F, $0F, $03, $D0, $0D, $D0 ;0x220
	dc.b	$04, $D0, $04, $D0, $0F, $0F, $03, $D0, $0E, $D0, $03, $D0, $04, $D0, $0F, $0F
	dc.b	$03, $D0, $0F, $D0, $01, $D0, $05, $D0, $0F, $0F, $03, $D0, $0F, $00, $D0, $00 ;0x240
	dc.b	$D0, $05, $D0, $0F, $0F, $03, $D0, $0F, $01, $D1, $05, $D0, $0F, $0F, $03, $D0
	dc.b	$0F, $01, $D1, $04, $D0, $0F, $0F, $04, $D0, $0F, $02, $D0, $04, $D0, $0F, $0F ;0x260
	dc.b	$04, $D0, $0F, $03, $D0, $03, $D0, $0F, $0F, $04, $D0, $0F, $04, $D0, $02, $D0
	dc.b	$0F, $0F, $03, $E2, $0F, $03, $D0, $02, $D0, $0F, $0F, $02, $F3, $E0, $0F, $03 ;0x280
	dc.b	$D0, $01, $D0, $0F, $0F, $02, $F1, $70, $F0, $E0, $0F, $04, $D0, $00, $D0, $0F
	dc.b	$0E, $F2, $00, $F1, $70, $F1, $00, $F1, $0F, $01, $D0, $00, $D0, $0F, $0D, $F0 ;0x2A0
	dc.b	$02, $F0, $00, $F2, $00, $F0, $01, $F0, $0F, $01, $D0, $0F, $0F, $F5, $E0, $F5
	dc.b	$0F, $02, $D0, $0F, $0D, $F0, $03, $F2, $E0, $F0, $03, $F0, $0F, $01, $D0, $0F ;0x2C0
	dc.b	$0D, $F0, $01, $F1, $00, $F5, $0F, $05, $D0, $0F, $0D, $F1, $01, $F1, $E0, $F1
	dc.b	$01, $F1, $0F, $04, $D0, $0F, $0C, $F0, $01, $F0, $01, $F0, $01, $F0, $01, $F0 ;0x2E0
	dc.b	$0F, $05, $D0, $0F, $0D, $F0, $06, $F0, $0F, $07, $D0, $0F, $0D, $F0, $06, $F0
	dc.b	$0F, $08, $D0, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x300
loc_10165:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00010165-0x000102B5, Entry count: 0x150) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $F0, $0F
	dc.b	$0F, $0F, $0D, $F0, $C0, $F0, $0F, $0F, $0F, $0C, $F0, $C0, $F0, $0F, $0F, $0F ;0x40
	dc.b	$0B, $F0, $C2, $F0, $0F, $0F, $0F, $0A, $F0, $C2, $F0, $0F, $0F, $0F, $0A, $F0
	dc.b	$C2, $F0, $0F, $0F, $0F, $09, $F0, $C4, $F0, $0F, $0F, $0F, $08, $F0, $C4, $F0 ;0x60
	dc.b	$0F, $0F, $0F, $02, $F6, $C4, $F6, $0F, $0F, $0B, $F0, $CF, $C2, $F0, $0F, $0F
	dc.b	$0B, $F0, $CF, $C0, $F0, $0F, $0F, $0D, $F0, $CE, $F0, $0F, $0F, $0F, $F1, $CA ;0x80
	dc.b	$F1, $0F, $0F, $0F, $02, $F0, $C8, $F0, $0F, $0F, $0F, $04, $F0, $C8, $F0, $0F
	dc.b	$0F, $0F, $04, $F0, $C8, $F0, $0F, $0F, $0F, $03, $F0, $C4, $F0, $C4, $F0, $0F ;0xA0
	dc.b	$0F, $0F, $02, $F0, $C3, $F0, $00, $F0, $C3, $F0, $0F, $0F, $0F, $02, $F0, $C1
	dc.b	$F1, $02, $F1, $C1, $F0, $0F, $0F, $0F, $01, $F0, $C1, $F0, $06, $F0, $C1, $F0 ;0xC0
	dc.b	$0F, $0F, $0F, $00, $F0, $C0, $F0, $08, $F0, $C0, $F0, $0F, $0F, $0F, $01, $F0
	dc.b	$0A, $F0, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0xE0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x100
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x120
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $08 ;0x140
loc_102B5:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x000102B5-0x00010462, Entry count: 0x1AD) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $09, $FC, $0F, $0F, $0F, $01, $F0, $7C, $F0, $0F, $0F, $0F, $F0, $7E, $F0
	dc.b	$0F, $0F, $0D, $F0, $7F, $70, $F0, $0F, $0F, $0B, $F0, $7F, $72, $F0, $0F, $0F ;0x40
	dc.b	$09, $F0, $7F, $74, $F0, $0F, $0F, $07, $F0, $7F, $76, $F0, $0F, $0F, $05, $F0
	dc.b	$7F, $78, $F0, $0F, $0F, $03, $F0, $7F, $7A, $F0, $0F, $0F, $01, $F0, $7F, $7C ;0x60
	dc.b	$F0, $0F, $0F, $00, $F0, $7F, $7C, $F0, $0F, $0F, $00, $F0, $71, $C3, $71, $C5
	dc.b	$71, $C3, $71, $C4, $71, $F0, $0F, $0F, $00, $F0, $70, $C1, $71, $C1, $72, $C1 ;0x80
	dc.b	$72, $C1, $71, $C1, $70, $C1, $71, $C1, $70, $F0, $0F, $0F, $00, $F0, $70, $C1
	dc.b	$76, $C1, $72, $C1, $71, $C1, $70, $C1, $71, $C1, $70, $F0, $0F, $0F, $00, $F0 ;0xA0
	dc.b	$70, $C1, $76, $C1, $72, $C1, $71, $C1, $70, $C1, $71, $C1, $70, $F0, $0F, $0F
	dc.b	$00, $F0, $71, $C3, $73, $C1, $72, $C1, $71, $C1, $70, $C4, $71, $F0, $0F, $0F ;0xC0
	dc.b	$00, $F0, $74, $C1, $72, $C1, $72, $C1, $71, $C1, $70, $C1, $74, $F0, $0F, $0F
	dc.b	$00, $F0, $74, $C1, $72, $C1, $72, $C1, $71, $C1, $70, $C1, $74, $F0, $0F, $0F ;0xE0
	dc.b	$00, $F0, $70, $C1, $71, $C1, $72, $C1, $72, $C1, $71, $C1, $70, $C1, $74, $F0
	dc.b	$0F, $0F, $00, $F0, $71, $C3, $73, $C1, $73, $C3, $71, $C1, $74, $F0, $0F, $0F ;0x100
	dc.b	$00, $F0, $7F, $7C, $F0, $0F, $0F, $00, $F0, $7F, $7C, $F0, $0F, $0F, $01, $F0
	dc.b	$7F, $7A, $F0, $0F, $0F, $03, $F0, $7F, $78, $F0, $0F, $0F, $05, $F0, $7F, $76 ;0x120
	dc.b	$F0, $0F, $0F, $07, $F0, $7F, $74, $F0, $0F, $0F, $09, $F0, $7F, $72, $F0, $0F
	dc.b	$0F, $0B, $F0, $7F, $70, $F0, $0F, $0F, $0D, $F0, $7E, $F0, $0F, $0F, $0F, $F0 ;0x140
	dc.b	$7C, $F0, $0F, $0F, $0F, $01, $FC, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x160
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $08 ;0x1A0
loc_10462:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00010462-0x00010694, Entry count: 0x232) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0E, $F3, $0F, $0F, $0F, $0A, $F0
	dc.b	$B3, $F0, $0F, $0F, $0F, $08, $F0, $B1, $F0, $B2, $F0, $0F, $0F, $0F, $07, $F0 ;0x20
	dc.b	$B0, $F0, $60, $F2, $0F, $0F, $0F, $08, $F0, $B0, $60, $72, $F0, $0F, $0F, $0F
	dc.b	$07, $F0, $D0, $F0, $62, $70, $F0, $0F, $0F, $0F, $06, $F0, $D0, $C1, $F0, $61 ;0x40
	dc.b	$70, $F1, $0F, $0F, $0F, $05, $F0, $D0, $C0, $D0, $61, $F1, $C0, $D0, $F1, $0F
	dc.b	$0F, $0F, $03, $F0, $D1, $C0, $61, $70, $C3, $D0, $F0, $0F, $0F, $0F, $02, $F1 ;0x60
	dc.b	$D1, $C0, $70, $C5, $D0, $F0, $0F, $0F, $0E, $F2, $61, $F0, $D0, $C3, $D0, $C1
	dc.b	$D0, $61, $F0, $0F, $0F, $0C, $F0, $62, $70, $F1, $D1, $C3, $D1, $70, $61, $F0 ;0x80
	dc.b	$0F, $0F, $0C, $F0, $70, $60, $F1, $01, $F0, $D0, $C4, $D0, $F0, $70, $60, $F0
	dc.b	$0F, $0F, $0D, $F1, $03, $F0, $D1, $C3, $D0, $F0, $61, $F0, $0F, $0F, $0F, $04 ;0xA0
	dc.b	$F0, $D1, $C2, $D0, $F0, $60, $F0, $0F, $0F, $0F, $04, $F2, $30, $D2, $F0, $61
	dc.b	$F0, $0F, $0F, $0F, $01, $F6, $31, $F0, $70, $61, $F0, $0F, $0F, $0F, $00, $FA ;0xC0
	dc.b	$71, $60, $F0, $0F, $0F, $0E, $F1, $60, $20, $F1, $31, $F5, $70, $F1, $0F, $0F
	dc.b	$0D, $F0, $62, $20, $31, $F7, $30, $F1, $0F, $0F, $0C, $F0, $61, $72, $F9, $30 ;0xE0
	dc.b	$F0, $0F, $0F, $08, $C0, $04, $F0, $61, $F3, $02, $F3, $30, $F1, $0F, $0F, $06
	dc.b	$20, $01, $20, $00, $C0, $01, $F0, $61, $70, $F0, $03, $F4, $30, $F0, $0F, $0F ;0x100
	dc.b	$0C, $20, $00, $20, $F0, $70, $61, $F0, $03, $F3, $30, $F1, $0F, $0F, $09, $C0
	dc.b	$00, $20, $00, $10, $C0, $10, $F0, $61, $F1, $02, $F0, $21, $F0, $30, $F0, $0F ;0x120
	dc.b	$0F, $0C, $10, $00, $C0, $D2, $F3, $02, $F0, $61, $21, $F0, $0F, $0F, $0B, $20
	dc.b	$00, $C0, $10, $D1, $F1, $61, $F1, $01, $F0, $61, $70, $F0, $0F, $0F, $0C, $20 ;0x140
	dc.b	$00, $10, $F0, $D0, $F0, $62, $70, $F0, $D0, $F2, $60, $71, $F0, $0F, $0F, $0F
	dc.b	$00, $F1, $70, $F2, $D3, $F0, $62, $70, $F0, $0F, $0F, $0F, $00, $F1, $C2, $D1 ;0x160
	dc.b	$C2, $F0, $62, $F0, $0F, $0F, $0F, $00, $F0, $D0, $C3, $D1, $C2, $F0, $61, $70
	dc.b	$F0, $0F, $0F, $0F, $00, $F0, $D0, $C4, $D0, $C1, $D0, $F0, $61, $F0, $0F, $0F ;0x180
	dc.b	$0F, $01, $F0, $D0, $C4, $D2, $F0, $70, $60, $70, $F0, $0F, $0F, $0F, $01, $F0
	dc.b	$D1, $C4, $D1, $F0, $70, $60, $F1, $0F, $0F, $0F, $01, $F0, $D1, $C5, $D0, $F0 ;0x1A0
	dc.b	$61, $F1, $0F, $0F, $0F, $01, $F0, $D2, $C3, $F0, $61, $70, $F0, $D0, $F1, $0F
	dc.b	$0F, $0F, $00, $F1, $D2, $C0, $F0, $61, $70, $F0, $C1, $D1, $F1, $0F, $0F, $0F ;0x1C0
	dc.b	$00, $F1, $D2, $F2, $C4, $D1, $F0, $0F, $0F, $0F, $01, $F1, $D4, $C4, $D1, $F0
	dc.b	$0F, $0F, $0F, $02, $F3, $D5, $F1, $0F, $0F, $0F, $07, $F5, $0F, $0F, $0F, $0F ;0x1E0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x200
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $02 ;0x220
loc_10694:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $03, $F2, $0F, $0F, $0F, $0B, $F0, $A1, $B0, $F1, $0F, $0F, $0F, $09, $F0 ;0x0 (0x00010694-0x00010AB0, Entry count: 0x41C)
	dc.b	$B1, $A1, $B0, $F0, $0F, $0F, $0F, $08, $F0, $B3, $A0, $B0, $F0, $0F, $0F, $0F
	dc.b	$08, $F0, $B3, $A0, $B0, $F0, $0F, $0F, $0F, $07, $FA, $0F, $0F, $0F, $03, $F0 ;0x20
	dc.b	$BA, $F3, $0F, $0F, $0E, $F0, $B0, $A1, $C0, $A0, $C3, $F2, $10, $20, $10, $20
	dc.b	$F1, $0F, $0F, $0C, $F0, $B1, $A5, $F0, $30, $20, $30, $20, $30, $20, $30, $20 ;0x40
	dc.b	$F0, $0F, $0F, $0C, $F1, $B7, $F7, $0F, $0F, $0E, $FE, $0F, $0F, $0B, $F2, $03
	dc.b	$F6, $B0, $A0, $B0, $F1, $0A, $F5, $0F, $0A, $F0, $E1, $F2, $00, $F0, $BB, $F2 ;0x60
	dc.b	$04, $F2, $B1, $F1, $B1, $F0, $0F, $08, $F0, $D1, $F1, $E0, $F1, $B7, $A0, $B6
	dc.b	$F1, $00, $F1, $B3, $F0, $B1, $F1, $B1, $F4, $0F, $02, $F0, $D1, $F0, $E0, $F1 ;0x80
	dc.b	$B0, $A6, $B2, $A1, $B5, $F1, $B2, $A1, $F0, $B0, $F1, $E0, $F1, $B0, $F0, $B1
	dc.b	$A0, $F0, $0F, $01, $F6, $A2, $C1, $A5, $B1, $A1, $B5, $F0, $A3, $F0, $B0, $F1 ;0xA0
	dc.b	$E1, $F1, $B0, $F0, $A0, $F1, $0F, $F1, $B3, $F2, $A3, $C0, $A0, $C2, $A3, $B1
	dc.b	$A0, $B0, $21, $32, $F1, $A1, $F0, $B0, $F2, $E0, $F2, $B0, $F1, $0F, $F0, $A2 ;0xC0
	dc.b	$F3, $B1, $F0, $A4, $C5, $A1, $B1, $20, $C1, $21, $32, $F0, $A0, $F0, $B0, $F0
	dc.b	$E0, $F0, $E0, $F2, $B0, $F0, $0F, $F0, $A2, $F1, $B2, $F3, $A5, $C2, $A1, $C0 ;0xE0
	dc.b	$A0, $B0, $F0, $23, $C0, $20, $30, $F3, $B0, $F6, $B0, $F0, $0D, $F0, $A3, $F0
	dc.b	$B0, $E2, $B2, $F0, $A6, $C1, $A0, $C1, $B0, $20, $C0, $F0, $25, $30, $F2, $B0 ;0x100
	dc.b	$F6, $B0, $F0, $0C, $F0, $A4, $F0, $B0, $F3, $E0, $B0, $F0, $A9, $C1, $B0, $20
	dc.b	$C0, $20, $F0, $24, $30, $F2, $B0, $F6, $E0, $B0, $F0, $0B, $F0, $A3, $F0, $B0 ;0x120
	dc.b	$F5, $E0, $B0, $F0, $A8, $C1, $B0, $20, $C0, $20, $FA, $B0, $F5, $E0, $B0, $F5
	dc.b	$02, $F3, $A4, $F0, $B0, $F3, $D1, $F0, $B0, $F0, $AA, $B0, $20, $F1, $20, $F0 ;0x140
	dc.b	$24, $30, $F0, $30, $F0, $B0, $E0, $F4, $E1, $B0, $F0, $B3, $F0, $00, $F0, $A0
	dc.b	$B5, $A0, $F0, $B0, $F1, $E0, $F1, $D1, $F0, $B0, $F0, $B2, $A7, $B0, $F0, $22 ;0x160
	dc.b	$F0, $25, $30, $F0, $30, $F0, $B0, $E0, $F2, $E2, $B0, $F0, $B1, $A0, $F1, $00
	dc.b	$F1, $A6, $F0, $B0, $F0, $E1, $F0, $D1, $F1, $B0, $F0, $B4, $F0, $A4, $B0, $23 ;0x180
	dc.b	$F0, $20, $C1, $22, $30, $F0, $30, $F0, $B0, $E3, $F2, $E0, $B0, $F0, $A0, $F1
	dc.b	$02, $F6, $A0, $F0, $B0, $F2, $E0, $D0, $F2, $B0, $F0, $A5, $F0, $A3, $B0, $20 ;0x1A0
	dc.b	$C0, $21, $F0, $20, $C1, $22, $30, $F0, $30, $F1, $B0, $E1, $F4, $B0, $F2, $05
	dc.b	$F0, $B2, $A1, $F0, $B0, $F7, $B0, $F6, $A4, $B0, $20, $C0, $22, $F0, $25, $30 ;0x1C0
	dc.b	$F0, $30, $F2, $E0, $F1, $E0, $F1, $E0, $B0, $F0, $06, $F0, $B0, $A2, $F0, $B0
	dc.b	$E0, $F7, $B0, $F2, $B0, $F3, $A3, $B0, $20, $C0, $22, $F0, $20, $C1, $22, $30 ;0x1E0
	dc.b	$F0, $30, $F0, $A1, $F2, $E1, $F0, $E0, $B0, $F0, $05, $F0, $B0, $A3, $F0, $B0
	dc.b	$E0, $F7, $E0, $B0, $F0, $A0, $B4, $F1, $A1, $B0, $20, $C0, $22, $F0, $20, $C2 ;0x200
	dc.b	$21, $30, $F0, $30, $F2, $A0, $F3, $E1, $B0, $F0, $05, $F0, $A4, $F0, $B0, $E1
	dc.b	$F5, $E1, $B0, $F0, $A0, $C1, $A0, $B0, $A2, $F0, $A0, $B0, $20, $C0, $22, $F0 ;0x220
	dc.b	$20, $C2, $22, $30, $F0, $30, $F0, $B0, $A0, $F0, $E4, $B0, $F0, $05, $F0, $A4
	dc.b	$F0, $B0, $E2, $F3, $E2, $B0, $F0, $C1, $A2, $F3, $A0, $B0, $20, $C0, $23, $F0 ;0x240
	dc.b	$C2, $20, $30, $20, $30, $F0, $30, $F2, $A0, $F0, $E1, $B1, $F0, $06, $F0, $A3
	dc.b	$F0, $B0, $EA, $B0, $F0, $A3, $F1, $B0, $F0, $A1, $B0, $30, $C1, $22, $F0, $20 ;0x260
	dc.b	$C1, $20, $30, $20, $30, $F0, $30, $F0, $A0, $B0, $A0, $F0, $B1, $F1, $05, $F2
	dc.b	$A3, $F0, $B0, $E3, $F3, $E2, $B0, $F0, $C1, $A0, $F1, $B0, $A0, $B0, $A2, $B0 ;0x280
	dc.b	$20, $C0, $22, $F0, $23, $30, $20, $30, $F0, $30, $F2, $B0, $F2, $06, $F0, $A0
	dc.b	$B3, $A1, $F0, $B0, $E2, $F0, $E1, $F2, $E1, $B0, $F0, $A2, $F2, $B0, $F0, $A2 ;0x2A0
	dc.b	$B0, $20, $C0, $22, $F0, $22, $31, $20, $30, $F2, $A0, $B1, $F0, $08, $F1, $A1
	dc.b	$B3, $F0, $B0, $E1, $F0, $E2, $F2, $E1, $B0, $F0, $A2, $F0, $B0, $A1, $B0, $A2 ;0x2C0
	dc.b	$B0, $30, $C0, $22, $F0, $22, $31, $20, $30, $F0, $30, $F1, $B0, $F0, $0A, $F2
	dc.b	$A3, $F0, $B0, $E1, $F0, $E1, $F3, $E0, $B0, $F3, $A0, $F1, $B1, $F0, $A3, $B0 ;0x2E0
	dc.b	$23, $F0, $21, $32, $F4, $B1, $F0, $0C, $F5, $B0, $E1, $F6, $E0, $B0, $F3, $A0
	dc.b	$F0, $B0, $A2, $B0, $A2, $B0, $F9, $31, $F1, $B1, $F0, $0E, $F2, $B1, $F0, $B0 ;0x300
	dc.b	$E1, $F4, $E1, $B0, $F0, $B2, $F0, $A0, $F1, $B1, $F0, $A3, $B0, $30, $C0, $20
	dc.b	$F0, $20, $32, $20, $31, $F3, $0F, $00, $F2, $B0, $F0, $B0, $E2, $F2, $E1, $B0 ;0x320
	dc.b	$F1, $A2, $F0, $A0, $F0, $B0, $A2, $B0, $A2, $B0, $31, $C0, $F0, $32, $20, $31
	dc.b	$F2, $0F, $04, $F3, $B2, $E4, $B0, $F4, $B1, $A0, $F1, $B1, $F0, $A3, $F0, $31 ;0x340
	dc.b	$F0, $C2, $32, $F0, $0F, $09, $F3, $B4, $F3, $B4, $A0, $F4, $A1, $B1, $F2, $33
	dc.b	$F2, $0F, $0D, $F4, $02, $F3, $B6, $F0, $B6, $F5, $0F, $0F, $07, $F9, $B5, $F6 ;0x360
	dc.b	$0F, $0F, $07, $F0, $B0, $F4, $01, $FE, $0F, $0F, $06, $F0, $B1, $A0, $F2, $07
	dc.b	$F5, $B0, $F3, $0F, $0F, $00, $F4, $B1, $A0, $B0, $F1, $0D, $F1, $B1, $F2, $0A ;0x380
	dc.b	$F2, $0D, $F3, $A2, $F1, $B2, $F2, $0E, $F1, $B0, $A0, $B0, $F1, $06, $F2, $B2
	dc.b	$F0, $09, $F2, $A5, $F0, $B1, $F3, $A1, $F3, $0B, $F0, $B1, $A0, $B0, $F0, $04 ;0x3A0
	dc.b	$F1, $B2, $F3, $08, $F1, $B3, $A3, $F1, $B1, $A0, $B0, $F1, $A4, $F5, $05, $F1
	dc.b	$B0, $A1, $B0, $F0, $01, $F1, $B1, $F6, $09, $F3, $B4, $A1, $F5, $AA, $F7, $B0 ;0x3C0
	dc.b	$F5, $B1, $F7, $0D, $F4, $B5, $AF, $A5, $F0, $B1, $F1, $B1, $F7, $0F, $03, $F5
	dc.b	$B6, $AE, $F3, $B1, $F7, $0F, $0A, $F6, $B6, $A7, $B4, $F7, $0F, $0F, $02, $F6 ;0x3E0
	dc.b	$B9, $F7, $0F, $0F, $0C, $FC, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $01 ;0x400
loc_10AB0:
	dc.b	$0F, $0D, $F0, $0F, $0F, $0F, $0D, $F0, $80, $F0, $0F, $0F, $0F, $0C, $F0, $80
	dc.b	$90, $F0, $0F, $0F, $0F, $0A, $F0, $81, $90, $F0, $0F, $0F, $0F, $0A, $F0, $81 ;0x0 (0x00010AB0-0x00010D4D, Entry count: 0x29D) [Unknown data]
	dc.b	$91, $F0, $0F, $0F, $0F, $08, $F0, $82, $91, $F0, $0F, $0F, $0F, $07, $F0, $84
	dc.b	$91, $F0, $0F, $0F, $0F, $06, $F0, $82, $90, $80, $92, $F0, $0F, $0F, $0F, $04 ;0x20
	dc.b	$F0, $83, $90, $80, $92, $F0, $0F, $0F, $0F, $04, $F0, $81, $90, $80, $95, $F0
	dc.b	$0F, $0F, $0F, $02, $F0, $91, $F0, $90, $81, $92, $F0, $90, $F0, $0F, $0F, $0F ;0x40
	dc.b	$03, $F2, $90, $81, $92, $F1, $0F, $0F, $0F, $05, $F0, $82, $94, $F0, $0F, $0F
	dc.b	$0F, $04, $F0, $83, $95, $F0, $0F, $0F, $0F, $03, $F0, $84, $94, $F0, $0F, $0F ;0x60
	dc.b	$0F, $02, $F0, $82, $90, $81, $95, $F0, $0F, $0F, $0F, $00, $F0, $82, $92, $80
	dc.b	$93, $F0, $91, $F0, $0F, $0F, $0F, $F0, $81, $98, $F0, $91, $F0, $0F, $0F, $0E ;0x80
	dc.b	$F0, $92, $F0, $90, $80, $95, $F1, $91, $F0, $0F, $0F, $0C, $F0, $90, $F2, $82
	dc.b	$96, $F2, $90, $F0, $0F, $0F, $0C, $F0, $00, $F0, $83, $90, $80, $95, $F0, $00 ;0xA0
	dc.b	$F0, $0F, $0F, $0F, $F0, $82, $90, $81, $95, $F0, $0F, $0F, $0F, $00, $F0, $85
	dc.b	$97, $F0, $0F, $0F, $0F, $F0, $82, $90, $81, $97, $F0, $0F, $0F, $0E, $F0, $81 ;0xC0
	dc.b	$92, $81, $98, $F0, $0F, $0F, $0C, $F0, $80, $94, $80, $95, $F1, $92, $F0, $0F
	dc.b	$0F, $0A, $F0, $91, $F1, $90, $80, $90, $80, $96, $F2, $91, $F0, $0F, $0F, $0A ;0xE0
	dc.b	$F2, $83, $98, $F0, $00, $F1, $0F, $0F, $0D, $F0, $83, $90, $80, $97, $F0, $0F
	dc.b	$0F, $0E, $F0, $83, $91, $80, $97, $F0, $0F, $0F, $0D, $F0, $88, $97, $F0, $0F ;0x100
	dc.b	$0F, $0C, $F0, $81, $90, $83, $90, $80, $97, $F0, $0F, $0F, $0B, $F0, $80, $92
	dc.b	$80, $90, $81, $90, $80, $98, $F0, $0F, $0F, $09, $F0, $80, $90, $F1, $81, $90 ;0x120
	dc.b	$80, $99, $F0, $91, $F0, $0F, $0F, $07, $F0, $80, $90, $F1, $90, $80, $91, $81
	dc.b	$98, $F1, $91, $F0, $0F, $0F, $06, $F0, $90, $F0, $00, $F0, $81, $91, $81, $99 ;0x140
	dc.b	$F2, $90, $F0, $0F, $0F, $04, $F0, $90, $F0, $00, $F0, $86, $90, $80, $97, $F0
	dc.b	$01, $F0, $0F, $0F, $06, $F0, $00, $F0, $86, $91, $80, $98, $F0, $0F, $0F, $0A ;0x160
	dc.b	$F0, $82, $90, $82, $90, $81, $99, $F0, $0F, $0F, $08, $F0, $82, $90, $80, $91
	dc.b	$80, $90, $81, $99, $F0, $0F, $0F, $08, $F0, $81, $91, $80, $91, $81, $90, $80 ;0x180
	dc.b	$95, $F1, $92, $F0, $0F, $0F, $06, $F0, $81, $90, $F1, $91, $82, $90, $81, $95
	dc.b	$F0, $93, $F0, $0F, $0F, $04, $F0, $80, $91, $F0, $00, $F0, $90, $83, $98, $F1 ;0x1A0
	dc.b	$93, $F0, $0F, $0F, $03, $F0, $90, $F1, $00, $F0, $82, $91, $80, $99, $F2, $92
	dc.b	$F0, $0F, $0F, $01, $F0, $90, $F0, $00, $F1, $82, $92, $80, $9A, $F0, $00, $F2 ;0x1C0
	dc.b	$0F, $0F, $03, $F0, $00, $F0, $87, $9C, $F0, $0F, $0F, $09, $F0, $83, $91, $80
	dc.b	$9D, $F0, $0F, $0F, $07, $F0, $81, $94, $80, $9D, $F0, $0F, $0F, $06, $F0, $80 ;0x1E0
	dc.b	$9B, $F0, $99, $F0, $0F, $0F, $04, $F0, $91, $F0, $90, $F2, $92, $F0, $90, $F1
	dc.b	$B0, $F1, $95, $F0, $91, $F0, $0F, $0F, $02, $F0, $90, $F1, $00, $F0, $00, $F0 ;0x200
	dc.b	$91, $F2, $90, $F0, $B1, $F2, $91, $F1, $91, $F1, $90, $F0, $0F, $0F, $02, $F0
	dc.b	$05, $F3, $90, $F1, $B1, $F0, $01, $F1, $01, $F1, $01, $F0, $0F, $0F, $0E, $F0 ;0x220
	dc.b	$B0, $F0, $B1, $F0, $0F, $0F, $0F, $09, $F0, $B0, $F0, $B1, $F0, $0F, $0F, $0F
	dc.b	$09, $F0, $B0, $F0, $B1, $F0, $0F, $0F, $0F, $09, $F0, $B0, $F0, $B1, $F0, $0F ;0x240
	dc.b	$0F, $0F, $09, $F0, $B0, $F0, $B1, $F0, $0F, $0F, $0F, $09, $F0, $B0, $F0, $B1
	dc.b	$F0, $0F, $0F, $0F, $08, $F1, $B4, $F0, $0F, $0F, $0F, $04, $F4, $B4, $F1, $0F ;0x260
	dc.b	$0F, $0F, $02, $F4, $B2, $F1, $B2, $F0, $0F, $0F, $0F, $02, $F2, $B1, $F1, $01
	dc.b	$F4, $0F, $0F, $0F, $03, $F3, $0F, $0F, $0F, $0F, $0F, $0F, $01 ;0x280
loc_10D4D:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $06, $F6, $0F, $0F, $0F, $06, $F2 ;0x0 (0x00010D4D-0x00011150, Entry count: 0x403)
	dc.b	$14, $F2, $0F, $0F, $0F, $03, $F1, $10, $C6, $10, $F2, $0F, $0F, $0F, $00, $F1
	dc.b	$10, $C1, $F4, $C1, $10, $F4, $0F, $0F, $0D, $F0, $20, $10, $C0, $F0, $64, $F1 ;0x20
	dc.b	$10, $F0, $70, $62, $F1, $0F, $0F, $0A, $F1, $10, $C0, $F0, $70, $65, $70, $F0
	dc.b	$70, $64, $70, $F0, $0F, $0F, $09, $F0, $20, $10, $F0, $72, $F4, $60, $F0, $60 ;0x40
	dc.b	$F3, $72, $F0, $0F, $0F, $08, $F0, $20, $10, $F0, $70, $F1, $C0, $F2, $C0, $F8
	dc.b	$70, $F0, $0F, $0F, $08, $F0, $20, $10, $F7, $C1, $F0, $C0, $F0, $C0, $F1, $C0 ;0x60
	dc.b	$F2, $0F, $0F, $08, $F0, $20, $F3, $10, $F2, $C1, $F1, $11, $F1, $C1, $F1, $0F
	dc.b	$0F, $09, $F6, $13, $F3, $13, $F1, $0F, $0F, $09, $F1, $70, $F2, $70, $F5, $71 ;0x80
	dc.b	$F5, $0F, $0F, $08, $F1, $71, $F2, $70, $62, $70, $F1, $70, $60, $72, $F1, $0F
	dc.b	$0F, $07, $F2, $72, $F3, $70, $61, $71, $F0, $70, $61, $70, $F1, $0F, $0F, $05 ;0xA0
	dc.b	$F3, $73, $F2, $70, $F1, $62, $70, $F1, $61, $70, $F1, $0F, $0F, $05, $F0, $74
	dc.b	$F2, $71, $F1, $00, $F0, $62, $70, $F0, $70, $60, $71, $F0, $0F, $F1, $0F, $04 ;0xC0
	dc.b	$F6, $71, $F1, $02, $F0, $70, $61, $70, $F0, $61, $70, $F1, $0E, $F0, $C1, $F0
	dc.b	$0F, $04, $F8, $03, $F0, $70, $62, $70, $61, $70, $F0, $0F, $F0, $C0, $D0, $F0 ;0xE0
	dc.b	$0F, $0F, $00, $F2, $70, $62, $70, $61, $70, $F1, $0D, $F0, $C0, $F0, $0F, $0F
	dc.b	$01, $F0, $B0, $F0, $70, $65, $70, $F2, $0B, $F0, $C0, $D0, $F0, $0F, $0F, $02 ;0x100
	dc.b	$F2, $66, $70, $F0, $A0, $F0, $08, $F3, $C0, $F2, $0F, $0F, $00, $F0, $B0, $F0
	dc.b	$67, $F0, $B0, $F0, $07, $F0, $C0, $F0, $C0, $F1, $C2, $F1, $0F, $0F, $F0, $A0 ;0x120
	dc.b	$F0, $67, $F0, $A0, $F1, $04, $F1, $C0, $F0, $D0, $C0, $F0, $C0, $F0, $D0, $C1
	dc.b	$F1, $0F, $0D, $F1, $B0, $F0, $66, $F0, $B0, $F0, $70, $F4, $70, $F0, $D1, $F2 ;0x140
	dc.b	$C0, $F2, $D0, $C1, $F0, $0F, $0A, $F1, $70, $60, $F0, $A0, $F0, $66, $F0, $A0
	dc.b	$F0, $66, $F0, $D0, $F2, $D0, $C0, $F0, $01, $D0, $C1, $F0, $0F, $07, $F1, $70 ;0x160
	dc.b	$61, $71, $F0, $B0, $F1, $64, $F0, $B0, $F0, $70, $63, $72, $F1, $01, $D0, $C0
	dc.b	$F0, $01, $F0, $D1, $F0, $0F, $06, $F0, $70, $61, $72, $F0, $70, $F0, $A0, $B0 ;0x180
	dc.b	$F5, $A0, $F1, $73, $F3, $02, $F0, $C1, $F0, $01, $F1, $0F, $05, $F1, $70, $60
	dc.b	$72, $F2, $70, $60, $F2, $B0, $A4, $F6, $06, $D0, $C0, $F0, $0F, $07, $F3, $60 ;0x1A0
	dc.b	$71, $F2, $00, $F0, $70, $61, $F0, $B0, $F1, $C0, $F2, $A0, $F1, $0A, $D0, $C0
	dc.b	$F0, $0F, $F2, $03, $F0, $C3, $F0, $70, $F1, $02, $F0, $70, $61, $F0, $A0, $F0 ;0x1C0
	dc.b	$A0, $C1, $F0, $C0, $B0, $F1, $0A, $F1, $0F, $00, $F0, $D0, $C0, $F7, $D1, $F1
	dc.b	$03, $F0, $70, $61, $F0, $B0, $F0, $C0, $F0, $C0, $F0, $C0, $A0, $F0, $70, $F0 ;0x1E0
	dc.b	$0F, $0C, $F1, $D4, $C3, $F0, $D0, $F0, $03, $F0, $71, $61, $F0, $B1, $F0, $C0
	dc.b	$A0, $F0, $A0, $B0, $F0, $70, $F0, $0F, $0D, $F4, $D1, $C2, $F1, $04, $F0, $70 ;0x200
	dc.b	$62, $F1, $B1, $A0, $B0, $A0, $B0, $F0, $61, $F0, $0F, $0F, $02, $F0, $C2, $F1
	dc.b	$05, $F0, $70, $63, $F6, $62, $70, $F1, $0F, $0F, $F0, $C0, $D0, $F0, $D0, $C0 ;0x220
	dc.b	$F0, $04, $F0, $70, $6F, $60, $70, $F1, $0F, $08, $F4, $C0, $D0, $F2, $D0, $C0
	dc.b	$F0, $02, $F0, $70, $62, $71, $6E, $70, $F1, $0F, $06, $F0, $D0, $C1, $D1, $F1 ;0x240
	dc.b	$00, $F1, $D0, $C0, $F0, $00, $F0, $70, $61, $75, $64, $73, $65, $70, $F0, $0F
	dc.b	$05, $F1, $D1, $F2, $02, $F1, $D0, $C0, $F0, $70, $61, $72, $F3, $70, $62, $71 ;0x260
	dc.b	$F3, $70, $64, $70, $F0, $0F, $05, $F3, $05, $F0, $D1, $F0, $61, $71, $F1, $02
	dc.b	$F1, $62, $70, $F0, $02, $F2, $70, $63, $70, $F0, $0F, $0F, $F1, $62, $70, $F1 ;0x280
	dc.b	$04, $F0, $61, $71, $F0, $04, $F1, $70, $63, $70, $F0, $0F, $0E, $F0, $70, $F1
	dc.b	$70, $F1, $05, $F0, $62, $71, $F0, $04, $F1, $70, $F0, $71, $F1, $0F, $0E, $F0 ;0x2A0
	dc.b	$60, $72, $F0, $06, $F0, $62, $71, $F0, $05, $F0, $71, $F1, $70, $F0, $0F, $0D
	dc.b	$F0, $70, $62, $70, $F0, $06, $F0, $70, $61, $71, $F0, $05, $F0, $60, $73, $F0 ;0x2C0
	dc.b	$0F, $0D, $F0, $70, $61, $71, $F0, $06, $F1, $72, $F0, $06, $F0, $62, $70, $F0
	dc.b	$0F, $0E, $F0, $70, $61, $70, $F1, $05, $F0, $71, $F3, $05, $F0, $70, $61, $71 ;0x2E0
	dc.b	$F0, $0F, $0D, $F1, $61, $71, $F0, $06, $F0, $60, $72, $F0, $05, $F1, $62, $71
	dc.b	$F1, $0F, $0B, $F1, $E0, $F0, $71, $F1, $05, $F0, $70, $61, $70, $F1, $05, $F2 ;0x300
	dc.b	$61, $70, $F2, $0F, $0A, $F0, $D0, $F0, $D0, $F3, $D0, $F0, $04, $F0, $61, $71
	dc.b	$F1, $05, $F0, $D0, $F6, $0F, $0A, $F0, $D0, $F1, $D0, $F0, $C0, $D0, $F1, $03 ;0x320
	dc.b	$F1, $60, $F4, $05, $F0, $E0, $D0, $C0, $E0, $F2, $D0, $F0, $01, $F4, $0F, $01
	dc.b	$F3, $D1, $F0, $C0, $D0, $F0, $03, $F3, $D0, $F0, $C0, $F0, $D0, $F0, $05, $F0 ;0x340
	dc.b	$E0, $D0, $C0, $E0, $F6, $D0, $E0, $D0, $E0, $F0, $0A, $FB, $C1, $D0, $E0, $F0
	dc.b	$02, $F0, $D0, $F0, $D0, $E0, $D0, $F0, $D1, $F0, $04, $F1, $D0, $E0, $C1, $F0 ;0x360
	dc.b	$D0, $F3, $D4, $E0, $F0, $08, $F0, $C1, $D1, $F0, $C0, $F1, $C0, $F2, $C1, $D0
	dc.b	$E0, $F1, $01, $F0, $D0, $F0, $E0, $D0, $F6, $02, $F0, $D0, $E0, $C1, $F1, $D0 ;0x380
	dc.b	$F1, $D0, $F0, $C2, $D1, $E0, $F1, $06, $F0, $C1, $D1, $E1, $F1, $C1, $F6, $E0
	dc.b	$F0, $01, $F5, $C1, $D0, $E1, $F1, $00, $F0, $C0, $F0, $E3, $FD, $05, $F0, $C0 ;0x3A0
	dc.b	$F0, $D1, $E3, $F4, $C3, $D0, $F1, $01, $F0, $D0, $F2, $C2, $D0, $E2, $F3, $C1
	dc.b	$D2, $E4, $D1, $C2, $D0, $E1, $F0, $05, $F0, $C0, $F7, $E1, $D1, $F4, $03, $F1 ;0x3C0
	dc.b	$D0, $F1, $C2, $D1, $E1, $F1, $00, $FF, $F2, $06, $F1, $C2, $D1, $E2, $F3, $09
	dc.b	$F1, $C1, $F8, $0F, $0B, $F8, $0E, $F2, $C1, $D1, $E3, $F0, $0F, $0F, $0F, $05 ;0x3E0
	dc.b	$F8, $0F, $08 ;0x400
loc_11150:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00011150-0x000114B0, Entry count: 0x360) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $08, $F5, $0F, $0F, $0F, $08, $F0, $65, $F0, $0F, $0F, $0F, $06, $F0 ;0x20
	dc.b	$67, $F0, $0F, $01, $FF, $F1, $0F, $01, $F9, $0F, $00, $F0, $6F, $61, $F0, $0F
	dc.b	$00, $F0, $77, $F0, $0F, $F0, $6F, $62, $F0, $0F, $01, $F0, $75, $F0, $0F, $00 ;0x40
	dc.b	$F0, $6F, $61, $F1, $0F, $01, $F0, $75, $F0, $0F, $FF, $F5, $0F, $02, $F0, $73
	dc.b	$F0, $0F, $00, $F0, $7F, $72, $F1, $01, $F1, $04, $F4, $04, $F0, $73, $F0, $04 ;0x60
	dc.b	$F4, $06, $FF, $F5, $00, $F0, $A1, $F0, $02, $F0, $D4, $F0, $03, $F5, $04, $F0
	dc.b	$A2, $F0, $08, $F1, $9F, $F1, $00, $F0, $A1, $F0, $01, $F0, $E1, $D1, $C0, $D1 ;0x80
	dc.b	$F0, $02, $F0, $91, $80, $90, $F0, $03, $F6, $09, $F0, $92, $F3, $92, $F2, $91
	dc.b	$F1, $00, $F0, $A1, $F0, $01, $F0, $E1, $D1, $C1, $D0, $F0, $02, $F0, $91, $80 ;0xA0
	dc.b	$90, $F0, $03, $F0, $A4, $F0, $0A, $F0, $90, $F2, $01, $F0, $90, $F2, $00, $F0
	dc.b	$90, $F2, $A1, $B1, $F0, $00, $F0, $E1, $D1, $C1, $D0, $F0, $02, $F0, $91, $80 ;0xC0
	dc.b	$90, $F0, $03, $F0, $A0, $F2, $A0, $F0, $0A, $F0, $90, $F1, $02, $F0, $90, $F1
	dc.b	$01, $F0, $90, $F1, $90, $F3, $01, $F0, $E1, $D1, $C1, $D0, $F0, $02, $F0, $91 ;0xE0
	dc.b	$80, $90, $F0, $02, $F1, $A2, $F0, $A0, $F0, $0A, $F0, $90, $F1, $02, $F0, $90
	dc.b	$F1, $01, $F0, $90, $F0, $90, $80, $91, $F1, $01, $F0, $E1, $D2, $C0, $D0, $F0 ;0x100
	dc.b	$02, $F0, $91, $80, $90, $F0, $00, $F3, $A2, $F0, $A0, $F0, $0A, $F0, $90, $F1
	dc.b	$02, $F0, $90, $F1, $01, $F0, $90, $F0, $82, $90, $F3, $E2, $D5, $F3, $91, $80 ;0x120
	dc.b	$90, $F2, $91, $F0, $A2, $F0, $A0, $F0, $0A, $F0, $90, $F1, $02, $F0, $90, $F1
	dc.b	$01, $F0, $90, $F0, $83, $F0, $90, $F0, $90, $F1, $D4, $F1, $93, $F3, $91, $F0 ;0x140
	dc.b	$81, $F1, $A3, $F0, $0A, $F0, $90, $F1, $02, $F0, $90, $F4, $90, $F0, $83, $F0
	dc.b	$90, $F0, $90, $81, $F4, $8A, $90, $F0, $81, $F0, $90, $F4, $0A, $F0, $90, $F1 ;0x160
	dc.b	$02, $F0, $96, $F0, $83, $F0, $90, $F0, $8F, $83, $F0, $81, $F0, $90, $F0, $0E
	dc.b	$F0, $90, $F1, $02, $F0, $90, $F4, $90, $F0, $83, $F0, $90, $F0, $90, $8F, $81 ;0x180
	dc.b	$90, $F0, $91, $F0, $90, $F0, $0E, $F0, $90, $F1, $02, $F0, $94, $F0, $90, $F0
	dc.b	$90, $82, $F0, $90, $F0, $9F, $93, $F0, $91, $F0, $90, $F0, $0E, $F0, $90, $F1 ;0x1A0
	dc.b	$02, $F0, $94, $F0, $90, $F0, $91, $80, $90, $F0, $90, $FF, $F5, $91, $F0, $90
	dc.b	$F2, $0C, $F0, $90, $F1, $02, $F0, $94, $F0, $90, $F0, $93, $F0, $90, $F0, $9F ;0x1C0
	dc.b	$93, $F0, $91, $F0, $90, $F0, $90, $F0, $0C, $F0, $90, $F1, $02, $F0, $96, $FF
	dc.b	$FC, $91, $F0, $90, $F0, $90, $F0, $0C, $FF, $EF, $EA, $F0, $91, $F0, $90, $F2 ;0x1E0
	dc.b	$0B, $F0, $EE, $FF, $FC, $91, $F0, $90, $F2, $0B, $FF, $F1, $74, $F8, $74, $FC
	dc.b	$0E, $FE, $72, $F2, $72, $F4, $72, $F2, $71, $F3, $D0, $F0, $D1, $F0, $D0, $F1 ;0x200
	dc.b	$0F, $FC, $71, $F2, $90, $F2, $71, $F2, $71, $F6, $D2, $F0, $C0, $F0, $C1, $F0
	dc.b	$C0, $F1, $0F, $FC, $70, $F0, $90, $F1, $90, $F1, $90, $F0, $70, $F5, $D5, $F3 ;0x220
	dc.b	$D0, $F0, $D1, $F0, $D0, $F1, $0E, $FC, $71, $F1, $90, $F2, $90, $F2, $D5, $F6
	dc.b	$71, $F0, $E0, $F0, $E1, $F0, $E0, $F1, $0E, $F0, $E7, $F3, $70, $F4, $70, $F2 ;0x240
	dc.b	$D1, $F7, $70, $F4, $70, $FB, $0B, $FC, $70, $F0, $91, $F0, $72, $FE, $91, $F0
	dc.b	$70, $F5, $95, $F0, $0B, $FB, $70, $F4, $70, $F0, $DD, $F3, $70, $F5, $91, $F1 ;0x260
	dc.b	$90, $F0, $90, $F0, $09, $F1, $72, $F2, $72, $F1, $71, $F1, $90, $FF, $F3, $71
	dc.b	$F1, $72, $F1, $91, $F0, $91, $F0, $90, $F0, $08, $F0, $70, $F2, $70, $F0, $70 ;0x280
	dc.b	$F2, $70, $F1, $70, $F0, $90, $F1, $90, $F1, $90, $F0, $70, $F0, $00, $F0, $70
	dc.b	$F0, $90, $F1, $90, $F1, $90, $F0, $70, $F1, $70, $F2, $70, $F0, $91, $F1, $90 ;0x2A0
	dc.b	$F1, $90, $F0, $07, $F0, $70, $F0, $70, $F0, $70, $F0, $70, $F0, $70, $F0, $70
	dc.b	$F1, $71, $F2, $90, $F2, $71, $F0, $00, $F0, $71, $F2, $90, $F2, $71, $F1, $70 ;0x2C0
	dc.b	$F0, $70, $F0, $70, $F1, $91, $F0, $91, $F1, $90, $F0, $06, $F0, $70, $F2, $70
	dc.b	$F0, $70, $F2, $70, $F0, $00, $F0, $72, $F2, $72, $F0, $02, $F0, $72, $F2, $72 ;0x2E0
	dc.b	$F0, $00, $F0, $70, $F2, $70, $F1, $91, $F1, $94, $F0, $06, $F0, $72, $F0, $00
	dc.b	$F0, $72, $F0, $02, $F1, $74, $F1, $04, $F1, $74, $F1, $02, $F0, $72, $F0, $00 ;0x300
	dc.b	$F1, $94, $F4, $06, $F2, $02, $F2, $05, $F4, $08, $F4, $05, $F2, $03, $F4, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x320
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $04 ;0x340
loc_114B0:
	dc.b	$0F, $0F, $00, $F5, $06, $F3, $0F, $0F, $0B, $F2, $80, $F0, $82, $90, $F0, $03
	dc.b	$F1, $80, $F0, $80, $F3, $0F, $0F, $07, $F0, $80, $F0, $84, $92, $F0, $01, $F0 ;0x0 (0x000114B0-0x00011963, Entry count: 0x4B3) [Unknown data]
	dc.b	$80, $F0, $80, $95, $F0, $0F, $0F, $05, $F1, $84, $91, $80, $90, $F0, $90, $F0
	dc.b	$00, $F0, $81, $93, $F0, $91, $F1, $0F, $0F, $03, $F1, $80, $F0, $80, $F0, $80 ;0x20
	dc.b	$93, $80, $91, $F1, $80, $F0, $80, $91, $F0, $91, $F0, $91, $F0, $0F, $0F, $02
	dc.b	$F0, $82, $F2, $80, $92, $F0, $91, $F0, $90, $F0, $81, $93, $F2, $90, $F1, $0F ;0x40
	dc.b	$0F, $01, $F1, $80, $F2, $01, $F1, $90, $F0, $94, $F1, $80, $91, $F0, $91, $F4
	dc.b	$0F, $0F, $01, $F0, $80, $F1, $04, $F2, $90, $F0, $92, $F0, $80, $90, $F0, $91 ;0x60
	dc.b	$F5, $0F, $0F, $01, $F0, $80, $F1, $04, $F7, $90, $F0, $80, $91, $F9, $0F, $0F
	dc.b	$F0, $81, $F0, $01, $F2, $80, $F0, $85, $F1, $90, $F1, $84, $F0, $80, $F0, $81 ;0x80
	dc.b	$F1, $0F, $0D, $F0, $80, $F3, $80, $F1, $83, $94, $F1, $95, $84, $92, $F0, $0F
	dc.b	$0D, $F2, $86, $93, $F0, $91, $F0, $91, $F4, $92, $80, $92, $F0, $90, $F0, $0F ;0xA0
	dc.b	$0C, $F0, $80, $F1, $82, $92, $80, $90, $F0, $91, $F3, $92, $F3, $90, $F0, $95
	dc.b	$F0, $0F, $0B, $F1, $83, $91, $80, $90, $F0, $92, $F4, $90, $81, $94, $F0, $00 ;0xC0
	dc.b	$F0, $90, $F0, $91, $F2, $0F, $09, $F3, $81, $90, $80, $93, $F0, $90, $F1, $B2
	dc.b	$F1, $82, $91, $F2, $01, $F1, $93, $F0, $0F, $09, $F0, $83, $93, $F0, $91, $F0 ;0xE0
	dc.b	$90, $F0, $B4, $F0, $80, $F1, $94, $F0, $00, $F0, $91, $F0, $90, $F1, $0F, $08
	dc.b	$F2, $83, $93, $F0, $90, $F1, $B3, $F0, $B0, $F1, $82, $91, $F1, $90, $F0, $00 ;0x100
	dc.b	$F1, $92, $F0, $0F, $08, $F1, $81, $91, $80, $90, $F0, $91, $F0, $90, $F1, $B0
	dc.b	$F0, $B1, $F0, $B0, $F0, $81, $F1, $93, $F1, $00, $F0, $92, $F1, $0F, $08, $F0 ;0x120
	dc.b	$82, $93, $F0, $92, $F0, $00, $F2, $B0, $F0, $B0, $F3, $83, $93, $F3, $90, $F0
	dc.b	$0F, $09, $F1, $80, $91, $F0, $91, $F0, $91, $F2, $D0, $F7, $83, $91, $F1, $90 ;0x140
	dc.b	$F0, $00, $F0, $90, $F1, $0F, $08, $F0, $83, $91, $F0, $91, $F0, $90, $F0, $00
	dc.b	$F0, $D0, $C1, $D1, $F0, $00, $F1, $80, $F1, $94, $F1, $00, $F2, $0F, $09, $F1 ;0x160
	dc.b	$81, $90, $80, $90, $F0, $91, $F1, $00, $F1, $D1, $C0, $D0, $F0, $01, $F2, $82
	dc.b	$94, $F0, $00, $F2, $0F, $09, $F0, $81, $93, $F0, $90, $F1, $01, $F0, $C1, $D2 ;0x180
	dc.b	$F0, $01, $F1, $90, $80, $F1, $91, $F1, $90, $F0, $00, $F1, $0F, $0A, $F1, $80
	dc.b	$91, $F0, $90, $F2, $01, $F0, $D0, $C2, $D0, $F0, $03, $F0, $90, $F0, $81, $93 ;0x1A0
	dc.b	$F1, $00, $F0, $0F, $0B, $F0, $81, $91, $F2, $03, $F0, $D0, $C1, $D1, $F0, $04
	dc.b	$F0, $81, $92, $F0, $91, $F0, $0F, $0E, $F0, $80, $F2, $05, $F0, $D1, $C0, $D0 ;0x1C0
	dc.b	$F0, $05, $F3, $80, $91, $F1, $0F, $0F, $F0, $80, $F0, $06, $F0, $C1, $D2, $F0
	dc.b	$06, $F0, $81, $93, $F0, $0F, $0F, $00, $F0, $07, $F0, $C2, $D1, $F0, $06, $F2 ;0x1E0
	dc.b	$92, $F1, $0F, $0F, $09, $F0, $C2, $D0, $F0, $07, $F0, $90, $81, $91, $F0, $0F
	dc.b	$0F, $0A, $F0, $D0, $C1, $D0, $F0, $08, $F1, $90, $F1, $0F, $0F, $0A, $F0, $C0 ;0x200
	dc.b	$D0, $C0, $D1, $F0, $08, $F0, $90, $F1, $0F, $0F, $0B, $F0, $C0, $D3, $F0, $08
	dc.b	$F1, $0F, $0F, $0D, $F0, $C2, $D0, $F0, $0F, $0F, $0F, $08, $F0, $C3, $D0, $F0 ;0x220
	dc.b	$0F, $0F, $0F, $08, $F0, $D0, $C1, $D1, $F0, $0F, $0F, $0F, $08, $F0, $D0, $C1
	dc.b	$D1, $F0, $0F, $0F, $0F, $08, $F0, $D1, $C0, $D0, $F0, $0F, $0F, $0F, $09, $F0 ;0x240
	dc.b	$C0, $D2, $F0, $0F, $0F, $0F, $08, $F0, $C3, $D0, $F0, $0F, $0F, $0F, $08, $F0
	dc.b	$D0, $C1, $D1, $F0, $0F, $0F, $0F, $05, $F0, $01, $F0, $D0, $C1, $D0, $F0, $0F ;0x260
	dc.b	$0F, $0C, $F0, $07, $F0, $80, $F0, $00, $F0, $D1, $C0, $D0, $F0, $0F, $0F, $0B
	dc.b	$F0, $80, $F1, $04, $F0, $80, $90, $F1, $C1, $D2, $F0, $0F, $0F, $0B, $F0, $80 ;0x280
	dc.b	$91, $F0, $02, $F0, $80, $90, $F0, $00, $F0, $C2, $D1, $F0, $05, $F0, $0F, $0F
	dc.b	$01, $F0, $01, $F0, $81, $91, $F0, $00, $F0, $80, $91, $F0, $00, $F0, $C2, $D1 ;0x2A0
	dc.b	$F0, $04, $F0, $90, $F0, $0F, $0F, $F0, $90, $F0, $00, $F0, $81, $F1, $01, $F0
	dc.b	$80, $90, $F0, $00, $F0, $D0, $C2, $D0, $F0, $05, $F0, $90, $F0, $03, $F0, $0F ;0x2C0
	dc.b	$07, $F0, $01, $F0, $90, $F0, $00, $F0, $81, $F0, $01, $F0, $80, $90, $F0, $01
	dc.b	$F0, $D1, $C1, $D0, $F0, $01, $F0, $01, $F0, $91, $F2, $00, $F0, $90, $F2, $0F ;0x2E0
	dc.b	$03, $F0, $90, $F2, $90, $F0, $00, $F0, $81, $F0, $00, $F0, $80, $91, $F0, $01
	dc.b	$F0, $C0, $D3, $F0, $00, $F0, $90, $F0, $01, $F0, $90, $F0, $B1, $F0, $94, $F0 ;0x300
	dc.b	$0F, $02, $F0, $80, $91, $F0, $91, $F0, $90, $80, $90, $F0, $00, $F0, $91, $F0
	dc.b	$01, $F0, $C3, $D1, $F0, $00, $F0, $90, $F0, $00, $F0, $91, $F2, $91, $F3, $0F ;0x320
	dc.b	$02, $F0, $80, $F1, $91, $F0, $92, $80, $91, $F0, $91, $F0, $02, $F0, $C3, $D1
	dc.b	$F0, $00, $F1, $90, $F1, $91, $F2, $90, $F0, $0F, $06, $F0, $80, $F0, $00, $F0 ;0x340
	dc.b	$92, $80, $92, $80, $92, $F0, $01, $F1, $C3, $D1, $F1, $B0, $F0, $90, $F1, $91
	dc.b	$F1, $91, $F0, $01, $F0, $0F, $04, $F1, $01, $F0, $93, $80, $90, $80, $91, $F3 ;0x360
	dc.b	$80, $F0, $D0, $C1, $D1, $F0, $00, $F0, $B0, $F1, $90, $F0, $91, $F0, $91, $F1
	dc.b	$00, $F0, $90, $F0, $02, $F0, $02, $F0, $0B, $F0, $80, $F1, $90, $F0, $93, $80 ;0x380
	dc.b	$90, $80, $90, $82, $90, $F0, $C1, $D3, $F5, $90, $F0, $94, $F0, $B0, $F0, $90
	dc.b	$F1, $00, $F1, $90, $F0, $00, $F0, $90, $F0, $0A, $F0, $81, $F1, $90, $F0, $92 ;0x3A0
	dc.b	$80, $90, $82, $92, $F0, $C2, $D2, $F2, $90, $F1, $91, $F0, $92, $F1, $B0, $F0
	dc.b	$90, $F0, $B0, $F0, $90, $F0, $90, $F1, $90, $F0, $0C, $F0, $90, $81, $90, $80 ;0x3C0
	dc.b	$F0, $90, $80, $90, $82, $92, $F1, $C3, $D1, $F1, $B0, $F0, $90, $F1, $94, $F0
	dc.b	$90, $F0, $90, $F0, $B1, $F0, $90, $F0, $90, $F0, $90, $F0, $0D, $F0, $94, $80 ;0x3E0
	dc.b	$97, $F1, $D0, $C3, $D1, $F0, $90, $F2, $90, $F0, $93, $F1, $90, $F0, $90, $F0
	dc.b	$B1, $F1, $92, $F0, $0E, $F3, $98, $F0, $91, $F0, $D0, $C2, $D1, $F1, $90, $F0 ;0x400
	dc.b	$90, $F1, $94, $F0, $92, $F1, $B0, $F0, $94, $F0, $0C, $F1, $9D, $F1, $C0, $D0
	dc.b	$90, $D0, $C0, $D1, $F0, $B0, $F0, $92, $F1, $94, $F0, $91, $F0, $90, $F1, $94 ;0x420
	dc.b	$F0, $0B, $F0, $92, $F2, $98, $F0, $80, $D0, $90, $C0, $90, $D3, $90, $F0, $B0
	dc.b	$F0, $9A, $F0, $91, $F0, $90, $F0, $92, $F1, $00, $F1, $09, $F2, $B1, $F3, $92 ;0x440
	dc.b	$F3, $80, $D0, $90, $D0, $90, $D0, $92, $D0, $90, $F0, $B0, $F1, $98, $F0, $96
	dc.b	$F0, $91, $F0, $91, $F0, $07, $F0, $B3, $F0, $95, $F0, $84, $D1, $80, $90, $D0 ;0x460
	dc.b	$94, $F1, $99, $F1, $96, $F2, $00, $F1, $09, $F3, $B0, $F5, $82, $90, $80, $90
	dc.b	$D0, $90, $80, $90, $D0, $91, $D0, $92, $F2, $96, $F9, $0F, $F0, $B6, $F3, $91 ;0x480
	dc.b	$81, $90, $80, $99, $F0, $B1, $F1, $92, $F3, $B1, $F0, $0F, $05, $F6, $03, $FF
	dc.b	$00, $FC, $0F ;0x4A0
loc_11963:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00011963-0x00011B86, Entry count: 0x223) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $05, $F7, $0F, $0F, $0F, $05, $F2, $B6, $F0, $0F, $0F, $0F, $03, $F1
	dc.b	$B1, $F3, $B3, $F0, $0F, $0F, $0F, $02, $F0, $B1, $F2, $B5, $F0, $0F, $0F, $07 ;0x40
	dc.b	$F4, $05, $F0, $B0, $F2, $B6, $F0, $0F, $0F, $03, $F3, $B4, $F1, $02, $F0, $B1
	dc.b	$F2, $B5, $F1, $09, $F3, $0F, $01, $F4, $B9, $F1, $00, $F0, $B1, $F1, $B6, $F0 ;0x60
	dc.b	$06, $F3, $D2, $F1, $0D, $F2, $B2, $F0, $BB, $F2, $B2, $F0, $B5, $F1, $02, $F3
	dc.b	$D3, $E1, $F0, $0D, $F2, $BF, $B2, $F1, $B9, $F4, $D3, $E2, $F6, $09, $F1, $BF ;0x80
	dc.b	$B3, $F2, $B6, $F3, $D3, $E3, $F3, $D2, $F1, $09, $F1, $BF, $B4, $F2, $B5, $F0
	dc.b	$D4, $E2, $F4, $D1, $E1, $F1, $0A, $F2, $BF, $B4, $F2, $B5, $E0, $D1, $E3, $F2 ;0xA0
	dc.b	$D1, $E2, $F2, $0B, $F2, $BF, $B6, $F2, $B2, $F1, $E3, $F2, $D0, $E3, $F2, $0D
	dc.b	$F3, $BF, $B6, $F2, $B3, $F5, $B0, $F1, $E1, $F1, $0F, $F4, $BF, $F0, $B1, $F0 ;0xC0
	dc.b	$B3, $F2, $B4, $F0, $60, $70, $F1, $B1, $F1, $03, $F1, $0B, $F0, $B0, $F3, $B5
	dc.b	$F0, $B8, $F2, $B1, $F0, $B1, $F2, $B5, $60, $B5, $F3, $D1, $F0, $09, $F0, $B2 ;0xE0
	dc.b	$F2, $B6, $F0, $B9, $F1, $B1, $F4, $BE, $D1, $E0, $F0, $0A, $F0, $B2, $F2, $B6
	dc.b	$F0, $B3, $F0, $B5, $F1, $B1, $F2, $BF, $B0, $E0, $B0, $F0, $09, $F0, $B2, $F2 ;0x100
	dc.b	$B7, $F0, $B2, $F0, $B6, $F7, $BF, $B1, $F0, $09, $F0, $B1, $F3, $B6, $F1, $B1
	dc.b	$F1, $B6, $FB, $B3, $F3, $B5, $F0, $08, $F0, $B2, $F3, $B5, $F5, $B6, $FF, $B4 ;0x120
	dc.b	$F2, $B2, $F0, $08, $F0, $B1, $F1, $00, $F0, $B5, $F6, $B4, $FB, $B1, $F7, $B2
	dc.b	$F1, $B1, $F0, $07, $F0, $B2, $F0, $01, $F1, $B2, $F3, $01, $F1, $B5, $F5, $00 ;0x140
	dc.b	$F5, $B1, $F0, $03, $F2, $B0, $F2, $B0, $F0, $08, $F0, $B1, $F1, $01, $F1, $B3
	dc.b	$F1, $03, $F0, $B3, $F5, $04, $F4, $B1, $F0, $04, $F2, $01, $F0, $09, $F0, $B1 ;0x160
	dc.b	$F0, $01, $F3, $B2, $F1, $03, $F0, $B1, $F3, $09, $F3, $B2, $F0, $0F, $03, $F1
	dc.b	$B0, $F0, $01, $F3, $B3, $F0, $02, $F1, $B3, $F1, $0A, $F3, $B1, $F0, $0F, $04 ;0x180
	dc.b	$F2, $01, $F4, $B2, $F0, $02, $F0, $B3, $F1, $0C, $F3, $B0, $F0, $0F, $04, $F8
	dc.b	$B3, $F0, $01, $F1, $B3, $F1, $0C, $F2, $B2, $F1, $0F, $03, $F2, $01, $F3, $B2 ;0x1A0
	dc.b	$F1, $00, $F1, $B1, $F2, $0D, $F3, $B3, $F0, $0F, $08, $F1, $B4, $F0, $00, $F0
	dc.b	$B4, $F0, $0E, $F7, $0F, $08, $F7, $00, $F0, $B5, $F0, $0F, $0F, $0F, $07, $F7 ;0x1C0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x1E0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x200
	dc.b	$0F, $0F, $05 ;0x220
loc_11B86:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $F5, $0F, $0F, $0F, $06, $F2, $81, $F2, $90
	dc.b	$F0, $0F, $0F, $0F, $03, $F1, $83, $91, $60, $F1, $90, $F0, $0F, $0F, $0F, $01 ;0x0 (0x00011B86-0x00011E72, Entry count: 0x2EC) [Unknown data]
	dc.b	$F0, $86, $90, $71, $80, $F3, $0F, $0F, $0F, $F0, $80, $91, $81, $91, $80, $93
	dc.b	$82, $F2, $0F, $0F, $0B, $F0, $80, $91, $81, $99, $83, $F1, $0F, $0F, $09, $F0 ;0x20
	dc.b	$80, $90, $82, $9C, $81, $F1, $0F, $0F, $08, $F0, $80, $90, $83, $92, $F2, $95
	dc.b	$F1, $80, $F0, $0F, $0F, $08, $F0, $80, $90, $85, $F0, $C0, $E0, $C0, $F2, $93 ;0x40
	dc.b	$F0, $90, $F0, $0F, $0F, $08, $F0, $84, $91, $70, $03, $C0, $E0, $C0, $F2, $91
	dc.b	$F0, $0F, $0F, $08, $F0, $84, $93, $C0, $72, $02, $C0, $E0, $C0, $F1, $0F, $0F ;0x60
	dc.b	$09, $F0, $82, $F0, $81, $94, $C0, $70, $C0, $71, $02, $E0, $0F, $0F, $08, $F1
	dc.b	$83, $90, $F2, $97, $C0, $70, $C0, $0F, $0F, $07, $F2, $84, $93, $F3, $97, $F0 ;0x80
	dc.b	$0F, $0F, $03, $F2, $87, $95, $F9, $0F, $0F, $02, $F1, $86, $92, $81, $95, $F4
	dc.b	$0F, $0F, $04, $F1, $84, $97, $80, $91, $F1, $90, $F2, $0F, $0F, $06, $F0, $84 ;0xA0
	dc.b	$9D, $F3, $0F, $0F, $05, $F1, $83, $94, $81, $91, $F0, $95, $F1, $0F, $0F, $05
	dc.b	$F1, $84, $93, $81, $93, $F0, $91, $F0, $91, $F1, $0F, $0F, $05, $F0, $84, $93 ;0xC0
	dc.b	$81, $94, $F0, $91, $F1, $90, $F9, $0F, $0D, $F0, $84, $93, $81, $94, $F0, $92
	dc.b	$F0, $91, $F1, $97, $F0, $0F, $0B, $F0, $83, $94, $81, $95, $F0, $91, $F1, $90 ;0xE0
	dc.b	$F6, $94, $F0, $0F, $09, $F0, $83, $93, $82, $95, $F0, $92, $F7, $00, $F0, $90
	dc.b	$F0, $90, $D0, $E0, $F0, $0F, $08, $F0, $83, $93, $83, $95, $F1, $99, $F2, $90 ;0x100
	dc.b	$D0, $E0, $F0, $0F, $08, $F0, $83, $93, $83, $97, $F5, $96, $F3, $0F, $09, $F0
	dc.b	$82, $93, $85, $97, $F5, $90, $F0, $93, $F0, $0F, $0B, $F0, $83, $92, $87, $97 ;0x120
	dc.b	$F3, $00, $F1, $91, $D0, $E0, $F0, $0F, $0A, $F0, $83, $90, $F1, $82, $94, $81
	dc.b	$95, $F3, $01, $F0, $D1, $E1, $F0, $0F, $0A, $F0, $83, $91, $F0, $90, $80, $97 ;0x140
	dc.b	$80, $94, $F3, $02, $F4, $0F, $0A, $F0, $83, $91, $F0, $9B, $80, $92, $F2, $0F
	dc.b	$0F, $04, $F0, $83, $91, $F0, $95, $86, $92, $F2, $0F, $0F, $03, $F0, $83, $92 ;0x160
	dc.b	$F0, $94, $82, $92, $82, $90, $F2, $0F, $0F, $04, $F0, $83, $92, $F0, $93, $F0
	dc.b	$90, $80, $95, $80, $90, $F1, $0F, $0F, $04, $F0, $80, $90, $82, $92, $F1, $92 ;0x180
	dc.b	$F0, $98, $80, $90, $F0, $0F, $0F, $03, $F0, $81, $90, $81, $93, $F1, $92, $F0
	dc.b	$9A, $F0, $0F, $0F, $03, $F0, $80, $91, $81, $94, $F1, $92, $F0, $9A, $F0, $0F ;0x1A0
	dc.b	$0F, $01, $F0, $81, $90, $83, $93, $F2, $92, $F0, $99, $F0, $0F, $0F, $00, $F0
	dc.b	$81, $91, $84, $93, $F3, $9C, $F0, $0F, $0F, $F0, $80, $91, $81, $98, $F6, $98 ;0x1C0
	dc.b	$F0, $0F, $0E, $F0, $81, $9C, $F7, $98, $F0, $0F, $0C, $F0, $81, $9D, $F9, $92
	dc.b	$F0, $92, $F0, $0F, $0B, $F0, $81, $9C, $F7, $01, $F0, $90, $F2, $93, $F0, $0F ;0x1E0
	dc.b	$0A, $F0, $81, $9B, $F8, $02, $F1, $96, $F0, $0F, $09, $F0, $81, $9B, $F6, $05
	dc.b	$F1, $96, $F0, $0F, $08, $F0, $81, $9A, $F5, $09, $F2, $94, $F0, $0F, $08, $F0 ;0x200
	dc.b	$81, $98, $F5, $0C, $F3, $91, $F0, $0F, $08, $F0, $81, $97, $F5, $0E, $F2, $92
	dc.b	$F0, $0F, $08, $F0, $81, $93, $F0, $91, $F3, $91, $F0, $0F, $F0, $93, $F0, $0F ;0x220
	dc.b	$07, $F0, $82, $92, $F0, $91, $F3, $91, $F1, $0F, $F0, $93, $F1, $0F, $06, $F0
	dc.b	$82, $91, $F1, $90, $F3, $92, $F0, $0F, $F0, $93, $F2, $0F, $06, $F0, $90, $81 ;0x240
	dc.b	$91, $F1, $90, $F2, $93, $F3, $0C, $F1, $92, $F0, $91, $F0, $0F, $05, $F0, $90
	dc.b	$82, $91, $F1, $90, $F1, $93, $F0, $92, $F1, $0B, $F0, $91, $F0, $93, $F1, $00 ;0x260
	dc.b	$F2, $0F, $F0, $91, $81, $91, $F4, $97, $D1, $F0, $09, $F2, $97, $F0, $92, $F0
	dc.b	$0E, $F0, $92, $81, $91, $F4, $94, $F0, $90, $E1, $D0, $F0, $07, $F0, $D1, $9B ;0x280
	dc.b	$D1, $F0, $0D, $F1, $92, $81, $92, $F7, $00, $F3, $07, $F0, $D0, $E1, $91, $F4
	dc.b	$91, $F1, $E2, $D0, $F0, $0D, $F0, $94, $81, $93, $F5, $0B, $F6, $01, $F4, $00 ;0x2A0
	dc.b	$F3, $0E, $F1, $94, $82, $95, $F4, $0F, $0F, $0B, $F1, $9F, $90, $F6, $0E, $F5
	dc.b	$0F, $01, $F2, $9F, $95, $FE, $91, $F2, $0F, $04, $F3, $9F, $9F, $91, $F2, $0F ;0x2C0
	dc.b	$09, $F5, $9F, $95, $F7, $0F, $0F, $00, $FF, $F8, $0F, $09 ;0x2E0
loc_11E72:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00011E72-0x000120E4, Entry count: 0x272) [Unknown data]
	dc.b	$0F, $0F, $0F, $04, $F1, $0F, $0F, $0B, $F8, $05, $F2, $71, $F0, $0F, $0F, $06
	dc.b	$F3, $78, $F5, $74, $F0, $0F, $01, $F2, $0F, $F1, $7F, $75, $D1, $F0, $0F, $00 ;0x20
	dc.b	$F0, $A1, $B0, $F0, $0C, $F1, $30, $74, $C8, $75, $D4, $F0, $0F, $F0, $A1, $B2
	dc.b	$F0, $0A, $F0, $32, $70, $D2, $CF, $D2, $71, $F0, $0F, $F6, $08, $F1, $33, $D3 ;0x40
	dc.b	$C0, $78, $C5, $74, $F0, $0F, $F1, $A1, $B0, $F1, $04, $F3, $35, $D0, $7F, $75
	dc.b	$D1, $F0, $0F, $00, $FA, $39, $74, $C8, $75, $D4, $F0, $0F, $00, $F0, $A0, $B0 ;0x60
	dc.b	$F1, $3F, $70, $D1, $CF, $C0, $D2, $71, $F0, $0F, $00, $F0, $A0, $B0, $F1, $3F
	dc.b	$D2, $C1, $78, $C5, $74, $F0, $0F, $00, $F0, $A0, $B0, $F1, $3F, $D0, $7F, $75 ;0x80
	dc.b	$D1, $F0, $0F, $00, $F0, $A0, $B0, $F1, $3F, $74, $C8, $75, $D4, $F0, $0F, $00
	dc.b	$F0, $A0, $B0, $F1, $3F, $70, $D1, $CF, $C0, $D2, $71, $F0, $0F, $00, $F0, $A0 ;0xA0
	dc.b	$B0, $F1, $3F, $D2, $C1, $78, $C4, $D0, $74, $F0, $0F, $00, $F0, $A0, $B0, $F1
	dc.b	$3F, $D0, $7F, $75, $D1, $F0, $0F, $00, $F0, $A0, $B0, $F1, $3F, $74, $C8, $75 ;0xC0
	dc.b	$D4, $F0, $0F, $00, $F0, $A0, $B0, $F1, $3F, $70, $D1, $CF, $D3, $71, $F0, $0F
	dc.b	$00, $F0, $A0, $B0, $F1, $3E, $D3, $C1, $78, $C4, $D0, $74, $F0, $0F, $00, $F0 ;0xE0
	dc.b	$A0, $B0, $F1, $3C, $D3, $7F, $75, $D1, $F0, $0F, $00, $F0, $A0, $B0, $F1, $3B
	dc.b	$C0, $D1, $75, $C8, $75, $D4, $F0, $0F, $00, $F0, $A0, $B0, $F1, $39, $C1, $D0 ;0x100
	dc.b	$73, $D2, $CD, $D4, $71, $F0, $0F, $00, $F0, $A0, $B0, $F1, $34, $C6, $72, $D4
	dc.b	$C0, $78, $C3, $D1, $74, $F0, $0F, $00, $F0, $A0, $B0, $F1, $C9, $72, $D3, $7F ;0x120
	dc.b	$75, $D1, $F0, $0F, $00, $F0, $A0, $B0, $F1, $C5, $75, $D2, $75, $C8, $75, $D4
	dc.b	$F0, $0F, $00, $F0, $A0, $B0, $F1, $79, $C0, $D1, $73, $D3, $CC, $D4, $71, $F0 ;0x140
	dc.b	$0F, $00, $F0, $A0, $B0, $F1, $75, $C4, $D0, $72, $D5, $78, $C2, $D2, $74, $F0
	dc.b	$0F, $00, $F0, $A0, $B0, $F1, $C9, $72, $D3, $7F, $75, $F1, $0F, $01, $F0, $A0 ;0x160
	dc.b	$B0, $F1, $C5, $75, $D2, $75, $F8, $75, $F2, $0F, $03, $F0, $A0, $B0, $F1, $79
	dc.b	$D2, $73, $F3, $08, $F5, $0F, $06, $F0, $A0, $B0, $F1, $75, $C3, $D1, $72, $F1 ;0x180
	dc.b	$0F, $0F, $09, $F0, $A0, $B0, $F1, $C9, $72, $F1, $0F, $0F, $0B, $F0, $A0, $B0
	dc.b	$F1, $C5, $75, $F0, $0F, $0F, $0D, $F0, $A0, $B0, $F1, $79, $F1, $0F, $0F, $0E ;0x1A0
	dc.b	$F0, $A0, $B0, $F1, $75, $F3, $0F, $0F, $0F, $00, $F0, $A0, $B0, $F7, $0F, $0F
	dc.b	$0F, $04, $F0, $A0, $B0, $F1, $0F, $0F, $0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F ;0x1C0
	dc.b	$0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F, $0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F
	dc.b	$0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F, $0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F ;0x1E0
	dc.b	$0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F, $0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F
	dc.b	$0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F, $0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F ;0x200
	dc.b	$0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F, $0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F
	dc.b	$0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F, $0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F ;0x220
	dc.b	$0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F, $0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F
	dc.b	$0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F, $0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F ;0x240
	dc.b	$0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F, $0F, $0A, $F0, $A0, $B0, $F1, $0F, $0F
	dc.b	$0F, $01 ;0x260
loc_120E4:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x000120E4-0x0001243C, Entry count: 0x358) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $70, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $70, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $07, $70, $01, $60, $02, $60, $0F, $0F, $0F, $0C, $70, $0F, $0F
	dc.b	$0F, $0F, $02, $70, $0F, $0F, $0F, $06, $60, $00, $F6, $0F, $0F, $0F, $07, $F2 ;0x40
	dc.b	$60, $71, $60, $70, $F1, $0F, $0F, $0F, $01, $F4, $73, $60, $71, $F2, $0F, $0F
	dc.b	$0F, $F1, $72, $60, $70, $61, $A0, $60, $70, $60, $F1, $70, $F0, $0F, $0F, $0E ;0x60
	dc.b	$F0, $70, $60, $70, $60, $A0, $66, $70, $F0, $70, $F0, $0F, $0F, $0D, $F2, $70
	dc.b	$F1, $61, $A3, $61, $F1, $71, $F0, $0F, $0F, $0C, $F0, $70, $F4, $A1, $C1, $A1 ;0x80
	dc.b	$F1, $72, $F0, $0F, $0F, $0B, $F1, $E0, $F1, $71, $F3, $C1, $F2, $71, $F2, $0F
	dc.b	$0F, $09, $F0, $70, $E1, $F0, $71, $F1, $71, $F4, $70, $F1, $70, $F1, $0F, $0F ;0xA0
	dc.b	$09, $F0, $70, $E0, $F1, $70, $F4, $70, $F2, $70, $F2, $70, $F2, $0F, $0F, $07
	dc.b	$F0, $70, $E0, $F2, $70, $F3, $76, $F0, $72, $F1, $0F, $0F, $06, $F0, $70, $E1 ;0xC0
	dc.b	$F0, $E0, $70, $F1, $7D, $F2, $0F, $0F, $04, $F0, $70, $E0, $F1, $E1, $74, $60
	dc.b	$72, $F1, $71, $60, $73, $F2, $0F, $0F, $01, $F2, $E1, $F1, $E1, $73, $61, $71 ;0xE0
	dc.b	$F3, $60, $71, $F1, $71, $F2, $0F, $0E, $F1, $E2, $F2, $E1, $72, $F0, $70, $60
	dc.b	$71, $F1, $72, $60, $71, $F1, $72, $F2, $0F, $0C, $F0, $E5, $F0, $E2, $71, $E1 ;0x100
	dc.b	$70, $60, $71, $F1, $72, $60, $70, $F3, $71, $F3, $0F, $0A, $F0, $E0, $F0, $E0
	dc.b	$F1, $E5, $71, $F2, $79, $E0, $70, $F3, $70, $F3, $01, $F4, $0F, $01, $F0, $E1 ;0x120
	dc.b	$F1, $E3, $F0, $E1, $F0, $70, $F0, $E1, $F0, $75, $F1, $71, $F6, $70, $F5, $72
	dc.b	$F2, $0C, $F2, $E1, $F0, $E1, $F3, $E0, $F1, $71, $E2, $72, $F0, $72, $F2, $70 ;0x140
	dc.b	$F6, $71, $F3, $E0, $F1, $73, $F0, $0A, $F0, $E2, $F0, $E2, $F0, $E3, $F0, $E0
	dc.b	$71, $E0, $F2, $71, $F2, $70, $F3, $70, $FC, $E2, $F5, $08, $F0, $E0, $F0, $E3 ;0x160
	dc.b	$F1, $E6, $70, $F4, $71, $F2, $70, $F3, $70, $FB, $E4, $F1, $E1, $F1, $03, $F5
	dc.b	$E2, $F1, $E7, $71, $E1, $F2, $70, $F3, $70, $FF, $E3, $F3, $E0, $F4, $00, $F0 ;0x180
	dc.b	$E2, $F1, $E2, $F1, $E3, $F4, $E6, $70, $E0, $F2, $70, $F4, $70, $F5, $E6, $F3
	dc.b	$E0, $F6, $E1, $F2, $E3, $F0, $E1, $F9, $E4, $70, $F0, $E2, $F5, $70, $F6, $E0 ;0x1A0
	dc.b	$F1, $E2, $F2, $E1, $F6, $E0, $F0, $E4, $F1, $E0, $F1, $E2, $F5, $E3, $F0, $70
	dc.b	$FA, $71, $F2, $E2, $F1, $E1, $F0, $E3, $F2, $E0, $F4, $E0, $F0, $E0, $F1, $E0 ;0x1C0
	dc.b	$F1, $E1, $F0, $E5, $F3, $E0, $F3, $70, $FA, $72, $F4, $71, $E0, $F1, $E1, $F2
	dc.b	$E1, $F5, $E3, $F1, $EB, $F1, $E1, $F9, $70, $F4, $77, $E5, $F2, $E1, $F6, $EF ;0x1E0
	dc.b	$E2, $F6, $70, $F3, $71, $E2, $F0, $75, $E3, $F0, $E4, $FA, $E3, $F2, $E0, $F8
	dc.b	$E1, $F6, $70, $F1, $E4, $F1, $70, $F0, $E5, $F4, $E6, $F7, $E4, $F2, $E3, $F5 ;0x200
	dc.b	$E0, $F5, $72, $E1, $F8, $E2, $F4, $E2, $FD, $E1, $F0, $EB, $F8, $72, $E0, $F9
	dc.b	$E2, $F4, $E1, $FF, $E1, $F1, $E3, $F4, $E4, $F5, $70, $E0, $FA, $E1, $F5, $E0 ;0x220
	dc.b	$FF, $F3, $E3, $FF, $F0, $71, $FF, $F1, $E1, $FF, $F2, $E4, $90, $E2, $91, $E0
	dc.b	$F9, $71, $F6, $90, $F2, $91, $FF, $FA, $90, $E2, $95, $F0, $E0, $F5, $E5, $F2 ;0x240
	dc.b	$91, $F1, $94, $F6, $90, $F2, $91, $FE, $E0, $97, $F5, $91, $E1, $92, $F0, $90
	dc.b	$F2, $97, $F8, $93, $FF, $93, $F1, $96, $F2, $95, $F0, $9F, $F0, $98, $F1, $91 ;0x260
	dc.b	$F1, $98, $F0, $96, $E0, $91, $F1, $9F, $94, $E0, $9F, $9B, $F0, $91, $D0, $E0
	dc.b	$92, $D0, $E0, $9F, $93, $D0, $E0, $92, $E0, $99, $D0, $E0, $9E, $F3, $D0, $E0 ;0x280
	dc.b	$97, $F0, $93, $D0, $E0, $D0, $E0, $97, $D0, $E0, $9D, $D1, $E0, $9F, $F0, $D1
	dc.b	$91, $D0, $E0, $91, $E0, $93, $D0, $E0, $90, $D2, $91, $D0, $E0, $91, $E0, $90 ;0x2A0
	dc.b	$D1, $91, $D0, $E0, $91, $E0, $91, $E0, $93, $D2, $91, $D0, $E0, $91, $E0, $93
	dc.b	$E0, $95, $D0, $E0, $92, $E1, $90, $E0, $F0, $90, $F1, $D0, $E0, $D0, $90, $D0 ;0x2C0
	dc.b	$E0, $92, $E1, $90, $E0, $90, $D0, $E0, $91, $F1, $E0, $90, $E0, $91, $E0, $D0
	dc.b	$90, $F0, $91, $D0, $E0, $92, $E1, $90, $E1, $92, $E1, $91, $F0, $91, $D0, $94 ;0x2E0
	dc.b	$D0, $F0, $E0, $92, $D1, $E0, $D0, $93, $F0, $91, $F0, $D0, $E0, $90, $D0, $90
	dc.b	$F0, $90, $F0, $90, $D1, $E0, $91, $E0, $D0, $E0, $F0, $D0, $90, $D0, $94, $D1 ;0x300
	dc.b	$E0, $91, $D1, $E1, $D0, $E0, $F1, $92, $F0, $93, $E0, $91, $F0, $90, $F0, $E0
	dc.b	$F0, $90, $F0, $91, $D0, $91, $F1, $E0, $F0, $92, $F0, $91, $F2, $91, $E0, $D0 ;0x320
	dc.b	$E0, $95, $F0, $93, $E0, $91, $F0, $D0, $E1, $D0, $90, $F0, $9E, $D0, $99, $F0
	dc.b	$90, $F0, $9F, $9C, $D0, $E0, $94, $F0 ;0x340
loc_1243C:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $05, $11, $0F, $0F, $05, $10, $07, $20, $06, $10 ;0x0 (0x0001243C-0x00012908, Entry count: 0x4CC) [Unknown data]
	dc.b	$20, $02, $12, $20, $12, $09, $10, $C0, $0F, $07, $10, $07, $C1, $00, $20, $05
	dc.b	$10, $20, $10, $00, $10, $04, $C0, $03, $C0, $02, $C0, $00, $C2, $09, $21, $03 ;0x20
	dc.b	$20, $01, $12, $20, $00, $10, $02, $20, $00, $C0, $02, $C1, $01, $10, $C0, $11
	dc.b	$00, $11, $00, $10, $C0, $00, $10, $01, $C0, $01, $C0, $11, $20, $00, $C0, $20 ;0x40
	dc.b	$C0, $20, $00, $C0, $01, $C0, $01, $20, $02, $C2, $03, $20, $00, $C0, $12, $00
	dc.b	$10, $C4, $01, $20, $01, $C0, $15, $C0, $10, $30, $C1, $30, $00, $C0, $00, $C2 ;0x60
	dc.b	$13, $01, $20, $C0, $20, $C0, $20, $C1, $02, $C1, $00, $C1, $21, $10, $30, $C0
	dc.b	$21, $10, $C0, $20, $00, $31, $10, $30, $C6, $20, $C2, $14, $C0, $11, $C0, $20 ;0x80
	dc.b	$C1, $20, $C0, $20, $C2, $31, $20, $10, $C1, $22, $C0, $10, $02, $C2, $30, $20
	dc.b	$30, $21, $30, $20, $C4, $11, $20, $30, $20, $10, $20, $C1, $20, $C8, $30, $C0 ;0xA0
	dc.b	$30, $C4, $30, $20, $31, $20, $C1, $21, $11, $20, $C0, $22, $C1, $30, $00, $C5
	dc.b	$22, $C1, $23, $C3, $30, $20, $C0, $20, $C1, $20, $C4, $20, $C0, $20, $C0, $11 ;0xC0
	dc.b	$C0, $20, $C5, $21, $C1, $30, $20, $C2, $10, $20, $C1, $20, $C1, $20, $C4, $30
	dc.b	$10, $C4, $20, $10, $21, $C2, $20, $C0, $21, $C0, $20, $C6, $20, $C3, $20, $10 ;0xE0
	dc.b	$C8, $20, $C5, $30, $20, $10, $C1, $21, $C0, $20, $33, $C2, $10, $C4, $25, $C1
	dc.b	$23, $C9, $20, $C0, $20, $C0, $30, $20, $C5, $20, $C1, $21, $C4, $11, $C0, $20 ;0x100
	dc.b	$C0, $20, $C0, $30, $C0, $30, $C1, $10, $C3, $24, $C0, $21, $C1, $10, $21, $C1
	dc.b	$30, $20, $C2, $30, $C0, $20, $C1, $30, $20, $C2, $30, $CC, $20, $C1, $30, $20 ;0x120
	dc.b	$C1, $22, $C0, $32, $C0, $32, $10, $C0, $23, $30, $C0, $20, $C1, $20, $C0, $20
	dc.b	$C3, $20, $30, $21, $C0, $30, $23, $10, $C5, $20, $C8, $10, $20, $C1, $10, $C0 ;0x140
	dc.b	$10, $C1, $20, $30, $20, $30, $C0, $31, $C1, $32, $C0, $30, $21, $30, $20, $10
	dc.b	$20, $10, $32, $20, $C2, $30, $C0, $31, $20, $C0, $31, $20, $31, $C1, $30, $20 ;0x160
	dc.b	$C0, $10, $21, $CA, $10, $C0, $24, $C0, $30, $11, $31, $C0, $35, $20, $30, $21
	dc.b	$11, $33, $10, $C2, $30, $C0, $38, $10, $30, $10, $30, $21, $30, $21, $C2, $30 ;0x180
	dc.b	$C0, $31, $10, $C0, $20, $30, $21, $10, $C0, $11, $C0, $20, $37, $C0, $20, $30
	dc.b	$20, $30, $20, $30, $10, $20, $31, $10, $31, $C3, $3A, $C0, $20, $10, $20, $30 ;0x1A0
	dc.b	$21, $30, $C0, $30, $20, $C1, $30, $C0, $10, $26, $C0, $30, $20, $38, $10, $3C
	dc.b	$C0, $30, $C0, $3E, $20, $30, $22, $31, $21, $30, $22, $10, $21, $30, $21, $10 ;0x1C0
	dc.b	$3F, $39, $C0, $31, $C0, $3B, $10, $31, $21, $11, $30, $10, $22, $30, $20, $10
	dc.b	$20, $30, $22, $C0, $3F, $3F, $3B, $10, $32, $20, $31, $C0, $21, $10, $21, $10 ;0x1E0
	dc.b	$20, $10, $20, $32, $20, $30, $C0, $3F, $3F, $3A, $20, $10, $31, $20, $30, $21
	dc.b	$10, $20, $10, $21, $32, $20, $3F, $3F, $3F, $30, $10, $31, $20, $30, $21, $10 ;0x200
	dc.b	$C0, $30, $10, $20, $30, $10, $3F, $3F, $3F, $34, $11, $30, $20, $11, $C0, $10
	dc.b	$3F, $3F, $3F, $38, $10, $31, $11, $3F, $3F, $3F, $3B, $10, $31, $20, $C0, $3F ;0x220
	dc.b	$38, $20, $3F, $3F, $30, $10, $3F, $3F, $39, $20, $3F, $3F, $3F, $3D, $20, $3F
	dc.b	$3F, $3F, $20, $3F, $3A, $20, $3F, $3F, $32, $20, $3F, $37, $20, $3F, $3F, $35 ;0x240
	dc.b	$20, $3F, $3F, $35, $20, $3F, $37, $20, $3A, $20, $3F, $3F, $3F, $32, $20, $3F
	dc.b	$3F, $3B, $20, $3F, $22, $3A, $21, $3F, $3F, $3F, $20, $3B, $20, $3F, $34, $20 ;0x260
	dc.b	$3F, $3B, $20, $30, $20, $38, $21, $3F, $34, $20, $30, $20, $38, $20, $35, $20
	dc.b	$38, $20, $30, $20, $3B, $20, $38, $20, $30, $20, $36, $20, $3A, $20, $35, $20 ;0x280
	dc.b	$38, $22, $3B, $20, $38, $21, $3A, $20, $35, $20, $37, $20, $37, $23, $31, $20
	dc.b	$37, $21, $38, $21, $37, $20, $32, $20, $34, $20, $3F, $30, $23, $31, $20, $35 ;0x2A0
	dc.b	$20, $30, $21, $38, $20, $3A, $21, $36, $20, $3F, $30, $21, $30, $20, $37, $20
	dc.b	$3C, $20, $3B, $20, $3F, $36, $22, $30, $20, $37, $20, $3B, $20, $38, $20, $30 ;0x2C0
	dc.b	$21, $33, $20, $3F, $32, $22, $30, $20, $39, $21, $38, $21, $3F, $20, $32, $20
	dc.b	$35, $20, $37, $24, $30, $20, $35, $20, $3B, $20, $38, $20, $32, $20, $36, $20 ;0x2E0
	dc.b	$34, $21, $33, $20, $31, $25, $37, $20, $30, $21, $30, $20, $36, $21, $3F, $20
	dc.b	$32, $21, $33, $21, $32, $20, $30, $20, $31, $24, $30, $20, $35, $20, $30, $21 ;0x300
	dc.b	$30, $20, $35, $21, $30, $20, $36, $22, $30, $21, $35, $21, $35, $21, $30, $21
	dc.b	$30, $20, $30, $23, $30, $21, $35, $20, $31, $20, $30, $20, $38, $20, $36, $22 ;0x320
	dc.b	$30, $21, $35, $21, $34, $21, $30, $20, $31, $21, $30, $24, $30, $20, $31, $20
	dc.b	$32, $20, $31, $22, $36, $20, $30, $20, $30, $20, $34, $20, $30, $22, $30, $20 ;0x340
	dc.b	$33, $20, $30, $21, $33, $21, $30, $20, $30, $22, $30, $20, $30, $22, $35, $20
	dc.b	$30, $20, $31, $21, $30, $20, $36, $21, $30, $20, $34, $20, $30, $22, $30, $20 ;0x360
	dc.b	$33, $21, $31, $20, $32, $21, $33, $21, $30, $20, $30, $22, $33, $20, $30, $20
	dc.b	$33, $23, $37, $21, $35, $25, $30, $21, $33, $20, $30, $20, $31, $20, $30, $25 ;0x380
	dc.b	$31, $20, $30, $23, $31, $21, $31, $21, $31, $22, $30, $20, $37, $20, $30, $21
	dc.b	$32, $23, $30, $20, $33, $20, $33, $20, $32, $22, $30, $20, $32, $23, $31, $20 ;0x3A0
	dc.b	$31, $20, $31, $21, $31, $20, $33, $20, $31, $20, $30, $21, $31, $20, $30, $20
	dc.b	$33, $23, $30, $23, $31, $22, $31, $20, $31, $23, $30, $22, $30, $20, $31, $20 ;0x3C0
	dc.b	$32, $20, $32, $20, $30, $20, $32, $20, $31, $22, $30, $23, $30, $21, $34, $26
	dc.b	$30, $20, $30, $22, $32, $24, $33, $27, $30, $21, $30, $22, $30, $20, $31, $22 ;0x3E0
	dc.b	$30, $21, $30, $26, $31, $20, $32, $21, $30, $22, $30, $21, $30, $20, $30, $20
	dc.b	$31, $20, $30, $20, $31, $20, $30, $22, $30, $25, $30, $20, $32, $20, $30, $20 ;0x400
	dc.b	$31, $20, $31, $20, $31, $20, $31, $24, $30, $24, $31, $2A, $31, $21, $32, $20
	dc.b	$30, $20, $30, $20, $31, $26, $31, $21, $31, $20, $31, $20, $32, $20, $33, $20 ;0x420
	dc.b	$30, $25, $30, $21, $31, $22, $30, $20, $31, $20, $30, $20, $30, $20, $32, $20
	dc.b	$30, $20, $31, $23, $30, $2F, $21, $32, $20, $34, $21, $30, $23, $30, $22, $30 ;0x440
	dc.b	$23, $31, $20, $32, $20, $30, $20, $32, $21, $32, $24, $30, $2D, $30, $20, $37
	dc.b	$23, $31, $29, $30, $22, $37, $23, $34, $2C, $31, $21, $31, $20, $32, $21, $31 ;0x460
	dc.b	$20, $30, $28, $31, $21, $31, $22, $31, $20, $30, $20, $33, $23, $31, $20, $32
	dc.b	$21, $30, $23, $30, $21, $30, $24, $30, $20, $30, $20, $30, $22, $33, $20, $31 ;0x480
	dc.b	$21, $30, $21, $30, $20, $30, $20, $30, $22, $33, $20, $30, $20, $30, $20, $31
	dc.b	$21, $30, $20, $31, $20, $30, $20, $30, $22, $30, $29, $33, $20, $37, $20, $30 ;0x4A0
	dc.b	$25, $33, $20, $30, $20, $32, $20, $33, $20, $36, $20, $31 ;0x4C0
loc_12908:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00012908-0x00012B92, Entry count: 0x28A) [Unknown data]
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $09, $F0, $03, $F0, $0F, $0F, $0F, $08, $F0, $B0, $F0, $01, $F0, $B0 ;0x20
	dc.b	$F0, $0F, $0F, $0F, $06, $F0, $B0, $F0, $B0, $F1, $B1, $F0, $0F, $0F, $0F, $06
	dc.b	$F0, $B0, $F1, $B2, $F1, $0F, $0F, $0F, $05, $F0, $B7, $F0, $0F, $0F, $0F, $04 ;0x40
	dc.b	$F0, $B0, $D1, $B6, $F0, $0F, $0F, $0F, $02, $F0, $B0, $D1, $B3, $F1, $B1, $F0
	dc.b	$0F, $0F, $0F, $01, $F0, $B0, $D2, $B3, $60, $70, $F0, $B0, $F1, $0F, $0F, $0F ;0x60
	dc.b	$00, $F0, $B0, $D1, $B2, $D4, $B1, $F1, $0F, $0F, $0D, $F2, $B0, $D1, $B1, $D2
	dc.b	$F1, $D1, $B1, $F1, $0F, $0F, $0A, $F1, $B1, $F0, $B0, $D2, $B0, $D1, $F0, $71 ;0x80
	dc.b	$F0, $D1, $F2, $0F, $0F, $09, $F0, $B3, $F1, $B0, $D1, $B1, $D1, $F2, $D2, $F1
	dc.b	$0F, $0D, $F6, $02, $F2, $B4, $F1, $B4, $D3, $F3, $0F, $0C, $F2, $B4, $F5, $B6 ;0xA0
	dc.b	$F2, $B5, $D2, $F0, $0F, $0B, $F1, $B6, $F6, $B8, $F1, $B2, $F4, $0F, $0B, $F1
	dc.b	$B7, $F5, $B9, $D0, $B0, $F0, $B1, $F1, $0F, $0D, $F1, $B6, $D0, $B0, $F5, $B2 ;0xC0
	dc.b	$D2, $B4, $D0, $B1, $F1, $0F, $0E, $F0, $B6, $D1, $B0, $F5, $B1, $D4, $B3, $D0
	dc.b	$B0, $F2, $0F, $0D, $F1, $B6, $D2, $B0, $F4, $B1, $D5, $B2, $D0, $B1, $F0, $0F ;0xE0
	dc.b	$0E, $F1, $B6, $D2, $B0, $F4, $B0, $D6, $B1, $D1, $B1, $F0, $0F, $0D, $F0, $B0
	dc.b	$F0, $B6, $D2, $B1, $F3, $B1, $D6, $B0, $D1, $B0, $F1, $0F, $0D, $F0, $B0, $F0 ;0x100
	dc.b	$B6, $D0, $F0, $D0, $B1, $F3, $B1, $D9, $B0, $F0, $0F, $0D, $F0, $B1, $F0, $B5
	dc.b	$D1, $F0, $D1, $B1, $F1, $B3, $D7, $B1, $F0, $0F, $0D, $F0, $B1, $F0, $B5, $D1 ;0x120
	dc.b	$F0, $D1, $B8, $D3, $B0, $D0, $B1, $F1, $0F, $0D, $F0, $B1, $F0, $D0, $B4, $D0
	dc.b	$F3, $B4, $F0, $B2, $D3, $B2, $F2, $0F, $0D, $F0, $B1, $F0, $D1, $B2, $D1, $F0 ;0x140
	dc.b	$B1, $F2, $B2, $F0, $B3, $D2, $B1, $F1, $D0, $F0, $0F, $0D, $F0, $B1, $F1, $D5
	dc.b	$F0, $B2, $F0, $00, $F3, $B3, $D2, $F1, $D2, $F0, $0F, $0D, $F0, $B2, $F0, $D4 ;0x160
	dc.b	$F1, $B1, $F1, $03, $F1, $B2, $D2, $F0, $B0, $D2, $F0, $0F, $0D, $F0, $B2, $F0
	dc.b	$B0, $D3, $F0, $B1, $F1, $05, $F1, $B1, $D2, $F0, $B0, $D1, $F1, $0F, $0D, $F1 ;0x180
	dc.b	$B1, $F0, $B0, $D2, $F1, $B0, $F1, $08, $F0, $B0, $D2, $F0, $B0, $D1, $F0, $0F
	dc.b	$0F, $F0, $B1, $F0, $B0, $D1, $F1, $B0, $F1, $09, $F0, $B0, $D1, $F1, $B1, $D0 ;0x1A0
	dc.b	$F0, $0F, $0F, $F1, $B0, $F0, $B0, $D0, $F1, $B1, $F0, $0A, $F0, $B1, $D0, $F2
	dc.b	$B0, $D0, $F0, $0F, $0F, $00, $F2, $D1, $F0, $B2, $F0, $0B, $F0, $B0, $D0, $F0 ;0x1C0
	dc.b	$00, $F0, $B0, $D0, $F0, $0F, $0F, $00, $F1, $B0, $D1, $F0, $B2, $F0, $0B, $F0
	dc.b	$B0, $D0, $F0, $00, $F0, $B0, $D0, $F0, $0F, $0F, $01, $F0, $B1, $D0, $F1, $B1 ;0x1E0
	dc.b	$F0, $0B, $F0, $B0, $D0, $F0, $00, $F0, $B0, $D0, $F0, $0F, $0F, $01, $F0, $B1
	dc.b	$D0, $F1, $B1, $F1, $0A, $F0, $B0, $D1, $F1, $B0, $D1, $F0, $0F, $0F, $01, $F0 ;0x200
	dc.b	$B2, $F0, $B2, $D0, $F0, $09, $F0, $B1, $D0, $F1, $B1, $F2, $0F, $0F, $00, $F0
	dc.b	$B1, $D1, $F0, $B0, $D2, $F0, $08, $F0, $B0, $F3, $B0, $F0, $B0, $D1, $F0, $0F ;0x220
	dc.b	$0F, $F0, $B0, $D2, $F5, $08, $F1, $B0, $D1, $F0, $B1, $D2, $F0, $0F, $0F, $00
	dc.b	$F4, $0D, $F0, $B0, $D2, $00, $F4, $0F, $0F, $0F, $05, $F3, $0F, $0F, $0F, $0F ;0x240
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x260
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $08 ;0x280
	dc.l	loc_13A19
	dc.l	loc_14E4E
	dc.l	loc_12C5A
	dc.l	loc_1595B
	dc.l	loc_13355
	dc.l	loc_16053
	dc.l	loc_16DF7
	dc.l	loc_1431E
	dc.l	loc_16AA7
	dc.l	$00FF1214
	dc.l	loc_13A19
	dc.l	loc_13C44
	dc.l	loc_13EAB
	dc.l	loc_140C0
	dc.l	loc_14E4E
	dc.l	loc_15101
	dc.l	loc_153D5
	dc.l	loc_15686
	dc.l	loc_12C5A
	dc.l	loc_12E12
	dc.l	loc_12FF7
	dc.l	loc_13198
	dc.l	loc_1595B
	dc.l	loc_15B59
	dc.l	loc_15CD9
	dc.l	loc_15EAE
	dc.l	loc_13355
	dc.l	loc_1350A
	dc.l	loc_136CC
	dc.l	loc_13873
	dc.l	loc_16053
	dc.l	loc_16309
	dc.l	loc_1657C
	dc.l	loc_16830
	dc.l	loc_16DF7
	dc.l	loc_170BD
	dc.l	loc_1736B
	dc.l	loc_17639
	dc.l	loc_1431E
	dc.l	loc_145FF
	dc.l	loc_148A3
	dc.l	loc_14BB7
	dc.l	loc_16AA7
	dc.l	loc_16C4C
	dc.l	loc_16AA7
	dc.l	loc_16C4C
	dc.l	$00FF1214
	dc.l	$00FF1A14
	dc.l	$00FF2214
	dc.l	$00FF2A14
loc_12C5A:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00012C5A-0x00012E12, Entry count: 0x1B8)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0D, $F5, $0F, $0F, $0F, $07, $F1, $A4, $B0, $F0
	dc.b	$0F, $0F, $0F, $05, $F0, $B2, $A1, $B1, $F1, $01, $F2, $0F, $0F, $0F, $F0, $B4 ;0x40
	dc.b	$A0, $B0, $F0, $30, $F2, $A0, $F0, $E0, $F0, $0F, $0F, $08, $F3, $01, $F0, $B4
	dc.b	$A0, $B0, $C0, $30, $A2, $B0, $F2, $0F, $0B, $F6, $03, $F1, $B3, $F1, $B4, $F0 ;0x60
	dc.b	$B8, $F0, $0B, $FF, $F0, $B6, $F3, $B4, $A1, $F0, $B2, $F2, $B8, $F0, $0A, $F0
	dc.b	$BF, $BF, $B1, $A0, $F2, $B0, $F1, $B3, $F0, $B3, $F0, $0C, $FD, $BF, $B3, $A1 ;0x80
	dc.b	$F0, $70, $F2, $B4, $F3, $0F, $08, $F1, $BF, $B5, $A0, $F0, $70, $F1, $B1, $F2
	dc.b	$B1, $F0, $0F, $09, $F2, $BF, $B5, $A0, $F0, $71, $F2, $01, $F2, $0F, $09, $F0 ;0xA0
	dc.b	$B0, $F0, $BF, $B6, $A1, $F0, $70, $F0, $0F, $0F, $F0, $B0, $F1, $BF, $B6, $A1
	dc.b	$F1, $C0, $F0, $0F, $0D, $F0, $B0, $F1, $B9, $F2, $BA, $F0, $A0, $F1, $C0, $F0 ;0xC0
	dc.b	$0F, $0D, $F0, $B0, $F0, $B9, $F1, $00, $F5, $B6, $F0, $B1, $F2, $0F, $0C, $F1
	dc.b	$B9, $F1, $06, $F1, $B5, $F0, $B4, $F2, $0F, $08, $F0, $B0, $F0, $B7, $F2, $09 ;0xE0
	dc.b	$F1, $B3, $F4, $B3, $F0, $0F, $04, $F2, $B1, $F0, $B2, $F5, $0D, $F0, $B4, $F5
	dc.b	$B1, $F0, $0F, $02, $F0, $B3, $F1, $B1, $F1, $0F, $03, $F2, $B3, $F2, $B2, $F0 ;0x100
	dc.b	$0F, $01, $F1, $B1, $F3, $B1, $F0, $0F, $07, $F1, $B3, $F0, $B1, $F0, $0F, $03
	dc.b	$F3, $01, $F0, $B1, $F0, $0F, $09, $F0, $B3, $F1, $0F, $0A, $F0, $B0, $F1, $0F ;0x120
	dc.b	$0A, $F0, $B2, $F0, $0F, $09, $F1, $B1, $F0, $0F, $0B, $F1, $B1, $F0, $0F, $08
	dc.b	$F0, $B2, $F1, $0F, $0C, $F2, $0F, $09, $F0, $B1, $F1, $0F, $0F, $0F, $0B, $F2 ;0x140
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x160
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $00 ;0x1A0
loc_12E12:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00012E12-0x00012FF7, Entry count: 0x1E5)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0C, $F5, $0F, $0F, $0F, $07
	dc.b	$F1, $A4, $B0, $F0, $0F, $0F, $0F, $05, $F1, $B1, $A1, $B1, $F1, $01, $F2, $0F ;0x40
	dc.b	$0F, $0F, $00, $F0, $B3, $A0, $B0, $F0, $30, $F2, $A0, $F0, $E0, $F0, $0F, $0F
	dc.b	$0F, $F0, $B3, $A0, $B0, $C0, $30, $A2, $B0, $F2, $0F, $0D, $FF, $F2, $B2, $A0 ;0x60
	dc.b	$F0, $B7, $F0, $0F, $0A, $F3, $BD, $A1, $F0, $70, $F0, $B2, $F0, $B8, $F0, $0F
	dc.b	$05, $F4, $BF, $B2, $A0, $F0, $70, $F0, $B2, $F0, $B2, $F0, $B3, $F0, $0F, $02 ;0x80
	dc.b	$F3, $BF, $B7, $A1, $F0, $70, $F2, $B4, $F3, $0E, $F4, $B3, $F3, $BF, $B4, $A0
	dc.b	$F0, $70, $F1, $B1, $F2, $B1, $F0, $0F, $F0, $B4, $F4, $00, $F0, $BF, $B5, $A0 ;0xA0
	dc.b	$F0, $71, $F2, $01, $F2, $0F, $01, $F5, $04, $F0, $BF, $B5, $A1, $F0, $70, $F0
	dc.b	$0F, $0F, $03, $F0, $B9, $F0, $BA, $A1, $F1, $C0, $F0, $0F, $0F, $02, $F0, $B8 ;0xC0
	dc.b	$F3, $B8, $A1, $F1, $C0, $F0, $0F, $0F, $00, $F1, $B8, $F7, $B5, $A0, $F0, $B0
	dc.b	$F2, $0F, $0F, $00, $F1, $B7, $F0, $06, $F1, $B4, $F0, $B2, $F0, $0F, $0F, $01 ;0xE0
	dc.b	$F0, $B0, $F0, $B4, $F1, $09, $F0, $B3, $F0, $B2, $F0, $0F, $0F, $00, $F0, $B1
	dc.b	$F0, $B2, $F1, $0C, $F0, $B2, $F0, $B3, $F0, $0F, $0F, $F1, $B0, $F0, $B1, $F2 ;0x100
	dc.b	$0C, $F0, $B1, $F1, $B3, $F0, $0F, $0F, $01, $F0, $B2, $F0, $B1, $F1, $0A, $F0
	dc.b	$B1, $F3, $B1, $F0, $0F, $0F, $01, $F0, $B3, $F2, $B1, $F0, $08, $F0, $B1, $F0 ;0x120
	dc.b	$01, $F1, $B0, $F1, $0F, $0F, $01, $F1, $B4, $F1, $B0, $F0, $06, $F0, $B1, $F1
	dc.b	$02, $F0, $B1, $F0, $0F, $0F, $02, $F3, $B3, $F1, $06, $F0, $B1, $F0, $03, $F0 ;0x140
	dc.b	$B1, $F0, $0F, $0F, $05, $F2, $B1, $F1, $06, $F0, $B0, $F1, $03, $F1, $B0, $F2
	dc.b	$0F, $0F, $05, $F1, $B0, $F0, $06, $F0, $B1, $F1, $04, $F0, $B2, $F0, $0F, $0F ;0x160
	dc.b	$06, $F1, $07, $F0, $B1, $F1, $04, $F1, $B1, $F0, $0F, $0F, $0F, $00, $F0, $B2
	dc.b	$F0, $05, $F2, $0F, $0F, $0F, $02, $F0, $B1, $F0, $0F, $0F, $0F, $0C, $F2, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x1A0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x1C0
	dc.b	$0F, $0F, $0F, $0F, $08 ;0x1E0
loc_12FF7:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00012FF7-0x00013198, Entry count: 0x1A1)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0B, $F5, $0F, $0F, $0F, $07, $F1, $A4, $B0, $F0, $0F, $0F, $0F, $06 ;0x40
	dc.b	$F0, $B2, $A1, $B0, $F1, $01, $F2, $0F, $0F, $0F, $00, $F0, $B3, $A0, $B0, $F0
	dc.b	$30, $F2, $A0, $F0, $E0, $F0, $0F, $0E, $F6, $09, $F1, $B2, $A0, $B0, $C0, $30 ;0x60
	dc.b	$A2, $B0, $F2, $0F, $0B, $F2, $B5, $FC, $B2, $A0, $B7, $F0, $0F, $0A, $F1, $BB
	dc.b	$F0, $B2, $A1, $F0, $70, $F1, $B3, $F0, $B6, $F0, $0F, $04, $F5, $BF, $B2, $A0 ;0x80
	dc.b	$F0, $70, $F2, $B2, $F0, $B0, $F0, $B3, $F0, $0F, $F5, $B5, $F0, $BF, $B1, $A0
	dc.b	$F0, $70, $F5, $B2, $F3, $0F, $F0, $B6, $F4, $BF, $B2, $A0, $F0, $71, $F2, $B0 ;0xA0
	dc.b	$F2, $B1, $F0, $0F, $02, $F7, $02, $F0, $BF, $B2, $A1, $F0, $71, $F2, $01, $F2
	dc.b	$0F, $0E, $F0, $BF, $B2, $A2, $F3, $0F, $0F, $04, $F0, $B7, $F3, $B6, $A2, $F0 ;0xC0
	dc.b	$C0, $F0, $0F, $0F, $05, $F0, $B6, $F5, $B4, $A3, $F0, $C0, $F0, $0F, $0F, $05
	dc.b	$F0, $B7, $F3, $B5, $A3, $F2, $0F, $0F, $06, $F0, $B6, $F2, $B5, $A1, $F2, $B0 ;0xE0
	dc.b	$F0, $0F, $0F, $07, $F0, $B4, $F2, $B6, $A0, $F2, $B1, $F1, $0F, $0F, $08, $F0
	dc.b	$B1, $F1, $B5, $F1, $B0, $F3, $B1, $F1, $0F, $0F, $0A, $F1, $B4, $F8, $B1, $F1 ;0x100
	dc.b	$0F, $0F, $0C, $F0, $B1, $F2, $B0, $F2, $B0, $F0, $B3, $F1, $0F, $0F, $0D, $F1
	dc.b	$B0, $F2, $B2, $F0, $B0, $F1, $B0, $F2, $0F, $0F, $0F, $F2, $00, $F1, $B1, $F0 ;0x120
	dc.b	$B1, $F1, $0F, $0F, $0F, $07, $F0, $B1, $F3, $0F, $0F, $0F, $08, $F2, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x140
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x160
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$00 ;0x1A0
loc_13198:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00013198-0x00013355, Entry count: 0x1BD)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0C, $F5, $0F, $0F, $0F, $07, $F1, $A4, $B0, $F0
	dc.b	$0F, $0F, $0F, $05, $F1, $B1, $A1, $B1, $F1, $01, $F2, $0F, $0F, $0F, $00, $F0 ;0x40
	dc.b	$B3, $A0, $B0, $F0, $30, $F2, $A0, $F0, $E0, $F0, $0F, $0F, $0F, $F0, $B3, $A0
	dc.b	$B0, $C0, $30, $A2, $B0, $F2, $0F, $0E, $F4, $02, $F9, $B2, $A0, $F0, $B7, $F0 ;0x60
	dc.b	$0F, $0B, $F3, $B4, $F2, $B4, $A1, $F0, $70, $F0, $B2, $F0, $B8, $F0, $0F, $07
	dc.b	$F3, $BF, $B1, $A0, $F0, $70, $F0, $B2, $F0, $B2, $F0, $B3, $F0, $0E, $F9, $BF ;0x80
	dc.b	$B5, $A1, $F0, $70, $F2, $B4, $F3, $0E, $F0, $B9, $F2, $BF, $B3, $A0, $F0, $70
	dc.b	$F1, $B1, $F2, $B1, $F0, $0F, $01, $FB, $BF, $B4, $A0, $F0, $71, $F2, $01, $F2 ;0xA0
	dc.b	$0F, $0D, $F0, $BF, $B4, $A1, $F0, $70, $F0, $0F, $0F, $04, $F0, $BF, $B5, $A0
	dc.b	$F1, $C0, $F0, $0F, $0F, $03, $F0, $B8, $F2, $B8, $F0, $A0, $F1, $C0, $F1, $0F ;0xC0
	dc.b	$0F, $01, $F0, $B9, $F7, $B5, $F3, $B0, $F0, $0F, $0F, $00, $F0, $B8, $F3, $03
	dc.b	$F2, $B5, $F1, $B0, $F0, $0F, $0F, $F0, $B8, $F3, $06, $F3, $B3, $F0, $B0, $F0 ;0xE0
	dc.b	$0F, $0F, $F0, $B6, $F2, $B0, $F0, $08, $F3, $B1, $F3, $0F, $0E, $F0, $B5, $F1
	dc.b	$B1, $F1, $07, $F2, $B3, $F3, $0F, $0F, $F1, $B3, $F0, $B1, $F1, $09, $F1, $B3 ;0x100
	dc.b	$F2, $0F, $0F, $02, $F1, $B1, $F1, $B0, $F0, $09, $F1, $B3, $F2, $0F, $0F, $05
	dc.b	$F0, $B2, $F0, $B0, $F0, $09, $F0, $B2, $F2, $0F, $0F, $07, $F1, $B1, $F0, $B0 ;0x120
	dc.b	$F0, $09, $F1, $B1, $F0, $0F, $0F, $0A, $F0, $B1, $F0, $B0, $F0, $0B, $F2, $0F
	dc.b	$0F, $0A, $F0, $B2, $F1, $0F, $0F, $0F, $09, $F1, $B1, $F1, $0F, $0F, $0F, $0A ;0x140
	dc.b	$F1, $B0, $F2, $0F, $0F, $0F, $09, $F0, $B2, $F1, $0F, $0F, $0F, $09, $F0, $B2
	dc.b	$F1, $0F, $0F, $0F, $0A, $F3, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x160
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $07 ;0x1A0
loc_13355:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00013355-0x0001350A, Entry count: 0x1B5)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $06, $F5 ;0x20
	dc.b	$0F, $0F, $0F, $07, $F1, $95, $F0, $0F, $0F, $0F, $05, $F0, $91, $84, $91, $F0
	dc.b	$0F, $0F, $0F, $03, $F0, $91, $81, $92, $F1, $91, $F0, $0F, $0F, $0F, $01, $F0 ;0x40
	dc.b	$92, $80, $93, $F1, $91, $F0, $0F, $0F, $0F, $01, $F0, $91, $81, $97, $A0, $F0
	dc.b	$0F, $0F, $0F, $00, $F0, $91, $80, $97, $A1, $B0, $F0, $0F, $0F, $0F, $F0, $91 ;0x60
	dc.b	$80, $97, $A3, $F1, $0F, $0F, $0D, $F0, $91, $80, $92, $F6, $A3, $F0, $0F, $0F
	dc.b	$0C, $F0, $91, $80, $91, $F1, $04, $F5, $0F, $0F, $0C, $F1, $90, $80, $92, $F1 ;0x80
	dc.b	$0F, $0F, $0F, $07, $F0, $91, $C3, $F0, $0F, $0F, $0E, $F8, $91, $B3, $A0, $B0
	dc.b	$F0, $0F, $0F, $0A, $F2, $B1, $D7, $B5, $A0, $B0, $F0, $0F, $0F, $07, $F1, $B2 ;0xA0
	dc.b	$C3, $D7, $B3, $A0, $B0, $F0, $0F, $0F, $05, $F1, $B1, $C8, $D1, $C1, $D2, $B2
	dc.b	$A1, $B0, $F0, $0F, $0F, $01, $F2, $B1, $C8, $B2, $C3, $D1, $B1, $A2, $B0, $F0 ;0xC0
	dc.b	$0F, $0F, $F1, $B2, $C8, $B3, $C4, $D0, $B2, $A2, $B0, $F0, $0F, $0B, $F3, $B1
	dc.b	$C7, $B6, $C6, $B1, $A2, $B1, $F0, $0F, $0C, $F1, $B5, $C2, $B6, $C8, $B6, $F0 ;0xE0
	dc.b	$0F, $09, $F6, $B9, $CC, $B5, $F1, $0F, $09, $F7, $B6, $CE, $B5, $F1, $0F, $0A
	dc.b	$F7, $C0, $B1, $CE, $D2, $B4, $F1, $0F, $0C, $F2, $C0, $F1, $CE, $D6, $B2, $F3 ;0x100
	dc.b	$0F, $0B, $F0, $C4, $D0, $F0, $C1, $D2, $C3, $DA, $F6, $0F, $0C, $F1, $D1, $F3
	dc.b	$C2, $DC, $E2, $F5, $0F, $0F, $00, $F5, $DB, $E3, $F4, $0F, $0F, $09, $F4, $E8 ;0x120
	dc.b	$F4, $0F, $0F, $0F, $00, $FA, $72, $F1, $0F, $0F, $0F, $05, $F0, $71, $F0, $74
	dc.b	$F0, $0F, $0F, $0F, $05, $F1, $70, $F5, $0F, $0F, $0F, $07, $F0, $60, $F0, $0F ;0x140
	dc.b	$0F, $0F, $0C, $F0, $60, $F2, $0F, $0F, $0F, $0A, $F0, $62, $F3, $0F, $0F, $0F
	dc.b	$06, $F0, $66, $F0, $0F, $0F, $0F, $06, $F1, $64, $F0, $0F, $0F, $0F, $09, $F1 ;0x160
	dc.b	$61, $F0, $0F, $0F, $0F, $0C, $F1, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F ;0x1A0
loc_1350A:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x0001350A-0x000136CC, Entry count: 0x1C2)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $07, $F5, $0F, $0F, $0F, $07, $F1, $95, $F0, $0F, $0F, $0F, $05, $F0
	dc.b	$91, $84, $91, $F0, $0F, $0F, $0F, $03, $F0, $91, $81, $92, $F1, $91, $F0, $0F ;0x40
	dc.b	$0F, $0F, $02, $F0, $91, $80, $93, $F1, $91, $F0, $0F, $0F, $0F, $01, $F0, $91
	dc.b	$81, $97, $A0, $F0, $0F, $0F, $0F, $00, $F0, $91, $80, $97, $A1, $B0, $F0, $0F ;0x60
	dc.b	$0F, $0F, $F0, $91, $80, $97, $A3, $F1, $0F, $0F, $0D, $F0, $91, $80, $92, $F6
	dc.b	$A3, $F0, $0F, $0F, $0C, $F0, $91, $80, $91, $F1, $04, $F5, $0F, $0F, $0C, $F0 ;0x80
	dc.b	$91, $80, $91, $F1, $0F, $0F, $0F, $06, $F0, $95, $C0, $F0, $0F, $0F, $0F, $00
	dc.b	$F6, $91, $C3, $B1, $F0, $0F, $0F, $0B, $F3, $B1, $D5, $90, $B3, $A0, $B1, $F0 ;0xA0
	dc.b	$0F, $0F, $06, $F3, $B5, $D7, $B2, $A1, $B0, $F0, $0F, $0F, $03, $F2, $B5, $C3
	dc.b	$D7, $B2, $A1, $B1, $F0, $0F, $0F, $00, $F1, $B4, $C8, $D5, $B3, $A2, $B0, $F0 ;0xC0
	dc.b	$0F, $0E, $F1, $B3, $CB, $D2, $C1, $D0, $B3, $A2, $B0, $F0, $0F, $0C, $F1, $B3
	dc.b	$CA, $B2, $D1, $C2, $D0, $B2, $A2, $B1, $F0, $0F, $09, $F5, $B1, $C8, $B6, $C4 ;0xE0
	dc.b	$B1, $A1, $B3, $F0, $0F, $09, $F4, $B4, $C1, $B8, $C7, $B6, $F1, $0F, $09, $F5
	dc.b	$BB, $CA, $B6, $F1, $0F, $09, $F6, $B6, $CE, $B5, $F1, $0F, $0B, $F6, $CF, $C1 ;0x100
	dc.b	$D3, $B3, $F2, $0F, $0A, $F0, $D2, $C2, $F0, $C2, $D2, $C7, $D7, $B1, $F3, $0F
	dc.b	$0B, $F0, $C4, $F2, $C1, $DF, $D0, $E1, $F3, $0F, $0F, $F1, $D1, $F4, $C0, $DA ;0x120
	dc.b	$E3, $F5, $0F, $0F, $02, $F1, $01, $F5, $E7, $F5, $00, $F2, $0F, $0F, $0B, $FD
	dc.b	$00, $F1, $71, $F0, $0F, $0F, $0E, $F0, $71, $F0, $04, $F0, $70, $F0, $72, $F1 ;0x140
	dc.b	$0F, $0F, $0E, $F0, $70, $F1, $04, $F0, $72, $F2, $0F, $0F, $0F, $F0, $60, $F1
	dc.b	$05, $F3, $0F, $0F, $0F, $01, $F0, $62, $F3, $0F, $0F, $0F, $06, $F0, $66, $F0 ;0x160
	dc.b	$0F, $0F, $0F, $06, $F1, $64, $F0, $0F, $0F, $0F, $09, $F1, $61, $F0, $0F, $0F
	dc.b	$0F, $0C, $F1, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x1A0
	dc.b	$0F, $03 ;0x1C0
loc_136CC:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x000136CC-0x00013873, Entry count: 0x1A7)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $06, $F5, $0F, $0F, $0F, $07 ;0x20
	dc.b	$F1, $95, $F0, $0F, $0F, $0F, $05, $F0, $91, $84, $91, $F0, $0F, $0F, $0F, $03
	dc.b	$F0, $91, $81, $92, $F1, $91, $F0, $0F, $0F, $0F, $01, $F0, $92, $80, $93, $F1 ;0x40
	dc.b	$91, $F0, $0F, $0F, $0F, $01, $F0, $91, $81, $97, $A0, $F0, $0F, $0F, $0F, $00
	dc.b	$F0, $91, $80, $97, $A1, $B0, $F0, $0F, $0F, $0F, $F0, $91, $80, $97, $A3, $F1 ;0x60
	dc.b	$0F, $0F, $0D, $F0, $91, $80, $92, $F6, $A3, $F0, $0F, $0F, $0C, $F0, $91, $80
	dc.b	$91, $F1, $04, $F5, $0F, $0F, $0C, $F1, $90, $80, $92, $F1, $0F, $0F, $0F, $07 ;0x80
	dc.b	$F0, $91, $C3, $F0, $0F, $0F, $0E, $F8, $91, $B3, $A0, $B0, $F0, $0F, $0F, $0A
	dc.b	$F2, $B1, $D7, $B5, $A0, $B0, $F0, $0F, $0F, $07, $F1, $B2, $C3, $D7, $B3, $A0 ;0xA0
	dc.b	$B0, $F0, $0F, $0F, $05, $F1, $B1, $C8, $D1, $C1, $D2, $B2, $A1, $B0, $F0, $0F
	dc.b	$0F, $01, $F2, $B1, $C8, $B2, $C3, $D1, $B1, $A2, $B0, $F0, $0F, $0F, $F1, $B2 ;0xC0
	dc.b	$C8, $B3, $C4, $D0, $B2, $A2, $B0, $F0, $0F, $0B, $F3, $B1, $C7, $B6, $C6, $B1
	dc.b	$A2, $B1, $F0, $0F, $0C, $F1, $B5, $C2, $B6, $C8, $B6, $F0, $0F, $09, $F6, $B9 ;0xE0
	dc.b	$CC, $B5, $F1, $0F, $09, $F7, $B6, $CE, $B5, $F1, $0F, $0A, $F7, $C0, $B2, $CD
	dc.b	$D2, $B4, $F1, $0F, $0C, $F2, $C0, $F1, $CE, $D6, $B2, $F3, $0F, $0B, $F0, $C4 ;0x100
	dc.b	$D0, $F0, $C1, $D2, $C3, $DA, $F6, $0F, $0C, $F1, $D1, $F3, $C2, $DC, $E2, $F5
	dc.b	$0F, $0F, $00, $F5, $DB, $E4, $F4, $0F, $0F, $08, $F4, $E8, $F4, $0F, $0F, $0F ;0x120
	dc.b	$00, $FC, $0F, $0F, $0F, $06, $F3, $70, $F4, $0F, $0F, $0F, $07, $F0, $66, $F0
	dc.b	$0F, $0F, $0F, $06, $F0, $74, $61, $F0, $0F, $0F, $0F, $06, $F8, $0F, $0F, $0F ;0x140
	dc.b	$07, $F0, $75, $F0, $0F, $0F, $0F, $07, $F7, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x160
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0C ;0x1A0
loc_13873:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00013873-0x00013A19, Entry count: 0x1A6)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $06, $F5, $0F, $0F, $0F, $07, $F1, $95, $F0, $0F, $0F, $0F, $05, $F0
	dc.b	$91, $84, $91, $F0, $0F, $0F, $0F, $03, $F0, $91, $81, $92, $F1, $91, $F0, $0F ;0x40
	dc.b	$0F, $0F, $01, $F0, $92, $80, $93, $F1, $91, $F0, $0F, $0F, $0F, $01, $F0, $91
	dc.b	$81, $97, $A0, $F0, $0F, $0F, $0F, $00, $F0, $91, $80, $97, $A1, $B0, $F0, $0F ;0x60
	dc.b	$0F, $0F, $F0, $91, $80, $97, $A3, $F1, $0F, $0F, $0D, $F0, $91, $80, $92, $F6
	dc.b	$A3, $F0, $0F, $0F, $0C, $F0, $91, $80, $91, $F1, $04, $F5, $0F, $0F, $0D, $F0 ;0x80
	dc.b	$94, $F1, $0F, $0F, $0F, $07, $F0, $91, $C3, $B0, $F0, $0F, $0F, $0F, $01, $F5
	dc.b	$B7, $F0, $0F, $0F, $0C, $F3, $D7, $B4, $A0, $B0, $F0, $0F, $0F, $08, $F2, $B3 ;0xA0
	dc.b	$C1, $D7, $B2, $A0, $B0, $F0, $0F, $0F, $05, $F2, $B0, $C6, $B1, $D0, $C3, $D1
	dc.b	$B1, $A2, $B0, $F0, $0F, $0F, $02, $F1, $B1, $C5, $B4, $C4, $D0, $B2, $A2, $B0 ;0xC0
	dc.b	$F0, $0F, $0F, $00, $F1, $B1, $C4, $B6, $C6, $B2, $A1, $B1, $F0, $0F, $0D, $F2
	dc.b	$B0, $C5, $B5, $C9, $B5, $F1, $0F, $0A, $F3, $BA, $CD, $B5, $F1, $0F, $09, $F6 ;0xE0
	dc.b	$B6, $CE, $D0, $B4, $F2, $0F, $09, $F7, $B3, $CC, $D4, $B3, $F2, $0F, $0B, $F7
	dc.b	$CA, $D8, $B2, $F4, $0F, $0C, $F2, $D2, $F0, $C1, $D2, $C1, $DC, $F6, $0F, $0C ;0x100
	dc.b	$F0, $D2, $E1, $F2, $C1, $DD, $E2, $F5, $0F, $0D, $F8, $C1, $D8, $E0, $F2, $E3
	dc.b	$F4, $0F, $0E, $F7, $D5, $E6, $F0, $71, $F5, $0F, $0F, $05, $F6, $EA, $F0, $70 ;0x120
	dc.b	$F2, $0F, $0F, $0E, $FC, $60, $F0, $0F, $0F, $0F, $04, $F1, $70, $F6, $60, $F5
	dc.b	$0F, $0F, $0D, $F0, $71, $F6, $66, $F0, $0F, $0F, $0D, $F2, $73, $F0, $00, $F2 ;0x140
	dc.b	$64, $F0, $0F, $0F, $0F, $F5, $02, $F6, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x160
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $0F, $06 ;0x1A0
loc_13A19:
	dc.b	$0F, $0E, $F7, $0F, $0F, $0F ;0x0 (0x00013A19-0x00013A1F, Entry count: 0x6)
	dc.b	$05, $F1, $C1, $A2, $C2, $F0, $0F, $0F, $0F, $03, $F0, $A2, $C1, $A3, $C1, $F0
	dc.b	$0F, $0F, $0F, $02, $F0, $A4, $B1, $A2, $C0, $F0, $0F, $0F, $0F, $01, $F0, $A2 ;0x0 (0x00013A1F-0x00013C44, Entry count: 0x225)
	dc.b	$B1, $A0, $B2, $A2, $F0, $0F, $0F, $0F, $01, $F0, $A1, $F0, $B0, $F3, $31, $A1
	dc.b	$F0, $0F, $0F, $0F, $01, $F0, $A1, $F0, $B2, $F1, $30, $F0, $A0, $F1, $0F, $0F ;0x20
	dc.b	$0F, $01, $F1, $A1, $B3, $31, $B0, $F1, $0F, $0F, $0F, $03, $F0, $A1, $B5, $F0
	dc.b	$0F, $0F, $0F, $05, $F0, $A0, $F0, $B5, $F0, $0F, $0F, $0F, $05, $F2, $B2, $F3 ;0x40
	dc.b	$0F, $0F, $0F, $06, $F1, $B2, $F0, $0F, $0F, $0F, $08, $F0, $11, $F1, $B0, $F0
	dc.b	$0F, $0F, $0F, $07, $F0, $30, $F1, $11, $F2, $0F, $0F, $0F, $05, $F0, $33, $F1 ;0x60
	dc.b	$10, $20, $F0, $0F, $0F, $0F, $05, $F0, $35, $F1, $20, $F0, $0F, $0F, $0F, $03
	dc.b	$F0, $38, $F1, $0F, $0F, $0F, $03, $F0, $30, $F0, $37, $F0, $0F, $0F, $0F, $03 ;0x80
	dc.b	$F0, $30, $F0, $37, $F0, $0F, $0F, $0F, $03, $F0, $30, $F0, $38, $F0, $0F, $0F
	dc.b	$0F, $02, $F0, $30, $F0, $38, $F0, $0F, $0F, $0F, $02, $F3, $37, $F0, $0F, $0F ;0xA0
	dc.b	$0F, $03, $F0, $30, $F0, $32, $F3, $30, $F0, $0F, $0F, $0F, $03, $F0, $30, $F3
	dc.b	$12, $F0, $30, $F0, $0F, $0F, $0F, $03, $F2, $21, $10, $F3, $30, $F0, $0F, $0F ;0xC0
	dc.b	$0F, $04, $F5, $B1, $F2, $0F, $0F, $0F, $04, $F0, $32, $F0, $B2, $F1, $0F, $0F
	dc.b	$0F, $05, $F0, $32, $F1, $B1, $F1, $0F, $0F, $0F, $05, $F0, $33, $F1, $B1, $F0 ;0xE0
	dc.b	$0F, $0F, $0F, $05, $F0, $34, $F0, $B1, $F0, $0F, $0F, $0F, $05, $F0, $31, $F4
	dc.b	$B1, $F0, $0F, $0F, $0F, $04, $F0, $31, $F4, $B2, $F0, $0F, $0F, $0F, $02, $F0 ;0x100
	dc.b	$32, $F1, $E1, $F1, $B2, $F0, $0F, $0F, $0F, $01, $F1, $30, $F1, $E3, $F0, $B2
	dc.b	$F0, $0F, $0F, $0F, $02, $F2, $E4, $F0, $B3, $F0, $0F, $0F, $0F, $02, $F1, $E4 ;0x120
	dc.b	$F0, $B2, $F1, $0F, $0F, $0F, $02, $F2, $E3, $F0, $B2, $F0, $0F, $0F, $0F, $03
	dc.b	$F3, $E3, $F3, $0F, $0F, $0F, $03, $F3, $E3, $F1, $D0, $F0, $0F, $0F, $0F, $02 ;0x140
	dc.b	$F8, $D1, $F1, $0F, $0F, $0F, $02, $F6, $E0, $D0, $F4, $0F, $0F, $0F, $01, $F0
	dc.b	$E1, $F2, $E0, $F2, $B2, $F0, $0F, $0F, $0F, $02, $F6, $B5, $F0, $0F, $0F, $0F ;0x160
	dc.b	$01, $F8, $B3, $F0, $0F, $0F, $0F, $01, $F6, $B4, $F1, $0F, $0F, $0F, $01, $F4
	dc.b	$B5, $F1, $0F, $0F, $0F, $02, $F3, $B5, $F1, $0F, $0F, $0F, $02, $F3, $B4, $F2 ;0x180
	dc.b	$0F, $0F, $0F, $03, $F2, $B3, $F2, $0F, $0F, $0F, $05, $F1, $C0, $F0, $B1, $F1
	dc.b	$0F, $0F, $0F, $06, $F0, $C0, $D0, $C1, $F2, $0F, $0F, $0F, $06, $F0, $C0, $D4 ;0x1A0
	dc.b	$F0, $0F, $0F, $0F, $07, $F0, $C0, $D0, $C0, $D0, $F2, $0F, $0F, $0F, $07, $F1
	dc.b	$C2, $F2, $0F, $0F, $0F, $08, $F0, $C0, $D0, $C0, $D0, $F1, $0F, $0F, $0F, $08 ;0x1C0
	dc.b	$F1, $C0, $D1, $F1, $0F, $0F, $0F, $08, $F1, $C0, $D1, $F1, $0F, $0F, $0F, $07
	dc.b	$F0, $E0, $F1, $C0, $D1, $F0, $0F, $0F, $0F, $07, $F0, $E1, $F0, $C0, $D1, $F0 ;0x1E0
	dc.b	$0F, $0F, $0F, $07, $F0, $D0, $E0, $F1, $C0, $F2, $0F, $0F, $0F, $06, $F0, $E2
	dc.b	$F3, $D0, $F1, $0F, $0F, $0F, $04, $F0, $D9, $F0, $0F, $0F, $0F, $03, $FB, $0F ;0x200
	dc.b	$0F, $0F, $0F, $0F, $0A ;0x220
loc_13C44:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0D, $F7, $0F, $0F, $0F, $05, $F1, $C1, $A2, $C2, $F0
	dc.b	$0F, $0F, $0F, $03, $F0, $A2, $C0, $A4, $C1, $F0, $0F, $0F, $0F, $02, $F0, $A2 ;0x0 (0x00013C44-0x00013CE7, Entry count: 0xA3)
	dc.b	$C1, $B0, $A2, $C1, $F0, $0F, $0F, $0F, $01, $F0, $A1, $B1, $A1, $B1, $A1, $C0
	dc.b	$A0, $F0, $0F, $0F, $0F, $01, $F0, $A1, $B0, $F3, $30, $A3, $F0, $0F, $0F, $0F ;0x20
	dc.b	$01, $F0, $A1, $B2, $F1, $30, $F0, $A1, $F1, $0F, $0F, $0F, $01, $F0, $A2, $B2
	dc.b	$31, $B1, $F1, $0F, $0F, $0F, $02, $F1, $A1, $B5, $F0, $0F, $0F, $0F, $05, $F0 ;0x40
	dc.b	$A0, $F0, $B5, $F0, $0F, $0F, $0F, $05, $F2, $B1, $F3, $0F, $0F, $0F, $06, $F2
	dc.b	$B2, $F0, $0F, $0F, $0F, $07, $F1, $20, $F0, $B2, $F1, $0F, $0F, $0F, $05, $F1 ;0x60
	dc.b	$30, $F0, $10, $F1, $B0, $F0, $20, $F0, $0F, $0F, $0F, $03, $F0, $33, $F0, $11
	dc.b	$F1, $20, $F1, $0F, $0F, $0F, $01, $F0, $35, $F1, $10, $21, $F1, $0F, $0F, $0F ;0x80
	dc.b	$01, $F0, $37 ;0xA0
	dc.b	$F2, $31, $F0, $0F, $0F, $0F, $F0, $35, $F0, $36, $F0, $0F, $0F, $0F, $F0, $34
	dc.b	$F1, $36, $F0, $0F, $0F, $0F, $F0, $34, $F1, $36, $F0, $0F, $0F, $0E, $F1, $33 ;0x0 (0x00013CE7-0x00013EAB, Entry count: 0x1C4)
	dc.b	$F2, $37, $F0, $0F, $0F, $0D, $F0, $10, $F5, $36, $F0, $30, $F0, $0F, $0F, $0D
	dc.b	$F0, $14, $F1, $36, $F0, $30, $F0, $0F, $0F, $0E, $F4, $20, $F0, $36, $F2, $0F ;0x20
	dc.b	$0F, $0E, $F0, $B2, $F1, $36, $F2, $0F, $0F, $0F, $F1, $B2, $F0, $36, $F3, $0F
	dc.b	$0F, $0F, $F0, $B2, $F0, $36, $F0, $B1, $F1, $0F, $0F, $0E, $F1, $B2, $F0, $35 ;0x40
	dc.b	$F2, $B0, $F2, $0F, $0F, $0D, $F0, $B2, $F0, $35, $F3, $B1, $F1, $0F, $0F, $0C
	dc.b	$F1, $B1, $F0, $34, $F1, $00, $F1, $B2, $F0, $0F, $0F, $0D, $F0, $B2, $F6, $01 ;0x60
	dc.b	$F0, $B1, $F1, $0F, $0F, $0D, $F1, $B2, $F0, $E3, $F0, $01, $F0, $B0, $F1, $0F
	dc.b	$0F, $0F, $F0, $B3, $F0, $E3, $F0, $00, $F2, $0F, $0F, $0F, $00, $F0, $B3, $F0 ;0x80
	dc.b	$E3, $F0, $0F, $0F, $0F, $04, $F1, $B2, $F0, $E4, $F0, $0F, $0F, $0F, $03, $F0
	dc.b	$B2, $F1, $E4, $F0, $0F, $0F, $0F, $03, $F5, $E5, $F0, $0F, $0F, $0F, $01, $F7 ;0xA0
	dc.b	$E5, $F0, $0F, $0F, $0F, $00, $F7, $E5, $F0, $0F, $0F, $0F, $00, $F0, $E1, $F6
	dc.b	$E0, $F2, $D0, $F0, $0F, $0F, $0F, $00, $F9, $D2, $F1, $0F, $0F, $0F, $00, $F6 ;0xC0
	dc.b	$E2, $F4, $0F, $0F, $0F, $00, $F0, $B0, $F8, $B2, $F0, $0F, $0F, $0F, $F0, $B2
	dc.b	$F2, $01, $F1, $B3, $F0, $0F, $0F, $0F, $F0, $B2, $F2, $02, $F1, $B2, $F0, $0F ;0xE0
	dc.b	$0F, $0E, $F1, $B2, $F1, $03, $F1, $B2, $F0, $0F, $0F, $0E, $F0, $B3, $F1, $03
	dc.b	$F0, $B3, $F0, $0F, $0F, $0E, $F0, $B2, $F1, $04, $F0, $B3, $F0, $0F, $0F, $0D ;0x100
	dc.b	$F0, $B3, $F1, $04, $F0, $B3, $F0, $0F, $0F, $0D, $F0, $B2, $F1, $05, $F0, $B3
	dc.b	$F0, $0F, $0F, $0C, $F0, $B2, $F1, $06, $F1, $B2, $F0, $0F, $0F, $0C, $F0, $B2 ;0x120
	dc.b	$F0, $08, $F0, $B2, $F0, $0F, $0F, $0B, $F1, $B1, $F1, $08, $F0, $B2, $F0, $0F
	dc.b	$0F, $0A, $F0, $D1, $F2, $09, $F0, $B2, $F0, $0F, $0F, $09, $F0, $D4, $F0, $09 ;0x140
	dc.b	$F0, $B2, $F0, $0F, $0F, $09, $F0, $D0, $E1, $D0, $F0, $0A, $F0, $B0, $F3, $0F
	dc.b	$0F, $07, $F0, $D1, $E1, $F1, $0A, $F1, $D0, $C1, $F0, $0F, $0F, $07, $F0, $E3 ;0x160
	dc.b	$D0, $F1, $09, $F0, $D0, $C1, $D0, $F0, $01, $F3, $0F, $0F, $01, $F1, $D2, $E2
	dc.b	$F0, $08, $F0, $D2, $C0, $F2, $D0, $C1, $D0, $F0, $0F, $0F, $01, $F2, $D2, $E0 ;0x180
	dc.b	$D0, $F0, $07, $F0, $C0, $D1, $C1, $D5, $F0, $0F, $0F, $03, $F3, $D2, $F0, $06
	dc.b	$F0, $D6, $C1, $F1, $0F, $0F, $07, $F4, $06, $F0, $D0, $C4, $F2, $0F, $0F, $0F ;0x1A0
	dc.b	$05, $F6, $0F, $04 ;0x1C0
loc_13EAB:
	dc.b	$0F, $0D, $F7, $0F, $0F, $0F, $05, $F1, $C1, $A2, $C2, $F0, $0F, $0F, $0F, $03
	dc.b	$F0, $A2, $C0, $A4, $C1, $F0, $0F, $0F, $0F, $02, $F0, $A2, $C1, $B0, $A2, $C1 ;0x0 (0x00013EAB-0x00013F01, Entry count: 0x56)
	dc.b	$F0, $0F, $0F, $0F, $01, $F0, $A1, $B1, $A1, $B1, $A1, $C0, $A0, $F0, $0F, $0F
	dc.b	$0F, $01, $F0, $A1, $B0, $F3, $30, $A3, $F0, $0F, $0F, $0F, $01, $F0, $A1, $B2 ;0x20
	dc.b	$F1, $30, $F0, $A1, $F1, $0F, $0F, $0F, $01, $F1, $A1, $B2, $31, $B1, $F1, $0F
	dc.b	$0F, $0F, $03, $F0, $A1, $B5 ;0x40
	dc.b	$F0, $0F, $0F, $0F, $05, $F0, $A0, $F0, $B5, $F0, $0F, $0F, $0F, $05, $F2, $B1
	dc.b	$F3, $0F, $0F, $0F, $07, $F1, $B2, $F0, $0F, $0F, $0F, $08, $F0, $11, $F1, $B0 ;0x0 (0x00013F01-0x000140C0, Entry count: 0x1BF)
	dc.b	$F0, $0F, $0F, $0F, $07, $F0, $30, $F1, $11, $F2, $0F, $0F, $0F, $05, $F0, $33
	dc.b	$F1, $10, $20, $F0, $0F, $0F, $0F, $05, $F0, $35, $F1, $20, $F0, $0F, $0F, $0F ;0x20
	dc.b	$03, $F0, $38, $F1, $0F, $0F, $0F, $03, $F0, $39, $F0, $0F, $0F, $0F, $03, $F1
	dc.b	$38, $F0, $0F, $0F, $0F, $03, $F1, $38, $F0, $0F, $0F, $0F, $03, $F1, $35, $F0 ;0x40
	dc.b	$31, $F0, $0F, $0F, $0F, $03, $F2, $32, $F2, $31, $F0, $0F, $0F, $0F, $04, $F4
	dc.b	$12, $F0, $30, $F0, $0F, $0F, $0F, $04, $F1, $20, $11, $F3, $30, $F0, $0F, $0F ;0x60
	dc.b	$0F, $04, $F5, $B1, $F0, $30, $F0, $0F, $0F, $0F, $05, $F1, $B4, $F2, $0F, $0F
	dc.b	$0F, $05, $F0, $30, $F1, $B3, $F1, $0F, $0F, $0F, $05, $F0, $31, $F2, $B2, $F2 ;0x80
	dc.b	$0F, $0F, $0F, $03, $F0, $33, $F1, $B4, $F2, $0F, $0F, $0F, $00, $F0, $34, $F2
	dc.b	$B5, $F0, $0F, $0F, $0F, $F0, $31, $F6, $B4, $F0, $0F, $0F, $0F, $F0, $31, $F1 ;0xA0
	dc.b	$E2, $F2, $B2, $F1, $0F, $0F, $0F, $F0, $31, $F0, $E4, $F5, $0F, $0F, $0F, $00
	dc.b	$F0, $31, $F0, $E4, $F0, $0F, $0F, $0F, $05, $F3, $E4, $F0, $0F, $0F, $0F, $06 ;0xC0
	dc.b	$F2, $E4, $F1, $0F, $0F, $0F, $05, $F1, $E5, $F1, $0F, $0F, $0F, $05, $F1, $E4
	dc.b	$F2, $0F, $0F, $0F, $05, $F0, $E5, $F2, $0F, $0F, $0F, $05, $F0, $E5, $F2, $0F ;0xE0
	dc.b	$0F, $0F, $05, $FA, $0F, $0F, $0F, $04, $F0, $D4, $E1, $F2, $0F, $0F, $0F, $04
	dc.b	$FA, $0F, $0F, $0F, $05, $F0, $B3, $F4, $0F, $0F, $0F, $05, $F1, $B2, $F3, $0F ;0x100
	dc.b	$0F, $0F, $07, $F0, $B2, $F3, $0F, $0F, $0F, $06, $F0, $B3, $F2, $0F, $0F, $0F
	dc.b	$07, $F0, $B2, $F2, $0F, $0F, $0F, $07, $F0, $B3, $F1, $0F, $0F, $0F, $08, $F0 ;0x120
	dc.b	$B2, $F1, $0F, $0F, $0F, $07, $F1, $B3, $F0, $0F, $0F, $0F, $07, $F2, $B3, $F0
	dc.b	$0F, $0F, $0F, $05, $F1, $D0, $F1, $B2, $F1, $0F, $0F, $0F, $04, $F1, $E0, $D1 ;0x140
	dc.b	$F0, $B2, $F0, $0F, $0F, $0F, $05, $F0, $E2, $D0, $F0, $B2, $F0, $0F, $0F, $0F
	dc.b	$05, $F1, $E0, $D0, $E0, $F0, $B2, $F0, $0F, $0F, $0F, $06, $F0, $E0, $D0, $E0 ;0x160
	dc.b	$F0, $B0, $F2, $0F, $0F, $0F, $06, $F1, $E0, $F2, $C1, $F0, $0F, $0F, $0F, $07
	dc.b	$F0, $E0, $F0, $D0, $C1, $D0, $F0, $0F, $0F, $0F, $07, $F2, $D2, $C0, $F0, $0F ;0x180
	dc.b	$0F, $0F, $08, $F1, $C0, $D1, $C1, $F2, $0F, $0F, $0F, $05, $F0, $D6, $C1, $F1
	dc.b	$0F, $0F, $0F, $03, $F0, $D0, $C9, $F0, $0F, $0F, $0F, $02, $FC, $0F, $0A ;0x1A0
loc_140C0:
	dc.b	$0F, $0F, $0F ;0x0 (0x000140C0-0x000140C3, Entry count: 0x3)
	dc.b	$0F, $0F, $0E, $F7, $0F, $0F, $0F, $05, $F1, $C1, $A2, $C2, $F0, $0F, $0F, $0F
	dc.b	$03, $F0, $A2, $C0, $A4, $C1, $F0, $0F, $0F, $0F, $02, $F0, $A3, $C0, $A0, $B0 ;0x0 (0x000140C3-0x0001431E, Entry count: 0x25B)
	dc.b	$A2, $C0, $F0, $0F, $0F, $0F, $01, $F0, $A2, $B1, $A0, $B2, $A2, $F0, $0F, $0F
	dc.b	$0F, $01, $F0, $A1, $F0, $B0, $F3, $31, $A1, $F0, $0F, $0F, $0F, $01, $F0, $A1 ;0x20
	dc.b	$F0, $B2, $F1, $30, $F0, $A0, $F1, $0F, $0F, $0F, $01, $F1, $A1, $B3, $31, $B0
	dc.b	$F1, $0F, $0F, $0F, $03, $F0, $A1, $B5, $F0, $0F, $0F, $0F, $05, $F0, $A0, $F0 ;0x40
	dc.b	$B5, $F0, $0F, $0F, $0F, $05, $F2, $B2, $F3, $0F, $0F, $0F, $04, $F3, $B2, $F0
	dc.b	$0F, $0F, $0F, $06, $F1, $20, $11, $F3, $0F, $0F, $0F, $05, $F5, $11, $21, $F0 ;0x60
	dc.b	$0F, $0F, $0F, $03, $F0, $30, $F0, $33, $F4, $0F, $0F, $0F, $03, $F0, $30, $F0
	dc.b	$36, $F2, $0F, $0F, $0F, $01, $F0, $30, $F0, $39, $F0, $0F, $0F, $0F, $01, $F0 ;0x80
	dc.b	$30, $F0, $3A, $F0, $0F, $0F, $0F, $F0, $31, $F0, $32, $F0, $36, $F0, $0F, $0F
	dc.b	$0F, $F0, $31, $F0, $31, $F3, $34, $F0, $0F, $0F, $0F, $F0, $31, $F0, $32, $F2 ;0xA0
	dc.b	$34, $F1, $0F, $0F, $0E, $F3, $33, $F2, $31, $F1, $10, $F0, $0F, $0F, $0E, $F0
	dc.b	$20, $F1, $33, $F4, $11, $F1, $0F, $0F, $0E, $F3, $34, $F1, $20, $10, $F1, $B0 ;0xC0
	dc.b	$F0, $0F, $0F, $0E, $F0, $B1, $F0, $34, $F0, $20, $F2, $B2, $F0, $0F, $0F, $0D
	dc.b	$F1, $B0, $F0, $35, $F3, $B3, $F0, $0F, $0F, $0C, $F1, $B0, $F0, $36, $F4, $B2 ;0xE0
	dc.b	$F0, $0F, $0F, $0C, $F2, $36, $F2, $00, $F1, $B2, $F1, $0F, $0F, $0A, $F2, $36
	dc.b	$F2, $01, $F2, $B2, $F0, $0F, $0F, $0A, $F1, $35, $F2, $04, $F0, $B3, $F0, $0F ;0x100
	dc.b	$0F, $09, $F1, $32, $F5, $04, $F1, $B2, $F0, $0F, $0F, $0A, $F0, $31, $F1, $E1
	dc.b	$F2, $05, $F0, $B2, $F0, $0F, $0F, $0A, $F0, $31, $F0, $E3, $F2, $04, $F1, $B0 ;0x120
	dc.b	$F1, $0F, $0F, $09, $F0, $31, $F1, $E3, $F2, $05, $F2, $0F, $0F, $0A, $F3, $E4
	dc.b	$F2, $0F, $0F, $0F, $04, $F1, $E4, $F3, $0F, $0F, $0F, $04, $F0, $E5, $F4, $0F ;0x140
	dc.b	$0F, $0F, $03, $F0, $E5, $F4, $0F, $0F, $0F, $03, $F0, $E5, $F4, $0F, $0F, $0F
	dc.b	$02, $F3, $E2, $F6, $0F, $0F, $0F, $01, $F0, $D2, $F9, $0F, $0F, $0F, $01, $F3 ;0x160
	dc.b	$D1, $E1, $F5, $0F, $0F, $0F, $02, $F9, $B0, $F1, $0F, $0F, $0F, $02, $F0, $B3
	dc.b	$F3, $B2, $F0, $0F, $0F, $0F, $02, $F0, $B2, $F4, $B2, $F0, $0F, $0F, $0F, $01 ;0x180
	dc.b	$F0, $B3, $F1, $01, $F0, $B3, $F0, $0F, $0F, $0F, $F0, $B3, $F1, $02, $F0, $B3
	dc.b	$F0, $0F, $0F, $0E, $F0, $B4, $F0, $03, $F0, $B3, $F0, $0F, $0F, $0E, $F0, $B3 ;0x1A0
	dc.b	$F1, $03, $F0, $B3, $F0, $0F, $0F, $0D, $F0, $B3, $F1, $04, $F1, $B2, $F0, $0F
	dc.b	$0F, $0D, $F0, $B2, $F1, $05, $F1, $B2, $F0, $0F, $0F, $0C, $F0, $B2, $F1, $07 ;0x1C0
	dc.b	$F0, $B2, $F0, $0F, $0F, $0C, $F0, $B2, $F0, $08, $F0, $B2, $F0, $0F, $0F, $0B
	dc.b	$F0, $B2, $F1, $08, $F1, $B1, $F0, $0F, $0F, $0A, $F2, $B0, $F1, $09, $F1, $B0 ;0x1E0
	dc.b	$F2, $0F, $0F, $09, $F0, $C1, $F2, $09, $F2, $D1, $F0, $0F, $0F, $08, $F0, $D0
	dc.b	$C2, $F0, $0A, $F0, $E0, $D1, $E0, $F0, $0F, $0F, $08, $F0, $D3, $F0, $0A, $F0 ;0x200
	dc.b	$E2, $D0, $F6, $0F, $0F, $01, $F0, $C1, $D1, $C0, $F0, $0A, $F0, $D0, $E1, $D1
	dc.b	$E2, $D1, $F0, $0F, $0F, $01, $F0, $D3, $C1, $F1, $08, $F0, $E5, $D2, $F0, $0F ;0x220
	dc.b	$0F, $02, $F0, $D0, $C2, $D2, $C0, $F1, $06, $F0, $D5, $F2, $0F, $0F, $03, $F3
	dc.b	$C6, $F0, $05, $F6, $0F, $0F, $09, $F8, $0F, $0F, $03 ;0x240
loc_1431E:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $F7, $0F, $0F, $0F, $05, $F1, $B3
	dc.b	$F1, $B1, $F1, $0F, $0F, $0F, $00, $F2, $B1, $F2, $B2, $F1, $B1, $F0, $0F, $0F ;0x0 (0x0001431E-0x000145FF, Entry count: 0x2E1)
	dc.b	$0E, $F0, $B2, $F6, $B1, $F1, $B0, $F0, $0F, $0F, $0E, $F1, $B0, $F3, $02, $F0
	dc.b	$B1, $F0, $B1, $F0, $0F, $0F, $0F, $F2, $05, $F0, $B1, $F0, $B0, $F0, $0F, $0F ;0x20
	dc.b	$0F, $09, $F0, $B0, $F3, $0F, $0F, $0F, $08, $F0, $B5, $F0, $0F, $0F, $0F, $06
	dc.b	$F0, $B1, $A4, $B0, $F0, $0F, $0F, $0F, $04, $F0, $B1, $A6, $B0, $F0, $0F, $0F ;0x40
	dc.b	$0F, $00, $FF, $0F, $0F, $0D, $FA, $E2, $F3, $0F, $0F, $0F, $00, $F1, $B2, $F1
	dc.b	$E0, $D0, $C0, $D0, $E0, $F2, $0F, $0F, $0F, $00, $F0, $B2, $A2, $B5, $F0, $0F ;0x60
	dc.b	$0F, $0F, $00, $F0, $B2, $A8, $B0, $F0, $0F, $0F, $0F, $00, $F0, $B1, $A6, $B0
	dc.b	$F3, $0F, $0F, $0F, $F0, $B2, $A7, $B2, $F0, $0F, $0F, $0F, $F0, $B1, $AB, $B0 ;0x80
	dc.b	$F0, $0F, $0F, $0D, $F0, $B3, $AA, $B0, $F0, $0F, $0F, $0D, $F1, $B0, $A2, $B0
	dc.b	$A9, $B0, $F1, $0F, $0F, $0A, $F1, $B0, $A5, $B0, $A8, $B1, $F0, $0F, $0F, $09 ;0xA0
	dc.b	$F0, $B0, $A6, $F0, $B0, $A8, $B1, $F0, $0F, $0F, $07, $F0, $B0, $A7, $F0, $B0
	dc.b	$A9, $B1, $F1, $04, $F1, $0F, $0D, $F0, $B0, $A7, $B0, $F0, $B0, $AA, $B2, $F4 ;0xC0
	dc.b	$B1, $F1, $0F, $0B, $F0, $B0, $A6, $B0, $F0, $B0, $AC, $B2, $F1, $B1, $A1, $B1
	dc.b	$F0, $0F, $09, $F0, $B0, $A6, $B0, $F0, $B1, $AD, $B2, $F1, $A2, $B1, $F0, $0F ;0xE0
	dc.b	$09, $F0, $B0, $A6, $B0, $F0, $B0, $AF, $B2, $F0, $B0, $A0, $B2, $F0, $0F, $08
	dc.b	$F0, $B0, $A6, $B0, $F0, $B1, $AF, $A0, $B2, $F0, $B2, $F1, $0F, $08, $F0, $B0 ;0x100
	dc.b	$A5, $B0, $F0, $B1, $AF, $A1, $B2, $F4, $0F, $09, $F0, $B0, $A5, $B0, $F0, $B0
	dc.b	$AF, $A3, $B2, $F0, $0F, $0C, $F0, $B0, $A4, $B0, $F0, $B1, $AF, $A3, $B2, $F0 ;0x120
	dc.b	$0F, $0C, $F0, $B1, $A3, $B0, $F0, $B0, $AF, $A3, $B0, $A0, $B2, $F0, $0F, $0B
	dc.b	$F1, $B0, $A3, $B0, $F0, $B0, $AF, $A1, $B0, $F1, $A0, $B2, $F0, $0F, $0C, $F0 ;0x140
	dc.b	$B1, $A2, $B0, $F0, $B0, $AF, $A5, $B2, $F0, $0F, $0C, $F1, $B1, $A2, $B0, $F0
	dc.b	$AF, $A4, $B2, $F1, $0F, $0D, $F2, $B1, $A1, $B0, $F0, $AF, $A3, $B2, $F0, $0F ;0x160
	dc.b	$0F, $00, $F1, $B1, $A0, $B0, $F0, $AF, $A2, $B2, $F1, $0F, $0F, $01, $F2, $B1
	dc.b	$F0, $AF, $A0, $B3, $F2, $0F, $0F, $03, $F3, $B3, $A9, $B5, $F1, $30, $F1, $0F ;0x180
	dc.b	$0F, $02, $F6, $BC, $F3, $33, $F0, $0F, $0F, $02, $F0, $70, $F1, $32, $FE, $35
	dc.b	$F0, $0F, $0F, $02, $F0, $70, $F1, $32, $F1, $39, $F0, $61, $F0, $34, $F0, $0F ;0x1A0
	dc.b	$0F, $02, $F3, $31, $F0, $61, $F0, $37, $F0, $63, $F0, $32, $F1, $0F, $0F, $02
	dc.b	$F3, $30, $F0, $63, $F0, $37, $F0, $61, $F0, $33, $F0, $0F, $0F, $04, $F5, $61 ;0x1C0
	dc.b	$F0, $39, $F1, $34, $F0, $0F, $0F, $03, $F8, $32, $F3, $35, $F1, $31, $F1, $0F
	dc.b	$0F, $03, $F7, $32, $F0, $63, $F0, $33, $F0, $71, $F2, $0F, $0F, $03, $FF, $F0 ;0x1E0
	dc.b	$35, $F4, $09, $F4, $0F, $04, $F1, $B1, $FB, $35, $F6, $07, $F0, $D0, $C2, $D0
	dc.b	$F0, $0F, $01, $F2, $B4, $FA, $32, $F5, $B2, $F0, $05, $F0, $D0, $C4, $D0, $F0 ;0x200
	dc.b	$0F, $F0, $D1, $F2, $B1, $F1, $08, $F8, $B1, $A0, $B1, $F1, $01, $F3, $D0, $C3
	dc.b	$D0, $F0, $0E, $F2, $D1, $F4, $0E, $F3, $B0, $A3, $B0, $F4, $D1, $F0, $D0, $C2 ;0x220
	dc.b	$E0, $D0, $F0, $0C, $F2, $D0, $F0, $D0, $E1, $F1, $0F, $00, $F2, $B1, $A1, $B1
	dc.b	$F0, $E0, $F2, $E0, $D0, $F0, $D0, $C1, $D0, $E0, $D0, $F0, $0B, $F0, $D0, $F0 ;0x240
	dc.b	$E0, $D1, $F2, $E0, $F0, $0F, $02, $F1, $B3, $F1, $E0, $F3, $E0, $F1, $D1, $E0
	dc.b	$D0, $F0, $0C, $F0, $D1, $F0, $D0, $F7, $00, $F3, $0C, $F4, $C0, $D0, $F8, $E0 ;0x260
	dc.b	$C0, $F0, $0E, $F0, $D1, $F5, $E1, $F1, $E0, $D1, $E0, $F0, $0B, $F2, $C1, $F5
	dc.b	$E0, $F2, $E0, $C0, $F0, $0F, $F1, $D1, $F4, $E0, $F1, $E0, $D3, $E0, $F0, $0A ;0x280
	dc.b	$F0, $D1, $F1, $C0, $F6, $E0, $C1, $F0, $0F, $01, $F1, $E2, $F6, $D3, $E0, $F0
	dc.b	$0A, $F3, $C2, $F3, $E0, $C1, $F1, $0F, $04, $F1, $E2, $FA, $0B, $F3, $D0, $F2 ;0x2A0
	dc.b	$E0, $C1, $F1, $0F, $08, $F1, $E0, $D1, $E1, $D5, $E0, $F0, $0B, $F4, $E0, $C1
	dc.b	$F1, $0F, $0C, $FB, $0C, $F0, $E0, $D1, $C1, $F1, $0F, $0F, $0F, $08, $F4, $0F ;0x2C0
	dc.b	$01 ;0x2E0
loc_145FF:
	dc.b	$0F, $01, $F3, $00, $F2, $0F, $0F, $0F, $05, $F1, $B3, $F1, $B1, $F0, $0F, $0F
	dc.b	$0F, $03, $F0, $B1, $F2, $B2, $F0, $B0, $F0, $0F, $0F, $0F, $02, $F0, $B0, $F1 ;0x0 (0x000145FF-0x000148A3, Entry count: 0x2A4)
	dc.b	$B0, $F3, $B0, $F0, $B1, $F0, $0F, $0F, $0F, $00, $F0, $B1, $F0, $B0, $F1, $01
	dc.b	$F0, $B1, $F0, $B0, $F0, $0F, $0F, $0F, $00, $F0, $B1, $F2, $02, $F0, $B1, $F0 ;0x20
	dc.b	$B0, $F0, $0F, $0F, $0F, $01, $F1, $05, $F0, $B1, $F0, $B0, $F0, $0F, $0F, $0F
	dc.b	$08, $F0, $B1, $F4, $0F, $0F, $0F, $06, $F0, $B6, $F1, $0F, $0F, $0F, $04, $F0 ;0x40
	dc.b	$B2, $A4, $B0, $F0, $0F, $0F, $0F, $03, $F1, $B1, $A5, $B0, $F1, $0F, $0F, $0F
	dc.b	$00, $FF, $0F, $0F, $0D, $FA, $E2, $F3, $0F, $0F, $0F, $00, $F1, $B2, $F1, $E0 ;0x60
	dc.b	$D0, $C0, $D0, $E0, $F2, $0F, $0F, $0F, $F1, $B1, $A3, $B5, $F0, $0F, $0F, $0F
	dc.b	$00, $F0, $B1, $A9, $B0, $F0, $0F, $0F, $0F, $00, $F0, $B1, $A6, $B0, $F3, $0F ;0x80
	dc.b	$0F, $0F, $F0, $B1, $A8, $B2, $F0, $0F, $0F, $0F, $F0, $B1, $AA, $F1, $0F, $0F
	dc.b	$0E, $F0, $B1, $A1, $B1, $A8, $B0, $F0, $0F, $0F, $0D, $F0, $B1, $F0, $B0, $A2 ;0xA0
	dc.b	$B0, $A7, $B0, $F1, $0F, $0F, $0A, $F0, $B1, $F0, $B0, $A4, $B0, $A7, $B1, $F0
	dc.b	$0F, $0F, $09, $F0, $B0, $F0, $B0, $A5, $B1, $A7, $B1, $F0, $0F, $0F, $08, $F0 ;0xC0
	dc.b	$B0, $F0, $B0, $A5, $B0, $F0, $A8, $B1, $F1, $0F, $0F, $06, $F1, $B0, $A6, $B0
	dc.b	$F0, $AA, $B1, $F0, $0F, $0F, $05, $F1, $B0, $A5, $B1, $F0, $AB, $B1, $F0, $0F ;0xE0
	dc.b	$0F, $04, $F1, $B0, $A5, $B0, $F1, $AC, $B1, $F0, $0F, $0F, $03, $F1, $B0, $A5
	dc.b	$B0, $F0, $B0, $AD, $B1, $F0, $0F, $0F, $02, $F1, $B0, $A5, $B0, $F0, $B0, $AE ;0x100
	dc.b	$B1, $F0, $0F, $0F, $01, $F1, $B0, $A5, $B0, $F0, $B0, $AE, $B1, $F0, $0F, $0F
	dc.b	$01, $F1, $B0, $A5, $B0, $F0, $B0, $AF, $B1, $F0, $0F, $0F, $00, $F1, $B0, $A6 ;0x120
	dc.b	$B0, $F0, $B0, $AD, $B2, $F0, $0F, $0F, $00, $F1, $B1, $A5, $B0, $F0, $B0, $AB
	dc.b	$B0, $F1, $B1, $F0, $0F, $0F, $00, $F2, $B2, $A4, $B0, $F0, $B0, $AD, $B1, $F0 ;0x140
	dc.b	$0F, $0F, $00, $F4, $B2, $A3, $B0, $F1, $B0, $AB, $B1, $F0, $0F, $0F, $00, $F2
	dc.b	$B0, $F3, $B2, $A1, $B1, $F0, $B0, $A9, $B1, $F1, $0F, $0F, $01, $F1, $B3, $F3 ;0x160
	dc.b	$B1, $F2, $B0, $A8, $B2, $F1, $0F, $0F, $02, $F1, $B5, $F3, $B1, $A7, $B2, $F2
	dc.b	$0F, $0F, $04, $F2, $B7, $A5, $B4, $F1, $30, $F1, $0F, $0F, $04, $F4, $BC, $F3 ;0x180
	dc.b	$32, $F1, $0F, $0F, $03, $F2, $31, $FF, $F1, $32, $F1, $0F, $0F, $03, $F2, $34
	dc.b	$F1, $39, $F0, $61, $F0, $31, $F1, $0F, $0F, $03, $F2, $33, $F0, $61, $F0, $37 ;0x1A0
	dc.b	$F0, $63, $F3, $0F, $0F, $03, $F2, $32, $F0, $63, $F0, $37, $F0, $61, $F0, $30
	dc.b	$F1, $0F, $0F, $04, $F2, $33, $F0, $61, $F0, $39, $F1, $31, $F1, $0F, $0F, $04 ;0x1C0
	dc.b	$F3, $33, $F1, $34, $F1, $35, $F2, $0F, $0F, $06, $F4, $37, $F0, $61, $F0, $31
	dc.b	$F5, $0F, $0F, $06, $F6, $34, $F0, $63, $F4, $E1, $F1, $0F, $0F, $07, $FB, $61 ;0x1E0
	dc.b	$F3, $E1, $D1, $E0, $F1, $0F, $0F, $09, $FD, $E1, $D2, $E1, $F0, $0F, $0F, $09
	dc.b	$F0, $E0, $F1, $B4, $F4, $E1, $D1, $E2, $F0, $0F, $0F, $09, $F2, $B2, $A0, $B0 ;0x200
	dc.b	$F6, $E2, $F3, $0F, $0F, $0B, $F0, $B0, $A2, $B0, $F0, $E1, $F6, $E1, $F1, $0F
	dc.b	$0F, $0A, $F2, $A1, $B0, $F3, $E6, $F1, $0F, $0F, $0C, $F0, $E1, $F2, $D1, $F0 ;0x220
	dc.b	$00, $F6, $0F, $0F, $0D, $F3, $D2, $F2, $03, $F4, $0F, $0F, $0C, $F2, $C0, $F2
	dc.b	$D1, $F4, $D0, $C1, $D1, $F0, $0F, $0F, $0A, $F0, $E0, $F0, $D0, $C1, $F1, $D0 ;0x240
	dc.b	$F1, $D1, $F0, $D0, $C3, $D1, $F0, $0F, $0F, $08, $F0, $C1, $F1, $D0, $F5, $D1
	dc.b	$F0, $D0, $C3, $D1, $F0, $0F, $0F, $08, $F1, $C1, $E0, $F9, $D0, $C3, $D1, $F0 ;0x260
	dc.b	$0F, $0F, $09, $F2, $C1, $E0, $F6, $D0, $C3, $D0, $F1, $D0, $F0, $0F, $0F, $0A
	dc.b	$F2, $D1, $E0, $FA, $C0, $D0, $F1, $0F, $0F, $0C, $F2, $D3, $C7, $F2, $0F, $0F ;0x280
	dc.b	$0F, $FD, $0F, $07 ;0x2A0
loc_148A3:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0B, $F3, $00, $F2, $0F, $0F, $0F, $05
	dc.b	$F1, $B3, $F1, $B1, $F0, $0F, $0F, $0F, $03, $F0, $B1, $F2, $B2, $F0, $B1, $F0 ;0x0 (0x000148A3-0x00014BB7, Entry count: 0x314)
	dc.b	$0F, $0F, $0F, $01, $F0, $B1, $F1, $B0, $F2, $B1, $F0, $B0, $F0, $0F, $0F, $0F
	dc.b	$01, $F0, $B1, $F0, $B0, $F1, $01, $F0, $B1, $F0, $B0, $F0, $0F, $0F, $0F, $00 ;0x20
	dc.b	$F0, $B1, $F2, $02, $F0, $B1, $F0, $B0, $F0, $0F, $0F, $0F, $01, $F1, $05, $F0
	dc.b	$B1, $F0, $B0, $F0, $0F, $0F, $0F, $09, $F1, $B1, $F2, $0F, $0F, $0F, $07, $F0 ;0x40
	dc.b	$B5, $F1, $0F, $0F, $0F, $05, $F1, $B1, $A3, $B1, $F0, $0F, $0F, $0F, $04, $F1
	dc.b	$B0, $A5, $B1, $F0, $0F, $0F, $0F, $03, $F0, $B1, $A1, $F7, $0F, $0F, $0F, $01 ;0x60
	dc.b	$F7, $E2, $F3, $0F, $0F, $0E, $F8, $E0, $D0, $C0, $D0, $E0, $F2, $0F, $0F, $0F
	dc.b	$00, $F1, $BA, $F0, $0F, $0F, $0F, $01, $F0, $B2, $A7, $B0, $F1, $0F, $0F, $0F ;0x80
	dc.b	$F1, $B1, $A5, $B0, $F4, $0F, $0F, $0F, $F0, $B2, $A6, $B2, $F1, $0F, $0F, $0F
	dc.b	$F0, $B1, $AB, $B0, $F0, $0F, $0F, $0E, $F0, $B1, $AC, $B0, $F1, $0F, $0F, $0C ;0xA0
	dc.b	$F0, $B1, $AD, $B1, $F1, $0F, $0F, $09, $F0, $B2, $A2, $B3, $A8, $B1, $F0, $0F
	dc.b	$0F, $08, $F0, $B2, $A2, $B1, $F1, $B0, $A8, $B1, $F1, $0F, $0F, $06, $F0, $B1 ;0xC0
	dc.b	$A6, $B0, $F0, $B0, $A8, $B2, $F0, $0F, $0F, $04, $F1, $B1, $A7, $B0, $F1, $B0
	dc.b	$A8, $B1, $F1, $0F, $0F, $02, $F1, $B2, $A8, $B0, $F1, $B0, $A7, $B2, $F0, $0F ;0xE0
	dc.b	$0F, $00, $F0, $B0, $F1, $B1, $AA, $B0, $F1, $B0, $A7, $B1, $F0, $0F, $0F, $F0
	dc.b	$B1, $F0, $B2, $AB, $B0, $F1, $B0, $A6, $B1, $F0, $0F, $0D, $F0, $B2, $F0, $B1 ;0x100
	dc.b	$F0, $B0, $AC, $B0, $F1, $A5, $B2, $F0, $0F, $0C, $F0, $B0, $A0, $B0, $F0, $B2
	dc.b	$F0, $B2, $AB, $B1, $A5, $F0, $B0, $F0, $0F, $0B, $F0, $B1, $A0, $B0, $F1, $B2 ;0x120
	dc.b	$F1, $B3, $A9, $F0, $B0, $A2, $B0, $F1, $B1, $F0, $0F, $0A, $F0, $B0, $A2, $B0
	dc.b	$F0, $B4, $F2, $B4, $A5, $B0, $F0, $B0, $A4, $B1, $F0, $0F, $0A, $F0, $B0, $A1 ;0x140
	dc.b	$B1, $F1, $B1, $A3, $B0, $F2, $B4, $A3, $F0, $B0, $A4, $B1, $F0, $0F, $0A, $F0
	dc.b	$B0, $A1, $B0, $F2, $B2, $A5, $B0, $F2, $B2, $A3, $F0, $A3, $B2, $F0, $0F, $0A ;0x160
	dc.b	$F0, $B0, $A0, $B1, $F2, $B2, $A8, $B0, $F1, $B1, $A2, $F0, $A3, $B1, $F0, $0F
	dc.b	$0B, $F0, $B0, $A0, $B0, $F1, $00, $F1, $B3, $A9, $F1, $B0, $A1, $F0, $A2, $B2 ;0x180
	dc.b	$F1, $0F, $0A, $F0, $B2, $F1, $01, $F1, $B3, $A8, $B0, $F0, $B0, $A0, $B0, $F0
	dc.b	$A0, $B3, $F2, $0F, $0A, $F0, $B2, $F0, $03, $F1, $B4, $A7, $B0, $F0, $B0, $F0 ;0x1A0
	dc.b	$B3, $F5, $0F, $09, $F1, $B0, $F1, $04, $F1, $B6, $A3, $B2, $F1, $B0, $F3, $31
	dc.b	$F2, $0F, $0A, $F2, $05, $F4, $B6, $F9, $33, $F1, $08, $F2, $0F, $07, $F3, $30 ;0x1C0
	dc.b	$F8, $33, $F0, $61, $F0, $32, $F2, $06, $F1, $E2, $F0, $0F, $06, $F3, $31, $F1
	dc.b	$38, $F0, $63, $F0, $31, $F2, $05, $F0, $E0, $D2, $F0, $E0, $F0, $0F, $05, $F3 ;0x1E0
	dc.b	$30, $F0, $61, $F0, $38, $F0, $61, $F0, $30, $F1, $B0, $F0, $05, $F0, $E0, $D4
	dc.b	$F0, $E0, $F0, $0F, $05, $F3, $63, $F0, $38, $F1, $31, $F0, $B2, $F0, $04, $F0 ;0x200
	dc.b	$E1, $D3, $F0, $E0, $F0, $0F, $05, $F4, $61, $F0, $35, $F2, $32, $F2, $B2, $F0
	dc.b	$03, $F3, $E0, $D1, $E0, $F2, $0F, $05, $F6, $33, $F4, $32, $F3, $B3, $F0, $02 ;0x220
	dc.b	$F1, $D1, $F0, $E1, $F0, $D0, $F0, $0F, $06, $F4, $31, $F1, $62, $F1, $32, $F6
	dc.b	$B3, $F5, $D0, $F0, $E0, $F0, $D0, $F1, $0F, $05, $F0, $B0, $FF, $F0, $02, $F3 ;0x240
	dc.b	$B1, $F0, $E0, $F2, $D0, $F3, $D0, $F1, $0F, $05, $F0, $B0, $A0, $B1, $FB, $07
	dc.b	$F2, $B0, $F0, $E0, $F6, $D0, $F1, $0F, $05, $F0, $B0, $A2, $B1, $F7, $0B, $F2 ;0x260
	dc.b	$E0, $F6, $D0, $F1, $0F, $05, $F0, $E0, $F1, $A1, $B1, $F1, $0F, $02, $F0, $E1
	dc.b	$F0, $D0, $F3, $D0, $F1, $0F, $05, $F2, $D0, $F1, $B1, $F1, $0F, $04, $F1, $D2 ;0x280
	dc.b	$F1, $D0, $F1, $0F, $05, $F4, $D1, $F2, $0F, $05, $F2, $D0, $F1, $D0, $F1, $0F
	dc.b	$06, $F1, $C1, $F2, $E1, $F0, $02, $F4, $0E, $F2, $D1, $F1, $0F, $06, $F0, $C0 ;0x2A0
	dc.b	$F0, $D0, $C0, $F8, $D0, $C1, $D1, $F0, $0D, $F0, $E2, $F1, $0F, $07, $F0, $C0
	dc.b	$F4, $D0, $F1, $D1, $F0, $D0, $C3, $D1, $F0, $0D, $F3, $0F, $08, $F1, $C0, $F6 ;0x2C0
	dc.b	$D1, $F0, $D0, $C3, $D1, $F0, $0F, $0F, $0B, $F1, $C0, $F8, $D0, $C3, $D1, $F0
	dc.b	$0F, $0F, $0C, $F1, $C1, $F5, $D0, $C3, $D0, $F1, $D0, $F0, $0F, $0F, $0C, $F2 ;0x2E0
	dc.b	$C1, $F9, $C0, $D0, $F1, $0F, $0F, $0E, $F2, $D1, $C7, $F2, $0F, $0F, $0F, $01
	dc.b	$FB, $0F, $0F, $00 ;0x300
loc_14BB7:
	dc.b	$0F, $0F, $0F, $0F, $0C, $F9, $0F, $0F, $0F, $05, $F0, $B0, $F1, $B3, $F3, $0F
	dc.b	$0F, $0F, $03, $F1, $B1, $F2, $B2, $F0, $B0, $F0, $0F, $0F, $0F, $01, $F1, $B1 ;0x0 (0x00014BB7-0x00014E4E, Entry count: 0x297)
	dc.b	$F0, $02, $F1, $B1, $F1, $0F, $0F, $0F, $00, $F0, $B2, $F0, $04, $F0, $B1, $F0
	dc.b	$B0, $F0, $0F, $0F, $0F, $00, $F0, $B0, $F0, $05, $F0, $B1, $F0, $B0, $F0, $0F ;0x20
	dc.b	$0F, $0F, $00, $F1, $06, $F0, $B1, $F0, $B0, $F0, $0F, $0F, $0F, $08, $F0, $B1
	dc.b	$F4, $0F, $0F, $0F, $06, $F0, $B6, $F1, $0F, $0F, $0F, $04, $F1, $B1, $A4, $B0 ;0x40
	dc.b	$F0, $0F, $0F, $0F, $03, $F1, $B1, $A5, $B0, $F1, $0F, $0F, $0F, $00, $FF, $0F
	dc.b	$0F, $0D, $FA, $E2, $F3, $0F, $0F, $0F, $00, $F1, $B2, $F1, $E0, $D0, $C0, $D0 ;0x60
	dc.b	$E0, $F2, $0F, $0F, $0F, $00, $F0, $B2, $A2, $B5, $F0, $0F, $0F, $0F, $00, $F0
	dc.b	$B2, $A8, $B0, $F0, $0F, $0F, $0F, $00, $F0, $B1, $A6, $B0, $F3, $0F, $0F, $0F ;0x80
	dc.b	$00, $F0, $B1, $A7, $B2, $F0, $0F, $0F, $0F, $F0, $B1, $AB, $B0, $F0, $0F, $0F
	dc.b	$0E, $F0, $B1, $A0, $B3, $A7, $B0, $F0, $0F, $0F, $0D, $F0, $B0, $A0, $B0, $F0 ;0xA0
	dc.b	$B0, $A2, $B0, $A6, $B0, $F1, $0F, $0F, $0A, $F1, $B1, $F0, $B0, $A4, $B0, $A6
	dc.b	$B1, $F0, $0F, $0F, $09, $F0, $B1, $F0, $B0, $A5, $B1, $A6, $B1, $F0, $0F, $0F ;0xC0
	dc.b	$08, $F0, $B1, $F0, $B0, $A4, $B0, $F0, $B0, $A7, $B1, $F0, $0F, $0F, $07, $F0
	dc.b	$B0, $F0, $B0, $A5, $B0, $F0, $B0, $A8, $B1, $F0, $0F, $0F, $06, $F0, $B0, $F0 ;0xE0
	dc.b	$B0, $A5, $B0, $F0, $B0, $A9, $B1, $F0, $0F, $0F, $05, $F0, $B0, $F0, $B0, $A5
	dc.b	$B0, $F0, $AB, $B1, $F0, $0F, $0F, $04, $F0, $B0, $F0, $B0, $A5, $B0, $F0, $AC ;0x100
	dc.b	$B1, $F0, $0F, $0F, $03, $F0, $B0, $F0, $B0, $A5, $B0, $F0, $AD, $B1, $F0, $0F
	dc.b	$0F, $02, $F0, $B0, $F0, $B0, $A5, $B0, $F0, $AD, $B2, $F0, $0F, $0F, $01, $F2 ;0x120
	dc.b	$B0, $A4, $B1, $F0, $AE, $B1, $F0, $0F, $0F, $02, $F1, $B0, $A4, $B0, $F1, $AE
	dc.b	$B2, $F0, $0F, $0F, $01, $F1, $B0, $A4, $B0, $F0, $B0, $AC, $B0, $F1, $B1, $F0 ;0x140
	dc.b	$0F, $0F, $01, $F1, $B0, $A3, $B1, $F0, $B0, $AE, $B2, $F0, $0F, $0F, $00, $F1
	dc.b	$B0, $A4, $B0, $F1, $AE, $B2, $F1, $0F, $0F, $00, $F1, $B0, $A3, $B1, $F0, $B0 ;0x160
	dc.b	$AE, $B2, $F0, $0F, $0F, $00, $F1, $B0, $A3, $B1, $F1, $B0, $AC, $B3, $F2, $0F
	dc.b	$0F, $F0, $B0, $A2, $B2, $F1, $B0, $AA, $B4, $F4, $0F, $0F, $F0, $B4, $F2, $B0 ;0x180
	dc.b	$A5, $B6, $F3, $31, $F2, $0F, $0F, $00, $F9, $B5, $F9, $32, $F1, $0F, $0F, $04
	dc.b	$FC, $34, $F0, $61, $F0, $32, $F1, $0F, $0F, $04, $F2, $32, $F3, $36, $F0, $63 ;0x1A0
	dc.b	$F0, $31, $F1, $0F, $0F, $04, $F8, $63, $F0, $33, $F0, $61, $F0, $31, $F1, $0F
	dc.b	$0F, $06, $FC, $34, $F1, $32, $F1, $0F, $0F, $06, $F5, $B2, $F2, $36, $F4, $0F ;0x1C0
	dc.b	$0F, $08, $F2, $B6, $F3, $32, $F0, $71, $F1, $0F, $0F, $08, $F0, $E0, $D0, $F0
	dc.b	$A4, $B1, $FA, $0F, $0F, $08, $F2, $D1, $F2, $A0, $B0, $FA, $0F, $0F, $09, $F0 ;0x1E0
	dc.b	$E0, $F3, $D1, $F2, $00, $F8, $0F, $0F, $09, $F0, $C0, $F1, $C1, $F2, $E1, $F3
	dc.b	$B3, $F0, $0F, $0F, $0B, $F0, $C0, $F1, $D0, $C0, $F1, $D0, $E0, $F4, $B3, $F0 ;0x200
	dc.b	$0F, $0F, $0B, $F1, $C0, $F8, $D0, $F6, $0F, $0F, $0C, $F1, $C0, $F6, $D1, $F0
	dc.b	$D0, $C2, $D0, $F1, $0F, $0F, $0C, $F1, $C0, $F8, $C4, $D0, $F1, $01, $F4, $0F ;0x220
	dc.b	$0F, $05, $F1, $C1, $F5, $D0, $C4, $D0, $F3, $E0, $D1, $E1, $F0, $0F, $0F, $05
	dc.b	$F2, $D1, $F2, $D0, $C4, $D1, $F2, $E0, $D3, $E1, $F0, $0F, $0F, $06, $F2, $D1 ;0x240
	dc.b	$F2, $D4, $F3, $E0, $D3, $E1, $F0, $0F, $0F, $09, $F1, $C2, $F8, $E0, $D3, $E1
	dc.b	$F0, $0F, $0F, $09, $F4, $C3, $D1, $F1, $E0, $D3, $E0, $F1, $E0, $F0, $0F, $0F ;0x260
	dc.b	$08, $FF, $F2, $D0, $E0, $F1, $0F, $0F, $09, $F5, $E4, $D6, $F2, $0F, $0F, $0F
	dc.b	$FD, $0F, $0F, $0F, $0F, $0F, $03 ;0x280
loc_14E4E:
	dc.b	$0F, $0F, $0F, $0F, $0F ;0x0 (0x00014E4E-0x00014E53, Entry count: 0x5)
	dc.b	$0F, $0F, $0F, $0F, $0F, $02, $F2, $0F, $0F, $0F, $0B, $F0, $A1, $B0, $F5, $0F
	dc.b	$0F, $0F, $04, $F0, $A2, $F0, $D0, $F0, $A3, $F0, $0F, $0F, $0F, $03, $F0, $A1 ;0x0 (0x00014E53-0x00015101, Entry count: 0x2AE)
	dc.b	$F0, $C0, $F0, $A5, $F0, $0F, $0F, $0F, $01, $F0, $A2, $F0, $D0, $F0, $A6, $F0
	dc.b	$0F, $0F, $0F, $00, $F0, $A2, $F2, $B0, $70, $F0, $A3, $F0, $0F, $0F, $0F, $00 ;0x20
	dc.b	$F0, $A1, $F0, $41, $F0, $72, $F0, $A1, $B0, $F0, $0F, $0F, $0F, $00, $F0, $A1
	dc.b	$F0, $41, $F0, $60, $D1, $F0, $A0, $B0, $F0, $0F, $0F, $0F, $01, $F0, $A2, $F1 ;0x40
	dc.b	$60, $D0, $C0, $20, $F0, $B0, $F0, $0F, $0F, $0F, $01, $F0, $A3, $B0, $F0, $64
	dc.b	$F0, $0F, $0F, $0F, $01, $F0, $A4, $B0, $F0, $63, $F0, $0F, $0F, $0F, $02, $F0 ;0x60
	dc.b	$A4, $F0, $60, $70, $62, $F0, $0F, $0F, $0F, $02, $F0, $A4, $F0, $61, $70, $F1
	dc.b	$0F, $0F, $0F, $03, $F0, $A3, $B0, $F1, $61, $F0, $0F, $0F, $0F, $03, $F0, $A3 ;0x80
	dc.b	$B0, $F0, $C1, $F0, $60, $F0, $0F, $0F, $0F, $03, $F0, $A1, $B1, $F0, $60, $F1
	dc.b	$C0, $F1, $0F, $0F, $0F, $04, $F3, $63, $F0, $C0, $F1, $0F, $0F, $0F, $04, $F2 ;0xA0
	dc.b	$63, $F0, $C0, $D0, $F0, $0F, $0F, $0F, $04, $F2, $63, $F0, $C0, $D1, $F0, $0F
	dc.b	$0F, $0F, $03, $F0, $D0, $F0, $62, $F1, $C1, $D0, $F0, $0F, $0F, $0F, $03, $F0 ;0xC0
	dc.b	$D0, $F0, $62, $F0, $C2, $D1, $F0, $0F, $0F, $0F, $02, $F0, $D0, $F0, $62, $F0
	dc.b	$C1, $D1, $F1, $0F, $0F, $0F, $02, $F0, $D0, $F0, $62, $F0, $D2, $F1, $0F, $0F ;0xE0
	dc.b	$0F, $03, $F0, $D0, $F0, $62, $F0, $D1, $F1, $0F, $0F, $0F, $04, $F1, $C0, $F0
	dc.b	$61, $F0, $D1, $F0, $0F, $0F, $0F, $06, $F0, $D0, $F0, $70, $61, $F1, $0F, $0F ;0x100
	dc.b	$0F, $07, $F3, $61, $F1, $0F, $0F, $0F, $07, $F0, $60, $70, $F0, $70, $61, $F0
	dc.b	$0F, $0F, $0F, $07, $F4, $61, $F0, $0F, $0F, $0F, $06, $F0, $54, $70, $61, $F0 ;0x120
	dc.b	$0F, $0F, $0F, $05, $F0, $42, $51, $F0, $70, $60, $F1, $0F, $0F, $0F, $03, $F0
	dc.b	$44, $50, $F1, $62, $F0, $0F, $0F, $0F, $02, $F0, $44, $51, $F0, $63, $F0, $0F ;0x140
	dc.b	$0F, $0F, $01, $F0, $44, $51, $F0, $70, $61, $70, $F0, $0F, $0F, $0F, $01, $F0
	dc.b	$50, $43, $51, $F1, $71, $F1, $0F, $0F, $0F, $01, $F0, $51, $43, $51, $F2, $51 ;0x160
	dc.b	$F0, $0F, $0F, $0F, $00, $F1, $50, $43, $52, $F0, $52, $F0, $0F, $0F, $0F, $01
	dc.b	$F0, $50, $43, $52, $F0, $53, $F0, $0F, $0F, $0F, $00, $F1, $50, $42, $52, $F0 ;0x180
	dc.b	$50, $F3, $0F, $0F, $0F, $01, $F0, $50, $41, $F6, $71, $F0, $0F, $0F, $0F, $01
	dc.b	$F4, $71, $F1, $73, $F0, $0F, $0F, $0F, $02, $F0, $74, $F1, $73, $F0, $0F, $0F ;0x1A0
	dc.b	$0F, $01, $F0, $62, $71, $F2, $72, $F1, $0F, $0F, $0F, $00, $F0, $63, $70, $F2
	dc.b	$73, $F0, $0F, $0F, $0F, $00, $F0, $63, $70, $F1, $00, $F0, $72, $F1, $0F, $0F ;0x1C0
	dc.b	$0F, $F0, $64, $70, $F0, $00, $F0, $73, $F0, $0F, $0F, $0F, $00, $F0, $63, $70
	dc.b	$F1, $00, $F0, $73, $F0, $0F, $0F, $0F, $F0, $63, $70, $F1, $01, $F0, $72, $F1 ;0x1E0
	dc.b	$0F, $0F, $0F, $F0, $63, $70, $F0, $02, $F0, $72, $F0, $0F, $0F, $0F, $00, $F0
	dc.b	$62, $70, $F1, $02, $F0, $72, $F0, $0F, $0F, $0F, $00, $F0, $61, $70, $F1, $03 ;0x200
	dc.b	$F0, $71, $F1, $0F, $0F, $0F, $F0, $62, $70, $F0, $03, $F0, $72, $F0, $0F, $0F
	dc.b	$0F, $00, $F0, $61, $70, $F1, $03, $F0, $71, $F1, $0F, $0F, $0F, $00, $F0, $60 ;0x220
	dc.b	$F2, $04, $F2, $D0, $F0, $0F, $0F, $0F, $F2, $C0, $D0, $F0, $03, $F1, $D1, $F2
	dc.b	$0F, $0F, $0E, $F0, $C1, $F1, $30, $F1, $01, $F0, $B0, $F1, $32, $F2, $0F, $0F ;0x240
	dc.b	$0A, $F0, $A0, $F1, $22, $30, $F3, $B1, $F0, $32, $F0, $B1, $F0, $0F, $0F, $09
	dc.b	$F0, $A1, $F0, $22, $F0, $A1, $B0, $FA, $0F, $0F, $09, $FB, $71, $F3, $71, $F0 ;0x260
	dc.b	$E0, $F0, $0F, $0F, $08, $F0, $60, $70, $F3, $60, $70, $F0, $D0, $F1, $71, $F1
	dc.b	$70, $F0, $71, $F1, $0F, $0F, $08, $60, $E0, $60, $70, $F1, $60, $E0, $60, $70 ;0x280
	dc.b	$F1, $71, $03, $71, $0F, $0F, $0C, $60, $72, $01, $60, $72, $0F, $0B ;0x2A0
loc_15101:
	dc.b	$0F, $0F, $03, $F2, $0F, $0F, $0F, $0B, $F0, $A1, $B0, $F5, $0F, $0F, $0F, $04
	dc.b	$F0, $A2, $F0, $D0, $F0, $A3, $F0, $0F, $0F, $0F, $03, $F0, $A1, $F0, $C0, $F0 ;0x0 (0x00015101-0x000151A9, Entry count: 0xA8)
	dc.b	$A5, $F0, $0F, $0F, $0F, $01, $F0, $A2, $F0, $D0, $F0, $A6, $F0, $0F, $0F, $0F
	dc.b	$00, $F0, $A2, $F2, $B0, $70, $F0, $A3, $F0, $0F, $0F, $0F, $00, $F0, $A1, $F0 ;0x20
	dc.b	$41, $F0, $72, $F0, $A1, $B0, $F0, $0F, $0F, $0F, $00, $F0, $A1, $F0, $41, $F0
	dc.b	$60, $D1, $F0, $A0, $B0, $F0, $0F, $0F, $0F, $01, $F0, $A2, $F1, $60, $D0, $C0 ;0x40
	dc.b	$20, $F0, $B0, $F0, $0F, $0F, $0F, $01, $F0, $A3, $B0, $F0, $64, $F0, $0F, $0F
	dc.b	$0F, $02, $F0, $A4, $F0, $63, $F0, $0F, $0F, $0F, $03, $F0, $A4, $F0, $70, $62 ;0x60
	dc.b	$F0, $0F, $0F, $0F, $02, $F0, $A4, $B0, $F0, $60, $70, $F1, $0F, $0F, $0F, $03
	dc.b	$F0, $A4, $B0, $F0, $61, $F0, $0F, $0F, $0F, $04, $F0, $A3, $B0, $F0, $C0, $F2 ;0x80
	dc.b	$0F, $0F, $0F, $03, $F0, $A3, $B0, $F5 ;0xA0
	dc.b	$0F, $0F, $0F, $04, $F1, $B1, $F2, $61, $70, $F1, $0F, $0F, $0F, $02, $F4, $C0
	dc.b	$F0, $63, $70, $F0, $0F, $0F, $0F, $01, $F0, $71, $F0, $D0, $C1, $F0, $64, $F1 ;0x0 (0x000151A9-0x000153D5, Entry count: 0x22C)
	dc.b	$0F, $0F, $0F, $F0, $72, $F0, $C2, $F0, $60, $F0, $62, $F1, $0F, $0F, $0F, $F0
	dc.b	$72, $F0, $C3, $F1, $62, $F0, $D0, $F0, $0F, $0F, $0D, $F0, $72, $F1, $C3, $D0 ;0x20
	dc.b	$F0, $62, $F0, $D0, $F0, $0F, $0F, $0D, $F0, $71, $F1, $D0, $C3, $D0, $F0, $62
	dc.b	$F2, $0F, $0F, $0C, $F0, $72, $F1, $C4, $D0, $F0, $62, $F1, $0F, $0F, $0D, $F0 ;0x40
	dc.b	$71, $F2, $C4, $D1, $F0, $62, $F1, $0F, $0F, $0C, $F0, $71, $F0, $00, $F0, $D0
	dc.b	$C3, $D1, $F0, $70, $60, $72, $F5, $0F, $0F, $06, $F0, $71, $F0, $00, $F4, $D2 ;0x60
	dc.b	$F2, $75, $62, $F0, $0F, $0F, $05, $F0, $71, $F0, $00, $F1, $71, $F4, $01, $F3
	dc.b	$71, $61, $71, $F0, $0F, $0F, $04, $F0, $71, $F0, $01, $F0, $64, $70, $F0, $04 ;0x80
	dc.b	$F2, $72, $F1, $0F, $0F, $03, $F1, $70, $F1, $01, $F7, $06, $F1, $70, $F1, $0F
	dc.b	$0F, $03, $F0, $72, $F0, $01, $F0, $50, $41, $53, $F0, $07, $F2, $0F, $0F, $04 ;0xA0
	dc.b	$F0, $72, $F0, $00, $F0, $50, $43, $53, $F0, $0F, $0F, $0E, $F0, $71, $F2, $50
	dc.b	$44, $53, $F0, $0F, $0F, $0E, $F3, $00, $F0, $43, $56, $F0, $0F, $0F, $0F, $01 ;0xC0
	dc.b	$F0, $50, $44, $55, $F0, $0F, $0F, $0F, $01, $F0, $50, $44, $51, $F1, $51, $F0
	dc.b	$0F, $0F, $0F, $01, $F0, $45, $50, $F1, $53, $F0, $0F, $0F, $0F, $00, $F0, $44 ;0xE0
	dc.b	$51, $F1, $53, $F0, $0F, $0F, $0F, $F0, $50, $44, $51, $F0, $54, $F0, $0F, $0F
	dc.b	$0F, $F0, $44, $51, $F1, $55, $F0, $0F, $0F, $0E, $F2, $41, $52, $F1, $55, $F0 ;0x100
	dc.b	$0F, $0F, $0F, $F0, $70, $F4, $00, $F7, $0F, $0F, $0E, $F0, $60, $72, $F1, $03
	dc.b	$F0, $73, $F0, $0F, $0F, $0D, $F1, $62, $70, $F0, $04, $F1, $72, $F0, $0F, $0F ;0x120
	dc.b	$0C, $F0, $64, $F1, $05, $F0, $72, $F0, $0F, $0F, $0B, $F0, $64, $70, $F0, $05
	dc.b	$F0, $73, $F0, $0F, $0F, $0A, $F0, $63, $71, $F0, $06, $F0, $73, $F0, $0F, $0F ;0x140
	dc.b	$09, $F0, $63, $71, $F1, $06, $F0, $73, $F0, $0F, $0F, $09, $F0, $62, $71, $F1
	dc.b	$07, $F0, $73, $F0, $0F, $0F, $08, $F0, $62, $71, $F1, $09, $F0, $72, $F0, $0F ;0x160
	dc.b	$0F, $08, $F0, $62, $70, $F1, $0A, $F0, $71, $F1, $0F, $0F, $07, $F0, $62, $70
	dc.b	$F1, $0B, $F0, $71, $F0, $0F, $0F, $07, $F1, $61, $70, $F0, $0D, $F0, $71, $F0 ;0x180
	dc.b	$0F, $0F, $05, $F1, $C0, $F1, $70, $F0, $0E, $F0, $71, $F0, $0F, $0F, $04, $F0
	dc.b	$A1, $F0, $C1, $F0, $0F, $F0, $71, $F1, $0F, $0F, $01, $60, $70, $F0, $B0, $F3 ;0x1A0
	dc.b	$0F, $00, $F2, $D0, $F0, $0F, $0F, $00, $60, $E0, $60, $70, $F0, $22, $F0, $0F
	dc.b	$00, $F0, $D1, $F2, $0F, $0F, $00, $60, $70, $F1, $30, $21, $F0, $0F, $F0, $B0 ;0x1C0
	dc.b	$F1, $32, $F2, $0F, $0E, $60, $70, $F0, $30, $F2, $0F, $F0, $B1, $F0, $32, $F0
	dc.b	$B1, $F0, $0F, $0C, $60, $E0, $60, $70, $F0, $A1, $F0, $0F, $FA, $0F, $0D, $60 ;0x1E0
	dc.b	$70, $F1, $B0, $A0, $F0, $0F, $F0, $71, $F3, $71, $F0, $E0, $F0, $0F, $0D, $F0
	dc.b	$D0, $F2, $0F, $00, $70, $F0, $71, $F1, $70, $F0, $71, $F1, $0F, $0D, $F2, $71 ;0x200
	dc.b	$0F, $01, $71, $03, $71, $0F, $0F, $02, $71, $0F, $0F, $0B ;0x220
loc_153D5:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $02, $F2, $0F, $0F, $0F, $0B, $F0, $A1, $B0, $F5
	dc.b	$0F, $0F, $0F, $04, $F0, $A2, $F0, $D0, $F0, $A3, $F0, $0F, $0F, $0F, $03, $F0 ;0x0 (0x000153D5-0x00015407, Entry count: 0x32)
	dc.b	$A1, $F0, $C0, $F0, $A5, $F0, $0F, $0F, $0F, $01, $F0, $A2, $F0, $D0, $F0, $A6
	dc.b	$F0, $0F ;0x20
	dc.b	$0F, $0F, $00, $F0, $A2, $F2, $B0, $70, $F0, $A3, $F0, $0F, $0F, $0F, $00, $F0
	dc.b	$A1, $F0, $41, $F0, $72, $F0, $A1, $B0, $F0, $0F, $0F, $0F, $00, $F0, $A1, $F0 ;0x0 (0x00015407-0x00015686, Entry count: 0x27F)
	dc.b	$41, $F0, $60, $D1, $F0, $A0, $B0, $F0, $0F, $0F, $0F, $00, $F0, $A3, $F1, $60
	dc.b	$D0, $C0, $20, $F0, $B0, $F0, $0F, $0F, $0F, $01, $F0, $A3, $B0, $F0, $64, $F0 ;0x20
	dc.b	$0F, $0F, $0F, $01, $F0, $A4, $B0, $F0, $63, $F0, $0F, $0F, $0F, $02, $F0, $A3
	dc.b	$B0, $F0, $71, $62, $F0, $0F, $0F, $0F, $01, $F1, $A3, $B0, $F0, $61, $70, $F1 ;0x40
	dc.b	$0F, $0F, $0F, $00, $F1, $A5, $B0, $F0, $61, $70, $F0, $0F, $0F, $0F, $01, $F0
	dc.b	$A5, $B0, $F2, $61, $F0, $0F, $0F, $0F, $02, $F0, $A2, $B0, $F2, $C1, $F0, $60 ;0x60
	dc.b	$F0, $0F, $0F, $0F, $03, $F0, $B1, $F0, $C0, $F0, $60, $F1, $C0, $F1, $0F, $0F
	dc.b	$0F, $04, $F1, $C0, $F0, $63, $F0, $C0, $D0, $F0, $0F, $0F, $0F, $04, $F0, $C0 ;0x80
	dc.b	$F0, $63, $F0, $C0, $D0, $F0, $0F, $0F, $0F, $03, $F0, $D0, $C0, $F0, $62, $70
	dc.b	$F0, $C0, $D1, $F0, $0F, $0F, $0F, $02, $F0, $D0, $C0, $F0, $62, $F1, $C1, $D0 ;0xA0
	dc.b	$F0, $0F, $0F, $0F, $02, $F0, $D0, $C0, $F0, $62, $F0, $C2, $D1, $F0, $0F, $0F
	dc.b	$0F, $01, $F0, $D0, $C0, $F0, $62, $F0, $C1, $D1, $F1, $0F, $0F, $0F, $01, $F0 ;0xC0
	dc.b	$D0, $C0, $F0, $62, $F0, $D2, $F1, $0F, $0F, $0F, $01, $F0, $D1, $C0, $F1, $61
	dc.b	$F0, $D0, $F2, $0F, $0F, $0F, $02, $F0, $D2, $C0, $F0, $61, $F0, $D0, $F0, $0F ;0xE0
	dc.b	$0F, $0F, $04, $F3, $D0, $F0, $61, $F1, $0F, $0F, $0F, $06, $F4, $61, $F0, $0F
	dc.b	$0F, $0F, $06, $F0, $60, $72, $F0, $61, $F0, $0F, $0F, $0F, $06, $F5, $61, $F0 ;0x100
	dc.b	$0F, $0F, $0F, $05, $F0, $54, $F0, $61, $F1, $0F, $0F, $0F, $04, $F0, $43, $50
	dc.b	$F0, $70, $62, $F0, $0F, $0F, $0F, $02, $F0, $45, $50, $F0, $63, $F0, $0F, $0F ;0x120
	dc.b	$0F, $01, $F0, $50, $44, $50, $F0, $70, $61, $70, $F0, $0F, $0F, $0F, $01, $F0
	dc.b	$50, $44, $50, $F1, $71, $F0, $0F, $0F, $0F, $02, $F0, $51, $44, $50, $F3, $0F ;0x140
	dc.b	$0F, $0F, $02, $F1, $53, $42, $52, $F0, $0F, $0F, $0F, $03, $F0, $50, $F0, $52
	dc.b	$44, $50, $F0, $0F, $0F, $0F, $02, $F1, $50, $F0, $52, $43, $F1, $0F, $0F, $0F ;0x160
	dc.b	$03, $F0, $50, $F1, $51, $42, $F1, $70, $F0, $0F, $0F, $0F, $02, $F4, $51, $40
	dc.b	$F1, $71, $F0, $0F, $0F, $0F, $03, $F0, $71, $F4, $70, $60, $70, $F0, $0F, $0F ;0x180
	dc.b	$0F, $03, $F0, $73, $F0, $70, $61, $71, $F0, $0F, $0F, $0F, $03, $F1, $72, $F0
	dc.b	$62, $70, $F1, $0F, $0F, $0F, $02, $F1, $72, $F0, $62, $70, $F1, $0F, $0F, $0F ;0x1A0
	dc.b	$03, $F0, $72, $F0, $63, $70, $F0, $0F, $0F, $0F, $03, $F0, $72, $F0, $63, $70
	dc.b	$F1, $0F, $0F, $0F, $03, $F0, $72, $F0, $62, $70, $F1, $0F, $0F, $0F, $03, $F0 ;0x1C0
	dc.b	$72, $F0, $63, $70, $F0, $0F, $0F, $0F, $04, $F0, $72, $F0, $62, $70, $F1, $0F
	dc.b	$0F, $0F, $03, $F0, $72, $F1, $62, $70, $F0, $0F, $0F, $0F, $04, $F0, $72, $F1 ;0x1E0
	dc.b	$61, $71, $F0, $0F, $0F, $0F, $03, $F0, $72, $F2, $61, $70, $F1, $0F, $0F, $0F
	dc.b	$03, $F0, $72, $F1, $61, $71, $F0, $0F, $0F, $0F, $03, $F6, $61, $F2, $0F, $0F ;0x200
	dc.b	$0F, $02, $F2, $D2, $E0, $F2, $C0, $D0, $F0, $0F, $0F, $0F, $02, $F1, $B0, $F4
	dc.b	$C1, $F1, $30, $F0, $0F, $0F, $0F, $01, $F1, $B1, $F2, $A0, $F1, $22, $30, $F1 ;0x220
	dc.b	$0F, $0F, $0F, $F6, $A1, $F0, $22, $F0, $A1, $F0, $0F, $0F, $0E, $70, $F0, $71
	dc.b	$FC, $0F, $0F, $0D, $70, $F0, $71, $F0, $70, $00, $F0, $70, $60, $F3, $70, $60 ;0x240
	dc.b	$F0, $D0, $F0, $0F, $0F, $0D, $70, $00, $71, $01, $70, $60, $E0, $60, $F1, $70
	dc.b	$60, $E0, $60, $F1, $0F, $0F, $0F, $04, $70, $60, $03, $70, $60, $0F, $09 ;0x260
loc_15686:
	dc.b	$0F, $0F, $04, $F2, $0F, $0F, $0F, $0B, $F0, $A1, $B0, $F5, $0F, $0F, $0F, $04
	dc.b	$F0, $A2, $F0, $D0, $F0, $A3, $F0, $0F, $0F, $0F, $03, $F0, $A1, $F0, $C0, $F0 ;0x0 (0x00015686-0x0001575E, Entry count: 0xD8)
	dc.b	$A5, $F0, $0F, $0F, $0F, $01, $F0, $A2, $F0, $D0, $F0, $A6, $F0, $0F, $0F, $0F
	dc.b	$00, $F0, $A2, $F2, $B0, $70, $F0, $A3, $F0, $0F, $0F, $0F, $00, $F0, $A1, $F0 ;0x20
	dc.b	$41, $F0, $72, $F0, $A1, $B0, $F0, $0F, $0F, $0F, $00, $F0, $A1, $F0, $41, $F0
	dc.b	$60, $D1, $F0, $A0, $B0, $F0, $0F, $0F, $0F, $01, $F0, $A2, $F1, $60, $D0, $C0 ;0x40
	dc.b	$20, $F0, $B0, $F0, $0F, $0F, $0F, $01, $F0, $A3, $B0, $F0, $64, $F0, $0F, $0F
	dc.b	$0F, $01, $F0, $A4, $F0, $70, $63, $F0, $0F, $0F, $0F, $02, $F0, $A4, $F0, $71 ;0x60
	dc.b	$62, $F0, $0F, $0F, $0F, $01, $F0, $A4, $B0, $F0, $60, $71, $F1, $0F, $0F, $0F
	dc.b	$02, $F0, $A3, $B0, $F0, $62, $70, $F0, $0F, $0F, $0F, $02, $F0, $A3, $B0, $F1 ;0x80
	dc.b	$62, $70, $F1, $0F, $0F, $0F, $01, $F0, $A1, $F5, $61, $70, $F1, $0F, $0F, $0F
	dc.b	$01, $F2, $62, $F0, $C0, $F0, $61, $70, $F0, $D0, $F0, $0F, $0F, $0F, $01, $F0 ;0xA0
	dc.b	$64, $F0, $C0, $F0, $71, $F0, $D0, $F0, $0F, $0F, $0F, $01, $F0, $62, $F0, $60
	dc.b	$F0, $C1, $F1, $D1, $F0, $0F, $0F, $0F ;0xC0
	dc.b	$00, $F0, $62, $70, $F0, $60, $F0, $C2, $D3, $F0, $0F, $0F, $0F, $F0, $62, $F2
	dc.b	$C3, $D3, $F0, $0F, $0F, $0F, $F0, $61, $70, $F0, $D1, $C4, $D2, $F0, $0F, $0F ;0x0 (0x0001575E-0x0001595B, Entry count: 0x1FD)
	dc.b	$0F, $F0, $61, $70, $F0, $D2, $C2, $D2, $F1, $0F, $0F, $0E, $F0, $62, $F1, $D6
	dc.b	$F1, $70, $F0, $0F, $0F, $0E, $F0, $62, $F0, $D6, $F1, $71, $F0, $0F, $0F, $0E ;0x20
	dc.b	$F0, $70, $61, $F0, $D5, $F2, $72, $F1, $0F, $0F, $0C, $F1, $61, $F0, $D4, $F1
	dc.b	$00, $F1, $73, $F3, $0F, $0F, $09, $F0, $61, $F6, $02, $F3, $74, $F0, $0F, $0F ;0x40
	dc.b	$08, $F0, $70, $60, $70, $F0, $73, $F0, $05, $F2, $72, $F0, $0F, $0F, $08, $F1
	dc.b	$61, $F5, $07, $F1, $70, $F0, $0F, $0F, $0A, $F0, $62, $F0, $41, $50, $F1, $07 ;0x60
	dc.b	$F1, $0F, $0F, $0A, $F1, $63, $F0, $41, $50, $F0, $0F, $0F, $0F, $04, $F0, $71
	dc.b	$62, $F0, $41, $50, $F0, $0F, $0F, $0F, $03, $F2, $73, $F0, $41, $50, $F0, $0F ;0x80
	dc.b	$0F, $0F, $03, $F0, $50, $F5, $41, $50, $F1, $0F, $0F, $0F, $02, $F0, $51, $F0
	dc.b	$50, $44, $51, $F0, $0F, $0F, $0F, $02, $F0, $51, $F0, $50, $45, $50, $F0, $0F ;0xA0
	dc.b	$0F, $0F, $01, $F0, $52, $F0, $51, $44, $50, $F0, $0F, $0F, $0F, $01, $F0, $52
	dc.b	$F1, $50, $44, $50, $F0, $0F, $0F, $0F, $01, $F0, $52, $F1, $50, $44, $50, $F0 ;0xC0
	dc.b	$0F, $0F, $0F, $00, $F2, $51, $F1, $51, $42, $50, $F1, $0F, $0F, $0F, $00, $F0
	dc.b	$70, $F4, $54, $F2, $0F, $0F, $0F, $00, $F0, $73, $F0, $00, $F5, $70, $F0, $0F ;0xE0
	dc.b	$0F, $0F, $F0, $73, $F1, $02, $F0, $62, $70, $F0, $0F, $0F, $0E, $F0, $74, $F0
	dc.b	$03, $F0, $62, $70, $F0, $0F, $0F, $0D, $F0, $74, $F1, $02, $F0, $63, $F1, $0F ;0x100
	dc.b	$0F, $0D, $F0, $73, $F1, $03, $F0, $62, $70, $F0, $0F, $0F, $0D, $F0, $73, $F1
	dc.b	$04, $F0, $62, $70, $F0, $0F, $0F, $0C, $F0, $73, $F1, $05, $F0, $62, $F1, $0F ;0x120
	dc.b	$0F, $0C, $F0, $72, $F1, $05, $F0, $63, $F0, $0F, $0F, $0C, $F0, $72, $F1, $06
	dc.b	$F0, $62, $70, $F0, $0F, $0F, $0B, $F1, $71, $F1, $07, $F0, $62, $70, $F0, $0F ;0x140
	dc.b	$0F, $09, $F1, $D0, $F3, $08, $F0, $62, $F1, $0F, $0F, $08, $F1, $B0, $F0, $D1
	dc.b	$F0, $09, $F0, $62, $F0, $0F, $0F, $08, $F1, $B2, $F2, $09, $F0, $61, $70, $F0 ;0x160
	dc.b	$0F, $0F, $07, $70, $F2, $B1, $F0, $30, $F0, $09, $F0, $61, $F2, $0F, $0F, $05
	dc.b	$70, $F5, $31, $F1, $08, $F2, $C0, $D0, $F0, $0F, $0F, $06, $70, $F1, $70, $F1 ;0x180
	dc.b	$31, $F0, $B0, $F0, $07, $F0, $C1, $F1, $30, $F0, $0F, $0F, $06, $F0, $70, $F0
	dc.b	$70, $F5, $06, $F0, $A0, $F1, $22, $30, $F1, $0F, $0F, $05, $F0, $70, $F2, $70 ;0x1A0
	dc.b	$F0, $E0, $F0, $06, $F0, $A1, $F0, $22, $F0, $A1, $F0, $0F, $0F, $07, $F0, $70
	dc.b	$F0, $70, $F0, $07, $FA, $0F, $0F, $08, $F0, $70, $09, $F0, $70, $60, $F3, $70 ;0x1C0
	dc.b	$60, $F0, $D0, $F0, $0F, $0F, $0F, $03, $70, $60, $E0, $60, $F1, $70, $60, $E0
	dc.b	$60, $F1, $0F, $0F, $0F, $04, $70, $60, $03, $70, $60, $0F, $05 ;0x1E0
loc_1595B:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0B, $F0, $0F, $0F, $0F, $0E, $F0, $0F, $0F, $0F, $0D, $F1, $0F, $0F, $0F, $0A ;0x0 (0x0001595B-0x00015B59, Entry count: 0x1FE)
	dc.b	$F0, $01, $F2, $0F, $0F, $0F, $07, $F0, $00, $F1, $00, $F2, $0F, $0F, $0F, $07
	dc.b	$F0, $00, $F6, $0F, $0F, $0F, $05, $FA, $0F, $0F, $0F, $04, $FB, $0F, $0F, $0F ;0x20
	dc.b	$03, $FC, $0F, $0F, $0F, $02, $FD, $0F, $0F, $0F, $02, $F2, $E4, $F5, $0F, $0F
	dc.b	$0F, $01, $F0, $D1, $E8, $F3, $0F, $0F, $0F, $F1, $D1, $EA, $F1, $0F, $0C, $F0 ;0x40
	dc.b	$02, $F0, $0D, $F1, $D2, $E9, $F2, $0F, $06, $F8, $0E, $F0, $D2, $EA, $F2, $0F
	dc.b	$03, $F8, $0F, $00, $F1, $D3, $EA, $F3, $0E, $F1, $C2, $F3, $0F, $03, $F1, $D2 ;0x60
	dc.b	$ED, $F2, $0B, $F0, $C5, $F1, $0F, $05, $F2, $D2, $E7, $F1, $E3, $F1, $07, $F2
	dc.b	$C1, $D3, $E0, $F0, $0F, $08, $F1, $D2, $E7, $F2, $E2, $F1, $04, $F1, $C2, $D5 ;0x80
	dc.b	$E0, $F0, $0F, $09, $F1, $D3, $E6, $F2, $E2, $F1, $02, $F0, $C2, $D7, $E0, $F0
	dc.b	$0F, $0A, $F1, $D3, $E6, $F2, $E1, $F1, $01, $F0, $C1, $D7, $E1, $F0, $0F, $0C ;0xA0
	dc.b	$F2, $D3, $E5, $F1, $E0, $F3, $C2, $D7, $E0, $F1, $0F, $0F, $F1, $D3, $E4, $F1
	dc.b	$E0, $F3, $C1, $D7, $E0, $F0, $0F, $0F, $02, $F1, $D2, $E4, $F5, $C1, $D7, $E0 ;0xC0
	dc.b	$F1, $0F, $0F, $03, $F0, $D3, $E4, $F1, $E0, $F2, $C0, $D7, $E0, $F0, $0F, $0F
	dc.b	$04, $F1, $D2, $E4, $F1, $E1, $F2, $D6, $E0, $F1, $0F, $0F, $05, $F0, $D2, $E5 ;0xE0
	dc.b	$F1, $E1, $F3, $D4, $E0, $F0, $0F, $0F, $06, $F1, $D2, $E4, $F2, $E1, $F1, $E0
	dc.b	$FE, $0F, $0F, $F1, $D2, $E4, $F5, $E1, $F0, $D6, $C3, $D1, $F1, $0F, $0E, $F1 ;0x100
	dc.b	$D2, $E4, $F3, $E1, $F1, $D0, $C1, $D2, $C6, $D1, $F0, $0F, $0E, $F7, $E4, $F2
	dc.b	$D0, $C3, $D2, $C1, $D0, $E0, $F1, $C0, $D1, $F0, $0F, $0E, $F2, $E5, $F3, $D1 ;0x120
	dc.b	$C5, $D1, $C3, $F1, $C0, $D1, $F0, $0F, $0B, $F2, $C0, $F8, $D4, $C5, $D1, $C6
	dc.b	$D1, $A0, $F1, $0F, $06, $F2, $C3, $DD, $C4, $D5, $C2, $D0, $A4, $F1, $0F, $F4 ;0x140
	dc.b	$C4, $DF, $D0, $C2, $D2, $F3, $D3, $F2, $A3, $F0, $08, $F5, $C4, $DF, $D8, $F3
	dc.b	$01, $F9, $A1, $B0, $F0, $05, $F1, $C7, $F4, $DF, $D4, $F2, $0C, $F3, $B0, $F0 ;0x160
	dc.b	$04, $F0, $C7, $F2, $DF, $D5, $F3, $0F, $01, $F2, $04, $F0, $C4, $F3, $D0, $F6
	dc.b	$DB, $F4, $0F, $05, $F0, $06, $F5, $D2, $F0, $A4, $B0, $FD, $0F, $0F, $03, $F1 ;0x180
	dc.b	$D3, $F0, $A2, $B2, $F0, $B1, $F1, $0F, $0F, $0E, $F5, $B2, $F2, $B0, $F2, $0F
	dc.b	$0F, $0F, $05, $F2, $B1, $F2, $0F, $0F, $0F, $07, $F5, $0F, $0F, $0F, $0F, $0F ;0x1A0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x1C0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0B ;0x1E0
loc_15B59:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00015B59-0x00015CD9, Entry count: 0x180)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x40
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $01
	dc.b	$F3, $0F, $0B, $FF, $F0, $08, $F5, $D3, $F3, $0F, $00, $F6, $DD, $F5, $02, $F2 ;0x60
	dc.b	$D6, $E6, $F3, $07, $F4, $DB, $ED, $FF, $FA, $01, $F3, $D7, $E9, $F8, $E5, $F1
	dc.b	$D6, $C3, $D1, $F8, $00, $FB, $E1, $FF, $F8, $E0, $F0, $D0, $C1, $D2, $C6, $D1 ;0x80
	dc.b	$F0, $02, $F0, $03, $FD, $02, $FF, $F2, $E1, $F1, $C3, $D2, $C1, $D0, $E0, $F1
	dc.b	$C0, $D1, $F0, $09, $F3, $01, $F2, $0B, $F8, $E1, $F3, $D0, $C4, $D1, $C3, $F1 ;0xA0
	dc.b	$C0, $D1, $F0, $08, $F1, $02, $F1, $0B, $FF, $D1, $C5, $D1, $C6, $D1, $A0, $F1
	dc.b	$0F, $06, $F2, $C3, $F6, $D6, $C4, $D5, $C2, $D0, $A4, $F1, $0F, $F4, $C4, $DF ;0xC0
	dc.b	$D0, $C2, $D2, $F3, $D3, $F2, $A3, $F0, $08, $F5, $C4, $DF, $D8, $F3, $01, $F9
	dc.b	$A1, $B0, $F0, $05, $F1, $C7, $F4, $DF, $D4, $F2, $0C, $F3, $B0, $F0, $04, $F0 ;0xE0
	dc.b	$C7, $F2, $DF, $D5, $F3, $0F, $01, $F2, $04, $F0, $C4, $F3, $D0, $F6, $DB, $F4
	dc.b	$0F, $05, $F0, $06, $F5, $D2, $F0, $A4, $B0, $FD, $0F, $0F, $03, $F1, $D3, $F0 ;0x100
	dc.b	$A2, $B2, $F0, $B1, $F1, $0F, $0F, $0E, $F5, $B2, $F2, $B0, $F2, $0F, $0F, $0F
	dc.b	$05, $F2, $B1, $F2, $0F, $0F, $0F, $07, $F5, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x120
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x140
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0A ;0x160
loc_15CD9:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00015CD9-0x00015EAE, Entry count: 0x1D5)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x40
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $06, $FD, $0F, $0F, $0A, $F7, $D6, $C3, $D1, $F1, $0F, $0F, $05, $F2 ;0x60
	dc.b	$D8, $C1, $D2, $C6, $D1, $F0, $0F, $0F, $01, $F2, $D4, $E2, $D1, $F0, $C3, $D2
	dc.b	$C1, $D0, $E0, $F1, $C0, $D1, $F0, $0F, $0E, $F1, $D3, $E7, $F1, $C4, $D1, $C3 ;0x80
	dc.b	$F1, $C0, $D1, $F0, $0F, $0D, $F0, $D2, $E4, $D1, $E2, $F1, $C5, $D1, $C6, $D1
	dc.b	$A0, $F1, $0F, $05, $F5, $D1, $E3, $D4, $E0, $F2, $D0, $C4, $D5, $C2, $D0, $A4 ;0xA0
	dc.b	$F1, $0F, $F5, $C1, $E4, $D0, $E0, $D4, $E1, $F0, $D3, $C2, $D2, $F3, $D3, $F2
	dc.b	$A3, $F0, $08, $F5, $C4, $D1, $F2, $C1, $D0, $E1, $D3, $E1, $F0, $D7, $F3, $E1 ;0xC0
	dc.b	$F9, $A1, $B0, $F0, $05, $F1, $C7, $F4, $D1, $F0, $C0, $D1, $E1, $D2, $E1, $F0
	dc.b	$D6, $F5, $E1, $F2, $04, $F3, $B0, $F0, $04, $F0, $C7, $F2, $D4, $F0, $C1, $D0 ;0xE0
	dc.b	$E1, $D2, $E1, $F0, $D4, $F2, $E3, $F2, $E1, $F2, $06, $F2, $04, $F0, $C4, $F3
	dc.b	$D0, $F5, $C1, $D1, $E1, $D2, $E0, $F0, $D1, $F4, $00, $F1, $E3, $F1, $E2, $F1 ;0x100
	dc.b	$07, $F0, $06, $F5, $D2, $F0, $A3, $F0, $C1, $D1, $E2, $D1, $E1, $F3, $05, $F1
	dc.b	$E4, $F0, $E1, $F2, $0F, $00, $F1, $D3, $F0, $A2, $B0, $F0, $C1, $D1, $E3, $D1 ;0x120
	dc.b	$E0, $F1, $09, $F2, $E3, $F0, $E1, $F1, $0F, $01, $F5, $B2, $F0, $C1, $D1, $E4
	dc.b	$D1, $E0, $F0, $0C, $F2, $E3, $F3, $0F, $06, $F2, $C1, $D1, $E4, $D1, $E0, $F1 ;0x140
	dc.b	$0E, $F3, $E2, $F3, $0F, $05, $F0, $C0, $D2, $E3, $D3, $F1, $0F, $01, $FB, $0F
	dc.b	$00, $F2, $D1, $E6, $D0, $F2, $0F, $05, $F4, $0F, $01, $F4, $E0, $D2, $E1, $D1 ;0x160
	dc.b	$F4, $0F, $0F, $0A, $F5, $E0, $F2, $D3, $F4, $0F, $0F, $0F, $00, $F4, $E2, $F2
	dc.b	$00, $F1, $0F, $0F, $0F, $FB, $00, $F0, $0F, $0F, $0E, $FC, $0F, $0F, $0F, $05 ;0x180
	dc.b	$F4, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x1A0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $01 ;0x1C0
loc_15EAE:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00015EAE-0x00016053, Entry count: 0x1A5)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $05, $F3, $0F ;0x40
	dc.b	$0F, $0F, $07, $F3, $D3, $F1, $0F, $0F, $0F, $02, $F2, $D4, $E0, $F4, $0D, $F5
	dc.b	$0F, $0B, $F1, $C1, $D4, $E0, $F6, $08, $F3, $D4, $F1, $0F, $09, $F0, $C2, $D4 ;0x60
	dc.b	$E1, $F7, $05, $F1, $D5, $E1, $F0, $E0, $F0, $0F, $09, $F0, $C2, $D3, $F0, $E0
	dc.b	$FA, $00, $F2, $D5, $E1, $F5, $0F, $07, $F1, $C1, $D3, $F1, $E0, $F5, $E0, $F6 ;0x80
	dc.b	$D5, $E0, $F7, $0F, $07, $F3, $D1, $F2, $E1, $F6, $E1, $FF, $F3, $0F, $07, $F8
	dc.b	$E1, $F8, $E1, $F4, $D6, $C3, $D1, $F1, $0F, $05, $F8, $E1, $FB, $E1, $F1, $D0 ;0xA0
	dc.b	$C1, $D2, $C6, $D1, $F0, $0F, $04, $F9, $E0, $F8, $E2, $F2, $D0, $C3, $D2, $C1
	dc.b	$D0, $E0, $F1, $C0, $D1, $F0, $0F, $04, $F8, $E0, $F5, $E2, $F3, $D1, $C5, $D1 ;0xC0
	dc.b	$C3, $F1, $C0, $D1, $F0, $0F, $05, $FF, $F2, $D4, $C5, $D1, $C6, $D1, $A0, $F1
	dc.b	$0F, $03, $FD, $D9, $C4, $D5, $C2, $D0, $A4, $F1, $0F, $F5, $C1, $F1, $D0, $F1 ;0xE0
	dc.b	$DD, $C2, $D2, $F3, $D3, $F2, $A3, $F0, $08, $F5, $C4, $D3, $F0, $D0, $F2, $DF
	dc.b	$F3, $01, $F9, $A1, $B0, $F0, $05, $F1, $C7, $F4, $D4, $F1, $DD, $F2, $0C, $F3 ;0x100
	dc.b	$B0, $F0, $04, $F0, $C7, $F2, $D9, $F1, $D9, $F3, $0F, $01, $F2, $04, $F0, $C4
	dc.b	$F3, $D0, $F6, $DB, $F4, $0F, $05, $F0, $06, $F5, $D2, $F0, $A4, $B0, $FD, $0F ;0x120
	dc.b	$0F, $03, $F1, $D3, $F0, $A2, $B2, $F0, $B1, $F1, $0F, $0F, $0E, $F5, $B2, $F2
	dc.b	$B0, $F2, $0F, $0F, $0F, $05, $F2, $B1, $F2, $0F, $0F, $0F, $07, $F5, $0F, $0F ;0x140
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x160
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $0D ;0x1A0
loc_16053:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $07, $FB, $0F, $0F, $0F, $00, $F2, $2B, $F1, $0F, $0F ;0x0 (0x00016053-0x00016309, Entry count: 0x2B6)
	dc.b	$0D, $F0, $36, $22, $11, $24, $F1, $04, $F1, $0F, $0F, $05, $F0, $38, $10, $32
	dc.b	$24, $F1, $00, $F1, $31, $F0, $0F, $0F, $05, $F1, $36, $20, $30, $B0, $32, $24 ;0x20
	dc.b	$F0, $33, $F0, $0F, $0F, $07, $F1, $36, $A0, $B1, $31, $20, $10, $22, $33, $F0
	dc.b	$0F, $0F, $09, $F0, $35, $A1, $B1, $31, $20, $10, $22, $32, $F0, $0F, $0F, $09 ;0x40
	dc.b	$F1, $34, $A1, $22, $13, $22, $31, $F0, $0F, $0F, $06, $F2, $36, $22, $10, $C0
	dc.b	$14, $21, $32, $F0, $0F, $0F, $03, $F1, $32, $21, $32, $23, $10, $C0, $10, $22 ;0x60
	dc.b	$12, $21, $32, $F0, $0F, $0F, $00, $F1, $31, $23, $32, $24, $11, $20, $D1, $22
	dc.b	$10, $21, $30, $F0, $30, $F0, $0F, $0F, $F0, $31, $25, $32, $24, $11, $20, $C1 ;0x80
	dc.b	$D1, $20, $11, $20, $30, $F0, $30, $F0, $0F, $0E, $F0, $36, $21, $31, $26, $10
	dc.b	$20, $C3, $D0, $21, $31, $F0, $30, $F0, $0F, $0D, $F0, $3C, $27, $C4, $F0, $32 ;0xA0
	dc.b	$F0, $30, $F0, $0F, $0C, $F0, $3D, $27, $C3, $F1, $32, $F0, $30, $F0, $0F, $0D
	dc.b	$F5, $34, $F0, $32, $24, $31, $20, $C2, $F2, $30, $F1, $30, $F0, $0F, $0F, $03 ;0xC0
	dc.b	$F2, $31, $F0, $33, $21, $34, $20, $C1, $F2, $30, $F0, $30, $F0, $0F, $0F, $07
	dc.b	$F0, $30, $F1, $36, $A2, $30, $20, $C0, $F2, $C0, $F2, $0F, $0F, $05, $F1, $32 ;0xE0
	dc.b	$F1, $34, $A4, $30, $20, $C0, $A1, $F4, $0F, $0F, $03, $F0, $34, $F3, $31, $B0
	dc.b	$A1, $B1, $A5, $F3, $0F, $0F, $03, $F0, $36, $F4, $B0, $A0, $B1, $A7, $B0, $F0 ;0x100
	dc.b	$0F, $0F, $03, $F0, $38, $F3, $B1, $A1, $B2, $A3, $B0, $F0, $0F, $0F, $00, $F3
	dc.b	$A5, $35, $F2, $B2, $A3, $B2, $F0, $0F, $0F, $F1, $C2, $A7, $33, $B1, $31, $F1 ;0x120
	dc.b	$B5, $F1, $0F, $0F, $F0, $D0, $C5, $A0, $B4, $31, $B5, $FB, $0F, $0C, $F0, $D0
	dc.b	$C2, $D0, $C3, $B0, $30, $B1, $31, $B0, $A3, $B2, $F0, $B1, $F3, $E0, $D1, $E0 ;0x140
	dc.b	$F0, $0F, $0B, $F0, $D0, $C1, $D0, $E0, $D1, $C1, $35, $A5, $B1, $F0, $B2, $E1
	dc.b	$D4, $E0, $F0, $0F, $09, $F0, $C0, $D1, $C0, $D1, $C2, $D0, $35, $A6, $B0, $F0 ;0x160
	dc.b	$B2, $E0, $D0, $E6, $F0, $0F, $08, $F0, $C1, $D0, $C1, $D0, $C1, $D0, $36, $A6
	dc.b	$B0, $F2, $B0, $E4, $D3, $F0, $0F, $09, $F0, $C0, $D1, $C0, $D3, $36, $A6, $B0 ;0x180
	dc.b	$F0, $01, $F1, $E4, $D2, $F0, $0F, $0A, $F1, $D2, $F0, $39, $A4, $B0, $F0, $04
	dc.b	$F0, $E1, $D1, $E2, $F0, $0F, $0C, $F7, $33, $21, $31, $A1, $F1, $05, $F0, $E2 ;0x1A0
	dc.b	$D1, $E0, $F0, $0F, $0E, $F1, $71, $E3, $F0, $32, $22, $30, $F1, $07, $F1, $E2
	dc.b	$F0, $0F, $0D, $F1, $72, $D2, $F4, $32, $21, $30, $F0, $09, $F2, $0F, $0D, $F0 ;0x1C0
	dc.b	$E1, $72, $D1, $F6, $32, $21, $30, $F0, $0F, $0F, $08, $F0, $70, $D1, $72, $D1
	dc.b	$F7, $32, $20, $30, $F0, $0F, $0F, $07, $F0, $72, $D1, $71, $E1, $D0, $F2, $E0 ;0x1E0
	dc.b	$F0, $01, $F0, $31, $21, $30, $F0, $08, $F4, $0F, $07, $F0, $74, $D0, $E1, $F0
	dc.b	$E3, $F1, $03, $F0, $33, $D0, $F1, $02, $F3, $62, $71, $F0, $0F, $05, $F0, $76 ;0x200
	dc.b	$E2, $F3, $05, $F0, $32, $C1, $D1, $F2, $64, $72, $F1, $0F, $04, $F0, $77, $F3
	dc.b	$09, $F0, $C2, $D1, $C0, $D0, $60, $D0, $62, $73, $F2, $0F, $03, $F0, $76, $F4 ;0x220
	dc.b	$09, $F0, $C0, $D4, $60, $D1, $61, $74, $F2, $0F, $04, $F1, $73, $F5, $0B, $F0
	dc.b	$D1, $62, $D1, $76, $F2, $0F, $06, $F8, $0E, $F0, $62, $70, $E1, $74, $F3, $0F ;0x240
	dc.b	$08, $F5, $0F, $F0, $62, $70, $E2, $73, $F3, $0F, $0F, $0F, $F0, $61, $71, $F2
	dc.b	$71, $F4, $0F, $0F, $0F, $00, $F0, $61, $FA, $0F, $0F, $0F, $01, $F3, $72, $F4 ;0x260
	dc.b	$0F, $0F, $0F, $04, $F1, $71, $F4, $0F, $0F, $0F, $07, $F4, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x280
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $09 ;0x2A0
loc_16309:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $05, $FC, $0F, $0F, $0F, $F2, $2C ;0x0 (0x00016309-0x0001657C, Entry count: 0x273)
	dc.b	$F2, $01, $F1, $0F, $0F, $07, $F0, $2E, $11, $21, $F1, $31, $F0, $0F, $0F, $07
	dc.b	$F0, $33, $28, $30, $10, $31, $21, $33, $F0, $0F, $0F, $07, $F2, $33, $25, $31 ;0x20
	dc.b	$A0, $B0, $31, $20, $32, $F0, $0F, $0F, $0A, $F1, $34, $21, $32, $A0, $B1, $31
	dc.b	$20, $32, $F0, $0F, $0F, $0B, $F0, $37, $A2, $B1, $31, $21, $30, $F1, $0F, $0F ;0x40
	dc.b	$0A, $F0, $37, $A0, $31, $22, $10, $22, $31, $F0, $0F, $0F, $07, $F1, $31, $20
	dc.b	$33, $21, $30, $22, $14, $21, $31, $F0, $0F, $0F, $04, $F1, $31, $22, $33, $24 ;0x60
	dc.b	$10, $C0, $10, $22, $10, $20, $31, $F0, $0F, $0F, $02, $F1, $31, $23, $33, $25
	dc.b	$10, $C0, $21, $D1, $20, $10, $20, $31, $F0, $0F, $0F, $F1, $31, $25, $33, $25 ;0x80
	dc.b	$11, $20, $C1, $D1, $21, $31, $F0, $0F, $0E, $F0, $31, $27, $F0, $31, $27, $10
	dc.b	$20, $C2, $D0, $21, $31, $F0, $0F, $0D, $F0, $31, $21, $33, $22, $F0, $32, $28 ;0xA0
	dc.b	$C2, $D0, $F0, $21, $30, $F0, $0F, $0C, $F0, $3A, $20, $F0, $32, $28, $C2, $F2
	dc.b	$20, $30, $F0, $0F, $0B, $F0, $3C, $F1, $32, $24, $31, $20, $C2, $F2, $30, $F0 ;0xC0
	dc.b	$0F, $0D, $F8, $33, $F1, $33, $21, $34, $20, $C1, $F2, $30, $F0, $0F, $0F, $06
	dc.b	$F1, $31, $F2, $35, $B0, $A1, $30, $20, $C1, $F2, $D0, $F1, $0F, $0F, $04, $F1 ;0xE0
	dc.b	$33, $F1, $34, $A4, $30, $20, $C1, $F0, $A0, $F3, $0F, $0F, $01, $F1, $35, $F2
	dc.b	$32, $B0, $A1, $B1, $A6, $F3, $0F, $0F, $00, $F0, $31, $22, $33, $C4, $F0, $A1 ;0x100
	dc.b	$B1, $A6, $B0, $F1, $0F, $0F, $00, $F0, $30, $21, $35, $C6, $B0, $A1, $B3, $A1
	dc.b	$B2, $F0, $0F, $0F, $00, $F0, $30, $20, $36, $D0, $C6, $B1, $A4, $B2, $F1, $0F ;0x120
	dc.b	$0F, $00, $F0, $30, $20, $37, $D0, $C6, $F0, $B6, $F1, $0F, $0F, $01, $F0, $3A
	dc.b	$C0, $D0, $C0, $D2, $C1, $F7, $0F, $0F, $03, $F0, $35, $F1, $31, $C1, $D6, $B0 ;0x140
	dc.b	$F0, $0F, $0F, $0A, $F7, $A1, $C0, $D3, $E0, $D1, $B2, $F0, $0F, $0F, $0E, $F0
	dc.b	$A4, $D0, $E0, $D0, $E1, $B4, $F0, $0F, $0F, $0D, $F0, $B0, $A3, $B0, $D1, $31 ;0x160
	dc.b	$B5, $F0, $0F, $0F, $0D, $F0, $B0, $A1, $B2, $33, $B5, $F0, $0F, $0F, $0D, $F0
	dc.b	$B3, $35, $B4, $F1, $0F, $0F, $0E, $F1, $39, $B0, $F4, $0F, $0F, $0E, $F0, $33 ;0x180
	dc.b	$20, $34, $F5, $0F, $0F, $0E, $F0, $32, $21, $33, $F7, $0F, $0F, $0D, $F0, $30
	dc.b	$F1, $20, $32, $F9, $0F, $0F, $0D, $F2, $21, $32, $F0, $E0, $F7, $0F, $0F, $0F ;0x1A0
	dc.b	$F0, $21, $31, $F0, $E2, $F5, $0F, $0F, $0D, $F0, $C1, $21, $32, $F1, $E0, $F5
	dc.b	$0F, $0F, $0B, $F2, $C2, $20, $32, $F0, $70, $F1, $0F, $0F, $0F, $00, $F0, $70 ;0x1C0
	dc.b	$60, $D0, $C0, $D0, $C0, $32, $F0, $70, $F0, $0F, $0F, $0F, $01, $F0, $62, $D0
	dc.b	$C0, $D1, $31, $F0, $71, $F0, $0F, $0F, $0F, $00, $F0, $60, $70, $62, $D0, $C0 ;0x1E0
	dc.b	$D2, $F0, $70, $F0, $0F, $0F, $0F, $01, $F0, $71, $61, $70, $D2, $E1, $F0, $70
	dc.b	$F0, $0F, $0F, $0F, $01, $F0, $71, $60, $72, $E2, $F2, $0F, $0F, $0F, $02, $F0 ;0x200
	dc.b	$71, $61, $71, $D3, $F1, $0F, $0F, $0F, $02, $F0, $71, $60, $C1, $D2, $62, $F2
	dc.b	$0F, $0F, $0F, $01, $F0, $D1, $C2, $70, $66, $F1, $0F, $0F, $0F, $F0, $70, $63 ;0x220
	dc.b	$77, $61, $F0, $0F, $0F, $0F, $F1, $7C, $F0, $0F, $0F, $0F, $00, $F3, $78, $F1
	dc.b	$0F, $0F, $0F, $03, $FA, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x240
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F ;0x260
loc_1657C:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $06, $FC, $0F, $0F, $0F, $F2, $2C, $F2, $01, $F1, $0F ;0x0 (0x0001657C-0x00016830, Entry count: 0x2B4)
	dc.b	$0F, $07, $F0, $2E, $11, $21, $F1, $31, $F0, $0F, $0F, $07, $F0, $33, $28, $30
	dc.b	$10, $31, $21, $33, $F0, $0F, $0F, $07, $F2, $33, $25, $31, $A0, $B0, $31, $20 ;0x20
	dc.b	$32, $F0, $0F, $0F, $0A, $F1, $34, $21, $32, $A0, $B1, $31, $20, $32, $F0, $0F
	dc.b	$0F, $0B, $F0, $37, $A2, $B1, $31, $21, $30, $F1, $0F, $0F, $0A, $F0, $37, $A0 ;0x40
	dc.b	$31, $22, $10, $22, $31, $F0, $0F, $0F, $07, $F1, $31, $20, $33, $21, $30, $22
	dc.b	$14, $21, $31, $F0, $0F, $0F, $04, $F1, $31, $22, $33, $24, $10, $C0, $10, $22 ;0x60
	dc.b	$10, $20, $31, $F0, $0F, $0F, $02, $F1, $31, $23, $33, $25, $10, $C0, $21, $D1
	dc.b	$20, $10, $20, $31, $F0, $0F, $0F, $F1, $31, $25, $33, $25, $11, $20, $C1, $D1 ;0x80
	dc.b	$21, $31, $F0, $0F, $0E, $F0, $31, $27, $F0, $31, $27, $10, $20, $C2, $D0, $21
	dc.b	$31, $F0, $0F, $0D, $F0, $31, $21, $33, $22, $F0, $32, $28, $C2, $D0, $F0, $21 ;0xA0
	dc.b	$30, $F0, $0F, $0C, $F0, $3A, $20, $F0, $32, $28, $C2, $F2, $20, $30, $F0, $0F
	dc.b	$0B, $F0, $3C, $F1, $32, $24, $31, $20, $C2, $F2, $30, $F0, $0F, $0D, $F8, $33 ;0xC0
	dc.b	$F1, $33, $21, $34, $20, $C1, $F2, $30, $F0, $0F, $0F, $06, $F1, $31, $F2, $35
	dc.b	$B0, $A1, $30, $20, $C1, $F2, $D0, $F1, $0F, $0F, $04, $F1, $33, $F1, $34, $A4 ;0xE0
	dc.b	$30, $20, $C1, $F0, $A0, $F3, $0F, $0F, $01, $F1, $35, $F2, $32, $B0, $A1, $B1
	dc.b	$A6, $F3, $0F, $0F, $00, $F0, $31, $22, $33, $F3, $30, $B0, $A1, $B1, $A6, $B0 ;0x100
	dc.b	$F1, $0F, $0F, $00, $F0, $30, $22, $36, $F3, $30, $B0, $A1, $B3, $A1, $B2, $F0
	dc.b	$0F, $0F, $00, $F0, $30, $20, $3A, $F3, $B1, $A4, $B2, $F1, $0F, $0F, $00, $F0 ;0x120
	dc.b	$30, $20, $3D, $F2, $B6, $F1, $0F, $0F, $01, $F0, $3E, $A0, $B0, $30, $B2, $F5
	dc.b	$0F, $0F, $03, $F0, $3D, $A2, $B0, $A0, $B2, $F1, $01, $F4, $0F, $0F, $00, $F2 ;0x140
	dc.b	$D0, $E0, $F4, $33, $A2, $B0, $A1, $B1, $F1, $00, $F0, $C3, $D0, $F0, $0F, $0F
	dc.b	$F0, $D1, $E0, $F4, $34, $A2, $B0, $A0, $B1, $F3, $C2, $D3, $F0, $0F, $0D, $F0 ;0x160
	dc.b	$D0, $E0, $D0, $E0, $F3, $35, $A2, $B3, $F1, $D1, $C1, $D0, $E0, $D0, $C1, $D0
	dc.b	$F0, $0F, $0C, $F0, $D0, $E0, $D0, $E1, $F0, $E0, $F1, $34, $B0, $A7, $D2, $C5 ;0x180
	dc.b	$D0, $F0, $0F, $0C, $F0, $D0, $E4, $F1, $32, $20, $32, $B1, $A5, $D0, $C0, $D0
	dc.b	$C3, $D2, $F0, $0F, $0B, $F7, $33, $22, $33, $B5, $D0, $C0, $D0, $C4, $D0, $F0 ;0x1A0
	dc.b	$0F, $0B, $F0, $70, $62, $70, $34, $22, $36, $F4, $D1, $E0, $C3, $D1, $F0, $0F
	dc.b	$0A, $F0, $64, $C1, $24, $35, $FA, $D4, $F0, $0F, $0A, $F0, $70, $62, $D0, $C0 ;0x1C0
	dc.b	$F1, $38, $F5, $01, $F9, $0F, $0B, $F0, $61, $71, $D0, $C0, $F1, $35, $F2, $07
	dc.b	$F2, $E0, $D0, $F1, $0F, $0D, $F0, $61, $72, $D1, $C0, $D1, $C0, $F3, $09, $F0 ;0x1E0
	dc.b	$E3, $D1, $F0, $0F, $0D, $F0, $C0, $60, $72, $D2, $C1, $D0, $F0, $0C, $F0, $E1
	dc.b	$D3, $F0, $0F, $0D, $F0, $C1, $60, $72, $D3, $F0, $0D, $F1, $E3, $71, $FA, $0F ;0x200
	dc.b	$02, $F0, $60, $C0, $D0, $73, $F2, $0D, $F3, $74, $D2, $77, $F0, $0F, $00, $F0
	dc.b	$62, $D2, $70, $F3, $0D, $F2, $75, $E0, $D1, $76, $F1, $0F, $00, $F0, $62, $70 ;0x220
	dc.b	$D2, $E1, $F0, $0E, $F1, $76, $E2, $75, $F1, $0F, $00, $F0, $62, $72, $F0, $E1
	dc.b	$F0, $0F, $F1, $75, $F1, $E1, $73, $F2, $0F, $01, $F0, $61, $72, $F3, $0F, $00 ;0x240
	dc.b	$F2, $74, $F2, $71, $F4, $0F, $02, $F0, $61, $71, $F3, $0F, $02, $FE, $0F, $03
	dc.b	$F0, $61, $71, $F3, $0F, $03, $FB, $0F, $06, $F0, $60, $71, $F3, $0F, $05, $F4 ;0x260
	dc.b	$0F, $0D, $F5, $0F, $0F, $0F, $0A, $F2, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x280
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $02 ;0x2A0
loc_16830:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $06, $FB, $0F, $0F, $0F, $00, $F2 ;0x0 (0x00016830-0x00016AA7, Entry count: 0x277)
	dc.b	$2B, $F1, $0F, $0F, $0D, $F0, $36, $22, $11, $24, $F1, $04, $F1, $0F, $0F, $05
	dc.b	$F0, $38, $10, $32, $24, $F1, $00, $F1, $31, $F0, $0F, $0F, $05, $F1, $36, $20 ;0x20
	dc.b	$30, $B0, $32, $24, $F0, $33, $F0, $0F, $0F, $07, $F1, $36, $A0, $B1, $31, $20
	dc.b	$10, $22, $33, $F0, $0F, $0F, $09, $F0, $35, $A1, $B1, $31, $20, $10, $22, $32 ;0x40
	dc.b	$F0, $0F, $0F, $09, $F1, $34, $A1, $22, $13, $22, $31, $F0, $0F, $0F, $06, $F2
	dc.b	$36, $22, $10, $C0, $14, $21, $32, $F0, $0F, $0F, $03, $F1, $32, $21, $32, $23 ;0x60
	dc.b	$10, $C0, $10, $22, $12, $21, $32, $F0, $0F, $0F, $00, $F1, $31, $23, $32, $24
	dc.b	$11, $20, $D1, $22, $10, $21, $30, $F0, $30, $F0, $0F, $0F, $F0, $31, $25, $32 ;0x80
	dc.b	$24, $11, $20, $C1, $D1, $20, $11, $20, $30, $F0, $30, $F0, $0F, $0E, $F0, $36
	dc.b	$21, $31, $26, $10, $20, $C3, $D0, $21, $31, $F0, $30, $F0, $0F, $0D, $F0, $3C ;0xA0
	dc.b	$27, $C4, $F0, $32, $F0, $30, $F0, $0F, $0C, $F0, $3D, $27, $C3, $F1, $32, $F0
	dc.b	$30, $F0, $0F, $0D, $F5, $34, $F0, $32, $24, $31, $20, $C2, $F2, $30, $F1, $30 ;0xC0
	dc.b	$F0, $0F, $0F, $03, $F2, $31, $F0, $33, $21, $34, $20, $C1, $F2, $30, $F0, $30
	dc.b	$F0, $0F, $0F, $07, $F0, $30, $F1, $36, $A2, $30, $20, $C0, $F2, $C0, $F2, $0F ;0xE0
	dc.b	$0F, $05, $F1, $32, $F1, $34, $A4, $30, $20, $C0, $A1, $F4, $0F, $0F, $03, $F0
	dc.b	$34, $F3, $31, $B0, $A1, $B1, $A5, $F3, $0F, $0F, $03, $F0, $36, $F4, $B0, $A0 ;0x100
	dc.b	$B1, $A7, $B0, $F0, $0F, $0F, $03, $F0, $38, $F3, $B1, $A1, $B2, $A3, $B0, $F0
	dc.b	$0F, $0F, $03, $F0, $3B, $F2, $B2, $A3, $B2, $F0, $0F, $0F, $03, $F0, $34, $A2 ;0x120
	dc.b	$34, $B0, $31, $F1, $B5, $F1, $0F, $0F, $04, $F0, $32, $A3, $B1, $31, $B4, $F7
	dc.b	$0F, $0F, $05, $F0, $32, $A2, $B2, $31, $B0, $A3, $B1, $F0, $E2, $F0, $0F, $0F ;0x140
	dc.b	$07, $F0, $32, $A1, $B1, $33, $A5, $B0, $F0, $D0, $E1, $F0, $0F, $0F, $07, $F0
	dc.b	$30, $F1, $A2, $B1, $32, $A0, $33, $A0, $B0, $F0, $E1, $F0, $0F, $0F, $09, $F0 ;0x160
	dc.b	$01, $F0, $A2, $B1, $34, $C0, $32, $F2, $0F, $0F, $0D, $F1, $A0, $D3, $32, $D0
	dc.b	$C3, $30, $F0, $0F, $0F, $0E, $F1, $D1, $C0, $D1, $32, $D2, $C3, $F0, $0F, $0F ;0x180
	dc.b	$0C, $F1, $D1, $C1, $D0, $C1, $D0, $30, $70, $D0, $C1, $D1, $F0, $0F, $0F, $0D
	dc.b	$F1, $D3, $C3, $D0, $70, $65, $F0, $0F, $0F, $0C, $F0, $31, $D0, $C2, $D1, $C0 ;0x1A0
	dc.b	$D0, $71, $63, $C0, $D0, $F0, $0F, $0F, $0B, $F0, $31, $D0, $C2, $D0, $E0, $D1
	dc.b	$74, $C2, $D0, $F1, $0F, $0F, $09, $F0, $31, $D0, $C3, $D2, $73, $D0, $C0, $64 ;0x1C0
	dc.b	$F1, $0F, $0F, $07, $F0, $30, $F0, $D0, $C2, $D2, $F0, $72, $D1, $72, $64, $F1
	dc.b	$0F, $0F, $06, $F1, $E0, $D5, $F0, $70, $F2, $D0, $75, $63, $F0, $0F, $0F, $07 ;0x1E0
	dc.b	$FC, $79, $F0, $0F, $0F, $08, $F0, $E2, $F3, $01, $F7, $72, $F1, $0F, $0F, $07
	dc.b	$F1, $E5, $F0, $07, $F5, $0F, $0F, $07, $F1, $72, $E2, $F1, $0F, $0F, $0F, $04 ;0x200
	dc.b	$F1, $74, $F2, $0F, $0F, $0F, $04, $F1, $78, $F0, $0F, $0F, $0F, $03, $F1, $74
	dc.b	$E4, $F0, $0F, $0F, $0F, $02, $F2, $71, $F0, $E3, $72, $F2, $0F, $0F, $0F, $00 ;0x220
	dc.b	$F5, $78, $F1, $0F, $0F, $0F, $F4, $7A, $F0, $0F, $0F, $0F, $00, $F6, $75, $F1
	dc.b	$0F, $0F, $0F, $02, $FB, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x240
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0A ;0x260
loc_16AA7:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00016AA7-0x00016C4C, Entry count: 0x1A5)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $07, $F4, $0F, $0F, $0F, $06, $F3, $C4
	dc.b	$F1, $0F, $0F, $0F, $04, $F0, $C2, $E4, $D1, $F1, $0F, $0F, $0F, $03, $F0, $E8 ;0x40
	dc.b	$D1, $F1, $0F, $0F, $0F, $01, $F0, $EA, $D1, $F1, $0F, $0F, $0F, $F0, $EC, $D1
	dc.b	$F1, $0F, $0F, $0D, $F0, $EE, $D1, $F1, $04, $F6, $0F, $0F, $00, $F0, $E2, $D3 ;0x60
	dc.b	$F1, $E6, $D1, $F4, $D6, $F0, $01, $F5, $0F, $07, $F0, $E1, $C3, $F1, $D1, $F0
	dc.b	$D1, $E4, $D4, $C3, $D0, $F1, $E0, $F1, $12, $22, $F1, $0F, $04, $F0, $C3, $D2 ;0x80
	dc.b	$F1, $D1, $F0, $D1, $E0, $D4, $C5, $D1, $E0, $F0, $E1, $D0, $11, $33, $22, $F1
	dc.b	$0F, $01, $70, $F0, $E3, $CF, $C2, $D4, $E5, $36, $22, $F1, $0C, $70, $01, $71 ;0xA0
	dc.b	$F2, $E9, $C6, $DA, $E4, $36, $22, $F1, $0B, $72, $61, $A0, $C0, $F0, $EF, $E0
	dc.b	$DC, $E5, $34, $22, $F2, $09, $72, $60, $A0, $C0, $F2, $E0, $F0, $E0, $F0, $EF ;0xC0
	dc.b	$E2, $D7, $E6, $32, $E0, $D2, $F2, $04, $70, $00, $70, $00, $71, $60, $A0, $FF
	dc.b	$EF, $E0, $D3, $E9, $D3, $F1, $05, $70, $00, $F2, $D3, $CB, $F8, $E3, $F1, $E0 ;0xE0
	dc.b	$F1, $E0, $F0, $ED, $D2, $F0, $05, $F0, $D4, $CD, $D2, $F3, $E4, $F1, $E0, $F1
	dc.b	$E0, $F5, $EA, $F2, $05, $F0, $D4, $CA, $D2, $FF, $FC, $E3, $F2, $06, $FF, $FF ;0x100
	dc.b	$F7, $00, $FD, $07, $F0, $DE, $FB, $01, $F2, $01, $F2, $0F, $09, $F0, $DC, $FF
	dc.b	$F8, $0F, $08, $F0, $DA, $FB, $E1, $F1, $E4, $F0, $C0, $60, $70, $0F, $0A, $F1 ;0x120
	dc.b	$D7, $F2, $0A, $F1, $00, $F7, $0F, $0D, $F9, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x140
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x160
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $01 ;0x1A0
loc_16C4C:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x0 (0x00016C4C-0x00016DF7, Entry count: 0x1AB)
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x20
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $08, $F4, $0F, $0F, $0F, $06, $F3, $C4
	dc.b	$F1, $0F, $0F, $0F, $04, $F0, $C2, $E4, $D1, $F1, $0F, $0F, $0F, $03, $F0, $E8 ;0x40
	dc.b	$D1, $F1, $0F, $0F, $0F, $01, $F0, $EA, $D1, $F1, $0F, $0F, $0F, $F0, $EC, $D1
	dc.b	$F1, $0F, $0F, $0D, $F0, $EE, $D1, $F1, $04, $F6, $0F, $0F, $00, $F0, $E2, $D3 ;0x60
	dc.b	$F1, $E6, $D1, $F4, $D6, $F0, $01, $F5, $0F, $07, $F0, $E1, $C3, $F1, $D1, $F0
	dc.b	$D1, $E4, $D4, $C3, $D0, $F1, $E0, $F1, $12, $22, $F1, $0F, $04, $F0, $C3, $D2 ;0x80
	dc.b	$F1, $D1, $F0, $D1, $E0, $D4, $C5, $D1, $E0, $F0, $E1, $D0, $11, $33, $22, $F1
	dc.b	$0F, $02, $F0, $E3, $CF, $C2, $D4, $E5, $36, $22, $F1, $0C, $70, $00, $71, $60 ;0xA0
	dc.b	$F2, $E9, $C6, $DA, $E4, $36, $22, $F1, $09, $72, $62, $A1, $C0, $F0, $EF, $E0
	dc.b	$DC, $E5, $34, $22, $F2, $05, $71, $60, $70, $61, $A1, $C1, $F2, $E0, $F0, $E0 ;0xC0
	dc.b	$F0, $EF, $E2, $D7, $E6, $32, $E0, $D2, $F2, $03, $70, $00, $60, $71, $60, $A1
	dc.b	$C0, $FF, $EF, $E0, $D3, $E9, $D3, $F1, $02, $70, $00, $70, $60, $70, $F2, $D3 ;0xE0
	dc.b	$CB, $F8, $E3, $F1, $E0, $F1, $E0, $F0, $ED, $D2, $F0, $04, $70, $F0, $D4, $CD
	dc.b	$D2, $F3, $E4, $F1, $E0, $F1, $E0, $F5, $EA, $F2, $05, $F0, $D4, $CA, $D2, $FF ;0x100
	dc.b	$FC, $E3, $F2, $06, $FF, $FF, $F7, $00, $FD, $07, $F0, $DE, $FB, $01, $F2, $01
	dc.b	$F2, $0F, $09, $F0, $DC, $FF, $F8, $0F, $08, $F0, $DA, $FB, $E1, $F1, $E4, $F0 ;0x120
	dc.b	$C0, $60, $70, $0F, $0A, $F1, $D7, $F2, $0A, $F1, $00, $F7, $0F, $0D, $F9, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x140
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x160
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x180
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $00 ;0x1A0
loc_16DF7:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $08, $F3, $0F, $0F, $0F, $09, $F1, $C1, $11, $F1, $0F, $0F, $0F, $06, $F0 ;0x0 (0x00016DF7-0x000170BD, Entry count: 0x2C6)
	dc.b	$C4, $12, $F1, $0F, $0F, $0F, $03, $F0, $C3, $16, $F0, $0F, $0F, $0F, $01, $F0
	dc.b	$10, $C1, $12, $F4, $10, $F0, $0F, $0F, $0F, $00, $F0, $20, $12, $F6, $20, $F0 ;0x20
	dc.b	$0F, $0F, $0F, $00, $F2, $20, $FB, $0F, $0F, $0C, $F2, $61, $F9, $71, $F2, $0F
	dc.b	$0F, $08, $F2, $70, $61, $F5, $74, $F2, $10, $F2, $0F, $0F, $06, $F0, $70, $62 ;0x40
	dc.b	$F1, $71, $F1, $70, $61, $70, $F4, $C0, $F3, $0F, $0F, $06, $F1, $60, $F1, $72
	dc.b	$F2, $62, $F0, $10, $F3, $C1, $F2, $0F, $0F, $07, $F6, $00, $F0, $62, $F0, $C0 ;0x60
	dc.b	$F4, $10, $C1, $10, $F0, $0F, $0F, $0F, $F0, $62, $F0, $C1, $F4, $11, $F1, $0F
	dc.b	$0F, $0F, $F0, $60, $70, $60, $F0, $10, $C1, $10, $F5, $0F, $0F, $0F, $00, $F1 ;0x80
	dc.b	$71, $F1, $11, $F5, $0F, $0F, $0F, $02, $F0, $72, $F3, $72, $F0, $0F, $0F, $0F
	dc.b	$03, $F1, $70, $60, $73, $F0, $70, $60, $F0, $0F, $0F, $0F, $04, $F0, $70, $63 ;0xA0
	dc.b	$70, $F0, $61, $F1, $0F, $0F, $0F, $03, $F1, $70, $63, $70, $62, $F1, $0F, $0F
	dc.b	$0F, $03, $F1, $70, $63, $70, $61, $F1, $0F, $0F, $0F, $04, $F0, $70, $66, $70 ;0xC0
	dc.b	$F1, $0F, $0F, $0F, $02, $F3, $66, $F1, $0F, $0F, $0F, $02, $F0, $A0, $C1, $F3
	dc.b	$62, $F0, $B0, $F0, $0F, $0F, $0F, $02, $F2, $C1, $A0, $C0, $F1, $60, $70, $F1 ;0xE0
	dc.b	$0F, $0F, $0F, $03, $F5, $C0, $A0, $F0, $70, $F0, $B0, $F0, $0F, $0F, $0F, $02
	dc.b	$F0, $70, $61, $70, $F5, $A0, $F0, $0F, $0F, $0F, $02, $F0, $70, $65, $FC, $0F ;0x100
	dc.b	$0F, $0A, $F1, $71, $68, $F0, $C1, $D1, $C2, $F0, $0F, $0F, $0A, $F2, $74, $63
	dc.b	$F0, $C0, $D1, $C3, $D0, $F0, $0F, $0F, $09, $F0, $70, $F5, $73, $F0, $C0, $E0 ;0x120
	dc.b	$D0, $C2, $D1, $F0, $0F, $0F, $09, $F0, $70, $61, $72, $F5, $D0, $F0, $D0, $C2
	dc.b	$D1, $F0, $0F, $0F, $09, $F1, $70, $62, $71, $F0, $A0, $C1, $A0, $F1, $D1, $C0 ;0x140
	dc.b	$D1, $F1, $0F, $0F, $0A, $F0, $70, $62, $71, $F0, $A0, $C1, $A0, $F3, $D2, $F0
	dc.b	$0F, $0F, $0B, $F0, $75, $F0, $B0, $A1, $B0, $F0, $01, $F1, $D1, $F4, $0F, $0F ;0x160
	dc.b	$07, $F0, $76, $F4, $02, $F3, $D2, $E0, $F0, $0F, $0F, $06, $F0, $70, $61, $75
	dc.b	$F1, $60, $F1, $02, $F0, $D4, $F1, $0F, $0F, $03, $F1, $64, $73, $F1, $71, $61 ;0x180
	dc.b	$F0, $01, $F0, $D4, $F0, $E0, $F0, $0F, $0E, $F4, $60, $70, $61, $73, $F2, $74
	dc.b	$60, $F0, $00, $F0, $E0, $D2, $E0, $F0, $D0, $F0, $0F, $09, $F4, $C0, $F0, $63 ;0x1A0
	dc.b	$70, $60, $71, $F8, $72, $60, $F2, $E2, $F0, $D0, $F0, $0F, $09, $F0, $C0, $F0
	dc.b	$C1, $F0, $C0, $F0, $62, $72, $F2, $71, $F1, $02, $F1, $71, $F0, $D0, $F3, $E0 ;0x1C0
	dc.b	$F0, $D0, $F0, $0F, $09, $F0, $C0, $F0, $D1, $F0, $C0, $F0, $60, $71, $F4, $72
	dc.b	$F0, $04, $F0, $70, $F0, $D0, $F2, $D0, $F1, $E0, $F0, $0F, $0A, $F0, $C0, $F0 ;0x1E0
	dc.b	$D0, $F1, $D0, $F7, $72, $F1, $04, $F1, $E0, $F2, $E0, $F2, $E0, $F0, $0F, $0A
	dc.b	$F0, $C0, $F3, $D0, $F3, $00, $F1, $72, $F1, $06, $F7, $E0, $F0, $0F, $0B, $F0 ;0x200
	dc.b	$C0, $F4, $E0, $F0, $01, $F1, $E0, $F0, $70, $F1, $07, $F0, $E1, $D1, $F1, $D0
	dc.b	$F0, $0F, $0C, $F0, $C0, $F2, $D0, $F1, $01, $F0, $E0, $F0, $E1, $F1, $08, $F1 ;0x220
	dc.b	$E1, $F1, $D0, $F0, $0F, $0D, $F0, $D0, $F2, $E0, $F1, $01, $F0, $E1, $F1, $E1
	dc.b	$F0, $00, $F3, $03, $F2, $E1, $F0, $0F, $0E, $F1, $D0, $F0, $D0, $F6, $E0, $F5 ;0x240
	dc.b	$E3, $F0, $04, $F2, $0F, $0F, $00, $F0, $D0, $F0, $C3, $F2, $E0, $F5, $E5, $F0
	dc.b	$0F, $0F, $07, $F0, $C0, $F0, $C4, $F0, $00, $F0, $E1, $F3, $E5, $F0, $0F, $0F ;0x260
	dc.b	$07, $F1, $C0, $F0, $D0, $C1, $D0, $F0, $01, $F1, $E1, $F8, $0F, $0F, $08, $F0
	dc.b	$D0, $F0, $D2, $F1, $03, $F1, $E7, $F0, $0F, $0F, $08, $F0, $D0, $F4, $06, $F7 ;0x280
	dc.b	$0F, $0F, $09, $F1, $D1, $F1, $0F, $0F, $0F, $0A, $F3, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x2A0
	dc.b	$0F, $0F, $0F, $0F, $0F, $09 ;0x2C0
loc_170BD:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $07, $F5, $0F, $0F, $0F, $07, $F1
	dc.b	$C3, $11, $F1, $0F, $0F, $0F, $04, $F0, $C6, $12, $F0, $0F, $0F, $0F, $02, $F0 ;0x0 (0x000170BD-0x0001736B, Entry count: 0x2AE)
	dc.b	$10, $C3, $16, $F0, $0F, $0F, $0F, $00, $F0, $11, $C1, $11, $F5, $10, $F0, $0F
	dc.b	$0F, $0F, $F1, $20, $11, $F6, $21, $F1, $0F, $0F, $0C, $F4, $20, $F5, $32, $F2 ;0x20
	dc.b	$0F, $0F, $0A, $F2, $70, $62, $70, $FA, $0F, $0F, $0B, $F0, $70, $62, $70, $F7
	dc.b	$0F, $0F, $0F, $01, $F1, $70, $F2, $71, $F2, $04, $F6, $0F, $0F, $09, $F7, $00 ;0x40
	dc.b	$F3, $01, $F0, $70, $61, $71, $F1, $0F, $0F, $0F, $F1, $61, $71, $F1, $70, $63
	dc.b	$71, $F1, $0F, $0F, $0D, $F0, $64, $73, $60, $F6, $0F, $0F, $0C, $F0, $70, $61 ;0x60
	dc.b	$70, $F4, $70, $F1, $10, $F2, $10, $F0, $0F, $0F, $0C, $F0, $61, $F5, $10, $F1
	dc.b	$C1, $F2, $10, $F0, $0F, $0F, $0C, $F1, $60, $F0, $C1, $F2, $10, $F1, $10, $C0 ;0x80
	dc.b	$F4, $0F, $0F, $0C, $F1, $70, $F0, $10, $C0, $F6, $12, $F1, $0F, $0F, $0E, $F1
	dc.b	$70, $F0, $12, $F8, $0F, $0F, $0F, $00, $F6, $71, $F1, $71, $F1, $0F, $0F, $0F ;0xA0
	dc.b	$02, $F1, $72, $60, $70, $F0, $70, $60, $70, $F0, $0F, $0F, $0F, $04, $F0, $70
	dc.b	$62, $70, $F0, $70, $60, $70, $F0, $0F, $0F, $0F, $04, $F0, $71, $62, $71, $61 ;0xC0
	dc.b	$F1, $0F, $0F, $0F, $03, $F1, $70, $63, $70, $61, $70, $F1, $0F, $0F, $0F, $03
	dc.b	$F0, $71, $66, $70, $F1, $0F, $0F, $0F, $02, $F6, $62, $70, $F0, $B0, $F0, $0F ;0xE0
	dc.b	$0F, $0F, $00, $F0, $B0, $A0, $C4, $F1, $61, $70, $F0, $A0, $F0, $0F, $0F, $0F
	dc.b	$F7, $C0, $A0, $F3, $B0, $F0, $0F, $0F, $0E, $F0, $66, $70, $F1, $A1, $F2, $A0 ;0x100
	dc.b	$F0, $0F, $0F, $0D, $F0, $62, $73, $61, $70, $F1, $C0, $F1, $B0, $F0, $0F, $0F
	dc.b	$0D, $F0, $70, $61, $70, $F1, $70, $62, $71, $F0, $A0, $B0, $F1, $0F, $0F, $0D ;0x120
	dc.b	$F0, $73, $F4, $60, $71, $F0, $B0, $A1, $F0, $0F, $0F, $0E, $F1, $70, $F1, $C0
	dc.b	$D0, $C0, $F1, $60, $70, $F0, $B0, $A0, $C0, $F0, $0F, $0F, $0F, $00, $F1, $C0 ;0x140
	dc.b	$D0, $C2, $D0, $F3, $A0, $C1, $F0, $0F, $0F, $0F, $00, $F0, $C0, $D0, $C3, $F1
	dc.b	$70, $F0, $B0, $A0, $C0, $F0, $0F, $0F, $0F, $00, $F0, $D0, $C4, $D0, $F0, $70 ;0x160
	dc.b	$F1, $B0, $A0, $F0, $0F, $0F, $0F, $00, $F0, $D1, $C3, $D0, $F0, $71, $F3, $0F
	dc.b	$0F, $0F, $01, $F1, $D0, $C1, $D0, $E0, $F0, $60, $71, $F1, $0F, $0F, $0F, $02 ;0x180
	dc.b	$F1, $D3, $E0, $62, $70, $F1, $0F, $0F, $0F, $03, $F1, $E2, $F0, $62, $70, $F2
	dc.b	$0F, $0F, $0F, $02, $F5, $61, $70, $F1, $70, $F0, $0F, $0F, $0B, $F7, $63, $72 ;0x1A0
	dc.b	$F1, $70, $61, $F0, $0F, $0F, $08, $F1, $E0, $F0, $E0, $F3, $71, $61, $70, $F3
	dc.b	$73, $60, $F0, $0F, $0F, $06, $F1, $E0, $F0, $E0, $F2, $C0, $D0, $F1, $71, $F1 ;0x1C0
	dc.b	$00, $F2, $73, $60, $F0, $0F, $0F, $05, $F0, $E1, $F0, $E0, $F3, $C0, $D0, $E0
	dc.b	$F2, $03, $F2, $72, $F0, $0F, $0F, $05, $F0, $E0, $F1, $E0, $F1, $C0, $F1, $C1 ;0x1E0
	dc.b	$D1, $F0, $01, $F4, $71, $F1, $0F, $0F, $05, $F0, $E0, $F4, $C0, $D0, $F8, $D0
	dc.b	$C1, $D0, $F0, $70, $F0, $02, $F3, $0F, $0F, $F0, $E0, $F3, $D0, $F5, $C0, $D0 ;0x200
	dc.b	$F1, $D0, $C3, $D0, $F2, $00, $F1, $E0, $D0, $E0, $F1, $0F, $0E, $F4, $D0, $C1
	dc.b	$F7, $D0, $C2, $D1, $F0, $E0, $F1, $E1, $D2, $E0, $F1, $0F, $0D, $F0, $E0, $F5 ;0x220
	dc.b	$C1, $FC, $E0, $F1, $E1, $D2, $F0, $D0, $F0, $0F, $0D, $F0, $E0, $F1, $E2, $F2
	dc.b	$D3, $C4, $D2, $F3, $E2, $D1, $F0, $D0, $F0, $0F, $0E, $F0, $E0, $F1, $E3, $FD ;0x240
	dc.b	$E1, $F1, $E1, $F1, $D0, $F0, $0F, $0F, $00, $F0, $E1, $F3, $E0, $F0, $04, $F0
	dc.b	$E1, $D1, $F7, $E0, $D0, $F0, $0F, $0F, $02, $F1, $E3, $F0, $05, $F0, $E1, $F6 ;0x260
	dc.b	$E2, $F1, $0F, $0F, $05, $F3, $06, $F1, $E1, $D5, $F2, $0F, $0F, $0F, $04, $F7
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x280
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $03 ;0x2A0
loc_1736B:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0A, $F3, $0F, $0F, $0F, $09, $F1, $C1, $11, $F1, $0F, $0F, $0F, $06, $F0 ;0x0 (0x0001736B-0x00017639, Entry count: 0x2CE)
	dc.b	$C4, $12, $F1, $0F, $0F, $0F, $03, $F0, $C3, $16, $F0, $0F, $0F, $0F, $01, $F0
	dc.b	$10, $C1, $12, $F4, $10, $F0, $0F, $0F, $0F, $00, $F1, $20, $11, $F6, $20, $F0 ;0x20
	dc.b	$0F, $0F, $0F, $00, $F1, $20, $FB, $0F, $0F, $0D, $F2, $61, $F8, $72, $F1, $0F
	dc.b	$0F, $09, $F2, $70, $61, $F3, $70, $60, $73, $F1, $70, $F3, $0F, $0F, $07, $F0 ;0x40
	dc.b	$70, $62, $F1, $71, $F0, $62, $70, $F5, $10, $F2, $0F, $0F, $07, $F1, $60, $F1
	dc.b	$72, $F0, $70, $62, $F0, $10, $F3, $C0, $F3, $0F, $0F, $08, $F7, $62, $F0, $C0 ;0x60
	dc.b	$F4, $C1, $F2, $0F, $0F, $0F, $F0, $60, $70, $60, $F0, $C1, $F3, $10, $C1, $10
	dc.b	$F0, $0F, $0F, $0F, $F0, $60, $71, $F0, $10, $C1, $10, $F2, $11, $F1, $0F, $0F ;0x80
	dc.b	$0F, $F1, $60, $F2, $11, $F6, $0F, $0F, $0F, $01, $F0, $72, $F7, $0F, $0F, $0F
	dc.b	$03, $F1, $70, $61, $72, $F0, $70, $F0, $0F, $0F, $0F, $05, $F1, $70, $62, $70 ;0xA0
	dc.b	$F0, $70, $F0, $0F, $0F, $0F, $05, $F2, $62, $70, $F0, $70, $F1, $0F, $0F, $0F
	dc.b	$03, $F3, $70, $62, $70, $F0, $70, $F1, $0F, $0F, $0F, $02, $F0, $C2, $F1, $61 ;0xC0
	dc.b	$70, $F0, $70, $F2, $0F, $0F, $0F, $00, $F3, $A0, $C1, $F0, $61, $70, $60, $F1
	dc.b	$70, $F1, $0F, $0F, $0E, $F1, $61, $F2, $A0, $F0, $62, $F2, $71, $F5, $0F, $0F ;0xE0
	dc.b	$07, $F0, $61, $70, $62, $70, $F0, $A0, $F0, $61, $F0, $B0, $F0, $72, $F0, $D0
	dc.b	$E0, $D0, $E0, $F0, $0F, $0F, $05, $F0, $61, $73, $61, $70, $F0, $A0, $F0, $60 ;0x100
	dc.b	$F0, $A0, $F1, $70, $F0, $D0, $E0, $D2, $E0, $F0, $0F, $0F, $04, $F0, $61, $70
	dc.b	$F2, $72, $F0, $C0, $F0, $60, $F0, $B0, $F3, $E1, $D3, $F0, $0F, $0F, $04, $F0 ;0x120
	dc.b	$61, $70, $F1, $70, $F1, $70, $60, $F0, $A0, $F0, $60, $F0, $A0, $F0, $00, $F0
	dc.b	$E2, $D2, $F0, $0F, $0F, $01, $F4, $71, $F1, $60, $71, $61, $F0, $A0, $F2, $A0 ;0x140
	dc.b	$F0, $00, $F2, $E0, $D1, $E0, $F0, $0F, $0F, $00, $F1, $C1, $D0, $C0, $F3, $70
	dc.b	$63, $70, $F0, $B0, $A1, $B0, $F0, $02, $F1, $E1, $F1, $0F, $0F, $00, $F0, $D0 ;0x160
	dc.b	$C2, $D1, $F2, $70, $63, $70, $F0, $A0, $C1, $A0, $F0, $03, $F3, $0F, $0F, $01
	dc.b	$F0, $D0, $C2, $D1, $F1, $00, $F0, $70, $60, $72, $F0, $A0, $C1, $A0, $F0, $0F ;0x180
	dc.b	$0F, $06, $F3, $D1, $C1, $D0, $F1, $01, $F0, $74, $F0, $A0, $C1, $A0, $F0, $0F
	dc.b	$0F, $05, $F0, $E0, $D4, $C1, $F1, $02, $F1, $74, $F4, $0F, $0F, $05, $F9, $04 ;0x1A0
	dc.b	$F0, $72, $61, $70, $F5, $08, $F3, $0F, $0F, $05, $F1, $70, $67, $F2, $06, $F0
	dc.b	$D0, $C1, $D0, $F1, $0F, $0F, $04, $F1, $70, $65, $72, $F0, $06, $F0, $C3, $F0 ;0x1C0
	dc.b	$C0, $F0, $0F, $0F, $03, $F2, $79, $F1, $03, $F0, $D2, $C1, $F0, $C0, $F0, $0F
	dc.b	$0F, $02, $F1, $70, $F6, $72, $62, $F1, $00, $F2, $D1, $C0, $D0, $F0, $C0, $F0 ;0x1E0
	dc.b	$0F, $0F, $01, $F2, $60, $72, $F5, $72, $60, $F6, $D1, $F0, $C0, $F0, $0F, $0F
	dc.b	$02, $F0, $E0, $F0, $60, $72, $F3, $E0, $F2, $70, $F2, $C0, $F1, $C0, $F2, $C0 ;0x200
	dc.b	$F0, $0F, $0F, $04, $F2, $71, $F3, $E3, $F3, $C0, $D0, $F0, $D0, $C0, $F1, $D0
	dc.b	$F0, $0F, $0F, $06, $F0, $70, $FC, $C0, $D0, $F1, $D0, $F1, $D0, $F0, $0F, $0F ;0x220
	dc.b	$07, $F0, $60, $71, $F1, $E5, $F1, $D1, $F4, $C0, $F0, $0F, $0F, $07, $F1, $60
	dc.b	$71, $F7, $00, $F1, $D1, $F2, $C0, $F0, $0F, $0F, $07, $F3, $71, $F0, $08, $F0 ;0x240
	dc.b	$D0, $F1, $C1, $F0, $0F, $0F, $08, $F6, $08, $F1, $D1, $F1, $0F, $0F, $08, $F1
	dc.b	$D0, $F3, $E0, $F0, $00, $F4, $02, $F2, $0F, $0F, $0A, $F2, $E0, $D1, $E0, $F3 ;0x260
	dc.b	$D1, $E0, $F1, $0F, $0F, $0F, $F0, $D0, $E0, $F3, $D0, $E0, $F0, $E0, $D2, $E0
	dc.b	$F0, $0F, $0F, $0F, $F1, $D0, $E0, $F5, $E1, $D0, $E1, $F0, $0F, $0F, $0E, $F0 ;0x280
	dc.b	$E1, $FD, $0F, $0F, $0F, $F1, $D3, $E2, $D4, $E0, $F0, $0F, $0F, $0F, $01, $FC
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x2A0
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $08 ;0x2C0
loc_17639:
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0A, $F4, $0F, $0F, $0F, $08, $F1, $C1, $12, $F1, $0F ;0x0 (0x00017639-0x0001791E, Entry count: 0x2E5)
	dc.b	$0F, $0F, $05, $F0, $C4, $13, $F0, $0F, $0F, $0F, $03, $F0, $10, $C1, $12, $F3
	dc.b	$10, $F0, $0F, $0F, $0F, $01, $F0, $20, $12, $F9, $0F, $0F, $0F, $00, $F0, $21 ;0x20
	dc.b	$F6, $71, $F3, $0F, $0F, $0D, $F5, $70, $61, $70, $F2, $70, $F0, $10, $F2, $0F
	dc.b	$0F, $09, $F2, $61, $F2, $70, $62, $F0, $10, $F2, $C0, $F3, $0F, $0F, $06, $F2 ;0x40
	dc.b	$62, $F4, $62, $F0, $C0, $F3, $C1, $F2, $0F, $0F, $05, $F0, $63, $F1, $71, $F1
	dc.b	$70, $62, $F0, $C1, $F2, $10, $C1, $10, $F0, $0F, $0F, $05, $F4, $71, $F1, $00 ;0x60
	dc.b	$F0, $60, $70, $61, $F0, $10, $C1, $10, $F1, $11, $F1, $0F, $0F, $07, $F4, $02
	dc.b	$F0, $60, $70, $61, $F1, $11, $F5, $0F, $0F, $0F, $00, $F0, $71, $F0, $71, $F3 ;0x80
	dc.b	$70, $F1, $0F, $0F, $0F, $02, $F1, $60, $70, $F7, $0F, $0F, $0F, $04, $F0, $62
	dc.b	$72, $F0, $70, $F0, $0F, $0F, $0F, $05, $F0, $70, $63, $70, $F0, $60, $F0, $0F ;0xA0
	dc.b	$0F, $0F, $05, $F1, $64, $F0, $70, $60, $F0, $0F, $0F, $0F, $05, $F0, $70, $63
	dc.b	$71, $60, $F1, $0F, $0F, $0F, $04, $F4, $61, $70, $60, $70, $F1, $0F, $0F, $0F ;0xC0
	dc.b	$02, $F0, $A0, $C0, $A0, $C0, $A0, $F1, $60, $71, $F1, $0F, $0F, $0F, $03, $F3
	dc.b	$C0, $A0, $C0, $F0, $71, $F0, $B0, $F0, $0F, $0F, $0F, $01, $F0, $70, $60, $71 ;0xE0
	dc.b	$F1, $A0, $C0, $F2, $A0, $F0, $0F, $0F, $0F, $01, $F0, $70, $62, $70, $FF, $F5
	dc.b	$0F, $0F, $03, $F0, $71, $6B, $F0, $C0, $D0, $C2, $D4, $E0, $F0, $0F, $0F, $03 ;0x100
	dc.b	$F1, $73, $68, $F0, $C0, $E0, $D0, $C1, $D1, $F3, $0F, $0F, $03, $F0, $71, $F1
	dc.b	$7A, $F0, $C0, $E0, $D0, $C1, $D1, $F0, $0F, $0F, $06, $F0, $71, $FD, $D0, $F0 ;0x120
	dc.b	$D0, $C0, $D2, $F0, $0F, $0F, $06, $F0, $71, $F1, $71, $62, $F1, $B1, $F4, $D3
	dc.b	$F1, $0F, $0F, $06, $F0, $71, $F1, $70, $63, $F0, $A0, $C1, $A0, $F0, $01, $F5 ;0x140
	dc.b	$0F, $0F, $07, $F0, $71, $F1, $71, $61, $70, $F0, $A0, $C1, $A0, $F0, $0F, $0F
	dc.b	$0F, $F1, $71, $F0, $74, $F0, $A0, $C1, $A0, $F0, $0F, $0F, $0F, $00, $F0, $71 ;0x160
	dc.b	$F1, $73, $F0, $B0, $A1, $B0, $F0, $0F, $0F, $0F, $00, $F2, $E0, $F0, $74, $F4
	dc.b	$0F, $0F, $0F, $01, $F0, $E0, $D0, $F0, $76, $F3, $0F, $0F, $0F, $00, $F0, $E1 ;0x180
	dc.b	$F0, $71, $62, $70, $F1, $72, $F1, $0F, $0F, $0F, $F3, $70, $62, $70, $F0, $75
	dc.b	$F0, $0F, $0F, $0D, $F1, $60, $F1, $71, $62, $F3, $73, $F1, $0F, $0F, $04, $F6 ;0x1A0
	dc.b	$60, $72, $F1, $70, $62, $F0, $00, $F3, $72, $F0, $0F, $0F, $04, $F0, $D1, $E0
	dc.b	$D0, $F0, $73, $F2, $70, $62, $F0, $02, $F2, $70, $F2, $0F, $0F, $02, $F0, $D0 ;0x1C0
	dc.b	$E1, $F0, $D0, $F0, $71, $F2, $00, $F1, $70, $60, $70, $F0, $04, $F2, $70, $F0
	dc.b	$05, $F3, $0F, $08, $F0, $D0, $E0, $F1, $D0, $F3, $02, $F0, $72, $F1, $04, $F1 ;0x1E0
	dc.b	$71, $F0, $04, $F0, $E3, $F0, $0F, $07, $F0, $D0, $F2, $E1, $F1, $03, $F0, $70
	dc.b	$61, $F0, $05, $F2, $71, $F0, $02, $F0, $E4, $F1, $0F, $06, $F0, $D0, $F5, $04 ;0x200
	dc.b	$F0, $70, $60, $70, $F0, $06, $F8, $E3, $F0, $E0, $F0, $0F, $06, $F0, $E0, $F1
	dc.b	$D0, $F1, $04, $F0, $70, $61, $F1, $06, $F4, $E0, $F3, $E2, $F0, $E0, $F0, $0F ;0x220
	dc.b	$06, $F0, $E0, $F1, $E0, $F1, $04, $F0, $70, $61, $F0, $08, $F0, $E2, $F2, $E0
	dc.b	$F3, $E0, $F0, $0F, $07, $F1, $E0, $F4, $02, $F6, $07, $F5, $E0, $F2, $E1, $F0 ;0x240
	dc.b	$0F, $09, $F0, $D0, $F0, $E0, $D0, $E1, $F0, $00, $F0, $C1, $F2, $E0, $F1, $01
	dc.b	$F2, $01, $F0, $E0, $F6, $E0, $F1, $0F, $0A, $F0, $D0, $F0, $D2, $E0, $F0, $00 ;0x260
	dc.b	$F1, $D0, $C1, $D0, $F4, $C2, $F0, $00, $F0, $E2, $F3, $E0, $F0, $0F, $0C, $F1
	dc.b	$D0, $F0, $D1, $E0, $F1, $C0, $D0, $F3, $C0, $D0, $F1, $D2, $C1, $F6, $E1, $F0 ;0x280
	dc.b	$0F, $0E, $F0, $E0, $F0, $E2, $F1, $C1, $D0, $F5, $E0, $D4, $F0, $00, $F0, $E3
	dc.b	$F1, $0F, $0F, $F1, $E0, $F2, $00, $FF, $F0, $01, $F3, $0F, $0F, $02, $F3, $01 ;0x2A0
	dc.b	$F0, $D0, $C3, $D3, $C4, $D0, $F0, $0F, $0F, $0F, $FE, $0F, $0F, $0F, $0F, $0F
	dc.b	$0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ;0x2C0
	dc.b	$0F, $0F, $0F, $0F, $05 ;0x2E0
	dc.l	loc_19D5B
	dc.l	loc_1A9D7
	dc.l	loc_1C499
	dc.l	loc_1D55E
	dc.l	loc_1907F
	dc.l	loc_17936
loc_17936:
	dc.b	$7F, $7F, $7F ;0x0 (0x00017936-0x00017939, Entry count: 0x3)
	dc.b	$54, $96, $7F, $29, $8B, $69, $A8, $7F, $1C, $84, $09, $85, $5E, $B4, $7F, $13
	dc.b	$83, $12, $83, $56, $93, $16, $93, $41, $85, $45, $81, $18, $83, $4F, $8E, $28 ;0x0 (0x00017939-0x0001907F, Entry count: 0x1746)
	dc.b	$8E, $3C, $81, $03, $83, $41, $81, $1C, $82, $49, $8C, $34, $8C, $37, $81, $07
	dc.b	$82, $3E, $81, $1F, $82, $44, $8E, $3A, $8A, $34, $80, $0A, $81, $3D, $80, $22 ;0x20
	dc.b	$82, $3F, $92, $3D, $89, $30, $81, $0B, $81, $3B, $81, $1C, $83, $03, $81, $3B
	dc.b	$96, $40, $88, $2D, $81, $0B, $81, $3A, $81, $1C, $80, $03, $81, $02, $82, $36 ;0x40
	dc.b	$88, $01, $8E, $43, $88, $29, $85, $07, $82, $3A, $81, $1B, $80, $06, $80, $03
	dc.b	$81, $33, $87, $04, $81, $05, $86, $46, $87, $27, $81, $02, $84, $03, $82, $3A ;0x60
	dc.b	$81, $1B, $80, $07, $81, $02, $82, $2F, $86, $06, $81, $07, $85, $49, $86, $24
	dc.b	$82, $06, $82, $00, $83, $39, $82, $1B, $80, $09, $80, $03, $81, $2B, $86, $09 ;0x80
	dc.b	$81, $07, $85, $4C, $86, $21, $80, $0A, $84, $3A, $82, $1C, $80, $09, $80, $03
	dc.b	$81, $28, $86, $0A, $81, $08, $86, $4D, $86, $1E, $81, $06, $81, $02, $83, $3A ;0xA0
	dc.b	$82, $1C, $80, $09, $80, $04, $81, $25, $86, $0C, $81, $08, $86, $4F, $86, $1C
	dc.b	$82, $07, $81, $00, $82, $3B, $82, $1C, $80, $0A, $80, $04, $81, $22, $85, $0E ;0xC0
	dc.b	$81, $09, $86, $49, $8E, $19, $81, $05, $81, $03, $83, $3B, $82, $1D, $80, $09
	dc.b	$80, $05, $81, $1F, $85, $0F, $81, $0B, $85, $48, $91, $17, $81, $07, $81, $01 ;0xE0
	dc.b	$82, $3C, $83, $1C, $80, $09, $80, $06, $81, $1D, $84, $11, $81, $0B, $85, $48
	dc.b	$92, $15, $86, $05, $84, $3C, $83, $1D, $80, $09, $80, $06, $81, $1A, $84, $12 ;0x100
	dc.b	$81, $0C, $86, $44, $8F, $02, $84, $13, $81, $03, $83, $03, $82, $3D, $83, $1E
	dc.b	$80, $08, $80, $07, $81, $17, $84, $14, $81, $0C, $86, $43, $81, $09, $84, $04 ;0x120
	dc.b	$84, $10, $81, $01, $80, $04, $82, $01, $82, $3E, $82, $1F, $81, $06, $80, $08
	dc.b	$81, $15, $84, $14, $81, $0D, $86, $43, $81, $09, $84, $05, $84, $0F, $80, $02 ;0x140
	dc.b	$80, $03, $80, $01, $84, $3F, $83, $20, $82, $02, $80, $02, $83, $03, $81, $12
	dc.b	$84, $15, $81, $0F, $85, $43, $81, $08, $84, $08, $84, $0C, $81, $01, $80, $03 ;0x160
	dc.b	$80, $03, $83, $3F, $83, $23, $82, $02, $80, $03, $81, $02, $81, $10, $83, $17
	dc.b	$81, $0F, $85, $42, $81, $09, $84, $0A, $83, $0B, $80, $02, $80, $03, $80, $03 ;0x180
	dc.b	$82, $41, $82, $28, $80, $06, $80, $02, $80, $0E, $84, $17, $81, $10, $86, $41
	dc.b	$81, $09, $84, $0B, $84, $08, $81, $01, $80, $03, $80, $03, $83, $41, $83, $27 ;0x1A0
	dc.b	$80, $07, $80, $01, $81, $0C, $83, $19, $81, $10, $86, $41, $81, $08, $84, $0E
	dc.b	$83, $07, $80, $02, $80, $03, $80, $03, $82, $43, $83, $26, $80, $08, $80, $01 ;0x1C0
	dc.b	$81, $09, $84, $19, $81, $11, $86, $40, $81, $09, $84, $0F, $84, $04, $81, $01
	dc.b	$80, $03, $80, $03, $83, $43, $83, $27, $80, $07, $80, $02, $81, $07, $83, $1B ;0x1E0
	dc.b	$81, $12, $85, $1F, $87, $01, $8A, $0B, $81, $09, $84, $11, $83, $03, $80, $02
	dc.b	$80, $03, $80, $03, $82, $45, $83, $26, $80, $08, $80, $02, $80, $06, $83, $1B ;0x200
	dc.b	$81, $13, $85, $1B, $99, $0A, $81, $08, $84, $13, $83, $01, $81, $01, $80, $03
	dc.b	$80, $03, $83, $46, $83, $26, $80, $07, $80, $02, $81, $04, $82, $1C, $81, $14 ;0x220
	dc.b	$86, $14, $A0, $05, $84, $09, $8B, $0E, $82, $00, $80, $02, $80, $03, $80, $03
	dc.b	$82, $47, $84, $25, $80, $08, $80, $02, $81, $01, $83, $1D, $81, $07, $81, $0A ;0x240
	dc.b	$86, $13, $A2, $03, $85, $09, $8C, $0E, $83, $01, $80, $03, $80, $03, $83, $48
	dc.b	$84, $25, $80, $07, $80, $03, $85, $1D, $81, $08, $81, $0A, $86, $13, $88, $04 ;0x260
	dc.b	$83, $08, $87, $03, $85, $08, $8D, $0F, $81, $02, $80, $03, $80, $03, $82, $4A
	dc.b	$84, $25, $80, $06, $80, $03, $84, $1E, $81, $07, $82, $0B, $85, $10, $87, $08 ;0x280
	dc.b	$82, $0A, $87, $00, $86, $09, $8C, $10, $81, $01, $80, $03, $80, $03, $83, $4B
	dc.b	$85, $24, $81, $04, $80, $04, $81, $1F, $81, $07, $83, $0B, $85, $0F, $81, $0F ;0x2A0
	dc.b	$81, $0C, $87, $18, $83, $11, $80, $02, $80, $03, $80, $03, $82, $22, $82, $27
	dc.b	$86, $24, $81, $01, $80, $05, $81, $1E, $81, $08, $83, $0B, $86, $0E, $81, $1F ;0x2C0
	dc.b	$86, $18, $82, $11, $81, $01, $80, $03, $80, $03, $83, $20, $82, $00, $82, $27
	dc.b	$89, $21, $81, $07, $80, $1E, $81, $07, $85, $0A, $86, $0F, $84, $1B, $84, $00 ;0x2E0
	dc.b	$80, $17, $81, $13, $80, $02, $80, $03, $80, $03, $82, $20, $81, $04, $81, $28
	dc.b	$8C, $26, $81, $1C, $81, $08, $85, $0A, $86, $13, $82, $0C, $81, $0B, $83, $00 ;0x300
	dc.b	$80, $16, $81, $13, $81, $01, $80, $03, $80, $03, $83, $1E, $82, $06, $81, $2A
	dc.b	$8B, $1D, $83, $03, $80, $1C, $81, $07, $86, $0B, $85, $14, $81, $0B, $82, $0B ;0x320
	dc.b	$83, $00, $86, $09, $87, $14, $80, $02, $80, $03, $80, $03, $82, $1D, $82, $09
	dc.b	$82, $2C, $89, $1A, $80, $03, $81, $01, $81, $1A, $81, $07, $87, $0B, $85, $14 ;0x340
	dc.b	$81, $0A, $83, $0A, $83, $05, $81, $09, $84, $17, $81, $01, $80, $03, $80, $03
	dc.b	$83, $1C, $81, $0D, $81, $30, $85, $19, $80, $05, $80, $01, $80, $1A, $81, $07 ;0x360
	dc.b	$87, $0B, $86, $12, $81, $0B, $83, $0A, $81, $07, $81, $09, $84, $17, $80, $02
	dc.b	$80, $03, $80, $03, $82, $1B, $82, $0F, $81, $32, $84, $16, $80, $06, $80, $01 ;0x380
	dc.b	$81, $18, $81, $07, $89, $0A, $86, $12, $81, $0A, $85, $08, $81, $08, $81, $09
	dc.b	$84, $16, $81, $01, $80, $03, $80, $03, $83, $1A, $81, $12, $82, $31, $84, $15 ;0x3A0
	dc.b	$80, $07, $80, $01, $80, $17, $81, $08, $89, $0A, $86, $12, $81, $0A, $87, $04
	dc.b	$82, $08, $81, $09, $84, $17, $80, $02, $80, $03, $80, $03, $83, $18, $82, $15 ;0x3C0
	dc.b	$81, $32, $83, $14, $80, $07, $80, $01, $81, $16, $81, $07, $8A, $0B, $85, $11
	dc.b	$81, $0A, $84, $02, $86, $0A, $81, $09, $84, $16, $81, $01, $80, $03, $80, $03 ;0x3E0
	dc.b	$85, $15, $82, $18, $81, $32, $83, $14, $80, $07, $80, $01, $80, $15, $81, $08
	dc.b	$8A, $0B, $85, $11, $81, $0A, $84, $14, $81, $09, $84, $16, $80, $02, $80, $03 ;0x400
	dc.b	$80, $03, $82, $00, $82, $13, $81, $1B, $82, $31, $82, $14, $80, $07, $80, $01
	dc.b	$81, $14, $81, $1F, $86, $10, $81, $0A, $83, $14, $81, $09, $85, $15, $81, $01 ;0x420
	dc.b	$80, $03, $80, $03, $83, $01, $82, $10, $82, $1E, $81, $0C, $80, $23, $82, $14
	dc.b	$80, $06, $80, $02, $80, $13, $81, $20, $86, $10, $81, $09, $84, $14, $81, $09 ;0x440
	dc.b	$84, $16, $80, $02, $80, $03, $80, $03, $82, $03, $82, $0E, $81, $21, $80, $0C
	dc.b	$81, $22, $82, $14, $80, $06, $80, $02, $80, $12, $81, $21, $86, $0F, $81, $0A ;0x460
	dc.b	$84, $14, $81, $09, $84, $15, $81, $01, $80, $03, $80, $03, $83, $03, $82, $0C
	dc.b	$82, $20, $82, $0C, $80, $00, $80, $22, $82, $14, $80, $05, $80, $02, $81, $11 ;0x480
	dc.b	$81, $22, $85, $0F, $81, $09, $84, $15, $81, $09, $84, $15, $80, $02, $80, $03
	dc.b	$80, $03, $82, $05, $82, $09, $82, $21, $82, $0D, $80, $01, $82, $11, $85, $07 ;0x4A0
	dc.b	$82, $15, $81, $01, $81, $04, $80, $10, $81, $23, $85, $0F, $81, $09, $84, $14
	dc.b	$81, $09, $84, $15, $81, $01, $80, $03, $80, $03, $83, $06, $82, $07, $81, $21 ;0x4C0
	dc.b	$84, $0D, $80, $03, $84, $0B, $82, $03, $83, $03, $82, $18, $81, $06, $80, $10
	dc.b	$81, $07, $8F, $0B, $86, $0D, $81, $0A, $84, $14, $81, $09, $84, $15, $80, $02 ;0x4E0
	dc.b	$80, $03, $80, $03, $82, $08, $82, $04, $82, $20, $85, $0E, $81, $06, $82, $08
	dc.b	$81, $08, $82, $01, $82, $21, $81, $0E, $81, $07, $84, $0A, $81, $0A, $86, $0D ;0x500
	dc.b	$81, $09, $84, $15, $81, $09, $84, $14, $81, $01, $80, $03, $80, $03, $83, $08
	dc.b	$82, $03, $81, $21, $86, $0E, $81, $08, $82, $05, $81, $0B, $84, $1B, $82, $04 ;0x520
	dc.b	$80, $0D, $81, $08, $83, $0B, $81, $0A, $86, $0D, $81, $09, $84, $14, $81, $09
	dc.b	$84, $01, $87, $0B, $80, $02, $80, $03, $80, $03, $82, $0A, $82, $00, $82, $20 ;0x540
	dc.b	$87, $10, $81, $09, $81, $03, $82, $2B, $80, $02, $81, $02, $80, $0D, $81, $07
	dc.b	$84, $0B, $81, $0B, $85, $0C, $81, $0A, $84, $14, $81, $09, $84, $00, $89, $09 ;0x560
	dc.b	$81, $01, $80, $03, $80, $03, $83, $0B, $83, $21, $88, $10, $82, $09, $81, $02
	dc.b	$81, $15, $83, $11, $80, $05, $80, $01, $81, $0B, $81, $08, $83, $0C, $81, $0B ;0x580
	dc.b	$86, $0B, $81, $09, $84, $15, $81, $09, $90, $08, $80, $02, $80, $03, $80, $03
	dc.b	$82, $0D, $80, $21, $89, $12, $83, $08, $81, $01, $81, $14, $86, $0F, $80, $05 ;0x5A0
	dc.b	$80, $02, $80, $0B, $81, $07, $84, $0C, $81, $0B, $86, $0B, $81, $09, $84, $14
	dc.b	$81, $09, $90, $08, $81, $01, $80, $03, $80, $03, $83, $0C, $81, $20, $89, $14 ;0x5C0
	dc.b	$84, $05, $86, $14, $80, $02, $83, $0E, $80, $06, $80, $01, $80, $0A, $81, $08
	dc.b	$83, $0E, $81, $0A, $86, $0B, $81, $09, $84, $14, $81, $09, $84, $05, $84, $09 ;0x5E0
	dc.b	$80, $02, $80, $03, $80, $03, $82, $0C, $81, $01, $81, $1B, $8A, $16, $86, $00
	dc.b	$84, $00, $83, $13, $80, $02, $84, $0D, $80, $06, $80, $01, $81, $08, $81, $08 ;0x600
	dc.b	$84, $0E, $81, $0B, $85, $0A, $81, $09, $85, $14, $81, $09, $83, $07, $83, $08
	dc.b	$81, $01, $80, $03, $80, $03, $83, $0C, $80, $04, $80, $18, $8B, $19, $89, $04 ;0x620
	dc.b	$83, $10, $80, $02, $85, $0D, $80, $05, $80, $02, $80, $08, $81, $08, $84, $0E
	dc.b	$81, $0B, $86, $09, $81, $09, $84, $14, $81, $0A, $83, $06, $83, $09, $80, $02 ;0x640
	dc.b	$80, $03, $80, $03, $82, $0C, $81, $05, $80, $16, $8B, $1C, $89, $05, $84, $0C
	dc.b	$80, $01, $82, $01, $81, $0D, $80, $06, $80, $01, $80, $06, $82, $08, $88, $0B ;0x660
	dc.b	$81, $0B, $88, $07, $81, $09, $84, $14, $81, $09, $83, $06, $83, $09, $81, $01
	dc.b	$80, $03, $80, $03, $83, $0B, $81, $07, $80, $13, $8B, $25, $83, $08, $83, $0A ;0x680
	dc.b	$80, $00, $82, $01, $82, $0D, $80, $05, $80, $01, $80, $05, $82, $09, $8B, $06
	dc.b	$83, $0B, $8B, $03, $81, $0A, $84, $14, $81, $09, $82, $07, $82, $0A, $80, $02 ;0x6A0
	dc.b	$80, $03, $80, $03, $82, $0C, $80, $09, $80, $11, $8B, $27, $84, $09, $82, $08
	dc.b	$83, $03, $81, $0D, $80, $04, $80, $02, $81, $03, $82, $0A, $8C, $04, $84, $0C ;0x6C0
	dc.b	$8B, $02, $81, $09, $84, $15, $81, $09, $81, $07, $82, $0A, $81, $01, $80, $03
	dc.b	$80, $03, $83, $0B, $81, $0A, $80, $0E, $8B, $2A, $84, $09, $83, $07, $82, $03 ;0x6E0
	dc.b	$81, $0E, $81, $02, $80, $03, $80, $01, $83, $0C, $8B, $04, $84, $0C, $8B, $02
	dc.b	$81, $09, $84, $15, $81, $12, $82, $0B, $80, $02, $80, $03, $80, $03, $82, $0C ;0x700
	dc.b	$80, $0C, $80, $0C, $8B, $2D, $83, $07, $81, $01, $83, $05, $80, $04, $81, $10
	dc.b	$82, $04, $80, $00, $81, $12, $88, $01, $84, $12, $88, $01, $81, $0A, $84, $15 ;0x720
	dc.b	$81, $11, $82, $0B, $81, $01, $80, $03, $80, $03, $83, $0B, $81, $0D, $80, $09
	dc.b	$8B, $30, $84, $04, $81, $05, $82, $04, $80, $02, $82, $18, $82, $16, $84, $01 ;0x740
	dc.b	$81, $19, $84, $02, $81, $09, $84, $16, $81, $10, $82, $0C, $80, $02, $80, $03
	dc.b	$80, $03, $82, $0C, $80, $0F, $81, $05, $8C, $33, $83, $03, $80, $08, $82, $03 ;0x760
	dc.b	$84, $0D, $83, $07, $82, $16, $81, $04, $81, $19, $81, $05, $81, $09, $81, $1A
	dc.b	$81, $0E, $82, $0C, $82, $05, $80, $03, $83, $0C, $81, $10, $80, $03, $8B, $36 ;0x780
	dc.b	$84, $00, $81, $0A, $82, $13, $80, $03, $80, $06, $81, $17, $81, $04, $81, $19
	dc.b	$81, $05, $81, $09, $81, $1A, $81, $0D, $81, $0E, $81, $00, $80, $09, $82, $0E ;0x7A0
	dc.b	$80, $11, $80, $00, $8C, $38, $86, $0C, $82, $10, $80, $05, $80, $05, $9A, $06
	dc.b	$9B, $07, $8B, $1C, $81, $0B, $81, $0E, $81, $01, $80, $03, $82, $01, $83, $0E ;0x7C0
	dc.b	$81, $10, $8C, $3A, $88, $0C, $82, $0E, $80, $06, $80, $04, $80, $6E, $82, $07
	dc.b	$82, $0F, $80, $03, $83, $02, $80, $00, $82, $10, $81, $0F, $8B, $3C, $89, $0C ;0x7E0
	dc.b	$82, $0C, $80, $06, $80, $04, $80, $70, $89, $11, $80, $0B, $83, $11, $81, $0E
	dc.b	$89, $3F, $8A, $0C, $82, $0B, $80, $06, $80, $03, $80, $7F, $0C, $80, $0A, $83 ;0x800
	dc.b	$13, $81, $0C, $88, $42, $8C, $0B, $82, $09, $80, $06, $80, $03, $80, $7F, $0C
	dc.b	$80, $0A, $83, $14, $81, $0B, $87, $44, $83, $01, $87, $0B, $82, $08, $80, $05 ;0x820
	dc.b	$80, $02, $81, $7F, $0C, $80, $09, $83, $16, $81, $09, $86, $47, $83, $03, $87
	dc.b	$0A, $82, $06, $80, $05, $80, $02, $80, $7F, $0D, $80, $09, $82, $18, $81, $08 ;0x840
	dc.b	$85, $49, $83, $04, $87, $0A, $82, $05, $81, $02, $80, $03, $80, $7F, $0D, $80
	dc.b	$08, $82, $1A, $81, $06, $84, $4C, $84, $05, $86, $0A, $82, $05, $82, $03, $81 ;0x860
	dc.b	$7F, $0D, $80, $07, $82, $1C, $81, $04, $84, $4E, $85, $06, $86, $09, $82, $0A
	dc.b	$80, $7F, $0E, $84, $01, $83, $1E, $81, $02, $84, $51, $84, $07, $86, $09, $82 ;0x880
	dc.b	$07, $81, $7F, $0E, $89, $20, $88, $52, $85, $08, $86, $08, $82, $04, $81, $3C
	dc.b	$85, $4C, $88, $27, $82, $54, $85, $08, $86, $08, $82, $01, $81, $2D, $95, $0B ;0x8A0
	dc.b	$84, $3B, $87, $28, $82, $53, $89, $08, $85, $08, $83, $2E, $95, $02, $8E, $3A
	dc.b	$86, $2A, $82, $52, $82, $02, $87, $06, $86, $07, $82, $2D, $A7, $3A, $85, $2B ;0x8C0
	dc.b	$82, $52, $82, $04, $89, $05, $85, $07, $82, $2B, $A7, $3A, $84, $2C, $82, $51
	dc.b	$82, $08, $95, $06, $82, $29, $A7, $3A, $83, $2E, $82, $50, $82, $0D, $93, $05 ;0x8E0
	dc.b	$82, $23, $90, $02, $97, $29, $83, $0C, $82, $2F, $82, $50, $82, $12, $90, $05
	dc.b	$82, $21, $81, $11, $8E, $02, $86, $27, $89, $3A, $82, $07, $82, $45, $82, $15 ;0x900
	dc.b	$90, $04, $80, $21, $81, $11, $85, $0B, $86, $26, $8F, $35, $82, $07, $84, $29
	dc.b	$81, $17, $82, $0E, $93, $00, $85, $00, $81, $21, $81, $11, $81, $0F, $86, $25 ;0x920
	dc.b	$96, $2F, $82, $07, $86, $27, $81, $16, $82, $0F, $93, $02, $86, $21, $82, $10
	dc.b	$81, $0F, $86, $25, $9B, $2B, $82, $06, $88, $25, $82, $15, $82, $0F, $93, $05 ;0x940
	dc.b	$82, $23, $81, $10, $81, $0F, $86, $24, $9D, $2A, $82, $06, $8A, $23, $83, $14
	dc.b	$82, $10, $8A, $00, $87, $2B, $81, $10, $81, $10, $85, $23, $81, $01, $9A, $2A ;0x960
	dc.b	$82, $02, $91, $20, $83, $14, $82, $10, $87, $04, $86, $2B, $81, $10, $81, $10
	dc.b	$86, $21, $81, $07, $96, $29, $82, $02, $94, $19, $81, $01, $84, $13, $82, $0B ;0x980
	dc.b	$86, $0A, $86, $2B, $81, $10, $81, $10, $86, $20, $81, $0D, $99, $21, $82, $02
	dc.b	$81, $01, $93, $16, $81, $01, $85, $12, $82, $0B, $81, $0F, $87, $2A, $82, $0F ;0x9A0
	dc.b	$81, $10, $86, $20, $81, $13, $A1, $13, $82, $02, $81, $03, $95, $12, $82, $00
	dc.b	$85, $11, $82, $0C, $81, $0F, $87, $2B, $81, $0F, $81, $10, $86, $1F, $81, $19 ;0x9C0
	dc.b	$B7, $06, $99, $0C, $8A, $10, $82, $0D, $81, $0F, $86, $2B, $81, $0F, $81, $10
	dc.b	$87, $1D, $81, $19, $B8, $08, $99, $0A, $8B, $0F, $82, $0D, $81, $0F, $86, $2B ;0x9E0
	dc.b	$81, $0F, $81, $11, $86, $1D, $81, $18, $B9, $0B, $96, $0A, $81, $00, $89, $0E
	dc.b	$82, $0D, $81, $0F, $87, $2A, $81, $0F, $81, $11, $86, $1C, $81, $18, $81, $02 ;0xA00
	dc.b	$B5, $0E, $93, $0A, $81, $01, $88, $0E, $82, $0E, $81, $0F, $86, $2A, $81, $0F
	dc.b	$81, $11, $86, $1B, $82, $17, $81, $0B, $AD, $11, $90, $0A, $81, $01, $89, $0D ;0xA20
	dc.b	$82, $0E, $81, $0F, $86, $2A, $81, $0F, $81, $11, $87, $1A, $81, $17, $81, $1A
	dc.b	$9F, $15, $8C, $0A, $81, $02, $89, $0C, $82, $0E, $81, $0F, $87, $29, $81, $0F ;0xA40
	dc.b	$82, $11, $86, $19, $81, $17, $81, $38, $81, $1C, $86, $0A, $81, $03, $89, $0B
	dc.b	$82, $0F, $81, $0E, $87, $2A, $81, $0E, $82, $11, $86, $18, $81, $17, $81, $39 ;0xA60
	dc.b	$81, $1F, $83, $0A, $81, $04, $88, $0B, $82, $0F, $81, $0F, $86, $2A, $81, $0E
	dc.b	$83, $10, $86, $18, $81, $16, $81, $3A, $81, $20, $82, $0A, $81, $04, $89, $0A ;0xA80
	dc.b	$82, $0F, $81, $0F, $86, $2A, $81, $0E, $83, $10, $87, $16, $81, $17, $81, $3A
	dc.b	$81, $1F, $82, $0B, $81, $05, $89, $09, $82, $10, $81, $0E, $87, $29, $81, $0E ;0xAA0
	dc.b	$84, $10, $86, $16, $81, $16, $81, $3B, $81, $1E, $83, $0B, $81, $06, $89, $08
	dc.b	$82, $10, $81, $0F, $86, $29, $81, $0E, $84, $10, $86, $15, $81, $16, $81, $3C ;0xAC0
	dc.b	$81, $1E, $82, $0C, $81, $07, $88, $08, $82, $10, $81, $0F, $86, $29, $81, $0E
	dc.b	$84, $10, $86, $14, $81, $16, $81, $3D, $81, $1D, $82, $0D, $81, $07, $89, $07 ;0xAE0
	dc.b	$82, $11, $81, $0E, $86, $29, $81, $0E, $85, $0F, $86, $14, $81, $15, $81, $3D
	dc.b	$81, $1E, $82, $0D, $81, $08, $89, $06, $82, $11, $81, $0E, $87, $28, $81, $0E ;0xB00
	dc.b	$85, $10, $86, $12, $81, $15, $81, $3E, $81, $1D, $82, $0E, $81, $09, $89, $05
	dc.b	$82, $11, $81, $0F, $86, $28, $81, $0E, $85, $10, $86, $12, $81, $15, $81, $3E ;0xB20
	dc.b	$81, $1D, $82, $0E, $81, $0A, $89, $04, $82, $11, $81, $0F, $86, $29, $81, $0D
	dc.b	$86, $0F, $86, $11, $81, $15, $82, $3E, $81, $1C, $82, $0F, $81, $0A, $89, $04 ;0xB40
	dc.b	$82, $12, $81, $0E, $86, $29, $81, $0D, $86, $0F, $86, $10, $81, $15, $83, $0B
	dc.b	$89, $28, $81, $1B, $82, $10, $81, $0B, $89, $03, $82, $12, $81, $0E, $86, $29 ;0xB60
	dc.b	$81, $0D, $86, $0F, $87, $0F, $81, $14, $83, $0C, $85, $02, $8A, $1E, $81, $1B
	dc.b	$82, $10, $81, $0C, $89, $03, $82, $11, $81, $0F, $86, $28, $81, $0D, $87, $0F ;0xB80
	dc.b	$86, $0E, $81, $14, $81, $00, $81, $0C, $85, $0C, $8B, $13, $81, $1A, $82, $11
	dc.b	$81, $0D, $89, $02, $82, $12, $81, $0E, $86, $28, $81, $0D, $87, $0F, $86, $0E ;0xBA0
	dc.b	$81, $13, $81, $01, $81, $0C, $85, $17, $88, $0B, $81, $1A, $82, $11, $81, $0E
	dc.b	$88, $02, $82, $12, $81, $0E, $86, $28, $81, $0D, $87, $0F, $86, $0D, $81, $14 ;0xBC0
	dc.b	$81, $01, $81, $0C, $85, $1F, $87, $04, $81, $19, $82, $12, $81, $0E, $89, $01
	dc.b	$82, $12, $81, $0E, $86, $28, $81, $0D, $88, $0E, $86, $0D, $81, $13, $81, $02 ;0xBE0
	dc.b	$81, $0C, $85, $26, $84, $00, $81, $18, $82, $13, $81, $0F, $89, $00, $82, $13
	dc.b	$81, $0D, $86, $28, $81, $0D, $88, $0F, $86, $0B, $81, $13, $81, $03, $81, $0C ;0xC00
	dc.b	$84, $2A, $84, $18, $82, $13, $81, $10, $8C, $13, $81, $0E, $85, $28, $81, $0D
	dc.b	$88, $0F, $86, $0A, $81, $13, $81, $04, $81, $0C, $84, $2A, $83, $18, $82, $14 ;0xC20
	dc.b	$81, $11, $8C, $12, $81, $0E, $86, $27, $81, $0D, $89, $0E, $86, $0A, $81, $12
	dc.b	$82, $03, $81, $0D, $84, $29, $84, $18, $82, $14, $81, $11, $8C, $12, $81, $0E ;0xC40
	dc.b	$86, $27, $81, $0D, $89, $0E, $86, $09, $81, $13, $81, $04, $81, $0D, $84, $29
	dc.b	$84, $17, $82, $15, $81, $12, $8B, $13, $81, $0D, $86, $27, $81, $0D, $86, $00 ;0xC60
	dc.b	$81, $0E, $86, $09, $81, $12, $81, $05, $81, $0D, $84, $29, $84, $16, $82, $16
	dc.b	$81, $13, $8A, $13, $81, $0D, $86, $27, $81, $0D, $86, $01, $81, $0E, $86, $07 ;0xC80
	dc.b	$81, $12, $82, $05, $81, $0C, $85, $29, $84, $16, $82, $16, $81, $14, $89, $13
	dc.b	$81, $0D, $86, $27, $81, $0D, $86, $01, $81, $0E, $86, $07, $81, $11, $82, $06 ;0xCA0
	dc.b	$81, $0C, $85, $29, $84, $15, $82, $17, $81, $15, $89, $12, $81, $0E, $85, $28
	dc.b	$81, $0C, $86, $02, $81, $0D, $86, $06, $81, $12, $81, $07, $81, $0C, $85, $28 ;0xCC0
	dc.b	$82, $00, $81, $15, $82, $17, $81, $08, $81, $0A, $8A, $12, $81, $0D, $86, $27
	dc.b	$81, $0D, $85, $02, $81, $0D, $86, $06, $81, $11, $82, $07, $81, $0C, $85, $28 ;0xCE0
	dc.b	$82, $00, $81, $14, $83, $17, $81, $08, $82, $0A, $8A, $11, $81, $0D, $86, $27
	dc.b	$81, $0D, $85, $02, $81, $0D, $86, $05, $81, $11, $82, $07, $81, $0D, $85, $28 ;0xD00
	dc.b	$82, $00, $81, $13, $83, $18, $81, $08, $82, $0B, $8A, $10, $81, $0D, $86, $27
	dc.b	$81, $0D, $85, $03, $81, $0D, $85, $05, $81, $11, $81, $08, $81, $0D, $87, $25 ;0xD20
	dc.b	$82, $01, $81, $13, $83, $18, $81, $08, $83, $0B, $89, $10, $81, $0D, $86, $27
	dc.b	$81, $0D, $85, $03, $81, $0D, $86, $03, $81, $11, $82, $08, $81, $0D, $8F, $1D ;0xD40
	dc.b	$82, $01, $81, $12, $83, $19, $81, $08, $83, $0C, $89, $0F, $81, $0D, $86, $27
	dc.b	$81, $0D, $85, $03, $81, $0D, $86, $03, $81, $10, $82, $09, $81, $0D, $9B, $11 ;0xD60
	dc.b	$82, $01, $81, $12, $83, $19, $81, $08, $84, $0C, $89, $0F, $81, $0D, $85, $27
	dc.b	$81, $0D, $85, $04, $81, $0C, $86, $02, $81, $11, $81, $0A, $81, $0D, $A4, $08 ;0xD80
	dc.b	$82, $01, $81, $12, $82, $1A, $81, $09, $83, $0D, $89, $0E, $81, $0D, $86, $26
	dc.b	$81, $0D, $85, $04, $81, $0C, $86, $02, $81, $10, $81, $0B, $81, $0D, $A4, $07 ;0xDA0
	dc.b	$82, $01, $81, $12, $83, $1A, $81, $09, $84, $0D, $89, $0D, $81, $0D, $86, $26
	dc.b	$81, $0D, $85, $04, $81, $0C, $86, $01, $81, $10, $82, $0A, $81, $0E, $A4, $07 ;0xDC0
	dc.b	$82, $01, $81, $12, $82, $1B, $81, $09, $84, $0D, $8A, $0C, $81, $0D, $86, $26
	dc.b	$81, $0D, $85, $05, $81, $0C, $85, $01, $81, $10, $81, $0B, $81, $11, $A0, $07 ;0xDE0
	dc.b	$82, $02, $81, $11, $83, $1B, $81, $09, $85, $0D, $8A, $0B, $81, $0D, $86, $26
	dc.b	$81, $0D, $85, $05, $81, $0C, $85, $01, $81, $0F, $81, $0C, $81, $19, $98, $07 ;0xE00
	dc.b	$82, $02, $81, $11, $82, $1C, $81, $09, $85, $0E, $8A, $0B, $81, $0C, $86, $26
	dc.b	$81, $0D, $85, $05, $81, $0C, $88, $0F, $82, $0C, $81, $25, $8C, $07, $82, $02 ;0xE20
	dc.b	$81, $10, $83, $1C, $81, $09, $86, $0E, $8A, $0A, $81, $0D, $85, $26, $81, $0D
	dc.b	$85, $06, $81, $0B, $88, $0E, $82, $0D, $81, $2D, $84, $06, $82, $03, $81, $10 ;0xE40
	dc.b	$82, $1D, $81, $09, $87, $0E, $8A, $09, $81, $0D, $85, $26, $81, $0D, $85, $06
	dc.b	$81, $0B, $87, $0F, $82, $0C, $81, $2E, $84, $06, $82, $03, $81, $0F, $83, $1D ;0xE60
	dc.b	$81, $0A, $86, $0F, $8A, $08, $81, $0D, $85, $26, $81, $0D, $85, $06, $81, $0B
	dc.b	$87, $0E, $82, $0D, $81, $2D, $84, $06, $82, $04, $81, $0F, $82, $1E, $81, $0A ;0xE80
	dc.b	$87, $0F, $8A, $07, $81, $0D, $86, $25, $81, $0D, $85, $07, $81, $0A, $87, $0D
	dc.b	$82, $0E, $81, $2D, $84, $06, $82, $04, $81, $0E, $83, $1E, $81, $0A, $88, $0F ;0xEA0
	dc.b	$8A, $07, $81, $0C, $86, $25, $81, $0D, $85, $07, $81, $0A, $86, $0E, $82, $0E
	dc.b	$81, $2D, $84, $05, $82, $05, $81, $0E, $83, $1E, $81, $0A, $88, $10, $8A, $06 ;0xEC0
	dc.b	$81, $0C, $86, $25, $81, $0D, $85, $07, $81, $0B, $85, $0D, $82, $0E, $81, $2E
	dc.b	$84, $05, $82, $05, $81, $0D, $83, $1F, $81, $0A, $86, $00, $81, $10, $8A, $05 ;0xEE0
	dc.b	$81, $0C, $86, $26, $81, $0C, $85, $07, $81, $0B, $84, $0E, $82, $0E, $81, $2E
	dc.b	$84, $04, $82, $06, $81, $0D, $83, $1F, $81, $0A, $86, $01, $81, $10, $8A, $04 ;0xF00
	dc.b	$81, $0C, $86, $26, $81, $0C, $86, $07, $81, $0A, $84, $0D, $82, $0F, $81, $2D
	dc.b	$84, $05, $82, $06, $81, $0C, $84, $1F, $81, $0A, $86, $02, $81, $10, $8A, $03 ;0xF20
	dc.b	$81, $0D, $85, $26, $81, $0C, $86, $07, $81, $0A, $84, $0C, $82, $10, $81, $2D
	dc.b	$84, $04, $82, $07, $81, $0C, $83, $20, $81, $0A, $86, $02, $81, $11, $8B, $01 ;0xF40
	dc.b	$81, $0D, $85, $26, $81, $0C, $86, $07, $81, $0A, $83, $0D, $82, $0F, $81, $0E
	dc.b	$86, $18, $84, $04, $82, $07, $81, $0C, $83, $20, $81, $0A, $86, $03, $81, $11 ;0xF60
	dc.b	$8F, $0C, $85, $26, $81, $0C, $86, $08, $81, $09, $83, $0C, $82, $10, $81, $0E
	dc.b	$84, $00, $87, $11, $81, $06, $82, $08, $81, $0B, $83, $21, $81, $0B, $85, $04 ;0xF80
	dc.b	$81, $11, $8E, $0C, $85, $26, $81, $0C, $86, $08, $81, $0A, $82, $0C, $81, $11
	dc.b	$81, $0E, $84, $07, $85, $0C, $81, $06, $82, $08, $81, $0B, $83, $21, $81, $0B ;0xFA0
	dc.b	$85, $05, $81, $11, $8D, $0C, $85, $26, $81, $0D, $85, $08, $81, $0A, $81, $0C
	dc.b	$82, $10, $81, $0E, $84, $0D, $85, $06, $81, $06, $82, $09, $81, $0B, $83, $20 ;0xFC0
	dc.b	$81, $0C, $85, $05, $81, $12, $8C, $0C, $85, $26, $81, $0D, $85, $08, $81, $0A
	dc.b	$81, $0B, $82, $11, $81, $0E, $84, $12, $84, $02, $81, $06, $82, $09, $81, $0A ;0xFE0
	dc.b	$83, $21, $81, $0C, $86, $05, $81, $12, $8B, $0C, $86, $25, $81, $0D, $85, $09
	dc.b	$81, $09, $81, $0B, $82, $11, $81, $0E, $84, $16, $85, $05, $82, $0A, $81, $0A ;0x1000
	dc.b	$83, $21, $81, $0C, $86, $06, $81, $13, $89, $0C, $86, $25, $81, $0D, $85, $09
	dc.b	$81, $16, $82, $12, $81, $0E, $84, $21, $82, $0A, $81, $0A, $84, $21, $81, $0C ;0x1020
	dc.b	$86, $04, $84, $13, $89, $0B, $86, $25, $81, $0D, $85, $09, $81, $15, $82, $12
	dc.b	$81, $0F, $83, $22, $82, $0A, $81, $0A, $83, $22, $81, $0C, $86, $01, $87, $14 ;0x1040
	dc.b	$88, $0B, $86, $25, $81, $0D, $85, $09, $81, $15, $82, $12, $81, $0E, $84, $21
	dc.b	$82, $0B, $81, $0A, $83, $22, $81, $0C, $91, $14, $87, $0B, $86, $20, $86, $0D ;0x1060
	dc.b	$85, $0A, $81, $13, $82, $13, $81, $0E, $84, $20, $82, $0C, $81, $09, $84, $22
	dc.b	$81, $0D, $90, $15, $86, $0C, $85, $1A, $8C, $0D, $86, $09, $81, $13, $82, $12 ;0x1080
	dc.b	$81, $0F, $84, $1F, $82, $0D, $81, $09, $83, $23, $81, $0D, $8E, $18, $85, $0C
	dc.b	$85, $16, $90, $0D, $86, $09, $81, $12, $82, $13, $81, $0F, $83, $20, $82, $0D ;0x10A0
	dc.b	$81, $09, $83, $23, $81, $0D, $8A, $1D, $84, $0C, $85, $12, $94, $00, $83, $08
	dc.b	$86, $09, $81, $11, $83, $13, $81, $0E, $84, $1F, $82, $0E, $81, $08, $84, $23 ;0x10C0
	dc.b	$81, $0D, $87, $21, $83, $0C, $85, $0F, $99, $00, $81, $08, $86, $0A, $81, $10
	dc.b	$82, $14, $81, $0E, $84, $1E, $82, $0F, $81, $08, $83, $24, $81, $0D, $85, $24 ;0x10E0
	dc.b	$83, $0B, $85, $0B, $97, $07, $81, $07, $86, $0A, $81, $0F, $83, $13, $81, $0F
	dc.b	$83, $1E, $82, $10, $81, $08, $83, $24, $81, $0D, $83, $27, $82, $0B, $85, $08 ;0x1100
	dc.b	$94, $0D, $81, $08, $85, $0A, $81, $0F, $82, $14, $81, $0F, $83, $1E, $82, $10
	dc.b	$81, $07, $84, $24, $81, $0E, $80, $2A, $81, $0B, $85, $04, $92, $13, $81, $08 ;0x1120
	dc.b	$85, $0A, $81, $0E, $83, $14, $81, $0E, $84, $1D, $82, $11, $81, $07, $83, $25
	dc.b	$81, $3B, $81, $0A, $85, $01, $91, $18, $81, $07, $85, $0B, $81, $0D, $82, $14 ;0x1140
	dc.b	$81, $0F, $83, $1D, $82, $12, $81, $07, $83, $25, $81, $3C, $82, $08, $95, $1C
	dc.b	$81, $07, $85, $0B, $81, $0C, $83, $14, $81, $0F, $89, $16, $82, $13, $81, $06 ;0x1160
	dc.b	$83, $26, $81, $3E, $81, $07, $92, $1F, $81, $07, $85, $0B, $81, $0C, $82, $15
	dc.b	$81, $0E, $93, $0C, $82, $14, $81, $06, $83, $26, $81, $21, $83, $19, $81, $06 ;0x1180
	dc.b	$8E, $23, $81, $07, $86, $0A, $81, $0B, $83, $14, $81, $0F, $9A, $04, $82, $15
	dc.b	$81, $06, $83, $26, $81, $1E, $83, $01, $81, $19, $81, $05, $8B, $26, $81, $07 ;0x11A0
	dc.b	$86, $0B, $81, $0A, $82, $15, $81, $0F, $A1, $16, $81, $05, $83, $27, $81, $1B
	dc.b	$83, $05, $81, $19, $81, $04, $87, $2B, $81, $06, $86, $0B, $81, $09, $83, $15 ;0x11C0
	dc.b	$81, $0E, $A7, $11, $81, $05, $83, $27, $81, $19, $82, $09, $81, $19, $81, $03
	dc.b	$84, $2E, $81, $06, $86, $0B, $81, $09, $82, $15, $81, $0F, $AC, $0C, $81, $04 ;0x11E0
	dc.b	$84, $27, $81, $17, $82, $0C, $81, $19, $81, $03, $81, $30, $81, $06, $86, $0B
	dc.b	$81, $08, $83, $15, $81, $16, $AB, $06, $81, $04, $83, $28, $81, $15, $82, $0F ;0x1200
	dc.b	$81, $19, $82, $34, $81, $07, $85, $0C, $81, $07, $82, $16, $81, $1F, $A6, $02
	dc.b	$81, $04, $83, $28, $81, $14, $81, $12, $81, $1A, $81, $33, $81, $07, $85, $0C ;0x1220
	dc.b	$81, $06, $83, $15, $81, $27, $9F, $02, $81, $03, $84, $27, $81, $13, $82, $13
	dc.b	$81, $1B, $81, $32, $81, $07, $85, $0C, $81, $06, $82, $16, $81, $2D, $98, $03 ;0x1240
	dc.b	$81, $03, $83, $28, $81, $12, $83, $14, $81, $1B, $81, $31, $81, $07, $81, $10
	dc.b	$81, $05, $83, $16, $81, $33, $92, $03, $81, $03, $81, $2A, $81, $11, $84, $15 ;0x1260
	dc.b	$81, $1A, $82, $25, $8C, $07, $81, $08, $8A, $04, $8A, $0E, $81, $39, $8C, $05
	dc.b	$81, $02, $80, $2B, $81, $10, $86, $15, $81, $17, $82, $1F, $88, $01, $81, $0F ;0x1280
	dc.b	$95, $03, $98, $01, $81, $3F, $86, $05, $81, $01, $81, $2B, $81, $10, $86, $16
	dc.b	$81, $14, $82, $1A, $87, $09, $81, $0F, $95, $03, $9B, $43, $82, $06, $81, $01 ;0x12A0
	dc.b	$81, $2B, $81, $10, $86, $17, $81, $10, $83, $17, $85, $10, $81, $09, $9B, $02
	dc.b	$9C, $42, $83, $07, $83, $2C, $81, $10, $86, $18, $81, $0D, $82, $16, $84, $0E ;0x12C0
	dc.b	$88, $01, $A4, $01, $9C, $42, $83, $38, $81, $10, $86, $19, $81, $0A, $82, $14
	dc.b	$84, $0D, $B4, $00, $A2, $3C, $83, $39, $81, $11, $85, $19, $81, $08, $82, $12 ;0x12E0
	dc.b	$84, $0C, $E3, $36, $83, $39, $81, $11, $85, $1A, $81, $06, $82, $0F, $84, $0C
	dc.b	$AC, $16, $AA, $2E, $84, $39, $81, $11, $85, $1B, $81, $04, $82, $0C, $84, $0C ;0x1300
	dc.b	$A3, $31, $A1, $29, $83, $07, $86, $2B, $81, $11, $85, $1C, $81, $01, $84, $09
	dc.b	$87, $08, $9E, $43, $9D, $24, $83, $05, $8A, $29, $81, $11, $85, $1C, $81, $00 ;0x1320
	dc.b	$81, $01, $81, $06, $83, $03, $84, $02, $9B, $51, $9B, $1E, $84, $03, $8D, $28
	dc.b	$81, $11, $86, $1C, $82, $01, $81, $03, $84, $07, $9C, $5C, $9A, $1A, $83, $03 ;0x1340
	dc.b	$8F, $27, $81, $11, $86, $1D, $80, $02, $81, $01, $82, $0A, $98, $66, $99, $16
	dc.b	$83, $02, $91, $26, $81, $11, $86, $21, $84, $09, $96, $70, $97, $12, $84, $01 ;0x1360
	dc.b	$93, $25, $81, $11, $86, $21, $82, $08, $93, $7B, $95, $0F, $83, $02, $84, $04
	dc.b	$89, $25, $81, $11, $86, $2A, $91, $7F, $04, $94, $0C, $83, $01, $83, $08, $88 ;0x1380
	dc.b	$24, $81, $12, $85, $27, $90, $7F, $0C, $93, $08, $81, $04, $81, $0B, $87, $23
	dc.b	$81, $13, $85, $25, $8E, $2D, $9D, $47, $93, $05, $81, $03, $81, $0D, $86, $23 ;0x13A0
	dc.b	$81, $13, $85, $22, $8D, $24, $8D, $1B, $8E, $3C, $93, $02, $82, $01, $81, $0F
	dc.b	$85, $23, $81, $13, $85, $20, $8C, $1F, $88, $36, $88, $37, $99, $10, $85, $01 ;0x13C0
	dc.b	$86, $1A, $81, $13, $86, $1D, $8B, $1B, $87, $46, $87, $33, $95, $12, $84, $02
	dc.b	$86, $00, $80, $17, $81, $13, $86, $1B, $8A, $18, $86, $00, $88, $4A, $85, $31 ;0x13E0
	dc.b	$92, $12, $83, $05, $81, $03, $80, $17, $81, $13, $86, $19, $8A, $15, $85, $09
	dc.b	$88, $4C, $85, $2E, $8F, $13, $83, $05, $81, $02, $81, $04, $80, $11, $81, $13 ;0x1400
	dc.b	$86, $17, $89, $13, $85, $11, $89, $46, $8C, $2C, $8C, $13, $82, $06, $81, $02
	dc.b	$82, $01, $82, $11, $81, $13, $86, $15, $89, $11, $84, $19, $8A, $3E, $8A, $04 ;0x1420
	dc.b	$84, $2A, $8A, $13, $81, $06, $81, $02, $83, $00, $83, $11, $81, $14, $85, $13
	dc.b	$88, $10, $84, $20, $8C, $34, $8C, $0B, $83, $2A, $87, $13, $81, $06, $81, $02 ;0x1440
	dc.b	$81, $00, $85, $11, $81, $14, $85, $11, $88, $0E, $84, $28, $8E, $28, $8E, $12
	dc.b	$83, $2A, $84, $12, $81, $07, $81, $02, $81, $00, $81, $00, $81, $12, $81, $14 ;0x1460
	dc.b	$85, $0F, $88, $0C, $84, $30, $93, $16, $93, $19, $83, $2A, $82, $11, $81, $07
	dc.b	$81, $01, $81, $01, $80, $01, $81, $12, $81, $14, $84, $0F, $87, $0B, $83, $39 ;0x1480
	dc.b	$B4, $21, $83, $28, $81, $10, $82, $0B, $81, $04, $81, $12, $81, $14, $81, $13
	dc.b	$84, $0A, $83, $42, $A8, $2A, $82, $27, $81, $0E, $86, $0E, $81, $13, $81, $14 ;0x14A0
	dc.b	$81, $13, $82, $09, $83, $4E, $96, $35, $83, $25, $81, $0C, $89, $0C, $81, $12
	dc.b	$81, $15, $81, $11, $82, $08, $83, $7F, $21, $82, $24, $82, $08, $8D, $0A, $81 ;0x14C0
	dc.b	$12, $81, $13, $83, $10, $81, $07, $83, $7F, $26, $82, $24, $82, $03, $93, $1C
	dc.b	$81, $11, $82, $12, $81, $05, $83, $7F, $2B, $82, $24, $9A, $1A, $81, $0E, $83 ;0x14E0
	dc.b	$13, $81, $04, $82, $1E, $84, $28, $82, $03, $83, $03, $82, $04, $81, $11, $81
	dc.b	$0A, $81, $19, $80, $0E, $82, $2A, $94, $18, $81, $0C, $82, $17, $80, $02, $82 ;0x1500
	dc.b	$1E, $87, $03, $81, $04, $82, $03, $82, $03, $81, $0B, $84, $01, $83, $03, $84
	dc.b	$02, $83, $0F, $81, $0A, $83, $17, $81, $10, $82, $2B, $93, $16, $81, $0A, $82 ;0x1520
	dc.b	$19, $80, $00, $82, $1F, $82, $03, $82, $01, $82, $03, $81, $00, $81, $01, $81
	dc.b	$00, $81, $01, $82, $0A, $82, $01, $80, $00, $82, $04, $82, $00, $81, $01, $81 ;0x1540
	dc.b	$00, $81, $0F, $81, $09, $81, $00, $81, $17, $80, $13, $82, $2B, $93, $14, $81
	dc.b	$08, $82, $1B, $82, $21, $81, $00, $83, $00, $81, $00, $83, $02, $81, $01, $81 ;0x1560
	dc.b	$00, $81, $01, $81, $00, $83, $0A, $81, $04, $81, $05, $81, $05, $80, $01, $81
	dc.b	$09, $82, $02, $82, $08, $80, $01, $81, $03, $81, $01, $81, $03, $82, $02, $81 ;0x1580
	dc.b	$02, $80, $02, $82, $03, $82, $07, $81, $2D, $92, $12, $81, $06, $82, $1E, $80
	dc.b	$21, $81, $00, $81, $03, $81, $02, $81, $02, $81, $01, $81, $00, $81, $01, $81 ;0x15A0
	dc.b	$02, $81, $0A, $83, $02, $84, $01, $82, $04, $81, $01, $81, $08, $81, $00, $81
	dc.b	$00, $83, $07, $81, $01, $81, $01, $81, $00, $82, $00, $81, $01, $81, $00, $81 ;0x15C0
	dc.b	$00, $83, $00, $81, $01, $81, $00, $81, $01, $81, $00, $81, $07, $82, $2D, $92
	dc.b	$10, $81, $05, $81, $43, $81, $00, $81, $03, $81, $02, $81, $02, $85, $00, $85 ;0x15E0
	dc.b	$02, $81, $0B, $83, $01, $83, $02, $81, $01, $82, $00, $85, $07, $81, $01, $81
	dc.b	$00, $82, $08, $85, $00, $81, $01, $81, $01, $81, $00, $81, $00, $81, $00, $81 ;0x1600
	dc.b	$01, $80, $00, $81, $00, $81, $04, $81, $01, $81, $09, $81, $2E, $92, $0E, $81
	dc.b	$03, $82, $44, $81, $00, $83, $00, $81, $03, $81, $03, $83, $02, $83, $03, $81 ;0x1620
	dc.b	$0D, $81, $01, $81, $04, $81, $02, $81, $00, $85, $07, $81, $01, $81, $01, $81
	dc.b	$08, $85, $00, $81, $01, $81, $01, $81, $00, $83, $01, $81, $03, $81, $00, $81 ;0x1640
	dc.b	$04, $81, $01, $81, $0A, $82, $2E, $92, $0C, $81, $02, $81, $46, $82, $03, $82
	dc.b	$03, $81, $05, $81, $04, $81, $03, $81, $09, $81, $00, $82, $01, $81, $04, $81 ;0x1660
	dc.b	$01, $82, $00, $81, $01, $81, $07, $81, $01, $81, $01, $81, $08, $81, $01, $81
	dc.b	$00, $81, $01, $81, $01, $81, $00, $81, $01, $80, $00, $81, $03, $81, $00, $81 ;0x1680
	dc.b	$01, $81, $00, $81, $01, $81, $0C, $81, $2F, $92, $0A, $81, $00, $82, $48, $87
	dc.b	$03, $84, $01, $82, $03, $82, $03, $84, $07, $84, $02, $85, $00, $85, $01, $81 ;0x16A0
	dc.b	$01, $81, $07, $81, $00, $81, $02, $81, $08, $81, $01, $81, $00, $81, $01, $81
	dc.b	$01, $81, $00, $81, $00, $81, $00, $81, $03, $81, $00, $81, $00, $81, $01, $81 ;0x16C0
	dc.b	$00, $82, $0D, $82, $2E, $93, $08, $83, $4B, $84, $04, $84, $01, $82, $03, $82
	dc.b	$03, $84, $09, $82, $03, $84, $02, $83, $02, $81, $01, $81, $08, $82, $03, $81 ;0x16E0
	dc.b	$08, $81, $01, $81, $00, $81, $01, $81, $01, $81, $01, $82, $01, $81, $03, $81
	dc.b	$01, $82, $03, $82, $00, $81, $0E, $81, $2F, $93, $06, $82, $7F, $26, $81, $47 ;0x1700
	dc.b	$82, $2F, $91, $06, $81, $7F, $73, $81, $2F, $90, $7F, $7D, $82, $2F, $8E, $7F
	dc.b	$7F, $81, $30, $8C, $7F, $7F, $00, $82, $2F, $8B, $7F, $7F, $02, $81, $30, $89 ;0x1720
	dc.b	$7F, $7F, $03, $81, $31, $87 ;0x1740
loc_1907F:
	dc.b	$4B, $80, $01, $80, $16, $80, $03, $80, $63, $80, $03, $80, $16, $80, $01, $80
	dc.b	$7F, $19, $80, $01, $80, $16, $80, $03, $80, $63, $80, $03, $80, $16, $80, $01 ;0x0 (0x0001907F-0x00019D5B, Entry count: 0xCDC)
	dc.b	$80, $7F, $19, $80, $01, $80, $16, $80, $02, $80, $65, $80, $02, $80, $16, $80
	dc.b	$01, $80, $7F, $19, $80, $01, $80, $15, $81, $02, $80, $65, $80, $02, $81, $15 ;0x20
	dc.b	$80, $01, $80, $7F, $19, $80, $01, $80, $15, $80, $02, $80, $67, $80, $02, $80
	dc.b	$15, $80, $01, $80, $7F, $18, $80, $02, $80, $15, $80, $01, $80, $69, $80, $01 ;0x40
	dc.b	$80, $15, $80, $02, $80, $5D, $81, $37, $80, $02, $80, $14, $81, $01, $80, $69
	dc.b	$80, $01, $81, $14, $80, $02, $80, $3B, $81, $1F, $83, $35, $80, $02, $80, $14 ;0x60
	dc.b	$80, $01, $80, $6B, $80, $01, $80, $14, $80, $02, $80, $39, $83, $15, $8A, $02
	dc.b	$B6, $02, $96, $01, $EE, $00, $96, $02, $BA, $01, $88, $0E, $80, $08, $80, $05 ;0x80
	dc.b	$82, $2E, $80, $02, $80, $14, $80, $01, $80, $6D, $80, $01, $80, $14, $80, $02
	dc.b	$80, $34, $81, $03, $81, $05, $80, $0E, $80, $00, $81, $05, $80, $01, $80, $05 ;0xA0
	dc.b	$82, $2B, $80, $02, $80, $13, $80, $01, $80, $6F, $80, $01, $80, $13, $80, $02
	dc.b	$80, $31, $82, $02, $80, $01, $81, $02, $81, $00, $80, $0E, $80, $01, $81, $03 ;0xC0
	dc.b	$81, $00, $82, $07, $82, $28, $80, $02, $80, $13, $80, $00, $80, $71, $80, $00
	dc.b	$80, $13, $80, $02, $80, $2E, $82, $04, $82, $00, $81, $01, $81, $01, $80, $0E ;0xE0
	dc.b	$80, $02, $81, $02, $81, $01, $80, $03, $80, $06, $83, $24, $80, $01, $81, $12
	dc.b	$82, $73, $82, $12, $81, $01, $80, $2B, $82, $08, $80, $01, $81, $00, $81, $02 ;0x100
	dc.b	$80, $0E, $80, $03, $81, $01, $80, $07, $82, $08, $A5, $01, $FF, $A3, $01, $AC
	dc.b	$06, $81, $06, $82, $03, $80, $0E, $80, $04, $83, $07, $84, $09, $A1, $01, $FF ;0x120
	dc.b	$A5, $01, $A7, $06, $85, $06, $81, $04, $80, $0E, $80, $05, $82, $06, $85, $0D
	dc.b	$84, $17, $80, $01, $80, $13, $80, $78, $81, $13, $80, $01, $80, $1E, $83, $08 ;0x140
	dc.b	$87, $06, $81, $04, $80, $0E, $80, $05, $82, $06, $84, $08, $80, $09, $83, $13
	dc.b	$80, $00, $80, $13, $81, $79, $81, $13, $80, $00, $80, $1A, $83, $0D, $86, $06 ;0x160
	dc.b	$81, $04, $80, $0E, $80, $05, $81, $06, $85, $08, $83, $0A, $85, $0D, $80, $00
	dc.b	$80, $11, $82, $7B, $82, $11, $80, $00, $80, $15, $84, $0E, $80, $01, $86, $06 ;0x180
	dc.b	$81, $04, $80, $0E, $80, $05, $81, $06, $85, $07, $84, $10, $84, $08, $81, $11
	dc.b	$80, $00, $81, $7B, $81, $00, $80, $11, $81, $10, $84, $10, $83, $02, $85, $07 ;0x1A0
	dc.b	$80, $04, $80, $0E, $80, $05, $81, $05, $85, $08, $83, $16, $85, $02, $81, $10
	dc.b	$80, $01, $80, $7D, $80, $01, $80, $10, $81, $0A, $85, $15, $83, $02, $86, $06 ;0x1C0
	dc.b	$80, $04, $80, $0E, $80, $05, $81, $05, $85, $08, $83, $0A, $83, $0D, $85, $0E
	dc.b	$80, $01, $80, $7F, $80, $01, $80, $10, $81, $03, $85, $1B, $83, $03, $85, $06 ;0x1E0
	dc.b	$81, $03, $80, $0E, $80, $05, $80, $06, $85, $07, $84, $09, $85, $12, $88, $04
	dc.b	$80, $01, $80, $7F, $01, $80, $01, $80, $0D, $87, $14, $83, $07, $84, $03, $85 ;0x200
	dc.b	$07, $80, $03, $80, $0E, $80, $04, $81, $05, $88, $05, $84, $08, $87, $19, $89
	dc.b	$7F, $02, $80, $01, $80, $03, $88, $1A, $86, $06, $83, $05, $84, $07, $80, $03 ;0x220
	dc.b	$80, $0E, $80, $04, $80, $06, $8B, $02, $83, $09, $87, $07, $83, $17, $8B, $74
	dc.b	$89, $1B, $83, $05, $85, $05, $83, $05, $84, $07, $80, $03, $80, $0E, $80, $04 ;0x240
	dc.b	$80, $05, $85, $01, $8B, $08, $88, $07, $89, $1D, $8D, $5A, $8B, $24, $85, $05
	dc.b	$85, $03, $84, $06, $83, $08, $80, $02, $80, $0E, $80, $03, $81, $05, $85, $04 ;0x260
	dc.b	$88, $07, $89, $07, $8D, $27, $92, $35, $91, $30, $85, $06, $85, $02, $83, $07
	dc.b	$84, $07, $80, $02, $80, $0E, $80, $03, $80, $06, $85, $07, $85, $06, $8A, $07 ;0x280
	dc.b	$85, $02, $86, $04, $87, $2B, $B5, $2D, $84, $0F, $86, $06, $85, $01, $83, $08
	dc.b	$83, $07, $80, $02, $80, $0E, $80, $02, $81, $05, $85, $08, $84, $07, $84, $00 ;0x2A0
	dc.b	$85, $06, $85, $04, $85, $03, $8C, $7F, $03, $8F, $0A, $88, $06, $8A, $08, $83
	dc.b	$08, $80, $01, $80, $0E, $80, $02, $80, $06, $85, $07, $85, $06, $84, $01, $85 ;0x2C0
	dc.b	$06, $85, $05, $85, $02, $84, $01, $88, $03, $85, $6D, $84, $03, $86, $02, $87
	dc.b	$08, $88, $07, $88, $0A, $81, $09, $80, $01, $80, $0E, $80, $01, $81, $05, $85 ;0x2E0
	dc.b	$08, $85, $05, $84, $02, $85, $06, $85, $05, $85, $02, $84, $04, $86, $02, $85
	dc.b	$07, $84, $53, $85, $06, $85, $02, $85, $06, $85, $07, $89, $07, $87, $16, $80 ;0x300
	dc.b	$01, $80, $0E, $80, $00, $81, $06, $85, $08, $85, $04, $87, $01, $84, $06, $85
	dc.b	$04, $85, $02, $85, $05, $85, $03, $85, $06, $84, $0E, $8C, $29, $8A, $02, $85 ;0x320
	dc.b	$06, $85, $02, $85, $07, $85, $05, $84, $00, $85, $07, $86, $17, $80, $00, $80
	dc.b	$0E, $80, $00, $81, $06, $85, $07, $85, $05, $8F, $04, $86, $04, $85, $02, $85 ;0x340
	dc.b	$05, $85, $03, $85, $05, $84, $0F, $8E, $06, $84, $05, $8A, $04, $90, $02, $85
	dc.b	$06, $85, $02, $85, $07, $85, $05, $84, $01, $85, $07, $85, $0B, $82, $08, $80 ;0x360
	dc.b	$00, $80, $0E, $82, $01, $80, $06, $82, $08, $85, $04, $85, $01, $88, $04, $87
	dc.b	$02, $85, $03, $85, $05, $85, $04, $85, $04, $84, $0F, $85, $04, $84, $05, $84 ;0x380
	dc.b	$02, $8F, $02, $8A, $09, $84, $06, $85, $02, $85, $08, $85, $04, $83, $02, $85
	dc.b	$07, $85, $0A, $84, $08, $81, $0E, $82, $00, $82, $07, $80, $08, $85, $03, $85 ;0x3A0
	dc.b	$05, $85, $04, $8F, $04, $85, $05, $85, $04, $85, $03, $83, $11, $85, $05, $84
	dc.b	$04, $84, $03, $84, $04, $85, $07, $84, $09, $85, $06, $84, $02, $85, $08, $85 ;0x3C0
	dc.b	$03, $84, $01, $87, $07, $85, $09, $84, $05, $80, $01, $81, $0E, $81, $02, $80
	dc.b	$11, $86, $03, $85, $06, $84, $04, $85, $00, $85, $07, $86, $03, $85, $06, $85 ;0x3E0
	dc.b	$02, $83, $11, $85, $05, $84, $04, $84, $03, $84, $05, $84, $07, $84, $09, $85
	dc.b	$06, $84, $02, $85, $09, $84, $03, $8F, $06, $85, $0A, $82, $05, $82, $01, $80 ;0x400
	dc.b	$0E, $81, $15, $85, $03, $85, $07, $85, $03, $85, $0E, $8F, $07, $85, $01, $83
	dc.b	$12, $85, $05, $84, $04, $84, $03, $84, $05, $84, $07, $84, $09, $85, $06, $84 ;0x420
	dc.b	$02, $85, $09, $84, $03, $87, $01, $85, $06, $85, $14, $80, $02, $80, $0E, $80
	dc.b	$00, $83, $15, $81, $02, $86, $07, $85, $03, $85, $0E, $85, $00, $85, $0B, $85 ;0x440
	dc.b	$00, $83, $12, $85, $05, $84, $04, $84, $03, $84, $05, $84, $07, $85, $08, $91
	dc.b	$03, $85, $08, $84, $02, $84, $06, $85, $05, $85, $16, $82, $0E, $80, $02, $84 ;0x460
	dc.b	$17, $85, $08, $85, $03, $85, $0E, $85, $12, $89, $13, $85, $04, $84, $05, $84
	dc.b	$03, $84, $05, $84, $07, $85, $08, $92, $02, $85, $07, $85, $02, $84, $06, $86 ;0x480
	dc.b	$05, $85, $13, $82, $00, $80, $0E, $80, $05, $84, $14, $85, $08, $85, $03, $85
	dc.b	$0E, $85, $13, $88, $13, $8E, $06, $84, $03, $84, $04, $84, $08, $85, $08, $85 ;0x4A0
	dc.b	$06, $85, $02, $85, $07, $84, $03, $84, $07, $85, $05, $85, $11, $82, $02, $80
	dc.b	$0E, $80, $05, $81, $00, $84, $14, $81, $0A, $85, $02, $85, $0E, $85, $13, $87 ;0x4C0
	dc.b	$14, $8F, $05, $84, $03, $84, $01, $87, $08, $85, $08, $85, $06, $85, $02, $85
	dc.b	$07, $84, $02, $85, $08, $85, $04, $82, $10, $84, $04, $80, $0E, $80, $05, $81 ;0x4E0
	dc.b	$03, $85, $1D, $85, $01, $86, $0E, $84, $15, $86, $14, $85, $04, $85, $04, $84
	dc.b	$03, $8C, $0A, $85, $08, $85, $06, $85, $02, $85, $06, $84, $03, $84, $09, $85 ;0x500
	dc.b	$15, $83, $00, $81, $05, $80, $0E, $80, $05, $81, $07, $85, $1B, $83, $01, $86
	dc.b	$0D, $85, $15, $85, $15, $85, $05, $85, $03, $84, $03, $8A, $0D, $84, $08, $85 ;0x520
	dc.b	$06, $85, $02, $85, $06, $84, $03, $84, $0A, $82, $14, $84, $02, $81, $05, $80
	dc.b	$0E, $80, $05, $81, $0A, $87, $1C, $86, $0D, $85, $15, $85, $15, $85, $06, $84 ;0x540
	dc.b	$03, $84, $03, $84, $00, $85, $0C, $84, $08, $85, $06, $85, $02, $85, $05, $84
	dc.b	$04, $84, $1D, $86, $05, $81, $05, $80, $0E, $80, $05, $81, $0E, $87, $1A, $84 ;0x560
	dc.b	$0D, $85, $15, $85, $15, $85, $06, $85, $02, $84, $03, $84, $01, $85, $0B, $85
	dc.b	$07, $85, $06, $85, $02, $85, $04, $84, $04, $84, $1B, $86, $08, $81, $05, $80 ;0x580
	dc.b	$0E, $80, $05, $81, $13, $86, $29, $85, $15, $85, $15, $85, $06, $85, $02, $84
	dc.b	$03, $84, $03, $84, $0A, $85, $07, $85, $06, $85, $02, $85, $01, $86, $05, $81 ;0x5A0
	dc.b	$1A, $86, $0C, $81, $05, $80, $0E, $80, $05, $81, $17, $88, $23, $85, $15, $85
	dc.b	$15, $85, $06, $84, $03, $84, $03, $84, $04, $84, $09, $85, $07, $85, $06, $85 ;0x5C0
	dc.b	$02, $8C, $1F, $87, $10, $81, $05, $80, $0E, $80, $05, $81, $1B, $89, $20, $83
	dc.b	$15, $85, $15, $85, $05, $85, $03, $84, $03, $84, $04, $84, $09, $85, $08, $85 ;0x5E0
	dc.b	$06, $85, $02, $86, $1F, $87, $15, $81, $05, $80, $0E, $80, $05, $81, $20, $8B
	dc.b	$33, $85, $15, $85, $04, $85, $04, $84, $03, $84, $05, $84, $08, $85, $08, $85 ;0x600
	dc.b	$06, $85, $23, $88, $1A, $81, $05, $80, $0E, $80, $05, $81, $26, $8B, $2F, $83
	dc.b	$15, $8F, $05, $84, $03, $84, $06, $84, $07, $85, $08, $85, $2A, $8A, $1E, $81 ;0x620
	dc.b	$05, $80, $0E, $80, $05, $81, $25, $80, $04, $8E, $41, $8D, $07, $84, $03, $84
	dc.b	$06, $85, $06, $85, $32, $8B, $24, $81, $05, $80, $0E, $80, $05, $81, $24, $80 ;0x640
	dc.b	$02, $82, $06, $8F, $4F, $84, $03, $84, $07, $84, $37, $8E, $03, $80, $24, $81
	dc.b	$05, $80, $0E, $80, $05, $81, $22, $81, $01, $81, $00, $80, $0F, $91, $5C, $83 ;0x660
	dc.b	$2F, $8E, $03, $80, $02, $82, $01, $81, $22, $81, $05, $80, $0E, $80, $05, $81
	dc.b	$20, $85, $01, $81, $18, $93, $7A, $91, $0C, $80, $01, $80, $01, $85, $20, $81 ;0x680
	dc.b	$05, $80, $0E, $80, $05, $81, $1B, $85, $05, $81, $22, $97, $5F, $97, $15, $80
	dc.b	$01, $80, $05, $85, $1B, $81, $05, $80, $0E, $80, $05, $81, $11, $8C, $08, $81 ;0x6A0
	dc.b	$2D, $A1, $37, $9F, $21, $80, $00, $80, $08, $8C, $11, $81, $05, $80, $0E, $80
	dc.b	$05, $81, $08, $88, $04, $83, $0B, $81, $3C, $DD, $30, $82, $0B, $83, $04, $88 ;0x6C0
	dc.b	$08, $81, $05, $80, $07, $82, $03, $80, $05, $8B, $0A, $82, $0D, $82, $50, $B7
	dc.b	$43, $82, $0D, $82, $0A, $8B, $05, $80, $03, $83, $01, $8D, $10, $83, $0F, $82 ;0x6E0
	dc.b	$7F, $4E, $82, $0F, $83, $11, $8C, $02, $83, $00, $8A, $0A, $86, $11, $80, $00
	dc.b	$80, $7F, $50, $80, $00, $80, $11, $86, $0C, $88, $00, $84, $06, $80, $05, $8C ;0x700
	dc.b	$17, $80, $01, $80, $7F, $50, $80, $01, $80, $17, $8C, $05, $80, $0E, $80, $05
	dc.b	$81, $20, $81, $01, $80, $7F, $52, $80, $01, $81, $20, $81, $05, $80, $0E, $80 ;0x720
	dc.b	$05, $81, $1F, $80, $02, $80, $7F, $54, $80, $02, $80, $1F, $81, $05, $80, $0E
	dc.b	$80, $05, $81, $1E, $80, $02, $80, $7F, $56, $80, $02, $80, $1E, $81, $05, $80 ;0x740
	dc.b	$0E, $80, $05, $81, $1D, $80, $02, $80, $7F, $58, $80, $02, $80, $1D, $81, $05
	dc.b	$80, $0E, $80, $05, $81, $1B, $81, $02, $80, $7F, $5A, $80, $02, $81, $1B, $81 ;0x760
	dc.b	$05, $80, $0E, $80, $05, $81, $1A, $80, $03, $81, $7F, $5A, $81, $03, $80, $1A
	dc.b	$81, $05, $80, $0E, $80, $05, $81, $19, $80, $03, $81, $7F, $5C, $81, $03, $80 ;0x780
	dc.b	$19, $81, $05, $80, $0E, $80, $05, $81, $17, $81, $03, $81, $7F, $5E, $81, $03
	dc.b	$81, $17, $81, $05, $80, $0E, $80, $05, $81, $16, $80, $04, $81, $7F, $60, $81 ;0x7A0
	dc.b	$04, $80, $16, $81, $05, $80, $0E, $80, $05, $81, $15, $80, $03, $81, $7F, $64
	dc.b	$81, $03, $80, $15, $81, $05, $80, $0E, $80, $05, $81, $14, $80, $03, $81, $7F ;0x7C0
	dc.b	$66, $81, $03, $80, $14, $81, $05, $80, $0E, $80, $05, $81, $12, $81, $03, $81
	dc.b	$7F, $68, $81, $03, $81, $12, $81, $05, $80, $0E, $80, $05, $81, $11, $80, $03 ;0x7E0
	dc.b	$81, $7F, $6C, $81, $03, $80, $11, $81, $05, $80, $0E, $80, $05, $81, $10, $80
	dc.b	$03, $81, $7F, $6E, $81, $03, $80, $10, $81, $05, $80, $0E, $80, $05, $81, $0E ;0x800
	dc.b	$81, $02, $81, $7F, $72, $81, $02, $81, $0E, $81, $05, $80, $0E, $80, $05, $81
	dc.b	$0D, $80, $02, $81, $7F, $76, $81, $02, $80, $0D, $81, $05, $80, $0E, $80, $05 ;0x820
	dc.b	$81, $0C, $80, $01, $81, $7F, $7A, $81, $01, $80, $0C, $81, $05, $80, $0E, $80
	dc.b	$05, $81, $0A, $84, $7F, $7E, $84, $0A, $81, $05, $80, $0E, $80, $05, $81, $08 ;0x840
	dc.b	$83, $7F, $7F, $04, $83, $08, $81, $05, $80, $0E, $80, $05, $81, $04, $85, $7F
	dc.b	$7F, $08, $85, $04, $81, $05, $80, $0E, $80, $05, $86, $01, $81, $7F, $7F, $0C ;0x860
	dc.b	$81, $01, $86, $05, $80, $0E, $80, $00, $85, $06, $80, $7F, $7F, $10, $80, $06
	dc.b	$85, $00, $80, $0B, $84, $09, $82, $7F, $7F, $12, $82, $09, $84, $04, $83, $0A ;0x880
	dc.b	$84, $7F, $7F, $16, $84, $0A, $83, $0B, $84, $7F, $7F, $1E, $84, $0A, $80, $06
	dc.b	$84, $01, $81, $7F, $7F, $1E, $81, $01, $84, $07, $87, $05, $81, $7F, $7F, $1E ;0x8A0
	dc.b	$81, $05, $88, $06, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05
	dc.b	$81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05 ;0x8C0
	dc.b	$80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F
	dc.b	$7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E ;0x8E0
	dc.b	$80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E
	dc.b	$81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05 ;0x900
	dc.b	$81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05
	dc.b	$80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F ;0x920
	dc.b	$7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E
	dc.b	$80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E ;0x940
	dc.b	$81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05
	dc.b	$81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05 ;0x960
	dc.b	$80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F
	dc.b	$7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E ;0x980
	dc.b	$80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E
	dc.b	$81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05 ;0x9A0
	dc.b	$81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05
	dc.b	$80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F ;0x9C0
	dc.b	$7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E
	dc.b	$80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E ;0x9E0
	dc.b	$81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05
	dc.b	$81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05 ;0xA00
	dc.b	$80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F
	dc.b	$7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E ;0xA20
	dc.b	$80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E
	dc.b	$81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05 ;0xA40
	dc.b	$81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05
	dc.b	$80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F ;0xA60
	dc.b	$7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E
	dc.b	$80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E ;0xA80
	dc.b	$81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05
	dc.b	$81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05 ;0xAA0
	dc.b	$80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F
	dc.b	$7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E ;0xAC0
	dc.b	$80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E
	dc.b	$81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05 ;0xAE0
	dc.b	$81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05
	dc.b	$80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F ;0xB00
	dc.b	$7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E
	dc.b	$80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E ;0xB20
	dc.b	$81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05
	dc.b	$81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05 ;0xB40
	dc.b	$80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F
	dc.b	$7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E ;0xB60
	dc.b	$80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E
	dc.b	$81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05 ;0xB80
	dc.b	$81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05
	dc.b	$80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F ;0xBA0
	dc.b	$7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E
	dc.b	$80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E ;0xBC0
	dc.b	$81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05
	dc.b	$81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05 ;0xBE0
	dc.b	$80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F
	dc.b	$7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E ;0xC00
	dc.b	$80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E
	dc.b	$81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05 ;0xC20
	dc.b	$81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05
	dc.b	$80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F ;0xC40
	dc.b	$7F, $1E, $81, $05, $80, $0E, $80, $05, $81, $7F, $7F, $1E, $81, $05, $80, $07
	dc.b	$FF, $FF, $BF, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F ;0xC60
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F ;0xC80
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F ;0xCA0
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F ;0xCC0
loc_19D5B:
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F
	dc.b	$7F, $7F, $7F, $7F, $80, $7F, $7F, $3F, $83, $7F, $7F, $3F, $81, $7F, $7F, $3F ;0x0 (0x00019D5B-0x0001A9D7, Entry count: 0xC7C)
	dc.b	$81, $7F, $7F, $3F, $84, $7F, $7F, $3F, $82, $7F, $7F, $3F, $81, $7F, $7F, $2C
	dc.b	$87, $0A, $84, $7F, $7F, $27, $81, $03, $8A, $06, $81, $7F, $7F, $25, $80, $05 ;0x20
	dc.b	$81, $04, $88, $01, $81, $7F, $7F, $24, $80, $05, $81, $05, $82, $03, $85, $7F
	dc.b	$7F, $23, $81, $05, $81, $04, $82, $04, $80, $02, $81, $7F, $7F, $22, $81, $05 ;0x40
	dc.b	$81, $05, $82, $02, $81, $04, $80, $7F, $7F, $21, $81, $06, $81, $04, $82, $03
	dc.b	$81, $03, $81, $7F, $7F, $1C, $83, $00, $80, $02, $80, $02, $81, $05, $80, $04 ;0x60
	dc.b	$81, $04, $80, $7F, $7F, $16, $89, $00, $80, $02, $80, $03, $81, $04, $81, $04
	dc.b	$80, $04, $80, $7F, $7F, $12, $8D, $00, $80, $02, $80, $03, $80, $06, $80, $04 ;0x80
	dc.b	$81, $03, $80, $7F, $7F, $0E, $91, $00, $81, $02, $80, $03, $80, $05, $80, $05
	dc.b	$80, $04, $80, $7F, $7F, $07, $97, $01, $80, $02, $80, $03, $80, $05, $80, $05 ;0xA0
	dc.b	$81, $03, $81, $7F, $7F, $00, $9D, $01, $80, $02, $81, $03, $80, $05, $80, $05
	dc.b	$80, $05, $81, $7F, $7A, $A1, $06, $80, $03, $80, $05, $80, $0E, $80, $7F, $6F ;0xC0
	dc.b	$AB, $06, $80, $1B, $80, $7F, $68, $B1, $06, $81, $1B, $80, $7F, $63, $B5, $06
	dc.b	$81, $0F, $83, $08, $FF, $FF, $99, $06, $81, $0A, $85, $02, $81, $07, $80, $7F ;0xE0
	dc.b	$7F, $1F, $80, $05, $84, $0A, $8B, $02, $85, $7F, $7F, $0B, $8E, $1B, $8A, $7F
	dc.b	$7F, $1A, $A6, $7F, $7F, $07, $90, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $2F, $98 ;0x100
	dc.b	$7F, $7F, $25, $B1, $7F, $7F, $0D, $AD, $02, $80, $7F, $7F, $1E, $94, $0A, $80
	dc.b	$7F, $7F, $2F, $80, $0A, $83, $7F, $7F, $0D, $91, $0F, $80, $02, $88, $00, $80 ;0x120
	dc.b	$7F, $7F, $0F, $A6, $07, $80, $7F, $7F, $21, $8F, $0A, $80, $00, $80, $7F, $7F
	dc.b	$30, $80, $07, $83, $00, $80, $7F, $7F, $30, $80, $07, $83, $00, $80, $7F, $7F ;0x140
	dc.b	$20, $8C, $02, $80, $02, $83, $00, $81, $00, $80, $00, $80, $7F, $7F, $2C, $80
	dc.b	$02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $7F, $7F, $2C, $80 ;0x160
	dc.b	$02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $7F, $7F, $2C, $80
	dc.b	$02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $7F, $7F, $2C, $80 ;0x180
	dc.b	$02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $7F, $7F, $2C, $80
	dc.b	$02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $7F, $7F, $2C, $80 ;0x1A0
	dc.b	$02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $7F, $7F, $2C, $80
	dc.b	$02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $7F, $7F, $2C, $80 ;0x1C0
	dc.b	$02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $7F, $7F, $2C, $80
	dc.b	$02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $7F, $7F, $2C, $80 ;0x1E0
	dc.b	$02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $7F, $7F, $2C, $80
	dc.b	$02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $7F, $7F, $2C, $80 ;0x200
	dc.b	$02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $7F, $7F, $2C, $80
	dc.b	$02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $7F, $7F, $2C, $80 ;0x220
	dc.b	$02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $0F, $83, $7F, $7F
	dc.b	$18, $80, $02, $80, $00, $82, $01, $80, $00, $81, $00, $80, $00, $80, $0D, $81 ;0x240
	dc.b	$01, $81, $7F, $7F, $18, $80, $02, $80, $00, $82, $01, $80, $00, $81, $00, $80
	dc.b	$00, $80, $0B, $81, $03, $81, $7F, $7F, $18, $80, $02, $80, $00, $82, $01, $80 ;0x260
	dc.b	$00, $83, $00, $80, $09, $81, $03, $82, $7F, $7F, $19, $80, $02, $80, $00, $82
	dc.b	$01, $80, $00, $81, $02, $80, $07, $81, $03, $83, $7F, $7F, $1A, $80, $02, $80 ;0x280
	dc.b	$00, $82, $01, $80, $05, $80, $05, $81, $03, $83, $00, $80, $7F, $7F, $1A, $80
	dc.b	$02, $80, $00, $82, $01, $80, $05, $80, $03, $81, $03, $85, $00, $80, $7F, $7F ;0x2A0
	dc.b	$1A, $80, $02, $80, $00, $82, $01, $80, $05, $80, $01, $81, $03, $87, $00, $80
	dc.b	$7F, $7F, $1A, $80, $02, $80, $00, $82, $01, $80, $05, $82, $03, $83, $01, $83 ;0x2C0
	dc.b	$00, $80, $7F, $7F, $1A, $80, $02, $8E, $03, $83, $03, $83, $00, $80, $7F, $7F
	dc.b	$1A, $80, $02, $80, $0F, $83, $05, $83, $00, $80, $7F, $7F, $1A, $80, $02, $92 ;0x2E0
	dc.b	$07, $83, $00, $80, $7F, $7F, $1A, $80, $02, $91, $08, $83, $00, $80, $7F, $7F
	dc.b	$1A, $80, $02, $80, $00, $82, $01, $80, $03, $83, $00, $80, $08, $83, $00, $80 ;0x300
	dc.b	$7F, $7F, $00, $8D, $0B, $80, $02, $80, $00, $82, $01, $80, $03, $80, $01, $80
	dc.b	$00, $80, $08, $83, $00, $80, $7F, $7F, $00, $80, $0C, $8C, $02, $80, $00, $82 ;0x320
	dc.b	$01, $80, $03, $80, $01, $80, $00, $80, $08, $83, $00, $80, $7F, $7F, $00, $80
	dc.b	$17, $81, $02, $80, $00, $82, $01, $80, $03, $80, $01, $80, $00, $80, $08, $83 ;0x340
	dc.b	$00, $80, $7F, $7F, $00, $80, $17, $81, $02, $80, $00, $82, $01, $80, $03, $80
	dc.b	$01, $80, $00, $80, $08, $83, $00, $80, $7F, $7F, $00, $80, $17, $81, $02, $80 ;0x360
	dc.b	$00, $82, $01, $80, $03, $80, $01, $80, $00, $8D, $00, $82, $7F, $7E, $80, $17
	dc.b	$81, $02, $80, $00, $82, $01, $80, $03, $80, $01, $80, $00, $91, $7F, $7E, $80 ;0x380
	dc.b	$17, $81, $02, $80, $00, $82, $01, $80, $03, $80, $01, $80, $00, $8F, $00, $81
	dc.b	$7F, $7D, $80, $17, $81, $02, $80, $00, $82, $01, $80, $03, $80, $01, $80, $00 ;0x3A0
	dc.b	$8D, $03, $80, $7F, $7D, $80, $17, $81, $02, $80, $00, $82, $01, $80, $03, $80
	dc.b	$01, $80, $00, $8C, $02, $80, $00, $80, $7F, $7D, $80, $17, $81, $02, $80, $00 ;0x3C0
	dc.b	$82, $01, $80, $02, $81, $01, $80, $00, $8B, $01, $82, $00, $80, $7F, $7D, $80
	dc.b	$17, $81, $02, $80, $00, $82, $01, $80, $00, $83, $01, $80, $00, $89, $02, $83 ;0x3E0
	dc.b	$01, $80, $7F, $7C, $80, $17, $81, $02, $80, $00, $82, $01, $85, $01, $80, $00
	dc.b	$88, $02, $85, $00, $80, $7F, $7C, $80, $17, $81, $02, $80, $00, $8A, $01, $80 ;0x400
	dc.b	$00, $87, $02, $86, $00, $80, $7F, $7C, $80, $17, $81, $02, $80, $00, $8A, $01
	dc.b	$80, $00, $86, $01, $88, $00, $80, $7F, $7C, $8C, $0B, $81, $02, $80, $00, $8A ;0x420
	dc.b	$01, $80, $00, $85, $01, $89, $01, $80, $7F, $7F, $08, $8D, $02, $80, $00, $8A
	dc.b	$01, $80, $00, $84, $01, $8B, $00, $80, $7F, $77, $80, $20, $8C, $01, $80, $00 ;0x440
	dc.b	$82, $02, $8C, $00, $80, $7F, $77, $90, $10, $8C, $01, $83, $01, $8E, $01, $80
	dc.b	$7F, $76, $B3, $01, $80, $00, $8E, $00, $80, $7F, $7F, $04, $A3, $02, $80, $03 ;0x460
	dc.b	$8C, $00, $8A, $7F, $7F, $0C, $90, $02, $80, $04, $8C, $00, $80, $09, $8D, $7F
	dc.b	$5E, $8D, $23, $81, $05, $8C, $01, $80, $16, $89, $7F, $54, $84, $08, $90, $11 ;0x480
	dc.b	$80, $08, $8C, $00, $80, $20, $89, $7F, $4A, $84, $16, $80, $00, $80, $00, $82
	dc.b	$00, $8A, $00, $80, $09, $8C, $00, $80, $2A, $94, $7F, $35, $84, $09, $85, $05 ;0x4A0
	dc.b	$80, $01, $80, $02, $80, $00, $80, $04, $84, $00, $97, $00, $80, $3F, $90, $7F
	dc.b	$24, $84, $0A, $85, $02, $81, $02, $80, $02, $80, $00, $80, $04, $84, $00, $80 ;0x4C0
	dc.b	$0A, $8B, $01, $85, $4A, $97, $7F, $0C, $84, $0B, $85, $00, $80, $04, $80, $02
	dc.b	$80, $00, $80, $04, $84, $00, $80, $0A, $8C, $00, $80, $04, $89, $58, $8F, $7C ;0x4E0
	dc.b	$84, $0C, $85, $04, $81, $02, $80, $00, $80, $04, $84, $00, $80, $0A, $8C, $00
	dc.b	$80, $0E, $8A, $5D, $8B, $70, $84, $0D, $83, $04, $82, $02, $80, $00, $80, $04 ;0x500
	dc.b	$84, $00, $80, $0B, $8B, $01, $80, $18, $89, $5F, $89, $60, $8A, $0E, $80, $04
	dc.b	$84, $02, $80, $00, $80, $04, $84, $00, $80, $0B, $8C, $00, $80, $22, $8A, $5E ;0x520
	dc.b	$8E, $47, $89, $05, $84, $0D, $80, $04, $83, $00, $80, $02, $80, $00, $80, $04
	dc.b	$84, $00, $80, $0C, $8B, $00, $80, $2D, $89, $63, $98, $23, $8A, $0F, $84, $0B ;0x540
	dc.b	$81, $04, $83, $01, $80, $02, $80, $00, $80, $04, $84, $00, $80, $0C, $8B, $00
	dc.b	$80, $37, $8C, $6F, $A3, $1A, $84, $0A, $80, $04, $86, $00, $80, $02, $80, $00 ;0x560
	dc.b	$80, $04, $84, $00, $80, $0C, $8B, $01, $80, $43, $87, $7F, $26, $84, $09, $80
	dc.b	$04, $87, $00, $80, $02, $80, $00, $80, $04, $84, $00, $80, $0D, $8B, $00, $80 ;0x580
	dc.b	$4B, $88, $7F, $1E, $83, $07, $81, $04, $83, $00, $83, $00, $80, $02, $80, $00
	dc.b	$80, $04, $84, $00, $80, $0D, $8B, $00, $80, $54, $89, $7F, $15, $82, $06, $80 ;0x5A0
	dc.b	$04, $84, $02, $82, $00, $80, $02, $80, $00, $80, $04, $84, $00, $80, $0D, $8B
	dc.b	$00, $80, $5E, $89, $7F, $0C, $81, $05, $80, $04, $83, $05, $81, $00, $80, $02 ;0x5C0
	dc.b	$80, $00, $80, $04, $84, $00, $80, $0D, $8B, $01, $80, $67, $89, $7F, $03, $81
	dc.b	$02, $81, $04, $83, $07, $80, $00, $80, $02, $80, $00, $80, $04, $84, $00, $80 ;0x5E0
	dc.b	$0D, $8C, $00, $80, $71, $8A, $74, $80, $03, $81, $00, $80, $04, $84, $0A, $80
	dc.b	$02, $80, $00, $80, $04, $84, $00, $80, $0B, $91, $7B, $89, $6A, $81, $03, $81 ;0x600
	dc.b	$04, $83, $0C, $80, $02, $80, $00, $80, $04, $84, $00, $80, $08, $84, $06, $87
	dc.b	$7F, $06, $89, $60, $82, $00, $80, $06, $83, $0D, $80, $02, $80, $00, $80, $04 ;0x620
	dc.b	$84, $00, $80, $18, $81, $7F, $12, $90, $4F, $84, $04, $84, $0E, $80, $02, $80
	dc.b	$00, $80, $04, $84, $00, $80, $7F, $3E, $95, $39, $83, $04, $83, $10, $80, $02 ;0x640
	dc.b	$80, $00, $80, $00, $80, $02, $84, $00, $80, $7F, $54, $99, $1F, $82, $04, $83
	dc.b	$11, $80, $02, $80, $00, $80, $00, $81, $01, $84, $00, $80, $7F, $6E, $A0, $04 ;0x660
	dc.b	$83, $00, $81, $10, $80, $02, $80, $00, $80, $00, $82, $00, $84, $00, $80, $7F
	dc.b	$7F, $13, $82, $03, $81, $0F, $80, $02, $80, $00, $80, $00, $88, $00, $80, $7F ;0x680
	dc.b	$7F, $12, $84, $03, $81, $0E, $80, $02, $80, $00, $80, $00, $88, $00, $80, $7F
	dc.b	$7F, $10, $84, $01, $80, $03, $81, $0D, $80, $02, $80, $00, $80, $00, $88, $00 ;0x6A0
	dc.b	$80, $7F, $7F, $0F, $84, $03, $80, $03, $81, $0C, $80, $02, $80, $00, $80, $01
	dc.b	$87, $00, $80, $7F, $7F, $0E, $84, $05, $80, $03, $81, $0B, $80, $02, $80, $00 ;0x6C0
	dc.b	$80, $02, $86, $00, $80, $7F, $7F, $0E, $84, $06, $80, $03, $81, $0A, $80, $02
	dc.b	$80, $00, $80, $03, $85, $00, $80, $7F, $7F, $0E, $84, $07, $80, $03, $81, $09 ;0x6E0
	dc.b	$80, $02, $80, $00, $80, $04, $84, $00, $80, $7F, $7F, $0E, $84, $08, $80, $03
	dc.b	$81, $08, $80, $02, $80, $00, $80, $04, $84, $00, $80, $7F, $7F, $0E, $84, $09 ;0x700
	dc.b	$80, $03, $81, $07, $80, $02, $80, $00, $80, $04, $84, $00, $80, $7F, $7F, $0E
	dc.b	$84, $0A, $80, $03, $81, $06, $80, $02, $80, $00, $80, $04, $84, $00, $80, $7F ;0x720
	dc.b	$7F, $0E, $84, $0B, $80, $03, $81, $05, $80, $02, $80, $00, $80, $04, $84, $00
	dc.b	$80, $7F, $7F, $0E, $84, $0C, $80, $03, $81, $04, $80, $02, $80, $00, $80, $04 ;0x740
	dc.b	$84, $00, $80, $7F, $7F, $0E, $84, $0D, $80, $03, $81, $03, $80, $02, $80, $00
	dc.b	$80, $04, $84, $00, $80, $7F, $7F, $22, $80, $03, $81, $02, $80, $02, $80, $00 ;0x760
	dc.b	$80, $04, $84, $00, $80, $7F, $7F, $23, $80, $03, $81, $01, $80, $02, $80, $00
	dc.b	$80, $04, $85, $7F, $7F, $25, $80, $03, $81, $00, $80, $02, $80, $00, $80, $00 ;0x780
	dc.b	$86, $7F, $7F, $20, $89, $03, $82, $02, $80, $00, $80, $00, $80, $7F, $7F, $19
	dc.b	$94, $01, $80, $03, $81, $02, $80, $00, $80, $7F, $7F, $1B, $86, $0F, $81, $03 ;0x7A0
	dc.b	$80, $02, $80, $00, $80, $7F, $7F, $2B, $87, $00, $80, $02, $80, $02, $80, $00
	dc.b	$80, $7F, $7F, $26, $89, $04, $80, $01, $80, $02, $80, $00, $80, $7F, $7F, $1E ;0x7C0
	dc.b	$8B, $0B, $80, $00, $80, $02, $80, $00, $80, $7F, $7F, $1B, $88, $12, $81, $02
	dc.b	$80, $00, $80, $7F, $7F, $1B, $82, $19, $80, $02, $80, $00, $80, $7F, $7F, $38 ;0x7E0
	dc.b	$80, $02, $80, $00, $80, $7F, $7F, $38, $80, $02, $80, $00, $80, $7F, $7F, $38
	dc.b	$80, $02, $80, $00, $80, $7F, $7F, $38, $80, $02, $80, $00, $80, $7F, $7F, $38 ;0x800
	dc.b	$80, $02, $80, $00, $80, $7F, $7F, $1B, $81, $1A, $80, $02, $80, $00, $80, $7F
	dc.b	$7F, $1B, $85, $15, $81, $02, $80, $00, $81, $7F, $7F, $1A, $89, $0C, $86, $02 ;0x820
	dc.b	$83, $7F, $7F, $1E, $A0, $7F, $7F, $1E, $9D, $7F, $7F, $1D, $9A, $7F, $7F, $24
	dc.b	$92, $7F, $7F, $2C, $8A, $7F, $7F, $34, $82, $7F, $7F, $7F, $7F, $7F, $7F, $7F ;0x840
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F ;0x860
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F
	dc.b	$7F, $7F, $7F, $7F, $7B, $EF, $7F, $4F, $FF, $DC, $36, $FF, $FF, $88, $36, $FF ;0x880
	dc.b	$FF, $88, $36, $AB, $7F, $1E, $BB, $00, $80, $36, $AB, $01, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $46, $80, $00 ;0x8A0
	dc.b	$80, $36, $81, $2B, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $00, $80, $36 ;0x8C0
	dc.b	$81, $23, $80, $06, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $00, $80, $36 ;0x8E0
	dc.b	$81, $03, $9C, $02, $80, $06, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $00 ;0x900
	dc.b	$80, $36, $81, $03, $80, $1A, $80, $02, $80, $06, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10 ;0x920
	dc.b	$80, $10, $80, $00, $80, $36, $81, $03, $80, $01, $81, $01, $81, $01, $82, $0D
	dc.b	$80, $02, $80, $06, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10 ;0x940
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $00, $80, $36
	dc.b	$81, $03, $80, $01, $82, $00, $81, $00, $81, $00, $81, $0C, $80, $02, $80, $06 ;0x960
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $00, $80, $36, $81, $03, $80, $01 ;0x980
	dc.b	$85, $00, $81, $00, $81, $0C, $80, $02, $80, $04, $80, $00, $90, $00, $90, $00
	dc.b	$90, $00, $90, $00, $90, $00, $90, $00, $90, $00, $90, $00, $90, $00, $80, $10 ;0x9A0
	dc.b	$80, $10, $80, $10, $80, $00, $80, $36, $81, $03, $80, $01, $81, $00, $82, $00
	dc.b	$81, $00, $81, $0C, $80, $02, $80, $0F, $80, $10, $80, $10, $80, $10, $80, $10 ;0x9C0
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $07, $90, $00, $90, $00, $90, $00
	dc.b	$80, $00, $80, $36, $81, $01, $82, $01, $81, $01, $81, $01, $82, $0D, $82, $00 ;0x9E0
	dc.b	$85, $0A, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $07, $80, $00, $80, $36, $81, $03 ;0xA00
	dc.b	$80, $1A, $80, $13, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $07, $80, $00, $80, $36 ;0xA20
	dc.b	$81, $03, $80, $01, $83, $02, $82, $02, $83, $01, $83, $01, $80, $13, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10 ;0xA40
	dc.b	$80, $10, $80, $10, $80, $07, $80, $00, $80, $36, $81, $03, $80, $01, $81, $00
	dc.b	$81, $00, $81, $00, $81, $00, $81, $03, $81, $04, $80, $13, $80, $10, $80, $10 ;0xA60
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $07, $80, $00, $80, $36, $81, $03, $80, $01, $81, $00, $81, $00 ;0xA80
	dc.b	$81, $00, $81, $00, $81, $00, $81, $01, $82, $02, $80, $13, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10 ;0xAA0
	dc.b	$80, $10, $80, $07, $80, $00, $80, $36, $81, $03, $80, $01, $81, $00, $81, $00
	dc.b	$81, $00, $81, $00, $81, $00, $81, $03, $81, $01, $80, $13, $80, $10, $80, $10 ;0xAC0
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $07, $80, $00, $80, $36, $81, $03, $80, $01, $83, $02, $82, $02 ;0xAE0
	dc.b	$82, $01, $83, $02, $80, $13, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $07, $80, $00 ;0xB00
	dc.b	$80, $36, $81, $03, $80, $1A, $80, $08, $80, $00, $FF, $A1, $08, $80, $10, $80
	dc.b	$10, $80, $07, $80, $00, $80, $36, $81, $03, $9C, $7F, $2C, $99, $00, $90, $00 ;0xB20
	dc.b	$89, $00, $80, $36, $81, $01, $A7, $00, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $47, $80, $00, $80, $36, $81, $2A ;0xB40
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $11, $80, $00, $80, $36, $81, $10, $80, $10 ;0xB60
	dc.b	$80, $06, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $11, $80, $00, $80, $36, $81, $10 ;0xB80
	dc.b	$80, $10, $80, $06, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $11, $80, $00, $80, $36 ;0xBA0
	dc.b	$81, $10, $80, $10, $80, $06, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $11, $80, $00 ;0xBC0
	dc.b	$80, $36, $81, $10, $80, $10, $80, $06, $80, $10, $80, $10, $80, $10, $80, $10
	dc.b	$80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $10, $80, $11 ;0xBE0
	dc.b	$80, $00, $80, $36, $81, $10, $80, $10, $80, $06, $81, $0F, $81, $0F, $81, $0F
	dc.b	$81, $0F, $81, $0F, $81, $0F, $81, $0F, $81, $0F, $81, $0F, $80, $10, $80, $10 ;0xC00
	dc.b	$80, $11, $80, $00, $B9, $10, $80, $10, $80, $05, $C5, $00, $D8, $02, $81, $0F
	dc.b	$81, $0F, $81, $10, $81, $37, $81, $10, $81, $0F, $81, $49, $81, $57, $D9, $00 ;0xC20
	dc.b	$C5, $44, $81, $57, $81, $57, $81, $7F, $08, $81, $58, $81, $57, $81, $7F, $08
	dc.b	$81, $58, $81, $58, $81, $7F, $06, $81, $59, $81, $58, $81, $7F, $06, $81, $59 ;0xC40
	dc.b	$81, $59, $81, $7F, $04, $81, $5A, $81, $59, $81, $7F, $04, $81, $5A, $81, $5A
	dc.b	$81, $7F, $02, $81, $5B, $81, $5A, $81, $7F, $7F, $7F, $01 ;0xC60
loc_1A9D7:
	dc.b	$05, $81, $03, $80, $27, $80, $02, $81, $5E, $80, $15, $80, $02, $82, $02, $82
	dc.b	$04, $82, $05, $84, $05, $80, $02, $80, $0B, $87, $0F, $93, $31, $81, $03, $80 ;0x0 (0x0001A9D7-0x0001C499, Entry count: 0x1AC2)
	dc.b	$27, $80, $02, $83, $5C, $80, $14, $80, $02, $83, $02, $82, $04, $82, $05, $85
	dc.b	$03, $80, $02, $81, $0A, $87, $0E, $95, $31, $81, $03, $80, $27, $80, $02, $81 ;0x20
	dc.b	$00, $83, $08, $80, $4F, $80, $14, $80, $02, $83, $03, $81, $04, $82, $05, $85
	dc.b	$02, $80, $02, $81, $09, $87, $0F, $96, $31, $81, $03, $80, $27, $80, $02, $81 ;0x40
	dc.b	$03, $81, $07, $80, $4F, $80, $13, $80, $02, $84, $03, $81, $04, $82, $06, $84
	dc.b	$01, $80, $02, $81, $09, $87, $0F, $97, $31, $81, $03, $80, $27, $80, $02, $81 ;0x60
	dc.b	$04, $81, $07, $81, $4D, $80, $13, $80, $02, $84, $03, $82, $03, $83, $05, $84
	dc.b	$00, $80, $02, $81, $09, $87, $0E, $99, $30, $81, $03, $80, $28, $80, $02, $81 ;0x80
	dc.b	$02, $80, $01, $82, $05, $80, $4E, $80, $0A, $84, $02, $80, $02, $85, $03, $82
	dc.b	$03, $83, $05, $85, $02, $81, $09, $87, $0E, $9A, $30, $81, $03, $80, $28, $80 ;0xA0
	dc.b	$02, $81, $02, $80, $03, $81, $02, $81, $4F, $80, $09, $80, $03, $81, $01, $80
	dc.b	$02, $81, $00, $82, $03, $82, $03, $83, $05, $84, $02, $81, $09, $86, $0E, $9C ;0xC0
	dc.b	$30, $81, $03, $80, $28, $80, $02, $81, $02, $80, $04, $84, $51, $80, $07, $80
	dc.b	$05, $82, $02, $81, $01, $82, $04, $81, $03, $83, $05, $83, $02, $81, $08, $87 ;0xE0
	dc.b	$0E, $9E, $2F, $81, $03, $80, $28, $80, $02, $81, $02, $80, $05, $83, $51, $80
	dc.b	$06, $80, $05, $83, $02, $81, $02, $81, $04, $81, $03, $83, $05, $82, $02, $81 ;0x100
	dc.b	$08, $87, $0E, $9F, $2F, $81, $03, $80, $28, $80, $02, $81, $00, $82, $05, $81
	dc.b	$53, $80, $06, $80, $05, $82, $02, $81, $03, $81, $04, $81, $03, $83, $05, $81 ;0x120
	dc.b	$02, $81, $08, $86, $0E, $A1, $2F, $81, $03, $80, $28, $80, $02, $81, $03, $83
	dc.b	$00, $81, $54, $80, $06, $80, $04, $83, $01, $83, $02, $81, $04, $81, $03, $84 ;0x140
	dc.b	$04, $80, $02, $81, $08, $86, $0E, $A2, $2F, $81, $03, $80, $28, $80, $02, $81
	dc.b	$07, $81, $55, $80, $07, $80, $02, $83, $02, $83, $02, $82, $03, $81, $03, $84 ;0x160
	dc.b	$03, $80, $01, $82, $08, $86, $0E, $A3, $2F, $81, $03, $80, $28, $80, $02, $81
	dc.b	$06, $81, $56, $80, $08, $86, $01, $84, $03, $81, $03, $82, $02, $84, $02, $80 ;0x180
	dc.b	$01, $82, $07, $87, $0D, $A5, $2F, $81, $03, $80, $28, $80, $02, $81, $05, $81
	dc.b	$57, $80, $08, $80, $03, $80, $01, $85, $03, $81, $03, $82, $03, $83, $01, $80 ;0x1A0
	dc.b	$01, $81, $08, $86, $0E, $A6, $2F, $81, $03, $80, $28, $80, $02, $81, $06, $81
	dc.b	$56, $80, $07, $80, $01, $83, $01, $81, $01, $81, $03, $81, $03, $82, $03, $83 ;0x1C0
	dc.b	$00, $80, $01, $81, $08, $86, $0D, $A8, $2F, $81, $03, $80, $28, $80, $02, $81
	dc.b	$00, $82, $02, $80, $57, $80, $07, $85, $01, $81, $02, $81, $03, $81, $03, $82 ;0x1E0
	dc.b	$03, $84, $01, $81, $08, $86, $0D, $A9, $2F, $81, $03, $80, $28, $80, $02, $81
	dc.b	$02, $82, $00, $80, $57, $80, $04, $88, $00, $82, $02, $81, $03, $82, $02, $82 ;0x200
	dc.b	$03, $83, $01, $81, $08, $86, $0D, $AA, $2F, $81, $03, $80, $28, $80, $02, $81
	dc.b	$02, $80, $02, $81, $56, $85, $05, $86, $02, $81, $03, $82, $02, $82, $03, $82 ;0x220
	dc.b	$01, $81, $07, $86, $0D, $AC, $2F, $81, $03, $80, $28, $80, $02, $81, $02, $80
	dc.b	$03, $81, $51, $83, $06, $84, $00, $85, $02, $82, $02, $82, $02, $83, $03, $80 ;0x240
	dc.b	$01, $81, $07, $86, $0D, $AD, $2F, $81, $03, $80, $28, $80, $02, $81, $02, $80
	dc.b	$02, $84, $4C, $82, $04, $87, $00, $80, $01, $85, $02, $82, $02, $82, $02, $83 ;0x260
	dc.b	$02, $80, $01, $81, $07, $86, $0C, $AF, $2F, $81, $03, $80, $28, $80, $02, $81
	dc.b	$02, $80, $00, $81, $02, $80, $00, $81, $03, $80, $42, $82, $03, $87, $04, $80 ;0x280
	dc.b	$01, $85, $02, $82, $02, $82, $02, $83, $01, $80, $01, $81, $07, $85, $0D, $B0
	dc.b	$2F, $81, $03, $80, $27, $80, $02, $81, $01, $84, $03, $80, $02, $83, $40, $82 ;0x2A0
	dc.b	$03, $84, $00, $83, $05, $80, $01, $85, $02, $82, $02, $82, $02, $83, $00, $80
	dc.b	$01, $81, $07, $85, $0D, $B2, $2E, $81, $03, $80, $27, $80, $02, $81, $05, $81 ;0x2C0
	dc.b	$02, $80, $03, $80, $3F, $82, $03, $84, $03, $83, $05, $80, $01, $86, $01, $82
	dc.b	$02, $82, $02, $84, $01, $81, $06, $86, $0C, $B4, $2E, $81, $03, $80, $27, $80 ;0x2E0
	dc.b	$02, $81, $07, $81, $00, $80, $41, $82, $03, $86, $04, $83, $05, $80, $01, $86
	dc.b	$01, $82, $02, $82, $02, $83, $01, $81, $06, $86, $0C, $B5, $2E, $81, $03, $80 ;0x300
	dc.b	$27, $80, $02, $81, $07, $81, $00, $80, $3E, $82, $03, $83, $00, $83, $05, $83
	dc.b	$05, $80, $01, $86, $01, $83, $01, $83, $01, $82, $01, $81, $06, $85, $0D, $B6 ;0x320
	dc.b	$2E, $81, $03, $80, $27, $80, $02, $84, $04, $80, $01, $80, $3B, $82, $03, $83
	dc.b	$04, $82, $05, $80, $00, $81, $05, $80, $02, $85, $01, $83, $01, $83, $02, $80 ;0x340
	dc.b	$01, $81, $06, $85, $0C, $B8, $2D, $81, $03, $80, $28, $80, $02, $82, $00, $82
	dc.b	$01, $80, $02, $80, $38, $82, $03, $85, $06, $80, $06, $80, $00, $81, $05, $80 ;0x360
	dc.b	$02, $85, $02, $82, $01, $83, $01, $80, $01, $81, $06, $85, $0C, $B9, $2D, $81
	dc.b	$03, $80, $28, $80, $02, $81, $03, $83, $02, $81, $35, $81, $03, $88, $0E, $80 ;0x380
	dc.b	$00, $80, $06, $80, $02, $85, $02, $82, $01, $83, $00, $80, $01, $81, $05, $86
	dc.b	$0B, $BB, $2D, $81, $03, $80, $28, $80, $02, $81, $0C, $80, $32, $81, $03, $82 ;0x3A0
	dc.b	$02, $83, $0F, $80, $00, $80, $06, $80, $02, $85, $02, $82, $01, $84, $01, $81
	dc.b	$05, $85, $0C, $BC, $2D, $81, $03, $80, $28, $80, $02, $81, $3E, $81, $03, $82 ;0x3C0
	dc.b	$04, $83, $0F, $80, $08, $80, $02, $86, $01, $82, $01, $83, $01, $81, $05, $85
	dc.b	$0C, $BD, $2D, $81, $03, $80, $28, $80, $02, $81, $3C, $81, $03, $84, $05, $82 ;0x3E0
	dc.b	$10, $80, $07, $80, $02, $86, $01, $83, $00, $82, $01, $81, $05, $85, $0B, $BF
	dc.b	$2D, $81, $03, $80, $28, $80, $02, $81, $3A, $81, $03, $86, $05, $82, $10, $80 ;0x400
	dc.b	$07, $80, $02, $86, $01, $83, $00, $81, $01, $81, $05, $84, $0C, $C0, $2D, $81
	dc.b	$03, $80, $28, $80, $02, $81, $38, $81, $03, $82, $00, $84, $05, $82, $10, $80 ;0x420
	dc.b	$08, $80, $01, $86, $01, $83, $00, $80, $01, $81, $04, $85, $0B, $C2, $2D, $81
	dc.b	$03, $80, $28, $80, $02, $81, $36, $81, $03, $82, $02, $83, $06, $82, $10, $80 ;0x440
	dc.b	$08, $80, $01, $86, $01, $84, $01, $81, $04, $85, $0B, $C3, $2D, $81, $03, $80
	dc.b	$28, $80, $02, $82, $33, $81, $03, $82, $05, $82, $06, $82, $10, $81, $07, $80 ;0x460
	dc.b	$01, $86, $01, $83, $00, $82, $04, $85, $0B, $C4, $2D, $81, $03, $80, $28, $80
	dc.b	$02, $84, $2F, $81, $03, $83, $06, $82, $06, $82, $08, $81, $05, $81, $07, $80 ;0x480
	dc.b	$01, $86, $01, $82, $00, $81, $05, $84, $0B, $C7, $2C, $81, $03, $80, $28, $80
	dc.b	$02, $81, $02, $81, $2B, $81, $03, $85, $06, $82, $06, $82, $07, $82, $05, $82 ;0x4A0
	dc.b	$06, $80, $01, $87, $01, $80, $00, $81, $05, $84, $0B, $C8, $2C, $81, $03, $84
	dc.b	$24, $80, $02, $81, $02, $80, $00, $80, $28, $81, $03, $87, $06, $82, $06, $82 ;0x4C0
	dc.b	$07, $82, $05, $82, $06, $80, $02, $86, $00, $80, $00, $81, $04, $85, $0B, $C9
	dc.b	$2C, $81, $01, $81, $04, $89, $1A, $80, $02, $81, $02, $80, $00, $81, $25, $81 ;0x4E0
	dc.b	$03, $82, $02, $82, $07, $82, $06, $82, $07, $82, $05, $80, $00, $81, $05, $80
	dc.b	$02, $87, $00, $81, $04, $85, $0A, $CB, $2C, $81, $00, $80, $10, $8F, $0A, $80 ;0x500
	dc.b	$02, $81, $01, $80, $03, $80, $23, $80, $03, $82, $04, $82, $07, $82, $06, $83
	dc.b	$06, $83, $04, $80, $00, $81, $05, $80, $02, $86, $00, $81, $04, $84, $0B, $CC ;0x520
	dc.b	$2C, $87, $1C, $8B, $02, $81, $01, $80, $04, $82, $1E, $81, $02, $84, $04, $82
	dc.b	$07, $83, $05, $83, $06, $83, $04, $80, $01, $80, $05, $80, $02, $85, $00, $81 ;0x540
	dc.b	$04, $84, $0A, $CE, $2C, $94, $1B, $80, $01, $81, $01, $80, $25, $80, $03, $85
	dc.b	$04, $82, $07, $83, $05, $83, $06, $83, $04, $80, $01, $81, $04, $80, $02, $84 ;0x560
	dc.b	$00, $81, $04, $84, $0A, $CF, $34, $9C, $0C, $80, $00, $81, $27, $80, $03, $86
	dc.b	$04, $82, $07, $83, $05, $83, $06, $80, $00, $81, $04, $80, $01, $81, $04, $80 ;0x580
	dc.b	$02, $83, $00, $81, $03, $85, $0A, $D0, $3F, $80, $00, $A0, $25, $81, $02, $81
	dc.b	$02, $82, $05, $81, $08, $83, $05, $83, $06, $80, $00, $81, $04, $80, $02, $80 ;0x5A0
	dc.b	$04, $80, $02, $82, $00, $81, $03, $84, $0A, $D2, $3E, $80, $11, $90, $24, $80
	dc.b	$03, $82, $02, $83, $04, $81, $08, $83, $05, $83, $06, $80, $00, $82, $03, $80 ;0x5C0
	dc.b	$02, $80, $04, $80, $01, $85, $03, $84, $0A, $D3, $3E, $80, $46, $80, $02, $83
	dc.b	$03, $83, $04, $81, $08, $83, $05, $83, $06, $80, $00, $82, $03, $80, $01, $82 ;0x5E0
	dc.b	$03, $82, $01, $82, $03, $84, $09, $D5, $3E, $80, $44, $81, $02, $82, $00, $80
	dc.b	$03, $83, $04, $81, $08, $83, $05, $80, $00, $81, $05, $80, $02, $81, $03, $81 ;0x600
	dc.b	$00, $82, $01, $81, $03, $82, $03, $83, $0A, $D6, $3D, $81, $43, $80, $03, $82
	dc.b	$01, $80, $03, $83, $04, $81, $08, $83, $05, $80, $00, $82, $04, $80, $02, $81 ;0x620
	dc.b	$04, $86, $02, $85, $01, $84, $0A, $D7, $3D, $80, $43, $80, $03, $83, $00, $81
	dc.b	$03, $80, $00, $81, $04, $80, $09, $83, $05, $80, $00, $82, $04, $80, $02, $81 ;0x640
	dc.b	$04, $83, $03, $84, $00, $81, $00, $84, $09, $DA, $3B, $80, $43, $80, $03, $84
	dc.b	$00, $80, $04, $80, $00, $81, $04, $80, $09, $80, $00, $81, $04, $81, $01, $81 ;0x660
	dc.b	$04, $81, $01, $81, $03, $82, $02, $84, $03, $86, $09, $DB, $3B, $80, $42, $80
	dc.b	$03, $85, $00, $80, $04, $80, $00, $81, $0F, $80, $00, $81, $04, $81, $01, $81 ;0x680
	dc.b	$05, $89, $02, $83, $06, $84, $0A, $DC, $3A, $81, $42, $80, $03, $85, $00, $80
	dc.b	$04, $80, $00, $81, $09, $80, $04, $80, $00, $81, $04, $80, $02, $81, $05, $86 ;0x6A0
	dc.b	$03, $82, $07, $85, $09, $DC, $00, $80, $38, $82, $42, $80, $03, $86, $00, $80
	dc.b	$04, $80, $00, $81, $08, $81, $04, $80, $00, $81, $04, $80, $02, $81, $05, $84 ;0x6C0
	dc.b	$02, $83, $07, $86, $09, $DB, $02, $80, $37, $80, $01, $80, $41, $80, $03, $87
	dc.b	$00, $80, $04, $80, $00, $81, $08, $81, $04, $80, $00, $82, $03, $80, $02, $81 ;0x6E0
	dc.b	$02, $84, $03, $82, $07, $88, $08, $DB, $04, $80, $33, $83, $01, $80, $41, $80
	dc.b	$04, $87, $00, $80, $04, $80, $00, $81, $08, $82, $03, $80, $00, $82, $03, $81 ;0x700
	dc.b	$01, $81, $01, $83, $02, $83, $07, $88, $09, $DA, $06, $80, $31, $81, $05, $80
	dc.b	$41, $80, $03, $88, $00, $80, $04, $80, $00, $81, $08, $82, $03, $80, $01, $81 ;0x720
	dc.b	$03, $81, $01, $81, $01, $81, $02, $82, $08, $89, $09, $DA, $07, $80, $30, $80
	dc.b	$07, $80, $40, $80, $04, $81, $00, $85, $00, $80, $04, $80, $00, $81, $08, $82 ;0x740
	dc.b	$02, $81, $01, $81, $04, $80, $00, $84, $02, $82, $07, $8B, $08, $DA, $09, $80
	dc.b	$39, $81, $3F, $80, $03, $81, $01, $85, $00, $80, $04, $80, $00, $81, $07, $81 ;0x760
	dc.b	$00, $80, $02, $80, $02, $81, $01, $87, $02, $82, $07, $8B, $09, $D9, $0B, $80
	dc.b	$38, $80, $01, $81, $3C, $80, $04, $81, $01, $85, $00, $80, $04, $80, $00, $81 ;0x780
	dc.b	$07, $81, $00, $80, $02, $80, $02, $81, $01, $85, $02, $82, $07, $8C, $08, $D9
	dc.b	$0D, $80, $38, $80, $02, $81, $3B, $80, $03, $82, $00, $86, $00, $80, $04, $80 ;0x7A0
	dc.b	$01, $80, $07, $80, $01, $80, $02, $80, $02, $81, $01, $83, $02, $82, $06, $8E
	dc.b	$08, $D8, $0F, $80, $38, $80, $40, $80, $03, $82, $01, $85, $00, $80, $04, $80 ;0x7C0
	dc.b	$01, $80, $07, $80, $01, $80, $02, $80, $02, $81, $01, $81, $02, $82, $06, $8F
	dc.b	$08, $D7, $0F, $82, $38, $80, $3F, $80, $04, $82, $01, $85, $00, $80, $04, $80 ;0x7E0
	dc.b	$01, $81, $06, $80, $01, $85, $00, $85, $01, $82, $06, $8F, $08, $D7, $0E, $85
	dc.b	$36, $81, $40, $80, $03, $83, $01, $85, $00, $80, $04, $80, $00, $82, $05, $81 ;0x800
	dc.b	$01, $85, $00, $83, $02, $81, $06, $90, $08, $D6, $0E, $88, $33, $81, $42, $80
	dc.b	$03, $83, $01, $85, $00, $80, $04, $80, $00, $82, $05, $80, $02, $89, $01, $82 ;0x820
	dc.b	$05, $91, $08, $85, $0C, $C2, $0E, $8A, $31, $82, $43, $80, $03, $83, $01, $85
	dc.b	$00, $80, $04, $80, $01, $81, $05, $80, $02, $87, $02, $81, $06, $8E, $02, $80 ;0x840
	dc.b	$06, $85, $27, $A7, $0E, $8A, $00, $80, $78, $80, $03, $83, $01, $85, $00, $80
	dc.b	$04, $80, $01, $81, $05, $80, $02, $86, $01, $82, $05, $8B, $07, $80, $05, $84 ;0x860
	dc.b	$47, $88, $0D, $89, $03, $80, $77, $80, $03, $84, $01, $85, $00, $80, $03, $80
	dc.b	$02, $88, $02, $84, $02, $81, $06, $88, $0B, $80, $05, $83, $50, $80, $0B, $88 ;0x880
	dc.b	$06, $80, $77, $80, $03, $84, $01, $85, $00, $81, $02, $80, $02, $88, $01, $84
	dc.b	$01, $82, $05, $87, $0E, $80, $05, $83, $50, $80, $09, $88, $08, $80, $77, $80 ;0x8A0
	dc.b	$03, $84, $01, $85, $01, $80, $02, $80, $02, $89, $00, $82, $02, $81, $06, $85
	dc.b	$11, $80, $05, $83, $50, $80, $07, $87, $0B, $80, $77, $80, $03, $85, $00, $85 ;0x8C0
	dc.b	$01, $80, $02, $80, $02, $8C, $01, $81, $06, $84, $14, $80, $05, $83, $50, $80
	dc.b	$05, $86, $0E, $80, $77, $80, $03, $85, $00, $85, $01, $80, $01, $81, $02, $8A ;0x8E0
	dc.b	$02, $81, $05, $84, $16, $80, $05, $83, $50, $80, $05, $84, $10, $80, $77, $80
	dc.b	$03, $85, $00, $85, $01, $80, $01, $81, $02, $89, $01, $81, $06, $83, $18, $80 ;0x900
	dc.b	$05, $83, $50, $80, $05, $84, $10, $80, $77, $80, $03, $85, $00, $85, $01, $84
	dc.b	$02, $88, $01, $81, $05, $82, $1B, $80, $05, $83, $50, $80, $05, $84, $10, $80 ;0x920
	dc.b	$77, $80, $03, $85, $00, $86, $01, $83, $02, $86, $02, $81, $05, $81, $1D, $80
	dc.b	$05, $83, $50, $80, $05, $84, $10, $80, $77, $80, $03, $85, $00, $86, $01, $84 ;0x940
	dc.b	$01, $85, $01, $82, $04, $81, $1F, $80, $05, $83, $50, $80, $05, $84, $10, $80
	dc.b	$77, $80, $03, $85, $00, $86, $01, $84, $01, $84, $01, $81, $05, $81, $20, $80 ;0x960
	dc.b	$05, $83, $50, $80, $06, $84, $0F, $80, $77, $80, $04, $84, $00, $86, $01, $84
	dc.b	$01, $82, $02, $81, $05, $81, $21, $80, $05, $83, $50, $80, $06, $84, $10, $80 ;0x980
	dc.b	$76, $80, $04, $84, $01, $85, $01, $88, $01, $82, $04, $81, $23, $80, $05, $83
	dc.b	$50, $80, $06, $84, $10, $80, $76, $81, $03, $84, $01, $85, $01, $87, $01, $81 ;0x9A0
	dc.b	$05, $81, $24, $80, $05, $83, $50, $80, $06, $84, $10, $80, $76, $81, $03, $84
	dc.b	$01, $85, $01, $86, $01, $81, $05, $81, $25, $80, $05, $83, $09, $90, $35, $80 ;0x9C0
	dc.b	$06, $84, $10, $80, $76, $81, $03, $84, $02, $84, $01, $84, $02, $81, $04, $81
	dc.b	$27, $80, $05, $84, $08, $82, $02, $A8, $18, $80, $05, $84, $10, $80, $6E, $89 ;0x9E0
	dc.b	$04, $83, $02, $84, $00, $84, $01, $82, $04, $81, $28, $80, $05, $84, $09, $80
	dc.b	$05, $B5, $09, $80, $05, $84, $10, $80, $6D, $80, $07, $81, $04, $83, $02, $84 ;0xA00
	dc.b	$00, $83, $01, $81, $05, $81, $29, $80, $05, $84, $09, $80, $05, $81, $01, $84
	dc.b	$19, $92, $09, $80, $05, $84, $10, $80, $6E, $8A, $03, $83, $02, $88, $01, $81 ;0xA20
	dc.b	$05, $81, $2A, $80, $05, $84, $09, $80, $03, $80, $00, $80, $02, $82, $06, $80
	dc.b	$05, $81, $11, $80, $04, $83, $00, $80, $0A, $80, $05, $84, $10, $80, $6F, $82 ;0xA40
	dc.b	$03, $82, $04, $82, $02, $87, $01, $81, $05, $81, $2B, $80, $05, $84, $09, $80
	dc.b	$03, $80, $00, $80, $02, $81, $06, $82, $03, $89, $03, $80, $0C, $81, $01, $80 ;0xA60
	dc.b	$0A, $80, $05, $84, $0D, $83, $6F, $80, $05, $82, $04, $82, $02, $8A, $05, $80
	dc.b	$2D, $81, $04, $84, $09, $80, $03, $80, $00, $80, $01, $81, $07, $83, $01, $80 ;0xA80
	dc.b	$00, $8A, $00, $81, $07, $80, $02, $81, $02, $80, $0A, $80, $05, $84, $0D, $83
	dc.b	$6F, $80, $05, $82, $04, $82, $02, $89, $05, $80, $2F, $80, $05, $83, $09, $80 ;0xAA0
	dc.b	$03, $80, $03, $80, $08, $80, $02, $82, $01, $89, $00, $82, $03, $80, $01, $80
	dc.b	$02, $81, $02, $80, $0A, $80, $05, $84, $0D, $83, $5C, $9A, $00, $81, $04, $82 ;0xAC0
	dc.b	$01, $87, $06, $80, $30, $80, $05, $83, $09, $80, $03, $81, $0B, $80, $03, $81
	dc.b	$02, $81, $07, $83, $02, $81, $01, $81, $01, $80, $04, $80, $09, $80, $05, $84 ;0xAE0
	dc.b	$0D, $83, $5B, $80, $17, $82, $00, $81, $04, $82, $01, $86, $06, $80, $04, $86
	dc.b	$25, $80, $05, $83, $09, $80, $04, $80, $05, $80, $03, $81, $04, $80, $02, $81 ;0xB00
	dc.b	$0A, $81, $01, $82, $01, $80, $01, $80, $04, $80, $09, $80, $05, $84, $0D, $83
	dc.b	$5C, $9A, $00, $82, $04, $81, $00, $86, $06, $80, $03, $81, $05, $82, $23, $80 ;0xB20
	dc.b	$05, $83, $09, $80, $04, $81, $00, $80, $00, $82, $01, $81, $00, $80, $04, $80
	dc.b	$02, $81, $0A, $81, $00, $83, $02, $80, $06, $80, $09, $80, $05, $84, $0D, $84 ;0xB40
	dc.b	$5B, $83, $15, $80, $01, $81, $04, $87, $07, $80, $02, $81, $08, $83, $21, $80
	dc.b	$05, $83, $09, $80, $05, $80, $00, $83, $02, $80, $0B, $81, $0B, $80, $00, $80 ;0xB60
	dc.b	$00, $81, $03, $80, $05, $80, $09, $80, $05, $84, $0D, $84, $5B, $80, $19, $80
	dc.b	$01, $81, $04, $85, $07, $80, $02, $80, $0B, $83, $20, $80, $05, $83, $09, $80 ;0xB80
	dc.b	$02, $80, $01, $80, $00, $83, $02, $80, $0B, $81, $0B, $80, $00, $80, $00, $81
	dc.b	$0A, $80, $09, $80, $05, $84, $0D, $84, $5B, $80, $19, $80, $01, $81, $05, $83 ;0xBA0
	dc.b	$07, $80, $02, $80, $0C, $84, $1F, $80, $05, $83, $09, $80, $02, $80, $01, $80
	dc.b	$00, $83, $01, $80, $0C, $81, $0C, $81, $00, $82, $00, $81, $06, $80, $09, $80 ;0xBC0
	dc.b	$06, $84, $0C, $84, $5B, $80, $19, $81, $00, $82, $04, $82, $07, $80, $03, $80
	dc.b	$0D, $83, $1F, $80, $05, $83, $09, $80, $02, $80, $01, $80, $00, $83, $01, $80 ;0xBE0
	dc.b	$0C, $81, $0C, $81, $00, $82, $01, $81, $00, $80, $04, $80, $08, $80, $06, $84
	dc.b	$0D, $83, $4D, $A9, $01, $82, $05, $81, $06, $80, $03, $80, $0E, $84, $1E, $80 ;0xC00
	dc.b	$05, $83, $09, $80, $02, $80, $01, $80, $00, $82, $01, $81, $0C, $81, $0C, $81
	dc.b	$00, $83, $01, $80, $00, $80, $04, $80, $08, $80, $06, $84, $0D, $83, $4C, $80 ;0xC20
	dc.b	$28, $80, $01, $83, $05, $80, $05, $80, $04, $80, $0E, $84, $1E, $80, $05, $83
	dc.b	$09, $80, $02, $80, $01, $80, $00, $82, $01, $80, $0D, $81, $0F, $84, $02, $80 ;0xC40
	dc.b	$04, $80, $08, $80, $06, $84, $0D, $83, $4C, $AA, $01, $83, $06, $80, $03, $80
	dc.b	$05, $80, $0E, $84, $1E, $80, $05, $83, $09, $80, $02, $80, $01, $83, $01, $81 ;0xC60
	dc.b	$0D, $81, $0F, $85, $01, $80, $04, $80, $08, $80, $06, $84, $0D, $83, $4D, $88
	dc.b	$1F, $80, $01, $84, $06, $80, $01, $81, $05, $80, $0D, $85, $1E, $80, $05, $83 ;0xC80
	dc.b	$08, $80, $03, $80, $02, $81, $01, $81, $0E, $82, $0E, $86, $06, $80, $08, $80
	dc.b	$06, $84, $0D, $83, $4D, $80, $27, $80, $01, $85, $06, $82, $06, $80, $0D, $85 ;0xCA0
	dc.b	$1E, $80, $05, $83, $08, $80, $03, $80, $06, $81, $0E, $82, $0E, $86, $06, $80
	dc.b	$08, $80, $06, $84, $0D, $83, $4D, $80, $26, $80, $02, $86, $06, $80, $07, $80 ;0xCC0
	dc.b	$0C, $86, $1E, $80, $05, $83, $08, $80, $03, $80, $02, $81, $01, $93, $0E, $88
	dc.b	$05, $80, $07, $80, $06, $84, $0D, $83, $4D, $80, $26, $80, $02, $86, $07, $80 ;0xCE0
	dc.b	$07, $80, $0A, $86, $1F, $80, $05, $83, $08, $80, $03, $81, $01, $81, $01, $AB
	dc.b	$05, $80, $08, $80, $05, $84, $0D, $83, $40, $B5, $02, $87, $07, $80, $06, $81 ;0xD00
	dc.b	$08, $86, $20, $80, $05, $83, $08, $80, $03, $81, $01, $80, $01, $82, $0F, $99
	dc.b	$05, $80, $08, $80, $05, $84, $0D, $83, $3F, $80, $34, $80, $02, $85, $00, $81 ;0xD20
	dc.b	$07, $81, $05, $82, $04, $88, $20, $80, $05, $83, $08, $80, $03, $81, $02, $84
	dc.b	$0F, $81, $0E, $88, $05, $80, $08, $80, $05, $84, $0D, $83, $3F, $B6, $02, $85 ;0xD40
	dc.b	$01, $81, $08, $80, $05, $8E, $21, $80, $05, $83, $08, $80, $04, $80, $01, $85
	dc.b	$0F, $81, $0F, $87, $03, $80, $00, $80, $08, $80, $05, $84, $0D, $84, $3F, $8F ;0xD60
	dc.b	$24, $80, $02, $86, $01, $81, $08, $81, $05, $8A, $23, $80, $05, $83, $08, $80
	dc.b	$04, $80, $01, $85, $0F, $81, $0F, $86, $04, $80, $01, $80, $07, $80, $05, $84 ;0xD80
	dc.b	$0D, $84, $3F, $80, $33, $80, $02, $87, $01, $81, $09, $81, $02, $80, $04, $84
	dc.b	$24, $80, $05, $83, $08, $80, $04, $80, $01, $85, $0F, $81, $0F, $86, $04, $80 ;0xDA0
	dc.b	$01, $80, $07, $80, $05, $84, $0D, $84, $3F, $80, $33, $80, $01, $85, $02, $80
	dc.b	$01, $81, $0A, $91, $20, $80, $05, $83, $08, $80, $04, $80, $01, $85, $0F, $81 ;0xDC0
	dc.b	$0F, $85, $05, $81, $00, $80, $07, $80, $05, $84, $0D, $84, $3F, $80, $33, $80
	dc.b	$01, $85, $02, $81, $01, $81, $09, $92, $1F, $80, $05, $83, $08, $80, $04, $80 ;0xDE0
	dc.b	$01, $85, $0F, $81, $0F, $85, $06, $80, $00, $80, $07, $80, $05, $84, $0D, $84
	dc.b	$3F, $80, $32, $81, $01, $86, $02, $81, $01, $81, $08, $80, $0F, $81, $1F, $80 ;0xE00
	dc.b	$05, $83, $08, $80, $04, $80, $01, $85, $0F, $81, $0F, $86, $05, $80, $00, $80
	dc.b	$07, $80, $05, $84, $0D, $84, $3F, $80, $12, $A1, $01, $86, $02, $82, $01, $82 ;0xE20
	dc.b	$06, $80, $0F, $81, $1F, $80, $05, $83, $08, $80, $07, $85, $0F, $81, $0F, $86
	dc.b	$05, $80, $01, $80, $06, $80, $05, $84, $0E, $83, $31, $A1, $1F, $80, $02, $86 ;0xE40
	dc.b	$00, $85, $02, $82, $04, $92, $1F, $80, $05, $83, $08, $80, $07, $85, $0F, $81
	dc.b	$0F, $86, $05, $80, $01, $80, $06, $80, $06, $84, $0D, $83, $30, $80, $41, $80 ;0xE60
	dc.b	$02, $86, $02, $84, $02, $83, $03, $90, $20, $80, $05, $83, $08, $80, $07, $85
	dc.b	$0F, $81, $0F, $86, $05, $80, $01, $80, $06, $80, $06, $84, $0D, $83, $30, $C3 ;0xE80
	dc.b	$02, $86, $00, $83, $01, $82, $02, $83, $02, $80, $0A, $81, $22, $80, $05, $84
	dc.b	$07, $80, $07, $85, $0F, $81, $0F, $86, $05, $81, $00, $80, $06, $80, $06, $84 ;0xEA0
	dc.b	$0D, $83, $31, $C2, $02, $86, $01, $82, $02, $83, $02, $83, $01, $8B, $23, $80
	dc.b	$05, $84, $07, $80, $08, $97, $0E, $86, $05, $81, $00, $80, $06, $80, $06, $84 ;0xEC0
	dc.b	$0D, $83, $1A, $88, $0D, $80, $3F, $81, $01, $87, $01, $82, $02, $84, $03, $8F
	dc.b	$23, $80, $05, $84, $07, $80, $08, $AD, $05, $81, $00, $80, $06, $80, $06, $84 ;0xEE0
	dc.b	$0D, $83, $08, $91, $16, $80, $3F, $81, $01, $87, $01, $82, $02, $80, $02, $82
	dc.b	$03, $82, $0A, $80, $22, $80, $05, $84, $07, $80, $08, $AD, $05, $81, $01, $80 ;0xF00
	dc.b	$05, $80, $06, $84, $0D, $8C, $28, $80, $3F, $81, $01, $87, $01, $81, $03, $80
	dc.b	$03, $83, $02, $8E, $21, $80, $05, $84, $07, $80, $08, $84, $0F, $99, $04, $81 ;0xF20
	dc.b	$01, $80, $05, $80, $06, $84, $0D, $81, $32, $80, $40, $82, $00, $85, $00, $80
	dc.b	$01, $81, $03, $80, $03, $85, $00, $80, $0C, $80, $21, $80, $05, $84, $07, $80 ;0xF40
	dc.b	$08, $84, $0F, $81, $0F, $87, $05, $80, $01, $80, $05, $80, $06, $84, $0D, $80
	dc.b	$33, $80, $40, $80, $03, $84, $00, $80, $01, $81, $03, $80, $03, $82, $00, $91 ;0xF60
	dc.b	$21, $80, $05, $84, $07, $80, $08, $84, $0F, $82, $0E, $87, $05, $80, $01, $80
	dc.b	$05, $80, $06, $84, $0D, $80, $33, $80, $19, $A8, $01, $85, $00, $80, $01, $81 ;0xF80
	dc.b	$04, $80, $01, $83, $02, $8E, $22, $80, $05, $84, $07, $80, $08, $84, $0F, $82
	dc.b	$0E, $87, $08, $80, $05, $80, $06, $84, $0D, $80, $27, $A6, $25, $82, $01, $84 ;0xFA0
	dc.b	$01, $80, $01, $81, $04, $80, $00, $83, $04, $8D, $22, $80, $05, $84, $07, $80
	dc.b	$08, $84, $0F, $82, $0E, $87, $08, $80, $06, $80, $05, $84, $0D, $80, $27, $80 ;0xFC0
	dc.b	$4B, $82, $01, $84, $01, $80, $01, $81, $04, $80, $02, $81, $05, $80, $08, $82
	dc.b	$22, $80, $05, $84, $07, $80, $08, $84, $0F, $82, $0E, $87, $08, $80, $06, $80 ;0xFE0
	dc.b	$05, $84, $0D, $80, $1B, $89, $00, $80, $27, $A7, $01, $84, $01, $80, $01, $81
	dc.b	$04, $80, $00, $83, $05, $80, $08, $82, $22, $80, $05, $84, $07, $80, $03, $80 ;0x1000
	dc.b	$03, $84, $0F, $82, $0E, $87, $06, $80, $01, $80, $05, $80, $05, $84, $0D, $81
	dc.b	$08, $9C, $00, $CE, $02, $84, $01, $80, $01, $81, $04, $80, $00, $83, $05, $80 ;0x1020
	dc.b	$08, $82, $22, $80, $05, $84, $07, $80, $03, $80, $03, $84, $0F, $82, $0E, $87
	dc.b	$06, $80, $01, $80, $05, $80, $05, $84, $0D, $9D, $0B, $A5, $24, $82, $02, $84 ;0x1040
	dc.b	$00, $80, $02, $81, $04, $80, $02, $81, $05, $80, $08, $82, $22, $80, $05, $84
	dc.b	$07, $80, $03, $80, $03, $84, $0F, $82, $0E, $87, $06, $80, $01, $80, $05, $80 ;0x1060
	dc.b	$05, $84, $0D, $89, $20, $80, $48, $82, $02, $84, $00, $80, $02, $81, $04, $80
	dc.b	$02, $81, $05, $80, $08, $82, $22, $80, $05, $84, $07, $80, $03, $80, $03, $84 ;0x1080
	dc.b	$0F, $82, $0E, $87, $06, $80, $01, $80, $05, $80, $05, $84, $0D, $81, $28, $80
	dc.b	$48, $82, $02, $83, $01, $80, $02, $81, $04, $80, $02, $81, $05, $80, $08, $82 ;0x10A0
	dc.b	$22, $80, $05, $84, $06, $80, $04, $80, $03, $84, $0F, $82, $0E, $87, $06, $80
	dc.b	$01, $80, $05, $80, $05, $84, $0D, $81, $12, $92, $02, $80, $48, $82, $02, $83 ;0x10C0
	dc.b	$01, $80, $02, $81, $04, $80, $02, $81, $05, $80, $08, $82, $23, $80, $04, $84
	dc.b	$06, $80, $04, $80, $03, $84, $0F, $82, $0E, $87, $06, $80, $01, $80, $05, $80 ;0x10E0
	dc.b	$06, $84, $0D, $A6, $02, $80, $48, $82, $02, $83, $01, $80, $02, $81, $04, $80
	dc.b	$02, $81, $05, $80, $08, $82, $23, $80, $05, $83, $06, $80, $04, $80, $04, $83 ;0x1100
	dc.b	$0F, $82, $0E, $87, $06, $80, $01, $80, $05, $80, $06, $84, $0D, $95, $13, $80
	dc.b	$48, $82, $02, $83, $01, $80, $02, $81, $04, $80, $02, $81, $05, $80, $08, $82 ;0x1120
	dc.b	$23, $80, $05, $83, $06, $80, $04, $80, $04, $83, $0F, $82, $0E, $87, $01, $80
	dc.b	$03, $80, $02, $80, $04, $80, $06, $84, $0D, $83, $22, $A7, $24, $81, $04, $82 ;0x1140
	dc.b	$01, $80, $02, $81, $04, $80, $02, $81, $05, $80, $08, $82, $23, $80, $05, $83
	dc.b	$06, $80, $01, $80, $01, $80, $04, $83, $0F, $82, $0E, $87, $01, $80, $00, $80 ;0x1160
	dc.b	$01, $80, $02, $80, $04, $80, $06, $84, $0D, $82, $4B, $A6, $04, $82, $01, $80
	dc.b	$02, $81, $04, $80, $02, $81, $05, $80, $08, $82, $23, $80, $05, $83, $06, $80 ;0x1180
	dc.b	$01, $80, $01, $80, $02, $80, $00, $AD, $01, $80, $00, $80, $01, $80, $00, $80
	dc.b	$00, $80, $04, $80, $06, $84, $0D, $82, $71, $80, $04, $82, $01, $80, $02, $81 ;0x11A0
	dc.b	$03, $80, $03, $81, $05, $80, $08, $82, $23, $80, $05, $83, $06, $80, $01, $80
	dc.b	$01, $81, $01, $80, $00, $AD, $00, $81, $00, $80, $03, $80, $00, $80, $04, $80 ;0x11C0
	dc.b	$06, $84, $0D, $82, $23, $A6, $26, $80, $04, $82, $01, $80, $02, $81, $03, $80
	dc.b	$03, $81, $05, $80, $08, $82, $23, $80, $05, $83, $06, $80, $01, $80, $01, $81 ;0x11E0
	dc.b	$01, $80, $00, $84, $0F, $81, $0E, $87, $00, $80, $01, $80, $03, $80, $00, $80
	dc.b	$04, $80, $06, $84, $0D, $82, $23, $CE, $04, $82, $00, $80, $02, $82, $03, $80 ;0x1200
	dc.b	$03, $81, $05, $80, $08, $82, $23, $80, $05, $83, $06, $80, $01, $80, $01, $81
	dc.b	$01, $80, $00, $84, $0F, $81, $0E, $87, $00, $80, $01, $80, $01, $80, $00, $80 ;0x1220
	dc.b	$00, $80, $04, $80, $06, $84, $0D, $82, $4B, $A6, $04, $82, $00, $80, $02, $81
	dc.b	$04, $80, $03, $81, $05, $80, $08, $82, $23, $80, $05, $83, $06, $80, $01, $80 ;0x1240
	dc.b	$02, $80, $01, $80, $00, $84, $0F, $81, $0F, $86, $00, $80, $01, $80, $01, $80
	dc.b	$00, $80, $00, $80, $04, $80, $06, $84, $0D, $82, $6F, $82, $04, $82, $00, $80 ;0x1260
	dc.b	$02, $81, $04, $80, $03, $81, $05, $80, $08, $82, $23, $80, $05, $83, $06, $80
	dc.b	$00, $81, $02, $80, $01, $80, $00, $84, $0F, $81, $0F, $86, $00, $80, $01, $80 ;0x1280
	dc.b	$01, $80, $00, $80, $00, $80, $04, $80, $06, $84, $0D, $82, $6F, $80, $00, $81
	dc.b	$03, $84, $02, $81, $04, $80, $03, $81, $05, $80, $08, $82, $23, $80, $05, $83 ;0x12A0
	dc.b	$06, $80, $00, $81, $02, $80, $01, $80, $00, $84, $0F, $81, $0F, $86, $00, $80
	dc.b	$00, $81, $01, $82, $00, $80, $04, $80, $06, $84, $0D, $83, $6E, $80, $00, $82 ;0x12C0
	dc.b	$02, $83, $04, $81, $03, $80, $03, $81, $05, $80, $08, $82, $23, $80, $05, $83
	dc.b	$06, $80, $00, $81, $02, $80, $01, $80, $00, $84, $0F, $81, $0F, $86, $00, $80 ;0x12E0
	dc.b	$00, $81, $02, $81, $01, $80, $03, $80, $06, $84, $0D, $83, $6E, $80, $00, $82
	dc.b	$01, $86, $00, $83, $03, $80, $02, $82, $05, $80, $08, $82, $23, $80, $05, $83 ;0x1300
	dc.b	$06, $80, $00, $81, $01, $80, $02, $80, $00, $84, $0F, $82, $0E, $86, $00, $80
	dc.b	$00, $81, $02, $81, $01, $80, $04, $80, $05, $84, $0D, $83, $22, $8C, $3E, $80 ;0x1320
	dc.b	$00, $80, $00, $88, $02, $81, $04, $80, $02, $82, $05, $80, $08, $82, $23, $80
	dc.b	$05, $83, $06, $80, $00, $81, $01, $80, $02, $86, $0F, $82, $0E, $86, $00, $80 ;0x1340
	dc.b	$00, $80, $04, $80, $01, $80, $04, $80, $05, $84, $0D, $83, $2F, $99, $24, $80
	dc.b	$00, $80, $00, $80, $02, $84, $03, $81, $03, $80, $02, $82, $05, $80, $08, $83 ;0x1360
	dc.b	$22, $80, $05, $83, $05, $80, $01, $80, $02, $80, $02, $86, $0F, $82, $0E, $88
	dc.b	$00, $80, $01, $80, $01, $80, $01, $80, $04, $80, $05, $84, $0E, $82, $49, $99 ;0x1380
	dc.b	$0A, $80, $00, $80, $00, $80, $04, $81, $04, $81, $03, $80, $02, $82, $05, $80
	dc.b	$08, $83, $22, $80, $05, $83, $05, $80, $01, $80, $02, $80, $02, $86, $0F, $82 ;0x13A0
	dc.b	$0E, $88, $00, $80, $01, $81, $00, $80, $01, $80, $04, $80, $05, $84, $0E, $82
	dc.b	$22, $8C, $33, $8D, $00, $80, $05, $80, $04, $81, $03, $80, $02, $81, $05, $80 ;0x13C0
	dc.b	$0A, $82, $22, $80, $05, $83, $05, $80, $01, $80, $02, $80, $02, $86, $0F, $82
	dc.b	$0E, $88, $00, $80, $00, $82, $00, $80, $01, $80, $04, $80, $05, $84, $0E, $82 ;0x13E0
	dc.b	$22, $A6, $26, $80, $01, $80, $04, $80, $04, $81, $03, $80, $02, $81, $05, $80
	dc.b	$0A, $82, $22, $80, $05, $84, $04, $80, $00, $80, $03, $80, $00, $80, $00, $86 ;0x1400
	dc.b	$0F, $82, $0E, $88, $02, $82, $00, $80, $01, $80, $04, $80, $06, $84, $0D, $82
	dc.b	$2F, $B3, $0C, $81, $00, $80, $04, $80, $04, $81, $03, $80, $02, $81, $05, $80 ;0x1420
	dc.b	$0A, $82, $22, $80, $05, $84, $03, $80, $01, $80, $01, $80, $00, $80, $00, $80
	dc.b	$00, $86, $0F, $82, $0E, $88, $02, $81, $00, $81, $01, $80, $04, $80, $06, $84 ;0x1440
	dc.b	$0D, $82, $49, $A8, $00, $80, $04, $80, $04, $81, $03, $80, $02, $81, $05, $80
	dc.b	$0A, $82, $22, $80, $05, $84, $03, $80, $01, $85, $00, $88, $0F, $82, $0E, $88 ;0x1460
	dc.b	$02, $81, $00, $80, $01, $82, $03, $80, $06, $84, $0D, $82, $13, $8E, $40, $8C
	dc.b	$00, $81, $00, $80, $02, $81, $04, $81, $03, $80, $02, $81, $05, $80, $0A, $82 ;0x1480
	dc.b	$22, $80, $05, $84, $03, $80, $02, $83, $00, $89, $0F, $82, $0E, $88, $00, $80
	dc.b	$00, $80, $04, $80, $00, $80, $03, $80, $06, $84, $0D, $82, $13, $8E, $4C, $80 ;0x14A0
	dc.b	$01, $80, $00, $80, $02, $81, $05, $81, $02, $80, $02, $81, $05, $80, $0A, $82
	dc.b	$22, $80, $05, $84, $03, $80, $00, $82, $00, $80, $01, $B6, $00, $80, $01, $80 ;0x14C0
	dc.b	$03, $80, $03, $80, $06, $84, $0D, $82, $13, $80, $00, $8C, $4C, $80, $01, $80
	dc.b	$00, $80, $02, $80, $06, $81, $02, $80, $02, $81, $05, $80, $0A, $82, $22, $80 ;0x14E0
	dc.b	$05, $84, $04, $81, $06, $B2, $02, $86, $00, $81, $03, $80, $06, $84, $0D, $83
	dc.b	$12, $80, $01, $8B, $4C, $80, $01, $81, $00, $80, $01, $80, $06, $81, $01, $80 ;0x1500
	dc.b	$00, $81, $00, $88, $0A, $A6, $05, $D7, $06, $96, $12, $80, $02, $80, $56, $80
	dc.b	$01, $81, $00, $80, $01, $80, $06, $81, $01, $80, $04, $81, $04, $80, $0A, $82 ;0x1520
	dc.b	$22, $80, $05, $84, $51, $80, $06, $84, $0F, $80, $13, $80, $02, $80, $09, $93
	dc.b	$38, $80, $02, $80, $00, $80, $01, $80, $06, $81, $01, $82, $01, $81, $05, $80 ;0x1540
	dc.b	$0A, $82, $22, $80, $05, $84, $51, $80, $06, $84, $0F, $80, $13, $80, $02, $80
	dc.b	$1D, $A6, $11, $80, $02, $80, $01, $80, $00, $80, $05, $82, $02, $80, $01, $82 ;0x1560
	dc.b	$05, $80, $0A, $82, $22, $80, $05, $84, $51, $80, $06, $84, $10, $80, $12, $80
	dc.b	$02, $80, $44, $97, $00, $80, $00, $80, $05, $82, $01, $80, $03, $88, $0A, $A6 ;0x1580
	dc.b	$05, $D7, $06, $96, $12, $80, $02, $80, $09, $93, $3C, $81, $01, $81, $05, $82
	dc.b	$01, $80, $03, $88, $0A, $A6, $05, $D7, $06, $96, $12, $80, $02, $80, $09, $BA ;0x15A0
	dc.b	$15, $81, $01, $81, $05, $82, $01, $80, $03, $81, $05, $80, $0A, $82, $22, $80
	dc.b	$05, $84, $51, $80, $06, $84, $10, $80, $13, $80, $01, $80, $1D, $BF, $00, $82 ;0x15C0
	dc.b	$04, $82, $01, $80, $03, $81, $05, $80, $0A, $82, $22, $80, $05, $84, $51, $80
	dc.b	$06, $84, $10, $80, $13, $80, $01, $80, $45, $94, $00, $81, $01, $81, $03, $82 ;0x15E0
	dc.b	$01, $80, $05, $81, $04, $80, $0A, $82, $22, $80, $05, $84, $51, $80, $06, $84
	dc.b	$10, $80, $13, $80, $01, $80, $58, $80, $02, $80, $01, $81, $03, $82, $01, $80 ;0x1600
	dc.b	$05, $81, $04, $80, $0A, $82, $22, $80, $05, $84, $52, $80, $05, $84, $10, $80
	dc.b	$13, $80, $01, $80, $58, $80, $02, $81, $01, $81, $01, $84, $00, $80, $05, $81 ;0x1620
	dc.b	$04, $80, $0A, $82, $22, $80, $05, $84, $52, $80, $05, $84, $10, $80, $13, $80
	dc.b	$01, $80, $58, $80, $03, $80, $01, $88, $00, $80, $05, $81, $04, $80, $0A, $82 ;0x1640
	dc.b	$22, $80, $05, $84, $52, $80, $05, $84, $10, $80, $13, $80, $01, $80, $58, $80
	dc.b	$03, $81, $00, $89, $06, $82, $03, $80, $0A, $82, $22, $80, $05, $84, $52, $80 ;0x1660
	dc.b	$06, $84, $0F, $80, $13, $80, $01, $80, $58, $80, $04, $80, $01, $80, $03, $83
	dc.b	$07, $81, $03, $80, $0A, $82, $22, $80, $05, $84, $52, $80, $06, $84, $0F, $80 ;0x1680
	dc.b	$13, $80, $02, $80, $57, $80, $04, $81, $01, $80, $05, $80, $07, $81, $03, $80
	dc.b	$0A, $82, $22, $80, $05, $84, $52, $80, $06, $84, $0F, $80, $13, $80, $02, $80 ;0x16A0
	dc.b	$08, $AB, $22, $80, $04, $81, $01, $80, $05, $80, $07, $81, $03, $80, $0A, $82
	dc.b	$22, $80, $05, $84, $52, $80, $06, $84, $0F, $80, $13, $80, $02, $80, $34, $AB ;0x16C0
	dc.b	$01, $80, $04, $80, $07, $81, $03, $80, $0A, $82, $22, $80, $05, $84, $52, $80
	dc.b	$06, $84, $0F, $80, $13, $80, $02, $80, $60, $80, $00, $80, $04, $80, $07, $81 ;0x16E0
	dc.b	$03, $80, $0A, $82, $22, $80, $05, $84, $52, $80, $06, $84, $0F, $80, $13, $80
	dc.b	$02, $80, $08, $AB, $2B, $80, $01, $80, $03, $80, $07, $81, $03, $80, $0A, $83 ;0x1700
	dc.b	$21, $80, $05, $84, $52, $80, $06, $84, $0F, $80, $13, $80, $02, $80, $08, $D8
	dc.b	$01, $80, $03, $80, $07, $81, $03, $80, $0A, $83, $21, $80, $05, $84, $52, $80 ;0x1720
	dc.b	$06, $84, $10, $80, $12, $80, $02, $80, $34, $AD, $01, $80, $02, $80, $07, $81
	dc.b	$03, $80, $0A, $83, $22, $80, $05, $83, $52, $80, $06, $84, $10, $80, $12, $80 ;0x1740
	dc.b	$02, $80, $5F, $82, $01, $80, $02, $80, $06, $82, $03, $80, $0A, $83, $22, $80
	dc.b	$05, $83, $52, $80, $06, $84, $10, $80, $12, $80, $02, $80, $5F, $83, $01, $80 ;0x1760
	dc.b	$01, $80, $06, $82, $03, $80, $0A, $83, $22, $80, $05, $83, $52, $80, $06, $84
	dc.b	$10, $80, $12, $80, $02, $80, $5F, $83, $01, $80, $02, $80, $05, $81, $04, $80 ;0x1780
	dc.b	$0A, $83, $22, $80, $05, $83, $52, $80, $06, $84, $10, $80, $12, $80, $02, $80
	dc.b	$5F, $80, $01, $81, $01, $80, $01, $80, $05, $81, $04, $80, $0A, $83, $22, $80 ;0x17A0
	dc.b	$05, $83, $52, $80, $06, $84, $10, $80, $12, $80, $02, $80, $5F, $80, $01, $81
	dc.b	$02, $80, $00, $80, $04, $82, $04, $80, $0A, $83, $22, $80, $05, $83, $52, $80 ;0x17C0
	dc.b	$06, $84, $10, $80, $13, $80, $01, $80, $5F, $80, $02, $81, $01, $82, $04, $83
	dc.b	$03, $80, $0A, $83, $22, $80, $05, $84, $51, $80, $06, $84, $10, $80, $13, $80 ;0x17E0
	dc.b	$01, $80, $5F, $80, $03, $81, $01, $80, $00, $80, $02, $84, $03, $80, $0A, $83
	dc.b	$22, $80, $05, $84, $51, $80, $06, $84, $10, $80, $13, $80, $01, $80, $5F, $80 ;0x1800
	dc.b	$04, $81, $01, $82, $01, $86, $01, $80, $0A, $83, $22, $80, $05, $84, $51, $80
	dc.b	$06, $84, $10, $80, $13, $80, $01, $80, $08, $B1, $24, $80, $04, $82, $01, $8B ;0x1820
	dc.b	$00, $80, $0A, $83, $22, $80, $05, $84, $52, $80, $06, $84, $0F, $80, $13, $80
	dc.b	$01, $80, $3A, $B2, $06, $83, $0A, $83, $22, $80, $05, $84, $52, $80, $06, $84 ;0x1840
	dc.b	$0F, $80, $13, $80, $01, $80, $6B, $80, $00, $80, $06, $82, $0A, $83, $22, $80
	dc.b	$05, $84, $52, $80, $06, $84, $0F, $80, $13, $80, $01, $80, $6B, $80, $01, $80 ;0x1860
	dc.b	$07, $80, $0A, $83, $22, $80, $05, $84, $52, $80, $06, $84, $0F, $80, $13, $80
	dc.b	$01, $80, $08, $E3, $02, $80, $06, $80, $0A, $83, $22, $80, $05, $84, $52, $80 ;0x1880
	dc.b	$06, $84, $0F, $80, $13, $80, $01, $80, $08, $E4, $02, $81, $04, $80, $0A, $83
	dc.b	$22, $80, $05, $84, $52, $80, $06, $84, $10, $80, $12, $80, $01, $80, $6A, $83 ;0x18A0
	dc.b	$03, $96, $20, $80, $05, $84, $52, $80, $06, $84, $10, $80, $12, $80, $01, $80
	dc.b	$6A, $80, $00, $82, $02, $80, $04, $80, $0F, $80, $1F, $80, $05, $84, $52, $80 ;0x18C0
	dc.b	$06, $84, $10, $80, $12, $80, $01, $80, $6A, $80, $02, $82, $00, $80, $04, $80
	dc.b	$0F, $80, $1F, $80, $05, $84, $52, $80, $06, $96, $12, $80, $02, $80, $69, $80 ;0x18E0
	dc.b	$03, $9A, $1F, $80, $05, $84, $2B, $AA, $03, $84, $10, $80, $12, $80, $02, $80
	dc.b	$69, $80, $04, $99, $1F, $80, $05, $B0, $2A, $88, $09, $87, $12, $80, $02, $80 ;0x1900
	dc.b	$69, $80, $05, $82, $04, $80, $0C, $A5, $03, $84, $4A, $9E, $06, $80, $12, $80
	dc.b	$02, $80, $69, $80, $07, $96, $22, $89, $1E, $AA, $10, $86, $07, $86, $12, $80 ;0x1920
	dc.b	$02, $80, $69, $80, $06, $80, $06, $80, $0B, $82, $0C, $BF, $29, $A6, $12, $80
	dc.b	$02, $80, $69, $80, $06, $80, $06, $80, $0B, $8F, $19, $86, $1F, $B6, $01, $96 ;0x1940
	dc.b	$12, $80, $02, $80, $3D, $BA, $00, $80, $0B, $82, $0D, $F6, $01, $96, $12, $80
	dc.b	$02, $80, $07, $B5, $3A, $81, $0B, $A6, $01, $DE, $01, $96, $13, $80, $01, $80 ;0x1960
	dc.b	$78, $81, $0C, $A5, $01, $DE, $01, $96, $13, $80, $01, $80, $5A, $9D, $00, $80
	dc.b	$0C, $A5, $01, $DE, $01, $96, $13, $80, $01, $80, $23, $D3, $01, $80, $0C, $A5 ;0x1980
	dc.b	$01, $DE, $01, $96, $13, $80, $01, $80, $07, $D2, $1A, $80, $02, $80, $0C, $A5
	dc.b	$01, $D5, $06, $8A, $0E, $80, $13, $80, $01, $80, $07, $9B, $51, $80, $02, $80 ;0x19A0
	dc.b	$0C, $A5, $01, $A2, $54, $80, $12, $80, $01, $80, $75, $80, $02, $80, $0C, $94
	dc.b	$10, $89, $6F, $80, $12, $80, $01, $80, $75, $80, $02, $80, $0C, $81, $7F, $1D ;0x19C0
	dc.b	$80, $12, $80, $01, $80, $75, $80, $02, $80, $0C, $81, $7F, $1D, $80, $12, $80
	dc.b	$01, $80, $75, $80, $02, $80, $0C, $82, $7F, $1C, $80, $12, $80, $01, $80, $75 ;0x19E0
	dc.b	$80, $02, $80, $0C, $82, $7F, $1C, $80, $12, $80, $01, $80, $75, $80, $02, $80
	dc.b	$0D, $81, $7F, $1C, $80, $12, $80, $01, $80, $75, $80, $02, $80, $0D, $81, $7F ;0x1A00
	dc.b	$1C, $80, $12, $80, $01, $80, $75, $80, $02, $80, $0D, $81, $7F, $1C, $80, $12
	dc.b	$80, $01, $80, $75, $94, $7F, $1C, $80, $12, $80, $01, $80, $75, $80, $01, $80 ;0x1A20
	dc.b	$10, $80, $7F, $1B, $80, $12, $80, $01, $80, $75, $94, $7F, $1C, $80, $12, $80
	dc.b	$02, $80, $74, $95, $7F, $1B, $80, $12, $80, $02, $80, $74, $82, $12, $80, $7F ;0x1A40
	dc.b	$1A, $80, $12, $80, $02, $80, $74, $82, $12, $80, $7F, $1A, $80, $13, $80, $01
	dc.b	$80, $57, $9F, $12, $80, $7F, $1A, $80, $13, $80, $01, $80, $21, $B6, $1A, $97 ;0x1A60
	dc.b	$7F, $1B, $80, $12, $80, $01, $80, $06, $9B, $7F, $7F, $04, $80, $12, $80, $01
	dc.b	$80, $7F, $7F, $27, $80, $12, $80, $01, $80, $7F, $7F, $27, $80, $12, $80, $01 ;0x1A80
	dc.b	$80, $7F, $7F, $27, $80, $12, $80, $01, $80, $7F, $7F, $27, $80, $12, $80, $01
	dc.b	$80, $7F, $7F, $27, $80, $12, $80, $01, $80, $7F, $7F, $27, $80, $12, $80, $01 ;0x1AA0
	dc.b	$80, $06 ;0x1AC0
loc_1C499:
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F ;0x0 (0x0001C499-0x0001D55E, Entry count: 0x10C5)
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $61
	dc.b	$81, $7F, $7F, $3B, $81, $01, $80, $7F, $7F, $32, $87, $04, $80, $7F, $7F, $31 ;0x20
	dc.b	$80, $0C, $80, $7F, $7F, $2F, $80, $0E, $80, $7F, $7F, $2D, $80, $10, $80, $7F
	dc.b	$7F, $2C, $80, $10, $80, $7F, $7F, $2B, $80, $11, $80, $7F, $7F, $2A, $80, $13 ;0x40
	dc.b	$80, $7F, $7F, $29, $80, $13, $80, $7F, $7F, $28, $80, $15, $80, $7F, $7F, $12
	dc.b	$81, $11, $80, $17, $80, $7F, $00, $82, $7F, $0C, $80, $12, $80, $18, $80, $7F ;0x60
	dc.b	$80, $02, $81, $7F, $09, $80, $11, $81, $1A, $81, $7C, $80, $05, $82, $7F, $06
	dc.b	$80, $0F, $81, $1E, $80, $7A, $80, $09, $81, $7F, $03, $80, $0F, $80, $20, $80 ;0x80
	dc.b	$79, $80, $0C, $80, $7F, $01, $80, $0F, $80, $22, $81, $01, $84, $70, $80, $0D
	dc.b	$80, $7E, $81, $0F, $80, $25, $81, $04, $81, $6D, $80, $0F, $80, $7B, $81, $0E ;0xA0
	dc.b	$82, $2F, $80, $6B, $80, $11, $80, $78, $81, $0F, $80, $33, $80, $69, $80, $13
	dc.b	$80, $16, $80, $5E, $80, $10, $80, $35, $80, $67, $80, $15, $80, $13, $81, $00 ;0xC0
	dc.b	$81, $5B, $80, $0D, $83, $37, $81, $43, $83, $1C, $80, $17, $80, $11, $80, $04
	dc.b	$81, $05, $81, $50, $80, $0D, $80, $3D, $80, $3E, $8A, $19, $80, $18, $80, $08 ;0xE0
	dc.b	$83, $01, $81, $07, $81, $02, $80, $01, $80, $4C, $82, $4E, $81, $39, $8F, $15
	dc.b	$81, $1A, $81, $04, $81, $03, $81, $0B, $81, $00, $80, $02, $81, $46, $83, $53 ;0x100
	dc.b	$82, $33, $95, $0F, $82, $1E, $84, $15, $80, $05, $82, $41, $81, $5A, $82, $2D
	dc.b	$9C, $0B, $80, $45, $82, $2A, $81, $0E, $82, $5F, $83, $0C, $87, $12, $A2, $05 ;0x120
	dc.b	$81, $49, $80, $10, $82, $11, $87, $0A, $81, $66, $82, $03, $85, $07, $87, $07
	dc.b	$AB, $4B, $80, $0F, $87, $0B, $8B, $06, $81, $6B, $83, $15, $B1, $4E, $81, $0A ;0x140
	dc.b	$8D, $06, $8F, $02, $81, $7F, $0E, $A9, $51, $84, $03, $91, $02, $94, $7F, $15
	dc.b	$90, $02, $8C, $59, $AC, $7F, $1D, $86, $08, $84, $2B, $83, $32, $A7, $7F, $23 ;0x160
	dc.b	$82, $36, $82, $03, $81, $31, $A4, $7F, $28, $83, $2F, $82, $08, $86, $2D, $9F
	dc.b	$7F, $2E, $84, $27, $82, $12, $88, $27, $9A, $7F, $35, $84, $1F, $82, $1E, $83 ;0x180
	dc.b	$25, $86, $03, $8B, $7F, $3C, $83, $17, $83, $25, $84, $13, $84, $08, $83, $09
	dc.b	$84, $7F, $43, $85, $0B, $85, $2E, $83, $04, $8A, $04, $82, $0D, $85, $7F, $4E ;0x1A0
	dc.b	$81, $04, $84, $38, $84, $12, $85, $02, $84, $7F, $56, $84, $41, $82, $14, $84
	dc.b	$7F, $7F, $25, $85, $0B, $82, $1A, $84, $7F, $7F, $10, $8B, $17, $85, $04, $83 ;0x1C0
	dc.b	$7F, $7F, $16, $99, $0E, $83, $7F, $7F, $3F, $FF, $FF, $C7, $08, $84, $02, $82
	dc.b	$7F, $7F, $36, $84, $03, $80, $7F, $7F, $28, $8D, $05, $82, $7F, $7F, $19, $91 ;0x1E0
	dc.b	$0B, $84, $7F, $7F, $13, $8A, $13, $87, $7F, $7F, $17, $81, $1B, $88, $7F, $7F
	dc.b	$1A, $85, $1D, $89, $7F, $7F, $17, $87, $7F, $7F, $3F, $8B, $7F, $7F, $3F, $8C ;0x200
	dc.b	$7F, $7F, $3F, $86, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F ;0x220
	dc.b	$7F, $7F, $7F, $7F, $7F, $7F, $7D, $81, $7F, $7F, $34, $8A, $7F, $7F, $29, $8E
	dc.b	$7F, $7F, $23, $8F, $7F, $7F, $28, $88, $7F, $7F, $31, $86, $7F, $7F, $33, $85 ;0x240
	dc.b	$7F, $7F, $34, $85, $7F, $7F, $2C, $8D, $7F, $7F, $25, $90, $7F, $7F, $27, $8C
	dc.b	$4A, $80, $7F, $61, $86, $13, $88, $2E, $89, $7F, $5E, $85, $0F, $88, $31, $85 ;0x260
	dc.b	$7F, $63, $87, $46, $86, $7F, $64, $86, $46, $85, $7F, $66, $85, $11, $82, $07
	dc.b	$89, $22, $82, $7F, $69, $83, $12, $83, $04, $85, $2A, $81, $7F, $6C, $80, $12 ;0x280
	dc.b	$82, $05, $82, $2E, $81, $7F, $6D, $80, $4F, $84, $7F, $69, $80, $0D, $81, $42
	dc.b	$8D, $7F, $5C, $80, $0D, $80, $4E, $87, $7F, $59, $81, $0B, $81, $54, $86, $7F ;0x2A0
	dc.b	$55, $81, $0B, $81, $4E, $81, $06, $87, $7F, $51, $81, $0B, $82, $08, $82, $41
	dc.b	$82, $09, $84, $7F, $50, $82, $0B, $83, $07, $84, $3F, $83, $09, $80, $7F, $53 ;0x2C0
	dc.b	$85, $09, $82, $09, $90, $2A, $81, $05, $81, $7F, $62, $85, $4E, $81, $05, $82
	dc.b	$7F, $65, $84, $19, $85, $2B, $81, $06, $81, $7F, $68, $85, $19, $85, $27, $81 ;0x2E0
	dc.b	$7F, $75, $89, $7F, $7F, $3F, $8D, $7F, $7F, $3F, $87, $0A, $81, $7F, $7F, $32
	dc.b	$82, $09, $83, $7F, $7F, $31, $82, $0A, $83, $04, $81, $7F, $7F, $29, $82, $0B ;0x300
	dc.b	$81, $04, $82, $7F, $7F, $29, $82, $0A, $81, $05, $82, $7F, $7F, $29, $82, $09
	dc.b	$81, $06, $82, $7F, $7F, $29, $82, $08, $81, $07, $80, $7F, $7F, $2B, $81, $08 ;0x320
	dc.b	$80, $07, $81, $7F, $7F, $2B, $81, $11, $80, $7F, $7F, $2C, $80, $0B, $80, $04
	dc.b	$80, $7F, $7F, $2C, $81, $0A, $80, $04, $80, $7F, $7F, $2D, $80, $09, $80, $7F ;0x340
	dc.b	$81, $7F, $32, $81, $08, $80, $79, $85, $7F, $35, $80, $07, $80, $76, $83, $7F
	dc.b	$3A, $80, $08, $81, $72, $82, $7F, $3D, $80, $09, $80, $04, $80, $69, $83, $7F ;0x360
	dc.b	$3F, $80, $03, $80, $04, $80, $04, $80, $62, $87, $7F, $41, $81, $03, $80, $04
	dc.b	$80, $04, $80, $0C, $84, $07, $83, $47, $82, $7F, $43, $81, $03, $80, $04, $80 ;0x380
	dc.b	$04, $80, $06, $85, $02, $89, $02, $80, $48, $81, $7F, $42, $81, $04, $80, $05
	dc.b	$80, $04, $80, $0E, $81, $0A, $81, $46, $82, $7F, $42, $80, $05, $80, $05, $80 ;0x3A0
	dc.b	$04, $80, $0E, $81, $09, $85, $0A, $85, $30, $84, $7F, $41, $81, $04, $80, $06
	dc.b	$80, $04, $80, $0D, $81, $0A, $82, $02, $8A, $05, $80, $28, $8B, $7F, $40, $81 ;0x3C0
	dc.b	$05, $80, $06, $80, $04, $80, $0D, $81, $0A, $81, $15, $83, $20, $8D, $7F, $40
	dc.b	$81, $06, $80, $0D, $80, $0D, $81, $0A, $81, $15, $81, $01, $86, $17, $8D, $7F ;0x3E0
	dc.b	$41, $81, $04, $80, $01, $80, $0D, $80, $0D, $81, $09, $82, $15, $81, $08, $83
	dc.b	$0F, $8F, $7F, $40, $83, $04, $80, $12, $80, $0C, $80, $0A, $81, $16, $80, $0D ;0x400
	dc.b	$8F, $00, $8D, $7F, $3E, $84, $06, $80, $06, $80, $0A, $80, $0B, $81, $0A, $81
	dc.b	$16, $80, $1E, $8C, $07, $82, $7F, $31, $83, $09, $80, $07, $80, $0A, $80, $0B ;0x420
	dc.b	$81, $0A, $81, $0C, $80, $08, $80, $1E, $8A, $00, $88, $01, $81, $06, $86, $7F
	dc.b	$20, $83, $15, $80, $16, $81, $09, $81, $0D, $80, $08, $80, $1E, $8A, $0B, $88 ;0x440
	dc.b	$06, $88, $7F, $15, $83, $04, $81, $0C, $80, $02, $80, $16, $80, $0A, $81, $0C
	dc.b	$80, $08, $81, $1E, $89, $0C, $80, $16, $82, $7F, $10, $83, $05, $82, $0C, $80 ;0x460
	dc.b	$03, $80, $16, $80, $0A, $81, $0C, $80, $08, $81, $0B, $80, $11, $89, $0B, $81
	dc.b	$16, $86, $0E, $83, $04, $88, $6A, $82, $06, $82, $13, $80, $15, $80, $0A, $80 ;0x480
	dc.b	$0D, $80, $08, $80, $0C, $80, $11, $89, $0B, $81, $16, $81, $04, $81, $08, $86
	dc.b	$00, $84, $01, $81, $04, $84, $62, $83, $07, $80, $00, $81, $05, $80, $06, $83 ;0x4A0
	dc.b	$01, $80, $14, $81, $09, $81, $0C, $81, $08, $80, $0B, $80, $12, $88, $0C, $81
	dc.b	$16, $81, $06, $88, $03, $82, $07, $81, $09, $82, $5A, $85, $09, $80, $01, $80 ;0x4C0
	dc.b	$05, $80, $05, $81, $02, $80, $17, $81, $09, $81, $0C, $80, $09, $80, $0B, $80
	dc.b	$11, $89, $0C, $80, $16, $82, $13, $82, $07, $80, $0D, $82, $55, $84, $0A, $81 ;0x4E0
	dc.b	$01, $81, $02, $80, $01, $80, $05, $80, $04, $80, $06, $80, $0E, $80, $0A, $81
	dc.b	$0C, $80, $09, $80, $0A, $80, $12, $89, $0B, $81, $16, $82, $13, $81, $07, $81 ;0x500
	dc.b	$0F, $84, $51, $81, $0A, $82, $03, $81, $02, $80, $00, $80, $05, $80, $05, $80
	dc.b	$03, $80, $01, $80, $07, $80, $05, $80, $0A, $80, $0C, $81, $08, $81, $0A, $80 ;0x520
	dc.b	$07, $80, $05, $81, $01, $88, $07, $80, $03, $81, $16, $82, $12, $82, $07, $81
	dc.b	$0E, $83, $01, $95, $3B, $81, $09, $81, $04, $81, $02, $80, $01, $80, $01, $80 ;0x540
	dc.b	$01, $81, $06, $80, $02, $80, $02, $80, $02, $80, $02, $80, $05, $80, $09, $81
	dc.b	$0C, $80, $09, $80, $0A, $80, $08, $80, $05, $80, $02, $88, $07, $80, $03, $81 ;0x560
	dc.b	$07, $80, $0D, $81, $13, $82, $07, $81, $0E, $83, $0D, $81, $05, $8A, $31, $81
	dc.b	$08, $81, $05, $82, $02, $80, $04, $80, $01, $82, $05, $80, $02, $80, $02, $80 ;0x580
	dc.b	$02, $80, $08, $81, $09, $81, $0C, $80, $09, $80, $0A, $80, $07, $80, $05, $81
	dc.b	$02, $88, $05, $81, $04, $80, $08, $80, $0D, $81, $13, $82, $07, $81, $0D, $83 ;0x5A0
	dc.b	$0E, $81, $05, $82, $07, $83, $2C, $81, $08, $81, $04, $84, $08, $80, $02, $81
	dc.b	$04, $81, $02, $80, $02, $80, $02, $80, $08, $80, $0A, $80, $0D, $80, $08, $80 ;0x5C0
	dc.b	$0A, $80, $08, $80, $03, $83, $01, $89, $04, $81, $05, $80, $07, $80, $0E, $81
	dc.b	$13, $81, $08, $80, $0E, $82, $0F, $81, $05, $82, $0B, $87, $22, $82, $08, $81 ;0x5E0
	dc.b	$04, $85, $08, $80, $02, $83, $02, $81, $02, $80, $06, $80, $08, $80, $0A, $80
	dc.b	$0C, $81, $08, $80, $0A, $80, $08, $80, $02, $81, $01, $8D, $01, $81, $06, $81 ;0x600
	dc.b	$07, $80, $0E, $81, $13, $81, $07, $81, $0D, $82, $10, $81, $05, $82, $10, $86
	dc.b	$1D, $82, $01, $80, $01, $80, $01, $81, $04, $87, $04, $80, $07, $86, $05, $80 ;0x620
	dc.b	$0E, $80, $09, $81, $0C, $80, $08, $80, $0A, $80, $08, $81, $01, $80, $05, $89
	dc.b	$00, $82, $08, $81, $07, $80, $0E, $81, $13, $81, $07, $81, $0D, $82, $10, $81 ;0x640
	dc.b	$05, $81, $11, $83, $02, $83, $09, $85, $07, $83, $01, $80, $01, $80, $02, $8E
	dc.b	$04, $80, $08, $84, $00, $80, $04, $80, $0D, $81, $09, $80, $0D, $80, $08, $80 ;0x660
	dc.b	$0A, $80, $08, $80, $0A, $87, $02, $81, $08, $80, $07, $80, $0E, $81, $14, $81
	dc.b	$07, $81, $0C, $82, $11, $81, $05, $81, $12, $82, $06, $89, $05, $82, $03, $83 ;0x680
	dc.b	$01, $80, $05, $82, $04, $87, $04, $80, $04, $80, $08, $80, $04, $80, $0D, $80
	dc.b	$09, $81, $0C, $81, $07, $80, $0A, $80, $09, $80, $0A, $87, $02, $80, $09, $80 ;0x6A0
	dc.b	$07, $80, $0E, $81, $14, $80, $08, $81, $0C, $81, $12, $81, $05, $81, $12, $82
	dc.b	$0B, $82, $0A, $87, $01, $80, $01, $80, $01, $81, $06, $87, $04, $80, $04, $80 ;0x6C0
	dc.b	$08, $80, $07, $80, $09, $81, $09, $81, $0C, $81, $07, $80, $0A, $80, $09, $80
	dc.b	$0A, $87, $02, $80, $08, $81, $07, $80, $0E, $81, $13, $81, $08, $80, $0C, $81 ;0x6E0
	dc.b	$13, $81, $05, $81, $12, $82, $0C, $81, $0D, $84, $00, $80, $02, $80, $01, $80
	dc.b	$08, $86, $04, $80, $04, $80, $04, $80, $02, $80, $07, $80, $09, $80, $09, $81 ;0x700
	dc.b	$0D, $80, $07, $80, $0A, $81, $08, $80, $0B, $86, $03, $81, $07, $80, $07, $80
	dc.b	$0F, $81, $13, $81, $08, $80, $0C, $81, $13, $80, $06, $81, $12, $82, $0C, $81 ;0x720
	dc.b	$0D, $83, $01, $80, $05, $80, $08, $86, $04, $80, $04, $80, $04, $80, $01, $80
	dc.b	$13, $80, $09, $81, $0C, $81, $07, $80, $0A, $80, $09, $80, $0B, $86, $04, $80 ;0x740
	dc.b	$07, $80, $07, $80, $0F, $80, $14, $81, $07, $81, $0B, $81, $14, $80, $06, $81
	dc.b	$13, $81, $0C, $81, $0C, $84, $01, $80, $05, $80, $08, $86, $0A, $80, $04, $80 ;0x760
	dc.b	$01, $80, $12, $80, $0A, $80, $0D, $81, $06, $80, $0A, $81, $09, $80, $0B, $86
	dc.b	$04, $80, $07, $80, $07, $80, $0F, $80, $14, $80, $08, $81, $0B, $80, $15, $80 ;0x780
	dc.b	$06, $81, $13, $81, $0C, $82, $0B, $84, $01, $80, $05, $80, $08, $86, $0A, $80
	dc.b	$04, $80, $01, $80, $12, $80, $09, $81, $0D, $80, $07, $80, $0A, $80, $09, $81 ;0x7A0
	dc.b	$0B, $85, $05, $80, $06, $81, $06, $80, $0F, $81, $14, $80, $08, $80, $0B, $81
	dc.b	$15, $80, $06, $81, $13, $81, $0D, $81, $0B, $83, $02, $80, $04, $80, $0A, $85 ;0x7C0
	dc.b	$0A, $80, $04, $80, $01, $80, $12, $80, $09, $80, $0D, $81, $06, $80, $0A, $81
	dc.b	$09, $80, $0C, $85, $05, $80, $06, $80, $07, $80, $0F, $81, $14, $80, $08, $80 ;0x7E0
	dc.b	$0B, $80, $15, $81, $05, $82, $13, $81, $0D, $81, $0B, $83, $08, $80, $0A, $85
	dc.b	$0A, $80, $04, $80, $01, $80, $11, $80, $09, $80, $0E, $81, $06, $80, $0A, $80 ;0x800
	dc.b	$0A, $80, $0B, $86, $04, $80, $07, $80, $07, $80, $0F, $80, $14, $81, $08, $80
	dc.b	$0A, $81, $15, $81, $05, $81, $14, $82, $0C, $81, $0B, $83, $08, $80, $0A, $85 ;0x820
	dc.b	$0A, $80, $04, $80, $14, $80, $09, $80, $0D, $82, $11, $81, $09, $81, $0B, $85
	dc.b	$05, $80, $07, $80, $06, $80, $0F, $81, $14, $81, $07, $80, $0B, $80, $16, $80 ;0x840
	dc.b	$06, $81, $14, $82, $0C, $81, $0B, $83, $07, $80, $0B, $85, $0A, $80, $04, $80
	dc.b	$13, $80, $0A, $80, $0D, $81, $11, $81, $0A, $80, $0C, $85, $05, $80, $07, $80 ;0x860
	dc.b	$06, $80, $0F, $81, $14, $80, $08, $80, $0B, $80, $16, $80, $06, $81, $14, $82
	dc.b	$0D, $80, $0C, $82, $07, $80, $0B, $85, $0A, $80, $04, $80, $13, $80, $09, $80 ;0x880
	dc.b	$0D, $82, $10, $82, $0A, $80, $0C, $85, $05, $80, $06, $80, $06, $80, $10, $80
	dc.b	$15, $80, $08, $80, $0A, $81, $16, $80, $06, $81, $14, $82, $0D, $81, $0B, $82 ;0x8A0
	dc.b	$06, $80, $0D, $84, $0A, $80, $04, $80, $1E, $80, $0D, $81, $11, $81, $0B, $80
	dc.b	$0B, $86, $04, $80, $07, $80, $06, $80, $0F, $81, $14, $81, $07, $80, $0B, $80 ;0x8C0
	dc.b	$17, $80, $06, $80, $15, $82, $0E, $81, $0A, $82, $06, $80, $0D, $84, $0A, $80
	dc.b	$04, $80, $1D, $80, $0D, $82, $10, $82, $0A, $81, $0B, $87, $03, $80, $07, $80 ;0x8E0
	dc.b	$06, $80, $0F, $80, $15, $81, $07, $80, $0B, $80, $0D, $80, $08, $80, $06, $80
	dc.b	$15, $82, $0E, $81, $0A, $82, $06, $80, $0D, $84, $0A, $80, $04, $80, $08, $80 ;0x900
	dc.b	$13, $80, $0D, $81, $10, $82, $0B, $80, $0B, $88, $03, $80, $07, $80, $05, $80
	dc.b	$0F, $81, $14, $82, $07, $80, $0A, $80, $0E, $80, $08, $80, $06, $80, $15, $82 ;0x920
	dc.b	$0F, $80, $0A, $82, $06, $80, $0D, $84, $0A, $80, $04, $80, $08, $80, $12, $80
	dc.b	$0D, $82, $0F, $82, $0B, $81, $0B, $88, $03, $80, $06, $80, $06, $80, $0F, $80 ;0x940
	dc.b	$15, $81, $07, $80, $0B, $80, $0D, $80, $08, $81, $05, $81, $15, $82, $0F, $80
	dc.b	$0B, $81, $05, $80, $0E, $84, $0A, $80, $04, $80, $08, $80, $12, $80, $0D, $81 ;0x960
	dc.b	$0F, $83, $0B, $80, $0C, $88, $03, $80, $06, $80, $06, $80, $0E, $81, $15, $81
	dc.b	$07, $80, $0A, $81, $0D, $80, $08, $80, $06, $81, $15, $82, $0F, $80, $0B, $81 ;0x980
	dc.b	$05, $81, $0E, $83, $0A, $80, $04, $80, $08, $80, $20, $82, $0F, $82, $0B, $81
	dc.b	$0C, $84, $01, $81, $03, $80, $06, $80, $05, $80, $0F, $80, $15, $81, $14, $80 ;0x9A0
	dc.b	$0E, $80, $08, $80, $06, $80, $17, $81, $0F, $80, $0B, $81, $05, $81, $0E, $83
	dc.b	$0B, $80, $03, $80, $08, $80, $20, $81, $0F, $82, $0C, $80, $0D, $82, $04, $80 ;0x9C0
	dc.b	$03, $80, $06, $80, $05, $80, $0E, $81, $15, $81, $13, $81, $0E, $80, $08, $80
	dc.b	$06, $80, $17, $81, $10, $80, $0A, $82, $04, $81, $0E, $83, $0B, $80, $03, $80 ;0x9E0
	dc.b	$08, $80, $1F, $82, $0E, $82, $0C, $81, $0C, $83, $04, $80, $03, $80, $05, $80
	dc.b	$06, $80, $0E, $80, $15, $81, $14, $81, $0D, $80, $09, $80, $06, $80, $17, $81 ;0xA00
	dc.b	$10, $80, $0A, $82, $04, $82, $0D, $83, $0B, $80, $03, $80, $08, $80, $1F, $81
	dc.b	$0E, $82, $0D, $80, $0D, $83, $04, $80, $03, $80, $05, $80, $05, $80, $0E, $81 ;0xA20
	dc.b	$15, $81, $13, $81, $0E, $80, $08, $80, $06, $80, $18, $81, $10, $80, $0A, $82
	dc.b	$04, $82, $0D, $83, $0B, $80, $0D, $80, $1E, $82, $0D, $82, $0D, $81, $0D, $84 ;0xA40
	dc.b	$00, $80, $00, $81, $02, $81, $04, $80, $06, $80, $0E, $80, $16, $80, $14, $81
	dc.b	$0E, $80, $08, $80, $06, $80, $18, $81, $10, $80, $0A, $82, $04, $82, $0D, $83 ;0xA60
	dc.b	$0B, $80, $0D, $80, $1E, $81, $0D, $83, $0D, $80, $0D, $80, $01, $80, $02, $83
	dc.b	$09, $80, $06, $80, $0E, $80, $15, $81, $13, $82, $0E, $80, $08, $80, $06, $80 ;0xA80
	dc.b	$18, $81, $10, $80, $0A, $82, $04, $80, $00, $80, $0D, $83, $0B, $80, $0C, $80
	dc.b	$0A, $84, $0E, $82, $0D, $82, $0D, $81, $0C, $80, $04, $86, $07, $80, $06, $80 ;0xAA0
	dc.b	$0E, $80, $16, $80, $14, $81, $0E, $80, $11, $80, $0A, $80, $0C, $81, $11, $80
	dc.b	$09, $82, $04, $80, $00, $81, $0D, $82, $0B, $80, $0C, $80, $0F, $81, $0C, $81 ;0xAC0
	dc.b	$0D, $82, $0E, $80, $0D, $80, $01, $80, $05, $81, $08, $80, $06, $80, $0E, $80
	dc.b	$16, $80, $13, $82, $0E, $80, $10, $80, $0B, $80, $0C, $81, $11, $80, $0A, $81 ;0xAE0
	dc.b	$04, $80, $00, $81, $0D, $82, $0B, $80, $0C, $80, $10, $80, $0B, $82, $0C, $82
	dc.b	$0E, $81, $0D, $80, $00, $80, $04, $80, $00, $81, $07, $80, $06, $81, $0D, $80 ;0xB00
	dc.b	$16, $81, $13, $81, $0F, $80, $10, $80, $0B, $80, $0C, $81, $11, $80, $0A, $81
	dc.b	$04, $80, $01, $81, $0C, $82, $0B, $80, $0C, $80, $0A, $82, $03, $88, $02, $81 ;0xB20
	dc.b	$0C, $83, $0E, $80, $0C, $82, $00, $80, $04, $83, $07, $80, $06, $80, $0E, $80
	dc.b	$16, $80, $13, $82, $0F, $80, $10, $80, $0B, $80, $0C, $81, $11, $80, $0A, $81 ;0xB40
	dc.b	$03, $80, $02, $81, $0C, $82, $01, $80, $08, $80, $0C, $80, $0C, $83, $09, $84
	dc.b	$0B, $83, $0E, $81, $0B, $80, $03, $81, $02, $83, $07, $80, $07, $80, $0D, $80 ;0xB60
	dc.b	$17, $80, $12, $83, $0E, $80, $10, $80, $0B, $80, $0D, $81, $12, $80, $09, $81
	dc.b	$03, $80, $02, $81, $0C, $82, $01, $80, $08, $80, $05, $80, $05, $80, $0F, $84 ;0xB80
	dc.b	$07, $86, $07, $83, $0E, $80, $0C, $80, $01, $80, $01, $81, $01, $83, $07, $80
	dc.b	$06, $80, $0E, $80, $16, $80, $11, $84, $0F, $80, $10, $80, $0B, $80, $0D, $81 ;0xBA0
	dc.b	$06, $80, $0A, $80, $09, $81, $03, $80, $02, $81, $0C, $82, $01, $80, $08, $80
	dc.b	$05, $80, $05, $80, $0A, $81, $06, $85, $09, $84, $01, $83, $0E, $81, $0A, $84 ;0xBC0
	dc.b	$03, $83, $00, $81, $06, $80, $07, $80, $0D, $80, $17, $80, $10, $84, $10, $80
	dc.b	$0F, $80, $0C, $80, $0D, $80, $07, $80, $0A, $80, $09, $81, $03, $80, $03, $81 ;0xBE0
	dc.b	$0B, $82, $01, $80, $08, $80, $05, $80, $05, $80, $0C, $83, $06, $87, $08, $85
	dc.b	$0E, $81, $09, $81, $02, $81, $01, $83, $01, $81, $06, $80, $06, $81, $0D, $80 ;0xC00
	dc.b	$16, $80, $10, $84, $11, $80, $0F, $80, $0C, $80, $0D, $80, $07, $80, $0A, $80
	dc.b	$09, $81, $03, $80, $04, $81, $0B, $81, $01, $80, $08, $80, $05, $80, $05, $80 ;0xC20
	dc.b	$10, $82, $08, $86, $08, $82, $0C, $81, $0A, $80, $03, $83, $01, $82, $01, $80
	dc.b	$05, $80, $07, $80, $0D, $80, $17, $80, $0F, $85, $10, $80, $0F, $80, $0D, $80 ;0xC40
	dc.b	$0D, $80, $07, $80, $0A, $80, $09, $81, $03, $80, $04, $82, $0A, $81, $01, $80
	dc.b	$08, $80, $05, $80, $1A, $82, $0A, $85, $06, $84, $08, $81, $0A, $80, $02, $82 ;0xC60
	dc.b	$05, $80, $01, $80, $0D, $81, $0D, $80, $16, $80, $10, $80, $00, $85, $0E, $80
	dc.b	$0F, $80, $0D, $80, $0D, $80, $07, $80, $0B, $80, $08, $81, $03, $80, $04, $80 ;0xC80
	dc.b	$00, $80, $0A, $81, $01, $80, $08, $80, $05, $80, $1D, $83, $0A, $84, $08, $8A
	dc.b	$07, $83, $00, $83, $09, $80, $0C, $82, $0C, $80, $17, $80, $0F, $80, $02, $85 ;0xCA0
	dc.b	$0D, $80, $0F, $80, $0C, $80, $0E, $80, $07, $80, $0B, $80, $08, $81, $03, $80
	dc.b	$04, $80, $01, $80, $09, $81, $01, $80, $08, $80, $05, $80, $21, $82, $0B, $84 ;0xCC0
	dc.b	$0E, $83, $03, $80, $01, $80, $04, $80, $06, $81, $00, $80, $0C, $81, $0D, $80
	dc.b	$16, $80, $10, $80, $02, $86, $0B, $81, $0E, $80, $0D, $80, $0D, $81, $07, $80 ;0xCE0
	dc.b	$0B, $80, $08, $81, $03, $80, $04, $80, $01, $81, $08, $81, $01, $80, $02, $80
	dc.b	$04, $80, $05, $80, $24, $83, $0B, $82, $10, $83, $02, $80, $01, $80, $00, $81 ;0xD00
	dc.b	$04, $81, $02, $81, $0A, $82, $0C, $80, $17, $80, $0F, $80, $02, $87, $0B, $80
	dc.b	$0F, $80, $0D, $80, $0D, $81, $07, $80, $0B, $80, $08, $81, $03, $80, $04, $80 ;0xD20
	dc.b	$02, $81, $07, $81, $01, $80, $02, $80, $0C, $80, $27, $82, $0A, $87, $0B, $81
	dc.b	$00, $81, $02, $82, $04, $81, $04, $80, $0A, $81, $37, $80, $02, $87, $0A, $81 ;0xD40
	dc.b	$0E, $80, $0E, $80, $0D, $81, $07, $80, $0C, $80, $07, $81, $03, $80, $04, $80
	dc.b	$02, $82, $06, $81, $01, $80, $02, $80, $0C, $80, $2A, $82, $09, $8C, $04, $80 ;0xD60
	dc.b	$01, $81, $00, $81, $01, $80, $05, $80, $03, $81, $09, $82, $34, $82, $02, $88
	dc.b	$0A, $81, $0E, $80, $0E, $80, $0D, $80, $08, $80, $0C, $80, $07, $81, $03, $80 ;0xD80
	dc.b	$04, $81, $02, $81, $06, $81, $01, $80, $02, $80, $0C, $80, $2D, $83, $0D, $8A
	dc.b	$04, $80, $02, $81, $01, $81, $00, $81, $02, $82, $08, $82, $2F, $84, $05, $87 ;0xDA0
	dc.b	$0B, $80, $0F, $80, $0D, $81, $0D, $80, $08, $80, $0C, $80, $07, $81, $03, $80
	dc.b	$05, $80, $02, $81, $06, $81, $01, $80, $02, $80, $0C, $80, $31, $81, $14, $84 ;0xDC0
	dc.b	$08, $81, $01, $85, $01, $85, $01, $82, $32, $82, $04, $88, $0A, $81, $0E, $80
	dc.b	$0E, $80, $0E, $80, $08, $80, $0C, $80, $07, $81, $03, $80, $05, $80, $03, $80 ;0xDE0
	dc.b	$06, $81, $01, $80, $02, $80, $0C, $80, $33, $81, $16, $8A, $03, $82, $09, $85
	dc.b	$32, $81, $04, $88, $0A, $80, $0F, $80, $0E, $80, $0E, $80, $08, $80, $0C, $80 ;0xE00
	dc.b	$07, $81, $03, $80, $05, $80, $04, $80, $05, $81, $01, $80, $02, $80, $0C, $80
	dc.b	$35, $81, $18, $8C, $10, $8B, $25, $81, $04, $89, $0A, $80, $0E, $80, $0F, $80 ;0xE20
	dc.b	$0E, $80, $08, $80, $0D, $80, $06, $81, $03, $80, $05, $80, $04, $80, $05, $81
	dc.b	$01, $80, $02, $80, $0C, $80, $37, $81, $1C, $89, $19, $82, $21, $80, $04, $8B ;0xE40
	dc.b	$09, $81, $0E, $80, $0E, $81, $0D, $81, $08, $80, $0D, $80, $06, $81, $03, $80
	dc.b	$05, $80, $05, $80, $04, $81, $01, $80, $02, $80, $0C, $80, $39, $81, $22, $88 ;0xE60
	dc.b	$15, $86, $19, $80, $02, $8E, $09, $80, $0E, $80, $0F, $80, $0E, $81, $08, $80
	dc.b	$0D, $80, $06, $81, $03, $80, $05, $80, $05, $80, $04, $81, $01, $80, $02, $80 ;0xE80
	dc.b	$0C, $80, $3B, $81, $26, $88, $16, $8B, $0B, $81, $01, $90, $08, $81, $0E, $80
	dc.b	$0F, $80, $0E, $80, $09, $80, $0D, $80, $06, $81, $03, $80, $05, $80, $05, $80 ;0xEA0
	dc.b	$04, $81, $01, $80, $02, $80, $4B, $81, $2A, $85, $1F, $85, $02, $96, $09, $81
	dc.b	$1F, $80, $0E, $80, $09, $80, $0E, $80, $05, $81, $03, $80, $05, $80, $06, $80 ;0xEC0
	dc.b	$03, $81, $01, $80, $02, $80, $4D, $81, $2D, $83, $22, $8C, $04, $87, $08, $81
	dc.b	$1F, $81, $0E, $80, $09, $80, $0E, $80, $05, $81, $03, $80, $05, $80, $06, $80 ;0xEE0
	dc.b	$03, $81, $01, $80, $02, $80, $4F, $80, $2E, $84, $08, $92, $04, $85, $06, $84
	dc.b	$02, $82, $09, $81, $1F, $81, $0E, $80, $09, $80, $0E, $80, $05, $81, $03, $80 ;0xF00
	dc.b	$05, $80, $0B, $81, $01, $80, $02, $80, $50, $81, $30, $8C, $0C, $87, $07, $84
	dc.b	$08, $81, $08, $81, $20, $80, $0E, $81, $09, $80, $0E, $80, $05, $81, $03, $80 ;0xF20
	dc.b	$05, $80, $0B, $81, $01, $80, $02, $80, $52, $81, $57, $80, $06, $84, $01, $80
	dc.b	$09, $81, $1F, $81, $0E, $80, $0A, $80, $0E, $80, $05, $81, $03, $80, $05, $81 ;0xF40
	dc.b	$0A, $81, $01, $80, $02, $80, $54, $81, $54, $82, $02, $88, $00, $80, $08, $82
	dc.b	$1F, $81, $0E, $80, $0A, $80, $0E, $80, $05, $81, $03, $80, $05, $81, $0A, $81 ;0xF60
	dc.b	$01, $80, $02, $80, $56, $81, $54, $85, $04, $80, $02, $83, $04, $81, $20, $81
	dc.b	$0E, $80, $0A, $80, $0E, $80, $05, $81, $03, $80, $05, $81, $0A, $81, $05, $80 ;0xF80
	dc.b	$58, $81, $5B, $81, $07, $86, $1F, $82, $0E, $80, $0A, $80, $0E, $80, $05, $81
	dc.b	$03, $80, $05, $81, $0B, $80, $05, $80, $08, $80, $50, $81, $58, $80, $0D, $82 ;0xFA0
	dc.b	$1F, $81, $0F, $80, $0A, $80, $0E, $80, $05, $81, $03, $80, $05, $81, $0B, $80
	dc.b	$05, $80, $08, $80, $52, $81, $55, $81, $10, $83, $1B, $81, $0E, $80, $0B, $80 ;0xFC0
	dc.b	$0E, $80, $05, $81, $03, $80, $05, $81, $0B, $80, $05, $80, $08, $80, $54, $81
	dc.b	$54, $82, $12, $84, $15, $82, $0E, $80, $0B, $80, $0E, $80, $05, $81, $03, $80 ;0xFE0
	dc.b	$05, $81, $0B, $80, $05, $80, $08, $80, $56, $81, $54, $82, $15, $82, $12, $82
	dc.b	$0E, $80, $0B, $80, $0E, $80, $05, $81, $03, $80, $05, $81, $0B, $80, $04, $80 ;0x1000
	dc.b	$09, $80, $58, $82, $53, $87, $11, $83, $0E, $82, $0E, $80, $0B, $80, $0E, $80
	dc.b	$05, $81, $03, $80, $06, $80, $0B, $80, $04, $80, $09, $80, $5B, $83, $55, $87 ;0x1020
	dc.b	$0F, $81, $0B, $82, $0F, $80, $0B, $80, $0E, $80, $04, $82, $03, $80, $06, $80
	dc.b	$0B, $80, $04, $80, $09, $80, $5F, $82, $5A, $82, $0E, $82, $08, $82, $0F, $80 ;0x1040
	dc.b	$0B, $80, $14, $82, $03, $80, $06, $80, $0B, $80, $04, $80, $09, $80, $62, $82
	dc.b	$5A, $83, $0D, $80, $07, $82, $1C, $80, $14, $82, $03, $80, $06, $80, $0B, $80 ;0x1060
	dc.b	$04, $80, $09, $80, $65, $83, $59, $83, $0B, $82, $04, $81, $1D, $80, $14, $82
	dc.b	$03, $80, $06, $80, $0B, $80, $04, $80, $09, $80, $69, $82, $58, $83, $0C, $81 ;0x1080
	dc.b	$01, $82, $1D, $80, $14, $82, $03, $80, $06, $80, $0B, $80, $04, $80, $09, $80
	dc.b	$6C, $81, $59, $81, $0D, $82, $1F, $80, $14, $82, $03, $80, $06, $80, $0B, $80 ;0x10A0
	dc.b	$04, $80, $09, $80, $14 ;0x10C0
loc_1D55E:
	dc.b	$FF, $C5, $00, $C7, $00, $FF, $82, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $82
	dc.b	$0A, $FF, $FF, $B0, $12, $FF, $FF, $A9, $18, $FF, $FF, $A4, $06, $86, $06, $82 ;0x0 (0x0001D55E-0x0001E0C5, Entry count: 0xB67)
	dc.b	$04, $BA, $00, $FF, $E4, $07, $83, $0D, $81, $04, $FF, $FF, $9D, $07, $80, $09
	dc.b	$84, $03, $81, $04, $FF, $FF, $9B, $07, $81, $08, $87, $02, $81, $04, $FF, $FF ;0x20
	dc.b	$99, $13, $81, $04, $81, $09, $FF, $FF, $97, $09, $82, $0F, $80, $0A, $FF, $A8
	dc.b	$00, $EB, $04, $83, $00, $84, $00, $83, $09, $81, $02, $80, $06, $FF, $FF, $93 ;0x40
	dc.b	$04, $82, $02, $81, $01, $82, $00, $82, $09, $80, $03, $81, $05, $FF, $FF, $91
	dc.b	$05, $81, $03, $80, $03, $80, $03, $80, $03, $80, $04, $80, $03, $81, $06, $FF ;0x60
	dc.b	$FF, $90, $02, $81, $00, $81, $04, $80, $07, $80, $03, $80, $02, $81, $04, $81
	dc.b	$06, $FF, $FF, $8F, $03, $81, $01, $80, $00, $81, $01, $82, $09, $81, $01, $80 ;0x80
	dc.b	$06, $81, $07, $FF, $FF, $8D, $01, $80, $00, $81, $03, $81, $09, $82, $02, $80
	dc.b	$01, $80, $06, $82, $08, $C6, $00, $BF, $00, $AD, $00, $BA, $00, $98, $00, $81 ;0xA0
	dc.b	$00, $81, $0B, $83, $01, $81, $00, $80, $02, $80, $04, $84, $08, $FF, $CB, $00
	dc.b	$BF, $00, $81, $01, $80, $09, $82, $03, $81, $01, $80, $01, $80, $04, $82, $00 ;0xC0
	dc.b	$82, $07, $FF, $FF, $8B, $01, $82, $02, $81, $04, $81, $04, $81, $05, $80, $01
	dc.b	$83, $04, $82, $07, $FF, $FB, $00, $8D, $00, $83, $02, $82, $02, $81, $04, $80 ;0xE0
	dc.b	$06, $80, $01, $81, $00, $82, $04, $81, $07, $FF, $CA, $00, $BE, $00, $83, $02
	dc.b	$82, $08, $81, $00, $81, $02, $80, $02, $80, $02, $81, $04, $81, $02, $81, $02 ;0x100
	dc.b	$95, $00, $FF, $F3, $00, $85, $00, $81, $09, $84, $01, $81, $07, $80, $05, $81
	dc.b	$02, $80, $02, $FF, $FF, $8A, $00, $85, $01, $81, $07, $80, $00, $82, $02, $81 ;0x120
	dc.b	$0E, $81, $02, $81, $01, $FF, $FF, $8A, $00, $86, $0A, $80, $00, $81, $03, $81
	dc.b	$05, $81, $06, $81, $02, $81, $01, $FF, $FF, $8A, $00, $87, $01, $84, $02, $80 ;0x140
	dc.b	$01, $80, $04, $80, $04, $83, $05, $81, $02, $81, $01, $FF, $FF, $8A, $00, $86
	dc.b	$01, $82, $01, $80, $03, $80, $03, $80, $01, $81, $02, $82, $07, $80, $07, $FF ;0x160
	dc.b	$FF, $8A, $01, $85, $00, $82, $02, $81, $02, $85, $02, $80, $02, $81, $05, $80
	dc.b	$01, $80, $00, $81, $04, $FF, $FF, $8B, $00, $85, $00, $80, $00, $81, $10, $80 ;0x180
	dc.b	$02, $80, $03, $82, $04, $81, $02, $FF, $FF, $8C, $00, $87, $06, $84, $0C, $83
	dc.b	$07, $81, $02, $FF, $D3, $00, $B7, $01, $89, $02, $82, $02, $80, $07, $80, $09 ;0x1A0
	dc.b	$80, $03, $81, $02, $FF, $FF, $8D, $01, $89, $01, $81, $04, $80, $10, $81, $02
	dc.b	$81, $02, $FF, $E2, $00, $AB, $00, $88, $01, $80, $00, $81, $03, $80, $0E, $81 ;0x1C0
	dc.b	$08, $FF, $FF, $90, $01, $87, $00, $81, $14, $81, $02, $81, $05, $FF, $DB, $00
	dc.b	$99, $00, $99, $01, $89, $07, $80, $08, $83, $04, $80, $04, $FF, $FF, $93, $01 ;0x1E0
	dc.b	$8A, $00, $80, $03, $81, $06, $82, $05, $81, $03, $F9, $00, $FF, $9A, $01, $8B
	dc.b	$03, $83, $08, $80, $01, $82, $03, $FF, $FF, $97, $01, $8B, $03, $84, $05, $81 ;0x200
	dc.b	$07, $FF, $FF, $99, $01, $8D, $00, $81, $00, $82, $0D, $BE, $00, $FF, $DB, $01
	dc.b	$8E, $03, $85, $07, $FF, $F0, $00, $AB, $02, $8F, $0D, $F1, $00, $FF, $AD, $02 ;0x220
	dc.b	$8C, $0C, $D4, $00, $CF, $00, $FD, $03, $90, $03, $D2, $00, $FF, $D5, $04, $88
	dc.b	$04, $FF, $CC, $00, $E2, $0A, $FF, $A4, $00, $D2, $00, $FF, $85, $00, $FF, $FF ;0x240
	dc.b	$AA, $00, $FF, $FF, $FB, $00, $FF, $FF, $FF, $FF, $FF, $83, $00, $F4, $00, $FF
	dc.b	$FF, $FF, $FF, $FF, $83, $1C, $FF, $FF, $98, $0A, $9A, $0A, $FF, $FF, $87, $08 ;0x260
	dc.b	$88, $1A, $89, $07, $FF, $FA, $06, $87, $2D, $85, $07, $FF, $A9, $00, $BF, $00
	dc.b	$83, $05, $85, $3B, $83, $04, $FF, $EA, $05, $83, $45, $82, $01, $CF, $00, $FF ;0x280
	dc.b	$95, $05, $83, $4B, $81, $00, $FF, $E2, $05, $83, $4C, $82, $02, $86, $00, $FF
	dc.b	$BB, $00, $9A, $04, $83, $4E, $81, $05, $B7, $00, $FF, $A3, $04, $82, $2B, $83 ;0x2A0
	dc.b	$02, $81, $17, $85, $07, $FF, $84, $00, $D3, $05, $81, $2A, $83, $03, $82, $01
	dc.b	$81, $13, $81, $0D, $FF, $D6, $05, $82, $26, $85, $0E, $82, $0B, $84, $0F, $FF ;0x2C0
	dc.b	$D3, $06, $81, $25, $83, $17, $82, $02, $85, $14, $FF, $D1, $07, $80, $24, $82
	dc.b	$1E, $82, $1A, $FF, $CE, $08, $81, $24, $80, $3F, $FF, $CC, $09, $80, $12, $83 ;0x2E0
	dc.b	$0D, $81, $40, $C2, $00, $FF, $85, $0B, $81, $0E, $83, $03, $85, $04, $82, $42
	dc.b	$FF, $C7, $0F, $84, $05, $83, $0D, $84, $45, $F7, $00, $CC, $16, $85, $5C, $FF ;0x300
	dc.b	$8F, $00, $B2, $0B, $86, $68, $F8, $00, $B2, $00, $93, $0A, $82, $03, $81, $2E
	dc.b	$84, $35, $FF, $BF, $09, $82, $04, $81, $2C, $83, $03, $81, $34, $FF, $BD, $08 ;0x320
	dc.b	$82, $05, $81, $2C, $81, $06, $81, $35, $FF, $BB, $07, $82, $07, $80, $2C, $81
	dc.b	$04, $84, $36, $FF, $BA, $06, $81, $08, $81, $22, $84, $03, $81, $06, $80, $3A ;0x340
	dc.b	$FF, $B8, $07, $80, $09, $80, $21, $82, $03, $80, $03, $80, $07, $80, $3A, $FF
	dc.b	$B6, $08, $80, $09, $80, $21, $80, $06, $80, $03, $80, $05, $82, $06, $8B, $27 ;0x360
	dc.b	$9F, $00, $FF, $94, $08, $80, $09, $80, $21, $80, $06, $81, $02, $80, $05, $81
	dc.b	$05, $82, $0B, $82, $24, $FF, $B3, $03, $82, $02, $80, $09, $81, $20, $80, $05 ;0x380
	dc.b	$81, $04, $80, $03, $82, $04, $82, $0E, $81, $24, $FF, $B1, $03, $83, $03, $80
	dc.b	$09, $80, $21, $80, $00, $85, $05, $85, $03, $82, $0F, $82, $25, $FF, $B0, $02 ;0x3A0
	dc.b	$81, $01, $81, $03, $80, $0A, $81, $1F, $82, $01, $81, $0B, $84, $0F, $83, $25
	dc.b	$FF, $B0, $02, $81, $02, $80, $03, $81, $0C, $80, $24, $80, $00, $80, $0A, $80 ;0x3C0
	dc.b	$11, $82, $24, $83, $01, $FF, $AD, $01, $81, $03, $80, $02, $81, $0E, $80, $22
	dc.b	$81, $01, $80, $0A, $80, $0F, $82, $22, $83, $05, $B3, $00, $F6, $02, $80, $04 ;0x3E0
	dc.b	$80, $01, $81, $10, $80, $21, $80, $03, $80, $0A, $82, $08, $85, $20, $83, $09
	dc.b	$A1, $00, $FF, $87, $02, $80, $04, $80, $01, $80, $12, $80, $20, $80, $05, $85 ;0x400
	dc.b	$06, $80, $05, $83, $21, $83, $0D, $C5, $00, $E2, $02, $80, $05, $82, $12, $81
	dc.b	$1F, $80, $0C, $80, $05, $80, $02, $83, $21, $82, $11, $FF, $A7, $03, $80, $1A ;0x420
	dc.b	$82, $1F, $81, $0B, $81, $05, $80, $01, $81, $23, $80, $14, $FF, $A6, $02, $81
	dc.b	$19, $82, $21, $80, $0A, $82, $06, $82, $01, $82, $1F, $80, $15, $FF, $A5, $02 ;0x440
	dc.b	$80, $18, $82, $24, $80, $05, $85, $0C, $80, $01, $81, $07, $86, $0F, $80, $15
	dc.b	$FF, $A4, $02, $80, $17, $82, $26, $80, $04, $81, $0F, $81, $03, $80, $06, $80 ;0x460
	dc.b	$06, $80, $0D, $80, $16, $FF, $A2, $02, $81, $17, $81, $28, $86, $0F, $80, $04
	dc.b	$81, $06, $81, $06, $80, $0B, $81, $16, $FF, $A1, $02, $80, $02, $81, $13, $80 ;0x480
	dc.b	$22, $81, $1C, $80, $00, $84, $08, $82, $00, $81, $01, $80, $0D, $82, $13, $FF
	dc.b	$A0, $02, $86, $12, $80, $21, $81, $01, $80, $0B, $81, $0D, $82, $0E, $82, $00 ;0x4A0
	dc.b	$82, $10, $82, $10, $FF, $9F, $03, $81, $01, $81, $11, $81, $21, $80, $03, $80
	dc.b	$08, $82, $00, $80, $39, $83, $0D, $FF, $8B, $00, $91, $07, $80, $12, $81, $21 ;0x4C0
	dc.b	$80, $04, $80, $07, $80, $03, $80, $3C, $84, $09, $FF, $9D, $06, $81, $12, $80
	dc.b	$22, $80, $05, $80, $06, $80, $03, $81, $40, $84, $05, $FF, $9B, $07, $80, $13 ;0x4E0
	dc.b	$80, $23, $80, $03, $82, $03, $82, $03, $81, $09, $85, $35, $84, $01, $FF, $9A
	dc.b	$07, $80, $14, $80, $23, $80, $02, $82, $02, $81, $04, $82, $08, $81, $05, $83 ;0x500
	dc.b	$33, $FF, $9E, $06, $81, $15, $80, $23, $80, $01, $81, $02, $81, $05, $81, $06
	dc.b	$83, $0B, $83, $32, $FF, $9A, $06, $80, $16, $80, $24, $80, $01, $80, $03, $80 ;0x520
	dc.b	$04, $82, $03, $83, $12, $81, $33, $FF, $97, $06, $80, $17, $80, $24, $82, $03
	dc.b	$80, $01, $84, $04, $80, $18, $81, $31, $FF, $96, $06, $80, $18, $80, $2A, $80 ;0x540
	dc.b	$02, $80, $07, $80, $1A, $81, $31, $FF, $94, $06, $80, $18, $80, $2B, $83, $07
	dc.b	$80, $1D, $80, $2F, $FF, $94, $06, $80, $19, $80, $35, $81, $1E, $80, $2F, $FD ;0x560
	dc.b	$00, $94, $06, $80, $19, $80, $33, $82, $1F, $80, $30, $FF, $93, $05, $80, $19
	dc.b	$81, $21, $86, $08, $81, $21, $80, $31, $FF, $92, $05, $80, $17, $82, $22, $80 ;0x580
	dc.b	$06, $81, $04, $81, $23, $81, $30, $FF, $91, $05, $80, $15, $82, $23, $81, $09
	dc.b	$84, $26, $80, $30, $FF, $90, $05, $80, $14, $81, $25, $80, $37, $80, $30, $FF ;0x5A0
	dc.b	$8F, $05, $80, $13, $81, $22, $84, $38, $80, $30, $FF, $8E, $05, $80, $13, $81
	dc.b	$21, $81, $3E, $81, $2E, $FF, $8D, $05, $80, $12, $81, $21, $81, $42, $80, $2D ;0x5C0
	dc.b	$FF, $8C, $05, $80, $12, $81, $20, $81, $45, $88, $24, $FF, $8C, $05, $80, $12
	dc.b	$80, $20, $80, $4F, $80, $24, $FF, $8B, $05, $80, $12, $81, $1F, $80, $50, $84 ;0x5E0
	dc.b	$20, $C5, $00, $C3, $05, $80, $12, $81, $1E, $81, $56, $80, $1F, $FF, $89, $05
	dc.b	$80, $12, $81, $1E, $80, $58, $82, $1D, $FF, $89, $05, $80, $12, $80, $1E, $80 ;0x600
	dc.b	$5C, $93, $09, $FF, $88, $05, $80, $12, $80, $1E, $80, $71, $80, $08, $FF, $81
	dc.b	$00, $84, $06, $80, $11, $80, $1E, $80, $73, $80, $07, $92, $00, $F3, $07, $80 ;0x620
	dc.b	$10, $80, $1D, $80, $74, $80, $07, $FF, $86, $08, $80, $0D, $82, $1C, $81, $76
	dc.b	$80, $06, $FF, $85, $08, $80, $0A, $84, $1E, $80, $77, $81, $05, $A5, $00, $DD ;0x640
	dc.b	$09, $80, $07, $83, $22, $80, $75, $83, $05, $D9, $00, $A9, $08, $80, $09, $80
	dc.b	$23, $80, $74, $82, $08, $FF, $83, $08, $80, $0A, $80, $23, $80, $72, $81, $0B ;0x660
	dc.b	$FF, $83, $08, $80, $0B, $80, $21, $80, $2D, $82, $42, $81, $0B, $FF, $82, $08
	dc.b	$80, $0C, $80, $21, $80, $2C, $81, $00, $81, $3D, $84, $0C, $FF, $81, $08, $80 ;0x680
	dc.b	$0D, $81, $20, $80, $2B, $81, $02, $80, $3C, $82, $0F, $FF, $81, $08, $80, $0B
	dc.b	$82, $21, $80, $29, $82, $03, $80, $3A, $82, $11, $B0, $00, $CE, $08, $80, $0A ;0x6A0
	dc.b	$82, $22, $80, $29, $81, $05, $80, $39, $81, $13, $FF, $80, $07, $80, $09, $82
	dc.b	$1F, $84, $29, $81, $06, $80, $25, $84, $0C, $81, $15, $B5, $00, $C8, $07, $80 ;0x6C0
	dc.b	$09, $81, $20, $80, $2D, $81, $07, $80, $23, $82, $01, $82, $0B, $80, $16, $FF
	dc.b	$07, $80, $09, $80, $21, $80, $2C, $81, $08, $80, $21, $83, $04, $82, $08, $81 ;0x6E0
	dc.b	$16, $FE, $07, $80, $09, $81, $20, $80, $2C, $81, $09, $80, $1E, $83, $09, $81
	dc.b	$06, $81, $17, $FE, $07, $80, $08, $81, $21, $80, $2B, $82, $09, $80, $19, $86 ;0x700
	dc.b	$0C, $83, $00, $84, $17, $FD, $07, $80, $08, $81, $21, $80, $2A, $82, $0A, $80
	dc.b	$10, $8B, $13, $83, $1B, $9D, $00, $DE, $07, $80, $08, $80, $22, $80, $29, $81 ;0x720
	dc.b	$0B, $81, $0F, $82, $3D, $FC, $07, $80, $08, $81, $22, $80, $1D, $84, $04, $82
	dc.b	$0C, $80, $0E, $82, $3F, $FC, $07, $80, $08, $80, $22, $80, $13, $8B, $02, $80 ;0x740
	dc.b	$00, $84, $0E, $80, $0D, $81, $41, $FB, $08, $80, $07, $80, $23, $80, $11, $82
	dc.b	$0D, $82, $11, $80, $0B, $83, $42, $AE, $00, $9B, $00, $AE, $07, $80, $07, $80 ;0x760
	dc.b	$23, $80, $11, $81, $22, $81, $0A, $82, $45, $FA, $08, $80, $06, $81, $23, $80
	dc.b	$0F, $82, $23, $80, $08, $83, $47, $FA, $07, $80, $06, $81, $23, $80, $0F, $81 ;0x780
	dc.b	$25, $80, $06, $82, $4A, $F9, $01, $80, $05, $80, $05, $80, $24, $80, $10, $80
	dc.b	$26, $80, $06, $80, $4C, $F9, $01, $80, $04, $80, $05, $80, $25, $80, $0F, $81 ;0x7A0
	dc.b	$26, $82, $03, $81, $4C, $F9, $00, $80, $05, $80, $04, $80, $25, $80, $0F, $81
	dc.b	$2A, $80, $02, $80, $4D, $F8, $01, $80, $05, $80, $03, $80, $25, $80, $0E, $82 ;0x7C0
	dc.b	$2B, $80, $02, $80, $4D, $F8, $00, $81, $05, $80, $03, $80, $25, $80, $0C, $82
	dc.b	$2C, $80, $03, $84, $49, $87, $00, $EE, $01, $80, $06, $80, $02, $80, $25, $80 ;0x7E0
	dc.b	$0B, $82, $2D, $81, $08, $84, $44, $F7, $00, $81, $06, $80, $00, $81, $26, $80
	dc.b	$08, $84, $2D, $80, $0E, $80, $44, $F7, $00, $80, $07, $81, $27, $80, $09, $81 ;0x800
	dc.b	$2E, $81, $10, $80, $43, $BE, $00, $B6, $01, $80, $02, $81, $2B, $80, $09, $81
	dc.b	$2D, $81, $12, $80, $43, $F6, $04, $82, $2B, $80, $08, $81, $2D, $80, $14, $82 ;0x820
	dc.b	$41, $F6, $03, $82, $2B, $80, $09, $80, $2E, $80, $17, $82, $3E, $F5, $04, $82
	dc.b	$2B, $80, $08, $81, $2D, $80, $19, $81, $3E, $F5, $00, $81, $00, $82, $2B, $80 ;0x840
	dc.b	$03, $86, $2D, $80, $19, $81, $3F, $F5, $00, $80, $01, $82, $2B, $81, $00, $82
	dc.b	$32, $80, $18, $82, $40, $F4, $01, $80, $01, $82, $2C, $82, $33, $80, $17, $82 ;0x860
	dc.b	$0C, $86, $2E, $C7, $00, $86, $00, $A3, $01, $80, $01, $82, $62, $80, $17, $82
	dc.b	$05, $87, $06, $83, $2A, $F4, $00, $81, $01, $81, $62, $80, $1B, $85, $12, $83 ;0x880
	dc.b	$26, $F4, $00, $81, $01, $81, $61, $80, $39, $83, $22, $F3, $01, $81, $00, $81
	dc.b	$02, $80, $5D, $80, $3E, $82, $1F, $F3, $00, $82, $00, $81, $02, $80, $5C, $80 ;0x8A0
	dc.b	$41, $80, $1F, $F3, $00, $81, $01, $81, $01, $82, $5B, $80, $42, $80, $1E, $F3
	dc.b	$00, $81, $01, $81, $01, $82, $5B, $80, $42, $80, $1E, $F2, $01, $82, $00, $81 ;0x8C0
	dc.b	$01, $82, $5A, $80, $43, $80, $1E, $F2, $00, $83, $00, $81, $00, $83, $5A, $80
	dc.b	$43, $80, $1E, $F2, $00, $83, $00, $81, $00, $83, $5A, $82, $42, $80, $1D, $F2 ;0x8E0
	dc.b	$00, $83, $00, $81, $00, $82, $5D, $80, $40, $82, $1D, $F2, $00, $83, $00, $81
	dc.b	$00, $82, $5D, $80, $3E, $82, $1F, $F2, $00, $83, $00, $81, $00, $82, $5D, $80 ;0x900
	dc.b	$3A, $83, $22, $DE, $00, $91, $01, $85, $01, $82, $5D, $81, $36, $83, $25, $80
	dc.b	$00, $82, $00, $EB, $00, $86, $02, $82, $5E, $81, $32, $83, $27, $F1, $00, $86 ;0x920
	dc.b	$02, $82, $5F, $80, $31, $81, $2A, $F1, $00, $86, $00, $80, $00, $82, $5E, $80
	dc.b	$2F, $82, $2C, $F1, $00, $86, $00, $80, $01, $81, $5E, $80, $2E, $81, $2C, $F3 ;0x940
	dc.b	$00, $86, $00, $81, $00, $81, $5D, $80, $2F, $80, $2B, $81, $01, $F1, $00, $86
	dc.b	$00, $81, $00, $82, $5A, $81, $2F, $81, $29, $81, $03, $F1, $00, $86, $00, $85 ;0x960
	dc.b	$59, $80, $30, $81, $27, $82, $05, $F0, $01, $8D, $58, $80, $31, $80, $26, $81
	dc.b	$08, $F0, $00, $8E, $57, $80, $31, $81, $24, $81, $0A, $F0, $00, $8F, $55, $80 ;0x980
	dc.b	$31, $81, $23, $81, $0C, $F0, $00, $8D, $00, $80, $53, $81, $32, $80, $22, $81
	dc.b	$0E, $F0, $00, $8D, $54, $80, $33, $81, $21, $80, $10, $F0, $00, $8D, $53, $80 ;0x9A0
	dc.b	$33, $81, $21, $80, $11, $F0, $00, $8D, $54, $80, $31, $81, $20, $81, $12, $F0
	dc.b	$00, $8E, $53, $80, $30, $81, $20, $80, $14, $F0, $00, $90, $52, $80, $2F, $80 ;0x9C0
	dc.b	$20, $80, $15, $F0, $00, $8B, $00, $83, $51, $80, $2F, $81, $20, $80, $15, $D5
	dc.b	$00, $99, $00, $8B, $01, $82, $00, $80, $4E, $80, $2F, $81, $20, $80, $16, $F0 ;0x9E0
	dc.b	$00, $8C, $01, $81, $00, $80, $4D, $80, $30, $81, $1F, $80, $17, $F0, $00, $8D
	dc.b	$00, $80, $01, $80, $4C, $80, $31, $80, $1F, $80, $18, $A3, $00, $CB, $00, $8D ;0xA00
	dc.b	$02, $81, $4B, $80, $31, $81, $1F, $80, $18, $F0, $00, $8E, $01, $81, $4A, $80
	dc.b	$32, $81, $1E, $80, $19, $A7, $00, $C7, $00, $8F, $00, $82, $48, $80, $33, $81 ;0xA20
	dc.b	$1E, $80, $19, $F0, $00, $8D, $00, $82, $49, $80, $34, $80, $1F, $80, $19, $E1
	dc.b	$00, $8D, $00, $8D, $01, $81, $48, $80, $34, $81, $20, $80, $18, $F0, $00, $8E ;0xA40
	dc.b	$01, $80, $01, $80, $44, $80, $35, $81, $20, $80, $18, $F0, $00, $8F, $03, $81
	dc.b	$42, $80, $38, $81, $1E, $80, $18, $CC, $00, $A2, $01, $8E, $03, $82, $40, $80 ;0xA60
	dc.b	$3B, $80, $1D, $80, $18, $C6, $00, $A9, $00, $8F, $02, $83, $3E, $80, $3C, $80
	dc.b	$1C, $80, $19, $F1, $00, $95, $3F, $80, $3C, $80, $1C, $80, $19, $F1, $00, $95 ;0xA80
	dc.b	$3F, $80, $3D, $80, $1A, $80, $1A, $F1, $00, $95, $3F, $80, $3D, $80, $1A, $80
	dc.b	$1A, $F1, $00, $94, $40, $80, $3B, $81, $1A, $80, $1B, $F1, $00, $94, $40, $80 ;0xAA0
	dc.b	$39, $81, $1B, $80, $1C, $C8, $00, $A7, $00, $94, $40, $80, $35, $83, $1C, $80
	dc.b	$1D, $F1, $01, $94, $03, $80, $3A, $80, $32, $83, $1E, $80, $1E, $F2, $00, $93 ;0xAC0
	dc.b	$01, $80, $01, $82, $38, $80, $2F, $83, $20, $80, $1F, $F2, $00, $94, $01, $80
	dc.b	$01, $81, $39, $80, $2A, $84, $22, $80, $20, $F2, $00, $94, $00, $82, $00, $82 ;0xAE0
	dc.b	$39, $81, $25, $83, $25, $80, $21, $F2, $00, $94, $00, $86, $3B, $80, $21, $83
	dc.b	$27, $80, $22, $F2, $00, $9C, $3B, $80, $1F, $82, $2A, $80, $22, $F2, $01, $9C ;0xB00
	dc.b	$39, $80, $1E, $82, $2B, $80, $23, $99, $00, $D8, $00, $97, $01, $83, $38, $80
	dc.b	$1D, $81, $2D, $80, $23, $F3, $00, $97, $3E, $80, $1B, $82, $2D, $80, $24, $F3 ;0xB20
	dc.b	$00, $98, $3D, $80, $1A, $81, $2F, $80, $24, $F3, $01, $98, $3B, $80, $1A, $81
	dc.b	$30, $80, $24, $F4, $00, $99, $3A, $80, $18, $82, $30, $80, $25, $F4, $00, $9A ;0xB40
	dc.b	$39, $80, $17, $81, $32, $80, $25 ;0xB60
	dc.b	$00 ;0x0 (0x0001E0C5-0x0001E0C6, Entry count: 0x1) [Unknown data]
	dc.b	$01, $12, $69, $8B, $02, $81, $01, $0B, $9C, $8C, $02, $81, $01, $0C, $0D, $8B
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $85, $02, $88, $01, $12 ;0x0 (0x0001E0C6-0x0001E186, Entry count: 0xC0)
	dc.b	$69, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $81
	dc.b	$01, $12, $69, $8C, $02, $81, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B ;0x20
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $85, $02, $88, $01, $12
	dc.b	$69, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $81, $01, $0B, $9C, $8C, $02, $81 ;0x40
	dc.b	$01, $12, $69, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $84, $02, $89, $01, $12 ;0x60
	dc.b	$69, $8B, $02, $81, $01, $0C, $0D, $8C, $02, $81, $01, $0B, $9C, $8B, $02, $82
	dc.b	$01, $12, $69, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B ;0x80
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $84, $02, $88, $01, $12
	dc.b	$69, $8C, $02, $81, $01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $00 ;0xA0
	dc.b	$8C ;0x0 (0x0001E186-0x0001E187, Entry count: 0x1) [Unknown data]
	dc.b	$01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85
	dc.b	$02, $95, $01, $1B, $9C, $85, $02, $94, $01, $1B, $9C, $86, $02, $94, $01, $1B ;0x0 (0x0001E187-0x0001E1F3, Entry count: 0x6C)
	dc.b	$9C, $85, $02, $95, $01, $1B, $9C, $85, $02, $81, $01, $1B, $9C, $85, $02, $8E
	dc.b	$01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85 ;0x20
	dc.b	$02, $95, $01, $1B, $9C, $85, $02, $94, $01, $1B, $9C, $86, $02, $94, $01, $1B
	dc.b	$9C, $85, $02, $95, $01, $1B, $9C, $85, $02, $94, $01, $1B, $9C, $86, $02, $81 ;0x40
	dc.b	$01, $1B, $9C, $85, $02, $8E, $01, $1B, $9C, $85, $02, $00 ;0x60
	dc.b	$8C ;0x0 (0x0001E1F3-0x0001E1F4, Entry count: 0x1) [Unknown data]
	dc.b	$01, $1B, $09, $86, $02, $94, $01, $1B, $09, $85, $02, $95, $01, $1B, $09, $85
	dc.b	$02, $95, $01, $1B, $09, $85, $02, $94, $01, $1B, $09, $86, $02, $94, $01, $1B ;0x0 (0x0001E1F4-0x0001E260, Entry count: 0x6C)
	dc.b	$09, $85, $02, $95, $01, $1B, $09, $85, $02, $81, $01, $1B, $09, $85, $02, $8E
	dc.b	$01, $1B, $09, $86, $02, $94, $01, $1B, $09, $85, $02, $95, $01, $1B, $09, $85 ;0x20
	dc.b	$02, $95, $01, $1B, $09, $85, $02, $94, $01, $1B, $09, $86, $02, $94, $01, $1B
	dc.b	$09, $85, $02, $95, $01, $1B, $09, $85, $02, $94, $01, $1B, $09, $86, $02, $81 ;0x40
	dc.b	$01, $1B, $09, $85, $02, $8E, $01, $1B, $09, $85, $02, $00 ;0x60
	dc.b	$FF, $FF, $FF, $91 ;0x0 (0x0001E260-0x0001E264, Entry count: 0x4) [Unknown data]
	dc.b	$01, $2B, $09, $85, $02, $82, $01, $2B, $37, $84, $02, $00 ;0x0 (0x0001E264-0x0001E270, Entry count: 0xC)
	dc.b	$01, $0A, $B4, $83, $02, $E3, $01, $0A, $B4, $84, $02, $BD, $01, $0A, $B4, $83
	dc.b	$02, $A3, $01, $0A, $B4, $83, $02, $B1, $01, $0A, $B4, $83, $02, $B0, $01, $0A ;0x0 (0x0001E270-0x0001E2A7, Entry count: 0x37) [Unknown data]
	dc.b	$B4, $83, $02, $A4, $01, $0A, $B4, $83, $02, $96, $01, $0A, $B4, $84, $02, $96
	dc.b	$01, $0A, $B4, $83, $02, $00, $99 ;0x20
	dc.b	$01, $0A, $B4, $87, $02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $87
	dc.b	$02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A ;0x0 (0x0001E2A7-0x0001E763, Entry count: 0x4BC)
	dc.b	$B4, $87, $02, $AD, $01, $0A, $B4, $86, $02, $A7, $01, $0A, $B4, $83, $02, $83
	dc.b	$01, $0A, $B4, $87, $02, $86, $01, $0A, $B4, $87, $02, $00, $01, $12, $69, $8B ;0x20
	dc.b	$02, $81, $01, $0B, $9C, $8C, $02, $81, $01, $0C, $0D, $8B, $02, $82, $01, $0B
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82 ;0x40
	dc.b	$01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $81, $01, $12, $69, $8C
	dc.b	$02, $81, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $82, $01, $0B ;0x60
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82
	dc.b	$01, $0C, $0D, $8B, $02, $81, $01, $0B, $9C, $8C, $02, $81, $01, $12, $69, $8B ;0x80
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $82, $01, $0B
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $84, $02, $89, $01, $12, $69, $8B, $02, $81 ;0xA0
	dc.b	$01, $0C, $0D, $8C, $02, $81, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $8B
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $82, $01, $0B ;0xC0
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $84, $02, $88, $01, $12, $69, $8C, $02, $81
	dc.b	$01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $8B ;0xE0
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $82, $01, $0B
	dc.b	$9C, $8B, $02, $81, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82 ;0x100
	dc.b	$01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $8B
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $81, $01, $0B ;0x120
	dc.b	$9C, $8C, $02, $81, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82
	dc.b	$01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $8B ;0x140
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $81, $01, $0C, $0D, $8C, $02, $81, $01, $0B
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82 ;0x160
	dc.b	$01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $8B
	dc.b	$02, $81, $01, $0B, $9C, $8C, $02, $81, $01, $0C, $0D, $8B, $02, $82, $01, $0B ;0x180
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82
	dc.b	$01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $81, $01, $12, $69, $8C ;0x1A0
	dc.b	$02, $81, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $82, $01, $0B
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82 ;0x1C0
	dc.b	$01, $0C, $0D, $8B, $02, $81, $01, $0B, $9C, $8C, $02, $81, $01, $12, $69, $8B
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $82, $01, $0B ;0x1E0
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $84, $02, $89, $01, $12, $69, $8B, $02, $81
	dc.b	$01, $0C, $0D, $8C, $02, $81, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $8B ;0x200
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $82, $01, $0B
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $84, $02, $88, $01, $12, $69, $8C, $02, $81 ;0x220
	dc.b	$01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $8B
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $82, $01, $0B ;0x240
	dc.b	$9C, $8B, $02, $81, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82
	dc.b	$01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $8B ;0x260
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $81, $01, $0B
	dc.b	$9C, $8C, $02, $81, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82 ;0x280
	dc.b	$01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $8B
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $81, $01, $0C, $0D, $8C, $02, $81, $01, $0B ;0x2A0
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82
	dc.b	$01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $8B ;0x2C0
	dc.b	$02, $81, $01, $0B, $9C, $8C, $02, $81, $01, $0C, $0D, $8B, $02, $82, $01, $0B
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82 ;0x2E0
	dc.b	$01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $81, $01, $12, $69, $8C
	dc.b	$02, $81, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $82, $01, $0B ;0x300
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82
	dc.b	$01, $0C, $0D, $8B, $02, $81, $01, $0B, $9C, $8C, $02, $81, $01, $0B, $37, $8B ;0x320
	dc.b	$02, $82, $01, $0B, $37, $8B, $02, $82, $01, $0B, $37, $8B, $02, $82, $01, $0B
	dc.b	$37, $8B, $02, $82, $01, $0B, $37, $84, $02, $89, $01, $0C, $0D, $8B, $02, $81 ;0x340
	dc.b	$01, $0B, $9C, $8C, $02, $81, $01, $12, $69, $8B, $02, $82, $01, $0B, $37, $8B
	dc.b	$02, $82, $01, $0B, $37, $8B, $02, $82, $01, $0B, $37, $8B, $02, $82, $01, $0B ;0x360
	dc.b	$37, $8B, $02, $82, $01, $0B, $37, $84, $02, $88, $01, $0C, $0D, $8C, $02, $81
	dc.b	$01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $8B, $02, $82, $01, $0B, $37, $8B ;0x380
	dc.b	$02, $82, $01, $0B, $37, $8B, $02, $82, $01, $0B, $37, $8B, $02, $82, $01, $0B
	dc.b	$37, $8B, $02, $81, $01, $0B, $37, $85, $02, $88, $01, $0C, $0D, $8B, $02, $82 ;0x3A0
	dc.b	$01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $8B, $02, $82, $01, $0B, $37, $8B
	dc.b	$02, $82, $01, $0B, $37, $8B, $02, $82, $01, $0B, $37, $8B, $02, $81, $01, $0B ;0x3C0
	dc.b	$37, $8C, $02, $81, $01, $0B, $37, $85, $02, $88, $01, $0C, $0D, $8B, $02, $82
	dc.b	$01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $8B, $02, $82, $01, $12, $69, $8B ;0x3E0
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $81, $01, $0C, $0D, $8C, $02, $81, $01, $0B
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82 ;0x400
	dc.b	$01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $12, $69, $8B
	dc.b	$02, $81, $01, $0B, $9C, $8C, $02, $81, $01, $0C, $0D, $8B, $02, $82, $01, $0B ;0x420
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82
	dc.b	$01, $0C, $0D, $8B, $02, $82, $01, $0B, $9C, $8B, $02, $81, $01, $12, $69, $8C ;0x440
	dc.b	$02, $81, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $82, $01, $0B
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $85, $02, $88, $01, $12, $69, $8B, $02, $82 ;0x460
	dc.b	$01, $0C, $0D, $8B, $02, $81, $01, $0B, $9C, $8C, $02, $81, $01, $12, $69, $8B
	dc.b	$02, $82, $01, $0B, $9C, $8B, $02, $82, $01, $0C, $0D, $8B, $02, $82, $01, $0B ;0x480
	dc.b	$9C, $8B, $02, $82, $01, $12, $69, $84, $02, $89, $01, $12, $69, $8B, $02, $81
	dc.b	$01, $0C, $0D, $8C, $02, $81, $01, $0B, $9C, $8B, $02, $00 ;0x4A0
	dc.b	$8C ;0x0 (0x0001E763-0x0001E764, Entry count: 0x1) [Unknown data]
	dc.b	$01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85
	dc.b	$02, $95, $01, $1B, $9C, $85, $02, $94, $01, $1B, $9C, $86, $02, $94, $01, $1B ;0x0 (0x0001E764-0x0001EA1C, Entry count: 0x2B8)
	dc.b	$9C, $85, $02, $95, $01, $1B, $9C, $85, $02, $81, $01, $1B, $9C, $85, $02, $8E
	dc.b	$01, $1B, $9C, $86, $02, $87, $01, $22, $69, $8B, $02, $82, $01, $1B, $9C, $85 ;0x20
	dc.b	$02, $88, $01, $1C, $0D, $8B, $02, $82, $01, $1B, $9C, $85, $02, $88, $01, $1B
	dc.b	$09, $8B, $02, $82, $01, $1B, $9C, $85, $02, $87, $01, $1C, $0D, $8C, $02, $81 ;0x40
	dc.b	$01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85
	dc.b	$02, $94, $01, $1B, $9C, $86, $02, $81, $01, $1B, $9C, $85, $02, $8E, $01, $1B ;0x60
	dc.b	$9C, $85, $02, $95, $01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85, $02, $94
	dc.b	$01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85 ;0x80
	dc.b	$02, $94, $01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $82, $01, $1B
	dc.b	$9C, $85, $02, $8E, $01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85, $02, $94 ;0xA0
	dc.b	$01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85
	dc.b	$02, $94, $01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $95, $01, $1B ;0xC0
	dc.b	$9C, $85, $02, $81, $01, $1B, $9C, $86, $02, $8E, $01, $1B, $9C, $85, $02, $94
	dc.b	$01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85 ;0xE0
	dc.b	$02, $94, $01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $95, $01, $1B
	dc.b	$9C, $85, $02, $95, $01, $1B, $9C, $85, $02, $81, $01, $1B, $9C, $85, $02, $8E ;0x100
	dc.b	$01, $1B, $9C, $86, $02, $87, $01, $22, $69, $8B, $02, $82, $01, $1B, $9C, $85
	dc.b	$02, $88, $01, $1C, $0D, $8B, $02, $82, $01, $1B, $9C, $85, $02, $88, $01, $1B ;0x120
	dc.b	$09, $8B, $02, $81, $01, $1B, $9C, $86, $02, $87, $01, $1C, $0D, $8B, $02, $82
	dc.b	$01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85 ;0x140
	dc.b	$02, $94, $01, $1B, $9C, $86, $02, $81, $01, $1B, $9C, $85, $02, $8E, $01, $1B
	dc.b	$9C, $85, $02, $95, $01, $1B, $9C, $85, $02, $94, $01, $1B, $9C, $86, $02, $94 ;0x160
	dc.b	$01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85
	dc.b	$02, $94, $01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $81, $01, $1B ;0x180
	dc.b	$9C, $86, $02, $8E, $01, $1B, $9C, $85, $02, $88, $01, $1A, $69, $8B, $02, $81
	dc.b	$01, $1B, $9C, $86, $02, $87, $01, $1A, $B4, $8B, $02, $82, $01, $1B, $9C, $85 ;0x1A0
	dc.b	$02, $88, $01, $1B, $09, $8B, $02, $82, $01, $1B, $9C, $85, $02, $88, $01, $1B
	dc.b	$9C, $8B, $02, $82, $01, $22, $69, $8B, $02, $8E, $01, $1B, $9C, $86, $02, $94 ;0x1C0
	dc.b	$01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85, $02, $81, $01, $1B, $9C, $85
	dc.b	$02, $8E, $01, $1B, $9C, $86, $02, $D4, $01, $22, $69, $86, $02, $87, $01, $22 ;0x1E0
	dc.b	$69, $86, $02, $D4, $01, $22, $69, $86, $02, $87, $01, $22, $69, $85, $02, $D5
	dc.b	$01, $22, $69, $85, $02, $88, $01, $22, $69, $85, $02, $88, $01, $1A, $69, $8B ;0x200
	dc.b	$02, $82, $01, $14, $0D, $8B, $02, $82, $01, $1A, $69, $8B, $02, $81, $01, $1A
	dc.b	$B4, $8C, $02, $81, $01, $1A, $69, $8B, $02, $82, $01, $1A, $B4, $85, $02, $88 ;0x220
	dc.b	$01, $1B, $09, $8B, $02, $82, $01, $1B, $9C, $96, $02, $84, $01, $1B, $9C, $85
	dc.b	$02, $94, $01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $95, $01, $1B ;0x240
	dc.b	$9C, $85, $02, $94, $01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $95
	dc.b	$01, $1B, $9C, $85, $02, $81, $01, $1B, $9C, $86, $02, $8E, $01, $1B, $9C, $85 ;0x260
	dc.b	$02, $94, $01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $95, $01, $1B
	dc.b	$9C, $85, $02, $94, $01, $1B, $9C, $86, $02, $94, $01, $1B, $9C, $85, $02, $95 ;0x280
	dc.b	$01, $1B, $9C, $85, $02, $95, $01, $1B, $9C, $85, $02, $81, $01, $1B, $9C, $85
	dc.b	$02, $8E, $01, $1B, $9C, $86, $02, $00 ;0x2A0
	dc.b	$8C ;0x0 (0x0001EA1C-0x0001EA1D, Entry count: 0x1) [Unknown data]
	dc.b	$01, $1B, $09, $86, $02, $94, $01, $1B, $09, $85, $02, $95, $01, $1B, $09, $85
	dc.b	$02, $95, $01, $1B, $09, $85, $02, $94, $01, $1B, $09, $86, $02, $94, $01, $1B ;0x0 (0x0001EA1D-0x0001EEB5, Entry count: 0x498)
	dc.b	$09, $85, $02, $95, $01, $1B, $09, $85, $02, $81, $01, $1B, $09, $85, $02, $8E
	dc.b	$01, $1B, $09, $86, $02, $94, $01, $1B, $09, $85, $02, $95, $01, $1B, $09, $85 ;0x20
	dc.b	$02, $95, $01, $1B, $09, $85, $02, $94, $01, $1B, $09, $86, $02, $94, $01, $1B
	dc.b	$09, $85, $02, $95, $01, $1B, $09, $85, $02, $94, $01, $1B, $09, $86, $02, $81 ;0x40
	dc.b	$01, $1B, $09, $85, $02, $8E, $01, $1B, $09, $85, $02, $95, $01, $1B, $09, $85
	dc.b	$02, $95, $01, $1B, $09, $85, $02, $94, $01, $1B, $09, $86, $02, $94, $01, $1B ;0x60
	dc.b	$09, $85, $02, $95, $01, $1B, $09, $85, $02, $94, $01, $1B, $09, $86, $02, $94
	dc.b	$01, $1B, $09, $85, $02, $82, $01, $1B, $09, $85, $02, $8E, $01, $1B, $09, $85 ;0x80
	dc.b	$02, $88, $01, $1B, $9C, $8B, $02, $82, $01, $1B, $09, $85, $02, $87, $01, $1C
	dc.b	$0D, $8C, $02, $81, $01, $1B, $09, $86, $02, $87, $01, $1B, $9C, $8B, $02, $82 ;0xA0
	dc.b	$01, $1B, $09, $85, $02, $88, $01, $1C, $0D, $8B, $02, $82, $01, $22, $69, $8B
	dc.b	$02, $8E, $01, $1B, $09, $86, $02, $94, $01, $1B, $09, $85, $02, $95, $01, $1B ;0xC0
	dc.b	$09, $85, $02, $81, $01, $1B, $09, $86, $02, $8E, $01, $1B, $09, $85, $02, $94
	dc.b	$01, $1B, $09, $86, $02, $94, $01, $1B, $09, $85, $02, $95, $01, $1B, $09, $85 ;0xE0
	dc.b	$02, $94, $01, $1B, $09, $86, $02, $94, $01, $1B, $09, $85, $02, $95, $01, $1B
	dc.b	$09, $85, $02, $95, $01, $1B, $09, $85, $02, $81, $01, $1B, $09, $85, $02, $8E ;0x100
	dc.b	$01, $1B, $09, $86, $02, $87, $01, $1B, $9C, $8B, $02, $82, $01, $1B, $09, $85
	dc.b	$02, $88, $01, $1B, $09, $8B, $02, $82, $01, $1B, $09, $85, $02, $88, $01, $1A ;0x120
	dc.b	$69, $8B, $02, $81, $01, $1B, $09, $86, $02, $87, $01, $1B, $09, $8B, $02, $82
	dc.b	$01, $1B, $09, $85, $02, $95, $01, $1B, $09, $85, $02, $95, $01, $1B, $09, $85 ;0x140
	dc.b	$02, $94, $01, $1B, $09, $86, $02, $81, $01, $1B, $09, $85, $02, $8E, $01, $1B
	dc.b	$09, $85, $02, $95, $01, $1B, $09, $85, $02, $94, $01, $1B, $09, $86, $02, $94 ;0x160
	dc.b	$01, $1B, $09, $85, $02, $95, $01, $1B, $09, $85, $02, $95, $01, $1B, $09, $85
	dc.b	$02, $94, $01, $1B, $09, $86, $02, $94, $01, $1B, $09, $85, $02, $81, $01, $1B ;0x180
	dc.b	$09, $86, $02, $8E, $01, $1B, $09, $85, $02, $88, $01, $1B, $9C, $8B, $02, $81
	dc.b	$01, $1B, $09, $86, $02, $87, $01, $1C, $0D, $8B, $02, $82, $01, $1B, $09, $85 ;0x1A0
	dc.b	$02, $88, $01, $1B, $9C, $8B, $02, $82, $01, $1B, $09, $85, $02, $88, $01, $1C
	dc.b	$0D, $8B, $02, $82, $01, $1B, $09, $8B, $02, $8E, $01, $1B, $09, $86, $02, $94 ;0x1C0
	dc.b	$01, $1B, $09, $85, $02, $95, $01, $1B, $09, $85, $02, $81, $01, $1B, $09, $85
	dc.b	$02, $8E, $01, $1B, $09, $86, $02, $D4, $01, $1B, $37, $86, $02, $87, $01, $1B ;0x1E0
	dc.b	$37, $86, $02, $D4, $01, $1B, $37, $86, $02, $87, $01, $1B, $37, $85, $02, $D5
	dc.b	$01, $1B, $37, $85, $02, $88, $01, $1B, $37, $85, $02, $88, $01, $1B, $37, $8B ;0x200
	dc.b	$02, $8F, $01, $1B, $09, $8B, $02, $8E, $01, $1A, $B4, $8B, $02, $8F, $01, $1A
	dc.b	$69, $8B, $02, $82, $01, $1B, $09, $96, $02, $84, $01, $1B, $09, $85, $02, $94 ;0x220
	dc.b	$01, $1B, $09, $86, $02, $94, $01, $1B, $09, $85, $02, $95, $01, $1B, $09, $85
	dc.b	$02, $94, $01, $1B, $09, $86, $02, $94, $01, $1B, $09, $85, $02, $95, $01, $1B ;0x240
	dc.b	$09, $85, $02, $81, $01, $1B, $09, $86, $02, $8E, $01, $1B, $09, $85, $02, $94
	dc.b	$01, $1B, $09, $86, $02, $94, $01, $1B, $09, $85, $02, $95, $01, $1B, $09, $85 ;0x260
	dc.b	$02, $94, $01, $1B, $09, $86, $02, $94, $01, $1B, $09, $85, $02, $95, $01, $1B
	dc.b	$09, $85, $02, $95, $01, $1B, $09, $85, $02, $81, $01, $1B, $09, $85, $02, $8E ;0x280
	dc.b	$01, $1B, $09, $86, $02, $00, $01, $2B, $9C, $98, $02, $81, $01, $2B, $37, $8B
	dc.b	$02, $82, $01, $2B, $09, $83, $02, $8A, $01, $2B, $37, $8B, $02, $82, $01, $2B ;0x2A0
	dc.b	$9C, $83, $02, $97, $01, $32, $69, $A4, $02, $82, $01, $2C, $0D, $8B, $02, $82
	dc.b	$01, $2B, $9C, $83, $02, $8A, $01, $2C, $0D, $98, $02, $82, $01, $2B, $09, $8B ;0x2C0
	dc.b	$02, $81, $01, $2B, $9C, $E6, $02, $E8, $01, $2B, $09, $85, $02, $82, $01, $2B
	dc.b	$37, $84, $02, $82, $01, $2B, $9C, $98, $02, $82, $01, $2B, $37, $8B, $02, $82 ;0x2E0
	dc.b	$01, $2B, $09, $83, $02, $89, $01, $2B, $37, $8C, $02, $81, $01, $2B, $9C, $83
	dc.b	$02, $97, $01, $32, $69, $A5, $02, $82, $01, $2C, $0D, $8B, $02, $81, $01, $2B ;0x300
	dc.b	$9C, $84, $02, $89, $01, $2C, $0D, $98, $02, $82, $01, $2B, $09, $8B, $02, $82
	dc.b	$01, $2A, $69, $E5, $02, $E9, $01, $2B, $09, $84, $02, $82, $01, $2B, $37, $85 ;0x320
	dc.b	$02, $81, $01, $2B, $9C, $98, $02, $82, $01, $2B, $37, $8B, $02, $82, $01, $2B
	dc.b	$09, $83, $02, $8A, $01, $2B, $37, $8B, $02, $82, $01, $2B, $9C, $83, $02, $96 ;0x340
	dc.b	$01, $32, $69, $A5, $02, $82, $01, $2C, $0D, $8B, $02, $82, $01, $2B, $9C, $83
	dc.b	$02, $8A, $01, $2C, $0D, $98, $02, $81, $01, $2B, $09, $8C, $02, $81, $01, $2B ;0x360
	dc.b	$9C, $E5, $02, $E9, $01, $2B, $09, $85, $02, $81, $01, $2B, $37, $85, $02, $82
	dc.b	$01, $2B, $9C, $98, $02, $82, $01, $2B, $37, $8B, $02, $81, $01, $2B, $09, $84 ;0x380
	dc.b	$02, $89, $01, $2B, $37, $8B, $02, $82, $01, $2B, $9C, $83, $02, $97, $01, $32
	dc.b	$69, $A5, $02, $81, $01, $2C, $0D, $8C, $02, $81, $01, $2B, $9C, $83, $02, $8A ;0x3A0
	dc.b	$01, $2C, $0D, $98, $02, $82, $01, $2B, $09, $8B, $02, $82, $01, $2A, $69, $E5
	dc.b	$02, $DC, $01, $2C, $0D, $8B, $02, $81, $01, $2B, $9C, $8C, $02, $81, $01, $2C ;0x3C0
	dc.b	$0D, $85, $02, $8F, $01, $2B, $9C, $84, $02, $82, $01, $2B, $37, $8B, $02, $82
	dc.b	$01, $2A, $69, $9E, $02, $82, $01, $2B, $37, $85, $02, $81, $01, $2B, $9C, $8C ;0x3E0
	dc.b	$02, $81, $01, $2B, $37, $8B, $02, $82, $01, $2B, $9C, $8B, $02, $82, $01, $2B
	dc.b	$37, $85, $02, $88, $01, $2B, $9C, $8B, $02, $82, $01, $2B, $37, $84, $02, $89 ;0x400
	dc.b	$01, $2B, $9C, $8B, $02, $81, $01, $2C, $0D, $85, $02, $88, $01, $32, $69, $8B
	dc.b	$02, $82, $01, $2B, $37, $85, $02, $82, $01, $2B, $9C, $84, $02, $82, $01, $2C ;0x420
	dc.b	$0D, $85, $02, $8E, $01, $2B, $9C, $85, $02, $82, $01, $2B, $37, $8B, $02, $82
	dc.b	$01, $2A, $69, $9E, $02, $82, $01, $2B, $37, $84, $02, $82, $01, $2B, $9C, $8B ;0x440
	dc.b	$02, $82, $01, $2B, $37, $8B, $02, $82, $01, $2B, $9C, $8B, $02, $82, $01, $2B
	dc.b	$37, $84, $02, $89, $01, $2B, $9C, $8B, $02, $81, $01, $2B, $37, $85, $02, $88 ;0x460
	dc.b	$01, $2B, $9C, $8B, $02, $82, $01, $2C, $0D, $85, $02, $88, $01, $32, $69, $8B
	dc.b	$02, $82, $01, $32, $69, $F2, $02, $FF ;0x480
	dc.b	$FF, $AB ;0x0 (0x0001EEB5-0x0001EEB7, Entry count: 0x2) [Unknown data]
	dc.b	$01, $2B, $09, $85, $02, $82, $01, $2B, $37, $84, $02, $00 ;0x0 (0x0001EEB7-0x0001EEC3, Entry count: 0xC)
	dc.b	$01, $0A, $B4, $83, $02, $89, $01, $0A, $B4, $84, $02, $96, $01, $0A, $B4, $83
	dc.b	$02, $8A, $01, $0A, $B4, $83, $02, $A4, $01, $0A, $B4, $83, $02, $96, $01, $0A ;0x0 (0x0001EEC3-0x0001F14C, Entry count: 0x289) [Unknown data]
	dc.b	$B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $96
	dc.b	$01, $0A, $B4, $84, $02, $89, $01, $0A, $B4, $83, $02, $8A, $01, $0A, $B4, $83 ;0x20
	dc.b	$02, $97, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $96, $01, $0A
	dc.b	$B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $96 ;0x40
	dc.b	$01, $0A, $B4, $84, $02, $96, $01, $0A, $B4, $83, $02, $8A, $01, $0A, $B4, $83
	dc.b	$02, $8A, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $89, $01, $0A ;0x60
	dc.b	$B4, $84, $02, $A3, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $96
	dc.b	$01, $0A, $B4, $84, $02, $96, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83 ;0x80
	dc.b	$02, $8A, $01, $0A, $B4, $83, $02, $8A, $01, $0A, $B4, $83, $02, $96, $01, $0A
	dc.b	$B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $96 ;0xA0
	dc.b	$01, $0A, $B4, $84, $02, $96, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83
	dc.b	$02, $97, $01, $0A, $B4, $83, $02, $89, $01, $0A, $B4, $84, $02, $89, $01, $0A ;0xC0
	dc.b	$B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $8A, $01, $0A, $B4, $83, $02, $A3
	dc.b	$01, $0A, $B4, $84, $02, $96, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83 ;0xE0
	dc.b	$02, $97, $01, $0A, $B4, $83, $02, $96, $01, $0A, $B4, $83, $02, $8A, $01, $0A
	dc.b	$B4, $83, $02, $8A, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $96 ;0x100
	dc.b	$01, $0A, $B4, $84, $02, $96, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83
	dc.b	$02, $97, $01, $0A, $B4, $83, $02, $96, $01, $0A, $B4, $83, $02, $97, $01, $0A ;0x120
	dc.b	$B4, $83, $02, $8A, $01, $0A, $B4, $83, $02, $8A, $01, $0A, $B4, $83, $02, $96
	dc.b	$01, $0A, $B4, $84, $02, $89, $01, $0A, $B4, $83, $02, $A4, $01, $0A, $B4, $83 ;0x140
	dc.b	$02, $97, $01, $0A, $B4, $83, $02, $96, $01, $0A, $B4, $83, $02, $97, $01, $0A
	dc.b	$B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $8A, $01, $0A, $B4, $83, $02, $89 ;0x160
	dc.b	$01, $0A, $B4, $84, $02, $96, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83
	dc.b	$02, $97, $01, $0A, $B4, $83, $02, $96, $01, $0A, $B4, $83, $02, $97, $01, $0A ;0x180
	dc.b	$B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $96, $01, $0A, $B4, $84, $02, $89
	dc.b	$01, $0A, $B4, $83, $02, $8A, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83 ;0x1A0
	dc.b	$02, $8A, $01, $0A, $B4, $83, $02, $A3, $01, $0A, $B4, $83, $02, $97, $01, $0A
	dc.b	$B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $96, $01, $0A, $B4, $84, $02, $96 ;0x1C0
	dc.b	$01, $0A, $B4, $83, $02, $8A, $01, $0A, $B4, $83, $02, $8A, $01, $0A, $B4, $83
	dc.b	$02, $97, $01, $0A, $B4, $83, $02, $96, $01, $0A, $B4, $83, $02, $97, $01, $0A ;0x1E0
	dc.b	$B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $96, $01, $0A, $B4, $84, $02, $96
	dc.b	$01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $8A, $01, $0A, $B4, $83 ;0x200
	dc.b	$02, $8A, $01, $0A, $B4, $83, $02, $96, $01, $0A, $B4, $83, $02, $8A, $01, $0A
	dc.b	$B4, $83, $02, $A4, $01, $0A, $B4, $83, $02, $96, $01, $0A, $B4, $84, $02, $96 ;0x220
	dc.b	$01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83
	dc.b	$02, $89, $01, $0A, $B4, $84, $02, $89, $01, $0A, $B4, $83, $02, $97, $01, $0A ;0x240
	dc.b	$B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $96, $01, $0A, $B4, $84, $02, $96
	dc.b	$01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83, $02, $97, $01, $0A, $B4, $83 ;0x260
	dc.b	$02, $96, $01, $0A, $B4, $83, $02, $00, $99 ;0x280
	dc.b	$01, $0A, $B4, $87, $02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $87
	dc.b	$02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A ;0x0 (0x0001F14C-0x0001F2AE, Entry count: 0x162)
	dc.b	$B4, $87, $02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $87, $02, $86
	dc.b	$01, $0A, $B4, $87, $02, $A0, $01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $87 ;0x20
	dc.b	$02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A
	dc.b	$B4, $87, $02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $87, $02, $AD ;0x40
	dc.b	$01, $0A, $B4, $86, $02, $87, $01, $0A, $B4, $86, $02, $A0, $01, $0A, $B4, $87
	dc.b	$02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A ;0x60
	dc.b	$B4, $87, $02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $87, $02, $AD
	dc.b	$01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $87, $02, $86, $01, $0A, $B4, $86 ;0x80
	dc.b	$02, $A1, $01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A
	dc.b	$B4, $87, $02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $87, $02, $AD ;0xA0
	dc.b	$01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $87, $02, $93, $01, $0A, $B4, $86
	dc.b	$02, $94, $01, $0A, $B4, $86, $02, $86, $01, $0A, $B4, $87, $02, $A0, $01, $0A ;0xC0
	dc.b	$B4, $86, $02, $AD, $01, $0A, $B4, $87, $02, $AD, $01, $0A, $B4, $86, $02, $AD
	dc.b	$01, $0A, $B4, $87, $02, $AD, $01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $87 ;0xE0
	dc.b	$02, $AD, $01, $0A, $B4, $86, $02, $93, $01, $0A, $B4, $87, $02, $93, $01, $0A
	dc.b	$B4, $86, $02, $87, $01, $0A, $B4, $86, $02, $A0, $01, $0A, $B4, $87, $02, $AD ;0x100
	dc.b	$01, $0A, $B4, $86, $02, $AD, $01, $0A, $B4, $87, $02, $AD, $01, $0A, $B4, $86
	dc.b	$02, $AD, $01, $0A, $B4, $87, $02, $AD, $01, $0A, $B4, $86, $02, $93, $01, $0A ;0x120
	dc.b	$B4, $87, $02, $93, $01, $0A, $B4, $86, $02, $94, $01, $0A, $B4, $86, $02, $8D
	dc.b	$01, $0A, $B4, $83, $02, $83, $01, $0A, $B4, $87, $02, $86, $01, $0A, $B4, $87 ;0x140
	dc.b	$02, $00 ;0x160
loc_1F2AE:
	dc.w	$0001, $E0C6, $0000, $0000, $0001, $E2E3, $0010, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
	dc.w	$0000, $0000, $0000, $0001, $E186, $0000, $0000, $0001, $E763, $0110, $0100, $0000, $0000, $0000, $0000, $0000 ;0x0 (0x0001F2AE-0x0001F36C, Entry count: 0xBE)
	dc.w	$0000, $0000, $0000, $0000, $0000, $0000, $0001, $E1F3, $0000, $0000, $0001, $EA1C, $0210, $0200, $0000, $0000
	dc.w	$0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0001, $E260, $0000, $0000, $0001, $ECC3, $0310 ;0x20
	dc.w	$0300, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0001, $E2A6, $0000, $0000
	dc.w	$0001, $F14B, $0410, $0500, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ;0x40
	dc.b	$00, $01, $E2, $70, $00, $00, $00, $00, $00, $01, $EE, $C3, $05, $10, $04, $00
	dc.b	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;0x0 (0x0001F36C-0x0001F392, Entry count: 0x26) [Unknown data]
	dc.b	$00, $00, $00, $00, $00, $00 ;0x20
	dc.l	loc_1F422
	dc.l	loc_1F451
	dc.l	loc_1F482
	dc.l	loc_1F4A9
	dc.l	loc_1F4DE
	dc.l	loc_1F4FD
	dc.l	loc_1F51C
	dc.l	loc_1F54D
	dc.l	loc_1F586
	dc.l	loc_1F5A5
	dc.l	loc_1F5C8
	dc.l	loc_1F5FF
	dc.l	loc_1F61E
	dc.l	loc_1F66A
	dc.l	loc_1F6AE
	dc.l	loc_1F6E3
	dc.l	loc_1F710
	dc.l	loc_1F74D
	dc.l	loc_1F782
	dc.l	loc_1F7A9
	dc.l	loc_1F7C8
	dc.l	loc_1F800
	dc.l	loc_1F832
	dc.l	loc_1F87E
	dc.l	loc_1F8B4
	dc.l	loc_1F8DC
	dc.l	loc_1F6AE
	dc.l	loc_1F8FA
	dc.l	loc_1F919
	dc.l	loc_1F93C
	dc.l	loc_1F961
	dc.l	loc_1F986
	dc.l	loc_1F9AB
	dc.l	loc_1F9D6
	dc.l	loc_1F9F5
	dc.l	loc_1FA26
loc_1F422:
	dc.b	$05, $82, $0C, $82, $0B, $84, $0A, $84 ;0x0 (0x0001F422-0x0001F42A, Entry count: 0x8)
	dc.b	$09, $86, $08, $82, $00, $82, $07, $83, $00, $83, $06, $82, $02, $82, $05, $83
	dc.b	$02, $83, $04, $82, $04, $82, $03, $8C, $02, $8C, $01, $83, $06, $83, $00, $82 ;0x0 (0x0001F42A-0x0001F451, Entry count: 0x27)
	dc.b	$08, $82, $00, $82, $08, $82, $10 ;0x20
loc_1F451:
	dc.b	$00, $88, $06, $8A, $04, $82, $04, $83, $03, $82, $05, $82, $03, $82, $05, $82
	dc.b	$03, $82, $04, $82, $04, $89, $05, $8A, $04, $82, $04, $83, $03, $82, $05, $83 ;0x0 (0x0001F451-0x0001F482, Entry count: 0x31)
	dc.b	$02, $82, $06, $82, $02, $82, $06, $82, $02, $82, $05, $83, $02, $8B, $03, $8A
	dc.b	$13 ;0x20
loc_1F482:
	dc.b	$04, $86, $06, $8A, $03, $83, $04, $83, $01, $83, $06, $82, $01, $82, $0B, $83
	dc.b	$0B, $82, $0C, $82, $0C, $82, $0C, $83, $0C, $82, $0C, $83, $06, $82, $02, $83 ;0x0 (0x0001F482-0x0001F4A9, Entry count: 0x27)
	dc.b	$04, $83, $03, $8A, $06, $86, $13 ;0x20
loc_1F4A9:
	dc.b	$00, $87, $07, $89, $05, $82, $03, $83, $04, $82, $04, $83, $03, $82, $05, $82
	dc.b	$03, $82, $05, $83, $02, $82, $06, $82, $02, $82, $06, $82, $02, $82, $06, $82 ;0x0 (0x0001F4A9-0x0001F4DE, Entry count: 0x35)
	dc.b	$02, $82, $05, $83, $02, $82, $05, $82, $03, $82, $04, $83, $03, $82, $03, $83
	dc.b	$04, $89, $05, $87, $16 ;0x20
loc_1F4DE:
	dc.b	$01, $8A, $04, $8A, $04, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $88, $06, $88
	dc.b	$06, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $8A, $04, $8A, $12 ;0x0 (0x0001F4DE-0x0001F4FD, Entry count: 0x1F)
loc_1F4FD:
	dc.b	$01, $8A, $04, $8A, $04, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $89, $05, $89
	dc.b	$05, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $1A ;0x0 (0x0001F4FD-0x0001F51C, Entry count: 0x1F)
loc_1F51C:
	dc.b	$04, $85, $07, $89, $04, $84, $01, $84, $02, $83, $05, $83, $01, $82, $07, $82
	dc.b	$00, $83, $0B, $82, $0C, $82, $03, $87, $00, $82, $03, $87, $00, $83, $07, $82 ;0x0 (0x0001F51C-0x0001F54D, Entry count: 0x31)
	dc.b	$01, $82, $07, $82, $01, $83, $05, $83, $02, $84, $01, $84, $04, $89, $07, $85
	dc.b	$14 ;0x20
loc_1F54D:
	dc.b	$00, $82, $06, $82, $02, $82, $06, $82, $02, $82, $06, $82, $02, $82, $06, $82
	dc.b	$02, $82, $06, $82, $02, $82, $06, $82, $02, $8C, $02, $8C, $02, $82, $06, $82 ;0x0 (0x0001F54D-0x0001F586, Entry count: 0x39)
	dc.b	$02, $82, $06, $82, $02, $82, $06, $82, $02, $82, $06, $82, $02, $82, $06, $82
	dc.b	$02, $82, $06, $82, $02, $82, $06, $82, $11 ;0x20
loc_1F586:
	dc.b	$03, $86, $0A, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82
	dc.b	$0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0A, $86, $14 ;0x0 (0x0001F586-0x0001F5A5, Entry count: 0x1F)
loc_1F5A5:
	dc.b	$09, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82
	dc.b	$0C, $82, $0C, $82, $0C, $82, $04, $82, $04, $82, $04, $83, $02, $83, $05, $88 ;0x0 (0x0001F5A5-0x0001F5C8, Entry count: 0x23)
	dc.b	$07, $86, $14 ;0x20
loc_1F5C8:
	dc.b	$00, $82, $05, $82, $03, $82, $04, $82, $04, $82, $03, $82, $05, $82, $02, $82
	dc.b	$06, $82, $01, $82, $07, $82, $00, $82, $08, $85, $09, $84, $0A, $85, $09, $82 ;0x0 (0x0001F5C8-0x0001F5FF, Entry count: 0x37)
	dc.b	$00, $82, $08, $82, $01, $82, $07, $82, $02, $82, $06, $82, $03, $82, $05, $82
	dc.b	$04, $82, $04, $82, $05, $82, $12 ;0x20
loc_1F5FF:
	dc.b	$01, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82
	dc.b	$0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $8A, $04, $8A, $12 ;0x0 (0x0001F5FF-0x0001F61E, Entry count: 0x1F)
loc_1F61E:
	dc.b	$82, $08, $82, $00, $82, $08, $82, $00, $83, $06, $83, $00, $83, $06, $83, $00
	dc.b	$84, $04, $84, $00, $84, $04, $84, $00, $85, $02, $85, $00, $85, $02, $85, $00 ;0x0 (0x0001F61E-0x0001F66A, Entry count: 0x4C)
	dc.b	$82, $00, $82, $00, $82, $00, $82, $00, $82, $00, $82, $00, $82, $00, $82, $00
	dc.b	$82, $01, $84, $01, $82, $00, $82, $01, $84, $01, $82, $00, $82, $02, $82, $02 ;0x20
	dc.b	$82, $00, $82, $02, $82, $02, $82, $00, $82, $08, $82, $10 ;0x40
loc_1F66A:
	dc.b	$82, $08, $82, $00, $83, $07, $82, $00, $84, $06, $82, $00, $85, $05, $82, $00
	dc.b	$86, $04, $82, $00, $82, $00, $83, $03, $82, $00, $82, $01, $83, $02, $82, $00 ;0x0 (0x0001F66A-0x0001F6AE, Entry count: 0x44)
	dc.b	$82, $02, $83, $01, $82, $00, $82, $03, $83, $00, $82, $00, $82, $04, $86, $00
	dc.b	$82, $05, $85, $00, $82, $06, $84, $00, $82, $07, $83, $00, $82, $08, $82, $00 ;0x20
	dc.b	$82, $08, $82, $10 ;0x40
loc_1F6AE:
	dc.b	$04, $84, $08, $88, $05, $83, $02, $83, $03, $83, $04, $83, $02, $82, $06, $82
	dc.b	$01, $83, $06, $83, $00, $82, $08, $82, $00, $82, $08, $82, $00, $82, $08, $82 ;0x0 (0x0001F6AE-0x0001F6E3, Entry count: 0x35)
	dc.b	$00, $83, $06, $83, $01, $82, $06, $82, $02, $83, $04, $83, $03, $83, $02, $83
	dc.b	$05, $88, $08, $84, $15 ;0x20
loc_1F6E3:
	dc.b	$01, $86, $08, $88, $06, $82, $02, $83, $05, $82, $03, $83, $04, $82, $04, $82
	dc.b	$04, $82, $04, $82, $04, $82, $04, $82, $04, $82, $03, $83, $04, $82, $02, $83 ;0x0 (0x0001F6E3-0x0001F710, Entry count: 0x2D)
	dc.b	$05, $88, $06, $86, $08, $82, $0C, $82, $0C, $82, $0C, $82, $1A ;0x20
loc_1F710:
	dc.b	$04, $84, $08, $88, $05, $84, $00, $84, $03, $83, $04, $83, $02, $82, $06, $82
	dc.b	$01, $83, $06, $83, $00, $82, $08, $82, $00, $82, $08, $82, $00, $82, $08, $82 ;0x0 (0x0001F710-0x0001F74D, Entry count: 0x3D)
	dc.b	$00, $83, $01, $82, $01, $83, $01, $82, $01, $82, $01, $82, $02, $83, $01, $86
	dc.b	$03, $84, $00, $84, $05, $8A, $06, $85, $00, $82, $0C, $82, $00 ;0x20
loc_1F74D:
	dc.b	$00, $87, $07, $89, $05, $82, $03, $83, $04, $82, $04, $83, $03, $82, $05, $82
	dc.b	$03, $82, $05, $82, $03, $82, $04, $83, $03, $82, $03, $83, $04, $89, $05, $88 ;0x0 (0x0001F74D-0x0001F782, Entry count: 0x35)
	dc.b	$06, $82, $03, $82, $05, $82, $04, $82, $04, $82, $04, $83, $03, $82, $05, $82
	dc.b	$03, $82, $05, $82, $12 ;0x20
loc_1F782:
	dc.b	$03, $86, $06, $8A, $03, $83, $04, $83, $02, $82, $06, $82, $02, $83, $0C, $84
	dc.b	$0B, $86, $0A, $86, $0B, $84, $0C, $83, $0C, $82, $02, $82, $06, $82, $02, $83 ;0x0 (0x0001F782-0x0001F7A9, Entry count: 0x27)
	dc.b	$04, $83, $03, $8A, $06, $86, $14 ;0x20
loc_1F7A9:
	dc.b	$00, $8C, $02, $8C, $07, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82
	dc.b	$0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $16 ;0x0 (0x0001F7A9-0x0001F7C8, Entry count: 0x1F)
loc_1F7C8:
	dc.b	$82, $08, $82, $00, $82, $08, $82, $00, $82, $08, $82, $00, $82, $08, $82, $00
	dc.b	$82, $08, $82, $00, $82, $08, $82, $00, $82, $08, $82, $00, $82, $08, $82, $00 ;0x0 (0x0001F7C8-0x0001F800, Entry count: 0x38)
	dc.b	$82, $08, $82, $00, $83, $06, $83, $01, $82, $06, $82, $02, $83, $04, $83, $03
	dc.b	$84, $00, $84, $05, $88, $08, $84, $15 ;0x20
loc_1F800:
	dc.b	$82, $08, $82, $00, $82, $08, $82, $00, $83, $06, $83, $01, $82, $06, $82, $02
	dc.b	$83, $04, $83, $03, $82, $04, $82, $04, $83, $02, $83, $05, $82, $02, $82, $06 ;0x0 (0x0001F800-0x0001F832, Entry count: 0x32)
	dc.b	$83, $00, $83, $07, $82, $00, $82, $08, $86, $09, $84, $0A, $84, $0B, $82, $0C
	dc.b	$82, $16 ;0x20
loc_1F832:
	dc.b	$82, $08, $82, $00, $82, $02, $82, $02, $82, $00, $82, $02, $82, $02, $82, $00
	dc.b	$82, $01, $84, $01, $82, $00, $82, $01, $84, $01, $82, $00, $82, $00, $82, $00 ;0x0 (0x0001F832-0x0001F87E, Entry count: 0x4C)
	dc.b	$82, $00, $82, $00, $82, $00, $82, $00, $82, $00, $82, $00, $85, $02, $85, $00
	dc.b	$85, $02, $85, $00, $84, $04, $84, $00, $84, $04, $84, $00, $83, $06, $83, $00 ;0x20
	dc.b	$83, $06, $83, $00, $82, $08, $82, $00, $82, $08, $82, $10 ;0x40
loc_1F87E:
	dc.b	$82, $08, $82, $00, $83, $06, $83, $01, $82, $06, $82, $03, $82, $04, $82, $05
	dc.b	$82, $02, $82, $07, $82, $00, $82, $09, $84, $0B, $82, $0B, $84, $09, $82, $00 ;0x0 (0x0001F87E-0x0001F8B4, Entry count: 0x36)
	dc.b	$82, $07, $82, $02, $82, $05, $82, $04, $82, $03, $82, $06, $82, $01, $83, $06
	dc.b	$83, $00, $82, $08, $82, $10 ;0x20
loc_1F8B4:
	dc.b	$82, $08, $82, $01, $82, $06, $82, $03, $82, $04, $82, $05, $82, $02, $82, $07
	dc.b	$82, $00, $82, $09, $84, $0B, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C ;0x0 (0x0001F8B4-0x0001F8DC, Entry count: 0x28)
	dc.b	$82, $0C, $82, $0C, $82, $0C, $82, $16 ;0x20
loc_1F8DC:
	dc.b	$8E, $00, $8E, $0B, $82, $0B, $82, $0B, $82, $0B, $82, $0B, $82, $0B, $82, $0B
	dc.b	$82, $0B, $82, $0B, $82, $0B, $82, $0B, $82, $0B, $8E, $00, $8E, $10 ;0x0 (0x0001F8DC-0x0001F8FA, Entry count: 0x1E)
loc_1F8FA:
	dc.b	$07, $81, $0C, $82, $0B, $83, $0A, $84, $0C, $82, $0C, $82, $0C, $82, $0C, $82
	dc.b	$0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $0C, $82, $15 ;0x0 (0x0001F8FA-0x0001F919, Entry count: 0x1F)
loc_1F919:
	dc.b	$04, $85, $07, $89, $04, $83, $03, $83, $03, $82, $05, $82, $0C, $82, $0B, $82
	dc.b	$0B, $82, $0B, $82, $0B, $82, $0B, $82, $0B, $82, $0B, $82, $0B, $82, $0B, $8B ;0x0 (0x0001F919-0x0001F93C, Entry count: 0x23)
	dc.b	$03, $8B, $11 ;0x20
loc_1F93C:
	dc.b	$01, $8B, $03, $8B, $0B, $82, $0B, $82, $0B, $82, $0B, $82, $0B, $85, $0C, $83
	dc.b	$0C, $83, $0C, $82, $03, $82, $05, $82, $03, $82, $05, $82, $04, $82, $03, $82 ;0x0 (0x0001F93C-0x0001F961, Entry count: 0x25)
	dc.b	$06, $87, $08, $85, $14 ;0x20
loc_1F961:
	dc.b	$0A, $82, $0B, $82, $0B, $82, $0B, $82, $0B, $82, $0B, $82, $0B, $82, $00, $82
	dc.b	$07, $82, $01, $82, $06, $82, $02, $82, $05, $8B, $02, $8C, $0A, $82, $0C, $82 ;0x0 (0x0001F961-0x0001F986, Entry count: 0x25)
	dc.b	$0C, $82, $0C, $82, $13 ;0x20
loc_1F986:
	dc.b	$01, $8A, $04, $8A, $04, $82, $0C, $82, $0C, $82, $0C, $87, $07, $89, $0C, $83
	dc.b	$0C, $83, $0C, $82, $03, $82, $05, $82, $03, $82, $04, $83, $03, $83, $02, $83 ;0x0 (0x0001F986-0x0001F9AB, Entry count: 0x25)
	dc.b	$05, $88, $08, $84, $15 ;0x20
loc_1F9AB:
	dc.b	$08, $82, $0B, $82, $0B, $82, $0B, $82, $0B, $82, $0B, $86, $07, $88, $06, $82
	dc.b	$03, $82, $04, $82, $05, $82, $03, $82, $05, $82, $03, $82, $05, $82, $03, $82 ;0x0 (0x0001F9AB-0x0001F9D6, Entry count: 0x2B)
	dc.b	$05, $82, $04, $82, $03, $82, $06, $87, $08, $85, $14 ;0x20
loc_1F9D6:
	dc.b	$01, $8B, $03, $8B, $0C, $82, $0B, $82, $0C, $82, $0B, $82, $0C, $82, $0B, $82
	dc.b	$0C, $82, $0B, $82, $0C, $82, $0B, $82, $0C, $82, $0B, $82, $0C, $82, $17 ;0x0 (0x0001F9D6-0x0001F9F5, Entry count: 0x1F)
loc_1F9F5:
	dc.b	$04, $85, $08, $87, $06, $83, $01, $83, $05, $82, $03, $82, $05, $82, $03, $82
	dc.b	$06, $82, $01, $82, $08, $85, $08, $87, $06, $82, $03, $82, $04, $82, $05, $82 ;0x0 (0x0001F9F5-0x0001FA26, Entry count: 0x31)
	dc.b	$03, $82, $05, $82, $03, $82, $05, $82, $04, $82, $03, $82, $06, $87, $08, $85
	dc.b	$14 ;0x20
loc_1FA26:
	dc.b	$04, $85, $08, $87, $06, $82, $03, $82, $04, $82, $05, $82, $03, $82, $05, $82
	dc.b	$03, $82, $05, $82, $03, $82, $05, $82, $04, $82, $03, $82, $06, $88, $07, $86 ;0x0 (0x0001FA26-0x0001FA51, Entry count: 0x2B)
	dc.b	$0B, $82, $0B, $82, $0B, $82, $0B, $82, $0B, $82, $18 ;0x20
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x0 (0x0001FA51-0x00020000, Entry count: 0x5AF) [Unknown data]
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x20
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x40
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x60
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x80
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0xA0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0xC0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0xE0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x100
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x120
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x140
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x160
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x180
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x1A0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x1C0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x1E0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x200
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x220
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x240
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x260
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x280
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x2A0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x2C0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x2E0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x300
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x320
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x340
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x360
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x380
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x3A0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x3C0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x3E0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x400
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x420
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x440
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x460
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x480
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x4A0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x4C0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x4E0
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x500
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x520
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x540
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x560
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x580
	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;0x5A0
	
EndOfRom:

	END
