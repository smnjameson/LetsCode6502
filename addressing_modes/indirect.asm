//indirect 3 bytes

//Only one opcode uses this mode


jmp ($1000)			//No zero page version will alwasy be 3 bytes
jmp ($10)			//So this is actually jmp ($0010)


//Hex view:
//1000   E2 FC 00 10 .........

jmp ($1000)  // read the adress found at this location
			 // in this case $FCE2	(little endian)				
		     // and jump to that address
		     // RESET !!!!


//Handy for jump tables

	lda CurrentBehaviour
	asl 
	sta SelfMod + 1
SelfMod:
	jmp ($1006)

* = $1000
	.word Behaviour1
	.word Behaviour2
	.word Behaviour3
	.word Behaviour4


