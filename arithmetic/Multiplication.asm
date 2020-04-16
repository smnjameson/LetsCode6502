BasicUpstart2(Entry)

.label NumberLSB = $fc
.label NumberMSB = $fd
.label NumberMSB2 = $fe

.label TEMP = $ff
Entry: 
	//Multiply by 3
	lda #$02
	sta TEMP
	asl	//x2
	clc
	adc TEMP

	//Muliplying by 40 using a table (c64 screen rows)
	ldx #$05
	lda lsb, x
	sta NumberLSB
	lda msb, x
	sta NumberMSB	

	ldy #$08
	lda #$00
	sta (NumberLSB), y		//Store at 8,5 on screen

	jmp *

	lsb:
		.fill 25, <[i * $28 + $0400]
	msb:
		.fill 25, >[i * $28 + $0400]
