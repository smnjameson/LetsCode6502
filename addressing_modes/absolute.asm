//Absolute mode(3) + Zero Page(2) 

//Zeropage uses only 8 bit operands
lda $01
lda %11011111
lda 240


//Absolute
//Loads
lda $2300 //Hex 
lda %1100110011001100 //Binary
lda 53280 //Decimal
ldx $c000
ldy $d020

//Store
sta $d020
stx $d021
sty $d022

jmp $1000 //Does not have a zeropage mode
jmp $34
//$4c $34 $00
jsr $1000 //Does not have a zeropage mode
jsr $42
jsr $0042

inc $2000	//Increment
dec $2000	//Decrement


//Shifts and rolls
asl $2000	
lsr $2030
rol $4096
ror $8000


//Logical operations
//Perform logical operation between Acc & memory - Store result in Acc
ora $1000
and $1000
eor $1000
bit $1000 //Like an AND but Does not store the result in Acc

//Add/Subtract
adc $1000
sbc $1000


//Compares
cmp $2000
cpx $1000
cpy $5678











//Kick asm calculations

lda $0400 + 40 * 10 + 8
//Becomes
lda $0598


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

//Why use square brackets???
.label offset = $80
jmp ($1000 + offset) //Diffent indirect addressing mode!
jmp $1080 //NOT THE SAME!!
jmp [$1000 + offset] //This is the same as jmp $1080


