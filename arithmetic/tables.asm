BasicUpstart2(Entry)

Entry:
	//Lets add 15 to X and put it in Y
	ldx #$07 

	txa 	//2
	clc		//2
	adc #$15 //2
	tay      //2		//Slow 8 cycles


	ldy	PLUS + 15, x	//4	Much quicker!!

	//Using PLUS table for BIT operations
	lda #$87
	and #$83	//Accumlator = 3, Zero = clear, Negative set
				//Accumulator gets trashed

	lda #$87
	bit PLUS + $83	//BIT doesnt work in immediate mode so PLUS table helps
					//Accumulator = $87, zero = clear, negative set
	bit PLUS + $02	
	bit PLUS + $12	
	bit PLUS + $ff	


	//Square roots
		ldx #$40
		lda SQRT, x  //Returns 8

	//Common use for sqrt is distance calcs
	//eg is the distance between two objects less than 10
	// sqrt( (x2-x1) * (x2-x1) + (y2-y1) * (y2-y1)) < 10
	// becomes:
	// (x2-x1) * (x2-x1) + (y2-y1) * (y2-y1)  < 10 * 10

	//x2-x1
	ldx #20
	lda SQR_LSB, x
	sta RESULT_LSB
	lda SQR_MSB, x
	sta RESULT_MSB
	//y2-y1
	ldy #10
	lda SQR_LSB, y
	clc
	adc RESULT_LSB
	sta RESULT_LSB
	lda SQR_MSB, y
	adc RESULT_MSB
	sta RESULT_MSB

	//RESULT_LSB/MSB contains (x2-x1) * (x2-x1) + (y2-y1) * (y2-y1) in 16 bit
	lda RESULT_MSB
	bne !Fail+
	lda RESULT_LSB
	cmp #100
	bcs !Fail+
!Success:
	//We are less than 100
	inc $d020

!Fail:
	//Not less than 100


	//trig math sin/cos
		ldx #$80	//Angles go from 0-255 NOT 0-359
		lda SINUS, x  //Returns Sin(180) * 127

	RESULT_LSB:
		.byte 00
	RESULT_MSB:
		.byte 00
	SQR_LSB:
		.fill 256, <[i*i]
	SQR_MSB:
		.fill 256, >[i*i]

	SQRT:
		.fill 256, sqrt(i)

	SINUS:
		.fill 256, sin([i/256] * PI * 2) * 127

	PLUS:
		.fill 256, i	//0-255
		.fill 256, i