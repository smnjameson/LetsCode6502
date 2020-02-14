//Relative instructions 2 bytes

Skip:	//Distance is -3 = $fd
	lda $d020
	beq Skip 	//Actually creates an 8 bit signed number (-128 to 127)
				//Which is the distance from the beginning of the branch
				//instruction to the label
	//Converts internally to:
	//beq $fd
	//beq $04
	lda #$00
Skip:
	//Distance of 4


//Can also thanks to KickAsm!!
	//Wait for fire button
	lda #$10
	bit $dc00
	bne * - 3	//Branches from current instruction *  minus 3 back to the bit $dc00

	//Wait for next raster line
	lda $d012
	cmp $d012
	beq * - 3



//Negative flag
	bpl Plus
	bmi Minus 

//Overflow flag
	bvc Clear
	bvs Set

//Zero Flag
	beq EqualToZero
	bne NotEqualToZero

//Carry flag
	bcc Clear
	bcs Set

	