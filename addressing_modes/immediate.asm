//Immediate mode 2 bytes

//# symbol implies immediate mode
//Loads
lda #96
lda #$96
lda #%010101
ldx #$96
ldy #$00

//Compare
cmp #$00
cpx #$01
cpy #$02

//logical operators
//Perform logical operation between Acc & Immeditate Value - Store result in Acc
and #%11110000
eor #$ff
ora #%00001000

//Add & subtract
adc #$02
sbc #$02





