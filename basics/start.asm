BasicUpstart2($c000)	//creates 10 sys49152

* = $c000
	
	lda #$00
	sta $d020
	sta $d021

	lda #$20
	ldx #$00
Loop:
	sta $0400, x
	sta $0500, x
	sta $0600, x
	sta $0700, x
	inx
	bne Loop

	lda #$01	//Track number
	jsr Music.Init

	//Set fonts
	
	//Set vic banks

	//Set graphics modes

	//Initialise interrupts
	


MainLoop:
	lda FrameFlag
	beq MainLoop

	lda #$00
	sta FrameFlag

		jsr GetControls
		jsr UpdatePlayer
		jsr UpdateEnemies

		jsr DrawPlayer
		jsr DrawEnemies

		jsr DrawHud

	jmp MainLoop

FrameFlag:
	.byte $00







	










