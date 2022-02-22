//left shift: r0 = r0 << 2
ls r0, #2 

//right shift: r0 = r0 << 3
rs r0, #3

//bitwise AND: r0 = r0 & r1
and r0, r1 

//bitwise OR: r0 = r0 || r1
or r0, r1

//load immediate: r0 = 7
ldi r0, #7

//load register: r2 = MEM[r0]
ldr r2, r0

//store register: MEM[r0] = r2
str r2, r0

//equals: r1 = (r1 == r2)
eq r1, r2 

//branch if not equal to zero: if r1 == 1, go to address in R3
bnz r3, r1

//greater than or equal to: r0 = (r0 >= r1)
geq r0, r1

//2's complement: r1 = (~r1 + 1)
neg r1, r1 

//add: r0 = r0 + r1
add r0, r1

//add immediate: r0 = r0 + 3
addi r0, #3

//not equal to: r0 = (r0 != r1)
neq r0, r1
