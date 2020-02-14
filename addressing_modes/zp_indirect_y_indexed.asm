//Zeropage indirect y indexed (2 bytes)

//Hex view
//0010 		40 20 48 20 00 00 00 00
//...
//...
//2040 		00 01 02 03 04 05 06 07
//2048 		ff fe fd fc fb fa f9 f8
//2050 		ff fe fd fc fb fa f9 f8
//2058 		ff fe fd fc fb fa f9 f8

	ldy #$03
	lda ($10), y	//Look up address in ZP = $2040
					//Add the y register offset = $2043
					//Load value value from this address = $03
	lda $10
	clc
	adc #$08
	sta $10

	ldy #$03
	lda ($10), y	//Look up address in ZP = $2048
					//Add the y register offset = $204b
					//Load value value from this address = $03

//Use instead of self modifying code:
Loop:
	ldy #$03
SelfMod:
	lda $2040, y
	sta $d020
	rol
	sta $d021
SelfMod2:
	lda $2040, y
	sta $d023

	lda SelfMod + 1
	clc
	adc #$08
	sta SelfMod + 1
	lda SelfMod2 + 1
	clc
	adc #$08
	sta SelfMod2 + 1
	jmp Loop
	//Creates messy code and multiple self mods gets inefficient fast


//Great for collision:
		ldy #$06	//X position on screen to check
		ldx #$10	//Y position on screen to check

		lda SCREEN_ROW_LSB, x
		sta $10			
		lda SCREEN_ROW_MSB, x
		sta $11		//Now $10 in zeropage contains the start of the screen row address

		lda ($10), y  //Grabs the character at the x,y location we wanted


	//Screen row look up table
	SCREEN_ROW_LSB:
		.fill 25, <[$0400 + i * 40]		// < grabs the LSB byte of a 16 bit value
	SCREEN_ROW_MSB:
		.fill 25, >[$0400 + i * 40]		// > grabs the MSB byte of a 16 bit value





//Instructions - Always on accumulator
	//load and store
	lda ($10), y
	sta ($10), y

	//Compare
	cmp ($10), y

	//Arithmetic
	adc ($10), y
	sbc ($10), y

	//logic
	and ($10), y
	ora ($10), y
	eor ($10), y

