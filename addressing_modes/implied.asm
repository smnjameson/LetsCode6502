//Implied Mode 1 byte

clc //Carry
sec
cld //Decimal
sed
cli //Interrupt flag
sei 
clv //Clear overflow

nop //No operation 
brk //Break instruction

rts //Return subroutine
rti //Return interrupt

tax //Transfer
txa 
tay
tya 
tsx //Stack pointer 
txs

inx //Increment by 1
iny

dex //Decrement by 1
dey

pha //Push Acc to stack
pla 

php //Push processor status to stack
plp

asl	//Arithmetic shift left of Acc
lsr //Logical shift right of Acc

rol //Roll left Acc
ror //Roll Right Acc

