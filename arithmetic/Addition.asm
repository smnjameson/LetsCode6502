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


	//Now lets do $10c0f0 + $224201     = $3302f1
	clc			  //      C=0

	lda NumberLSB //$f0
	adc #$01	  //$f1   C=0
	sta NumberLSB //$f1

	lda NumberMSB //$c0
	adc #$42	  //$02   C=1
	sta NumberMSB //$02

	lda NumberMSB2 //$10
	adc #$22	   //$33  C=0
	sta NumberMSB2 


// 					Set Carry
// 					===========>					
// $00-------------------$ff-$00-----------$FF
//  				<===========
//  				Clear carry