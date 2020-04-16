BasicUpstart2(Entry)

.label NumberLSB = $fc
.label NumberMSB = $fd
.label NumberMSB2 = $fe

Entry: 
	//Multiply by 2
	lda #$01
	asl			//$02

	//By 4
	asl			//$04

	//By 8
	asl			//$08


	//Divide by 2
	lda #$0f
	lsr			//$07 

	//By 4
	lsr			//$03

	//By 8
	lsr 		//$01



	lda #$f0
	sta NumberLSB
	lda #$10
	sta NumberMSB    //f0 10  little endian
					
	//Multiply by 2	 = %0010000111100000  $21e0
	lda NumberLSB	//C=? %11110000
	asl				//C=1 %11100000
	sta NumberLSB	//C=1 %11100000 = $e0

	lda NumberMSB   //C=1 %00010000
	rol				//C=0 %00100001
	sta NumberMSB   //C=0 %00100001 = $21

	//By 4 = Repeat multiplyu by two again
	lda NumberLSB	//C=? %11110000
	asl				//C=1 %11100000
	sta NumberLSB	//C=1 %11100000 = $e0

	lda NumberMSB   //C=1 %00010000
	rol				//C=0 %00100001
	sta NumberMSB   //C=0 %00100001 = $21
	

	//x4 16 bit optimisation
	lda NumberLSB
	asl
	rol NumberMSB
	asl
	rol NumberMSB
	sta NumberLSB

	//x8 24 bit optimisation
	lda NumberLSB
	asl
	rol NumberMSB
	rol NumberMSB2
	asl
	rol NumberMSB
	rol NumberMSB2
	asl
	rol NumberMSB
	rol NumberMSB2
	sta NumberLSB	


	// divide by 4 Optimised - 16 bit
	// Start with MSB for right shift
	// Shift to the right = start with rightmost bit (little endian) = MSB
	// Shift to the left = start with leftmost bit (little endian) = LSB

	lda NumberMSB
		lsr
		ror NumberLSB
		lsr
		ror NumberLSB
	sta NumberMSB

	//24 bit
	lda NumberMSB2
		lsr
		ror NumberMSB
		ror NumberLSB
		lsr
		ror NumberMSB
		ror NumberLSB
	sta NumberMSB2




	//Shifting signed numbers
	//Multiply by 2
	lda #$f0	// %11110000   = -16
	asl			// %11100000   = $e0 = -32

	//Same as non signed for 16 bit +
	lda #$40
	sta NumberLSB
	lda #$f0
	sta NumberMSB //$f040 = -4032

	lda NumberLSB
	asl
	rol NumberMSB
	sta NumberLSB		//$e080



	//Divide by 4
	lda #$40
	sta NumberLSB
	lda #$f0
	sta NumberMSB //$f040 = -4032


	lda NumberMSB

	cmp #$80		//When shifting signed numbers to right, MSB needs a CMP #$80 + ROR rather than a LSR
	ror
	ror NumberLSB

	cmp #$80
	ror
	ror NumberLSB	

	sta NumberMSB //$fc10

	jmp *
