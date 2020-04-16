BasicUpstart2(Entry)

.label TEMP = $fc

Entry:
	//Divide by 3 approximation

	//100 / 3  = 33.33333

	//100 * 0.333333333 
	//0.25 + 0.0625 = 0.3125
	// 1/4 + 1/16

	lda #$64
	lsr
	lsr		//dividied by 4
	sta TEMP
	lsr
	lsr		//divided by 16
	sec		//CLC = floor, SEC = CEIL set according to which way your tolerance is
	adc TEMP	//= 32


	//Divide by 5 approximation

	//100 / 5  = 20

	//100 * 0.20

	//0.125 + 0.0625 + 0.015625= 0.2025...
	// 1/8 + 1/16 + 1/64

	lda #$64
	lsr
	lsr
	lsr
	sta TEMP
	lsr
	pha
	clc
	adc TEMP
	sta TEMP
	pla
	lsr
	lsr
	adc TEMP



	jmp *





