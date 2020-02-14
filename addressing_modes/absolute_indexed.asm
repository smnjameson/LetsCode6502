//Zero page(2) and Absolute indexed(3)

//Use X & Y register to offset memory addresses

//Example
	lda $1000
	sta $10
	lda $1001
	sta $11
	lda $1002
	sta $12
	...
	...
	lda $1027
	sta $37

//Becomes
	ldx #$00
!:
	lda $1000, x 	//4 cycles (5 cycles if page boundary crossed)
					//$1000 - $10ff  = a page
					//$1100 - $11ff  = next page
					//so:
					// ldx #$10
					// lda $10ff, x 	//This is rooted at $10ff but accesses $110f
										//Crossing a page boundary and using an extra cycle
										//See bottom of page!!!
	sta $10, x
	inx
	cpx #$28
	bne !-


	lda $1000, x + 1 //INVALID!! Calculations only allowed on the number not the adressing mode part


//Load
	lda $1000, x
	lda $1000, y 
	ldx $1000, y
	ldy $1000, x
	//Zero page
	lda $10, x//There is no ZP y indexing for lda
	ldx $10, y
	ldy $10, x

//Stores
	sta $1000, x
	sta $1000, y 
	//There is no stx $1000,y  or sty $1000, x
	//zero page
	sta $10, x //There is no ZP y index for sta
	stx $10, y
	sty $10, x

//Logical operations
	ora $1000, x
	ora $1000, y
	ora $10, x //There is no ZP y index for ora
	and $1000, x
	and $1000, y
	and $10, x //There is no ZP y index for and
	eor $1000, x
	eor $1000, y
	eor $10, x //There is no ZP y index for eor


//Shifts (only work with the x register, no y indexing at all)
	asl $1000, x
	asl $10, x
	lsr $1000, x
	lsr $10, x
	eor $1000, x
	eor $10, x



//Crossing a zero page boundary...
	ldx #$02
	lda $ff, x 		//zeropage indexing always reads from zero page
					//so in this case we are not reading $ff + $02 = $101
					//But will actually read $01, the value jsut wraps in Zero page


//Page boundaries and how to avoid them!!!

* = $10f8	//Assume the code has reached this addr, not set directly like this
	lda $d020	//10f8
	cmp #$02	//10fb
	beq !+		//10fd	//Normally would be 3 cycles to take this branch
						//However we cross from page $10 to $11 so it will instead
						//Take 4 cycles
	rts 		//10ff
!:	//1100


//Instead we can use align
* = $10f8 //Assume the code has reached this addr, not set directly like this
.align $100		//Moves the program counter to the next $100 rounded
				//in this case $1100
	lda $d020	//1100
	cmp #$02	//1103
	beq !+		//1105	//Now the branch does not cross a boundary
						//and so takes 3 cycles
	rts 		//1106
!:	//1107


//How do i know where my code is at?
* = *	//Typing this will show the address in kick asm output
* = * "Some Label"		//Adding a label will make it easy to find

