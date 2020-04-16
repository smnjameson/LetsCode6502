BasicUpstart2(Entry)

.label ScoreVector = $fa

.label Score00 = $fc
.label Score01 = $fd
.label Score02 = $fe
.label TEMP = $ff

Entry:
	// BCD treats each nibble as a digit 0-9
	// %0101 0011
	// $53	
	lda #$53
	sed		//enable bcd mode
	clc
	adc #$07		//$5a??
					//BCD does decimal arithmetic
					//so its actually $60
	cld		//Remember to disable BCD mode


	//Great for scores!!
	//score is 019900
	lda #$00
	sta Score00
	lda #$99
	sta Score01
	lda #$01
	sta Score02

	//Lets add 001000 to score = 020900
	sed
	clc
	lda Score00
	adc #$00
	sta Score00
	lda Score01
	adc #$10
	sta Score01
	lda Score02
	adc #$00
	sta Score02
	cld



	lda Score02
	lsr
	lsr
	lsr
	lsr
	clc 
	adc #$30
	sta $0400
	lda Score02
	and #$0f
	clc 
	adc #$30
	sta $0401
	lda Score01
	lsr
	lsr
	lsr
	lsr
	clc 
	adc #$30
	sta $0402
	lda Score01
	and #$0f
	clc 
	adc #$30
	sta $0403
	lda Score00
	lsr
	lsr
	lsr
	lsr
	clc 
	adc #$30
	sta $0404
	lda Score00
	and #$0f
	clc 
	adc #$30
	sta $0405


	//////////////////////////////
	// WITHOUT BCD!!!
	//////////////////////////////
	
	lda #$00	//Create an indirect lookup for score display
	sta ScoreVector + 0 
	lda #$04
	sta ScoreVector + 1


	//Score is 020900
	//Add 2500 to score without BCD = 023400
	lda #$02	//Digit value
	ldx #$03	//trailing zeroes
	jsr AddScore	//Add 2000
	lda #$19	//Digit value
	ldx #$02	//trailing zeroes
	jsr AddScore	//Add 500

	jmp *


AddScore:
	sta TEMP	//Store add value
	ldy #$05
!deczeroes:
	cpx #$00
	beq !+
	dex
	dey
	jmp !deczeroes-
!:
!loop:
	lda (ScoreVector), y
	clc
	adc TEMP
	cmp #$3a	//numbers in font go from $30-$39
	bcc !end+
	sbc #$0a	//Loop number back 
	sta (ScoreVector), y
	lda #$01	//Carry simulation! 
	sta TEMP
	dey
	jmp !loop-

!end:
	sta (ScoreVector), y
	rts


