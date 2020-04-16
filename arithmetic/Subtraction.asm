BasicUpstart2(Entry)

.label NumberLSB = $fc
.label NumberMSB = $fd
.label NumberMSB2 = $fe

Entry: 
	lda #$f0
	sta NumberLSB
	lda #$c0
	sta NumberMSB    //f0 c0 10  little endian
	lda #$10
	sta NumberMSB2   //f0 c0 10  little endian

// 					Set Carry
// 					===========>					
// $00--------$80-------$ff-$00------$80------$FF
//  				<===========
//  				Clear carry


	//Now lets do $10c0f0 - $01d004     = $0ef0ec
	sec			  //C=1  Borrow=0  //Borrow is inverse of carry

	lda NumberLSB //$f0
	sbc #$04	  //$ec   C=1 Borrow=0
	sta NumberLSB //$ec

	lda NumberMSB //$c0
	sbc #$d0	  //$f0   C=0 Borrow=1
	sta NumberMSB //$f0



	lda NumberMSB2 //$10
	sbc #$01	   //$0e  C=0 Borrow=1
	sta NumberMSB2 //$0e
 								
	//Carry is always set




	//Overflow, set when we cross the boundary from $7f to $80 positive to negative
	//Effectred by ADC, SBC and BIT
	//bit $ff //N if bit 7,  V if bit 6

	//$00---------------$80---------------$ff
	//0-----------------127 __ -128------- -1
	sec
	lda #$80	
	sbc #$10
	jmp *

	

