//Useful Kick asm directives

//Using FOR loops
lda $0400
sta $10
lda $0428
sta $11
lda $0450
sta $12

//Simplifies to
.for(var i=0; i<3; i++) {
	lda $0400 + i * $28
	sta $10 + i
}



//Bytes and words
	.byte $00, $20, $52, $ff	//Inserts bytes into memory
	.byte 0, [20 * 3], [$52 / 2], [$ff - %11100]	//Mix and match calculations and number bases

	.byte value1, value2, value3	//Can also use vars and labels

	.word $ffff, $d020, 53280	//Store 16 bit values in little endian format in memory
								//Again can mix and match calculations and number bases

	.dword $10203040			//Store 32 bit values in little endian format

//Fills
	//You might want to store several bytes following a pattern:
	.for(var i=0; i<25; i++) {
		.byte [i * 10]
	}
	//However its neater to use a fill
	.fill 25, [i * 10]

	//Also works with words
	.fillword 25, [i * 100]		//stores 16 bit values


//Grabbing LSB < 	and MSB >
	
	.fill 25, <[$0400 + i * 40]	//Fills with just the lsb from scren addresses
	.fill 25, >[$0400 + i * 40]	//Fills with just the msb from scren addresses

	//You can create matching lsb and msb tables using lohifill

	.lohifill 25, [$0400 + i * 40]	//Creates the same two tables from above
									//A table of LSB values followed by a table of MSB values

//Text						
	.text "ABCDEF"					//Fills the bytes 1,2,3,4,5,6 into memory
	.text "ABCDEF@"					//Using @ is zero as per PETSCII values
	.text @"ABCDEF\$5f"				//Preceding the string with @ lets you use inline hex values

	//You can change the encoding using:
	.encoding "screencode_upper"
	.encoding "screencode_mixed"
	.encoding "petscii_upper"
	.encoding "petscii_mixed"


//Color Constants

	lda #$02
	//or instead
	lda #RED

	//All colors:
	lda #BLACK
	lda #WHITE
	lda #RED
	lda #CYAN
	lda #PURPLE
	lda #GREEN
	lda #BLUE
	lda #YELLOW
	lda #ORANGE
	lda #BROWN
	lda #LIGHT_RED
	lda #DARK_GREY
	lda #GREY
	lda #LIGHT_GREEN
	lda #LIGHT_BLUE
	lda #LIGHT_GREY

//Assemble time output
	* = * "Current address"
	//or instead
	.print ("Current address" + *)

	//Can print out labels, vars, loop iterators
	//But not Acc, X , Y or memory contents as this is assemble time only!!
	.for(var i=0; i<10; i++) {
		.print ("iteration: " + i)
	}
