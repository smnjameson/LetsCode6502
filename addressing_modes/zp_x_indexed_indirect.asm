//Zero page x indexed indirect

//Hex view
//0010 		40 20 48 20 00 00 00 00
//...
//...
//2040 		00 01 02 03 04 05 06 07
//2048 		ff fe fd fc fb fa f9 f8
//2050 		ff fe fd fc fb fa f9 f8
//2058 		ff fe fd fc fb fa f9 f8

	
	ldx #$02
	lda ($10, x)	//This will add the x register to the given Zeropage address
					//before looking up the value with indirection
					//In this case we look at $10 + $02 = $12
					//Zeropage address $12 contains $2048 (little endian)
					//and so Acc is set to the contents of $2048 = $ff

	//Notice the ,x is INSIDE the brackets

	lda ($10), x	//This is NOT indirect addressing 
	//This is the same as:
	lda $10, x


//Could be used for sound registers...BAD EXAMPLE!!!

//Hex view
//0010 		04 D4 0B D4 12 D4 00
	ldx #$00
	lda #%01000001
	sta ($10, x)
	inx 
	inx 
	sta ($10, x)
	inx 
	inx 
	sta ($10, x)
