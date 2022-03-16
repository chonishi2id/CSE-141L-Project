ldi r0, #0  		// Func1_start:
ldi r1, #6          // 6 = 00000110
ls r1, #1			// 12 = 00001100
addi r1, #1         // 13 = 00001101
ls r1, #4           // 208 = 11010000	
addi r1, #7         // r1 = 215 = 11010111
str r1, r0		    // datamem[215] = 0
ldi r2, #7          // 7 = 00000111
ls r2, #2           // 28 = 00011100
addi r2, #2         // r2 = 30 = 00011110
addi r1, #1        	// r1 = 216
str r1, r2			// data_mem[216] = 30 (store initial output index 30)
ldi r2, #6          // 'Func1_loop:' // 6 = 00000110
ls r2, #1			// 12 = 00001100
addi r2, #1         // 13 = 00001101
ls r2, #4           // 208 = 11010000	
addi r2, #7			// r2 = 215
ldr r0, r2			// r0 = data_mem[215] (r0=0)
ldr r1, r0			// r1 = data_mem[0] = 01010010 Load LSW of input string into r1 (r1=01010010)
addi r0, #1			// Prepare to load MSW of input string
ldr r2, r0    		// r2 = data_mem[1] = 00000011 (Load MSW of input string into r2)
addi r0, #1			// r0 = 2 (Increment input address for the next input if applicable)
ldi r3, #6          // 6 = 00000110
ls r3, #1			// 12 = 00001100
addi r3, #1         // 13 = 00001101
ls r3, #4           // 208 = 11010000	
addi r3, #7         // r3 = 215 = 11010111
str r3, r0   		// data_mem[215] = 2 (store input address to use later)
ldi r3, #3  		//00000011
ls r3, #6   		//11000000
addi r3, #3 		// r3 = 195 = 11000011
str r3, r1			// data_mem[195] = 01010010 (store LSW for later)
addi r3, #1 		// r3 = 196
str r3, r2			// data_mem[196] = 00000011
ls r1, #7 			// r1 = 00000000 LSW = LSW << 7 (00000000)
rs r1, #7			// r1 = 00000000 LSE = LSW >> 7 (00000000) (get LSB [b1] of LSW)
addi r3, #1 		//r3 = 197
str r3, r1			// data_mem[197] = r1 = 0
ldi r2, #3  		//00000011
ls r2, #6   		//11000000
addi r2, #3 		// r2 = 195 = 11000011
ldr r1, r2			// r1 = data_mem[195] = 01010010
ls r1, #6 			// r1 = 10000000
rs r1, #7			// r1 = 00000001 (get b2 of LSW)
addi r3, #1 		// r3 = 198
str r3, r1			// data_mem[198] = 00000001
ldr r1, r2			// r1 = data_mem[195] = 01010010
ls r1, #5 			// r1 = 01000000
rs r1, #7			// r1 = 00000000
addi r3, #1 		// r3 = 199
str r3, r1			// data_mem[199] = r1 = 00000000
ldr r1, r2			// r1 = data_mem[195] = 01010010
ls r1, #4 			// r1 = 00100000
rs r1, #7			// r1 = 00000000
addi r3, #1 		// r3 = 200
str r3, r1			//data_mem[200] = 00000000
ldr r1, r2			
ls r1, #3 //b5
rs r1, #7
addi r3, #1 		//r3 = 201
str r3, r1
ldr r1, r2
ls r1, #2 //b6
rs r1, #7
addi r3, #1 		//r3 = 202
str r3, r1
ldr r1, r2
ls r1, #1 			//b7
rs r1, #7
addi r3, #1 		//r3 = 203
str r3, r1
ldr r1, r2
rs r1, #7 			//b8
addi r3, #1 		//r3 = 204
str r3, r1
addi r2, #1 		//r2 = 196
ldr r1, r2 			// r1 = data_mem[196] = 00000011 (load back value of MSW from datamem[196])
ls r1, #7 			// r1 = 10000000
rs r1, #7			// r1 = 00000001 b9 (We're now on the MSB)
addi r3, #1 		// r3 = 205
str r3, r1			// data_mem[205] = 00000001
ldr r1, r2			// r1 = data_mem[196] = 00000011
ls r1, #6 			// r1 = 10000000
rs r1, #7			// r1 = 00000001
addi r3, #1 		// r3 = 206
str r3, r1			// data_mem[206] = r1 = 00000001 (store b10)
ldr r1, r2			// r1 = data_mem[196] = 00000011			
rs r1, #2 			// r1 = 00000000 (store b11)
addi r3, #1 		// r3 = 207
str r3, r1			// data_mem[207] = 00000000
ldr r2, r3 			// 'p8_loop:' r2 = data_mem[207] = b11 = 00000000
ldi r1, #1			// r1 = 1
neg r1, r1 			// r1 = -1
add r3, r1			// r3 = 206
ldr r1, r3			// r1 = data_mem[206] = 00000001
neq r2, r1 			// r2 = 1 [= r2 xor r1 = (r2 != r1) = (b11 != b10) = 00000000 != 00000001 = 1]
ldi r1, #1			// r1 = 1
neg r1, r1 			// r1 = -1
add r3, r1 			// r3 = 205 
ldr r1, r3			// r1 = data_mem[205] (b9)
neq r2, r1			// r2 = 0 [(r2 != r1) = (00000001 != 00000001) = 0 (b11^b10)^b9 ]
ldi r1, #1			// r1 = 1
neg r1, r1 			// r1 = -1
add r3, r1			// r3 = 204
ldr r1, r3			// r1 = data_mem[204] = 00000000
neq r2, r1			// r2 = 0 [= (r2 != r1) = (b11^b10^b9)^b8 = 00000000]
ldi r1, #1			// r1 = 1
neg r1, r1 			// (r1 = -1)
add r3, r1			// r3 = 203
ldr r1, r3			// r1 = data_mem[203] = 00000001
neq r2, r1 			// r2 = 1 [ = (r2 != r1) = (b11^b10^b9^b8)^b7 = (00000000 != 00000001) = 00000001]
ldi r1, #1			// r1 = 1
neg r1, r1 			// r1 = -1
add r3, r1			// r3 = 202		
ldr r1, r3			// r1 = data_mem[202] = 00000000			
neq r2, r1			// r2  = 1 [= (r2 != r1) = (b11^b10^b9^b8^b7)^b6 = 00000001 ^ 00000000 = 00000001]
ldi r1, #1			// r1 = 1
neg r1, r1 			// r1 = -1
add r3, r1			// r3 = 201
ldr r1, r3			// r1 = data_mem[201] = 00000001
neq r2, r1			// r2 = 0 [= (r2 != r1) = (b11^b10^b9^b8^b7^b6)^b5 = 00000001 ^ 00000001 = 00000000]
addi r3, #7 		// r3 = 208
addi r3, #2			// r3 = 210
str r3, r2 			// data_mem[210] = r2 = ^b11:b5 = 0 ('p8_end:')
ldi r0, #3			// r0 = 3
neg r0, r0 			// r0 = -3
add r3, r0 			// r3 = 207
ldr r1, r3 			// r1 = data_mem[207] = 00000000 (b11)
ls r1, #1			// r1 = 00000000
ldi r0, #1			// r0 = 1
neg r0, r0 			// r0 = -1
add r3, r0 			// r3 = 206
ldr r2, r3 			// r2 = data_mem[206] = 00000001 (b10)
or r1, r2			// r1 = r1 | r2 = 00000000 | 00000001 = 00000001
ls r1, #1			// r1 = r1 << 1 = 00000010
add r3, r0 			// r3 = 205
ldr r2, r3 			// r2 = data_mem[205] = 00000001 (b9)
or r1, r2			// r1 = r1 | r2 = 00000010 | 00000001 = 00000011
ls r1, #1			// r1 = r1 << 1 = 00000110
add r3, r0 			// r3 = 204
ldr r2, r3 			// r2 = data_mem[204] = 00000000 (b8)
or r1, r2			// r1 = r1 | r2 = 00000110 | 00000000 = 00000110
ls r1, #1			// r1 = r1 << 1 = 00001100
add r3, r0 			// r3 = 203
ldr r2, r3 			// r2 = data_mem[203] = 00000001 (b7)
or r1, r2			// r1 = r1 | r2 = 00001100 | 00000001 = 00001101
ls r1, #1			// r1 = r1 << 1 = 00011010
add r3, r0 			// r3 = 202
ldr r2, r3 			// r2 = data_mem[202] = 00000000 (b6)
or r1, r2			// r1 = r1 | r2 = 00011010 | 00000000 = 00011010
ls r1, #1			// r1 = r1 << 1 = 00110100
add r3, r0 			// r3 = 201
ldr r2, r3 			// r2 = data_mem[201] = 00000001 b5
or r1, r2			// r1 = r1 | r2 = 00110100 | 00000001 = 00110101
ls r1, #1			// r1 = r1 << 1 = 01101010
ldi r3, #6          // r3 = 00000110 = 6
ls r3, #1			// r3 = 00001100 = 12
addi r3, #1         // r3 = 00001101 = 13
ls r3, #4           // r3 = 11010000 = 208 	
addi r3, #2 		// r3 = 210
ldr r0, r3			// r0 = data_mem[210]
or r1, r0 			// r1 = r1 | r0 = 01101010 | 00000000 = 01101010 (insert p8 here. Now the MSW is finished)
ldi r3, #6          // r3 = 00000110
ls r3, #1			// r3 = 00001100
addi r3, #1         // r3 = 00001101
ls r3, #4           // r3 = 208 
addi r3, #1			// r3 = 209
str r3, r1			// data_mem[209] = r1 = 01101010
ldi r0, #1			// r0 = 1
neg r0, r0 			// r0 = -1
add r3, r0 			// r3 = 208
add r3, r0 			// r3 = 207	(b11)
ldr r2, r3 			// r2 = data_mem[207] = 00000000 (b11) 'p4_loop:'
add r3, r0			// r3 = 206 (b10)
ldr r1, r3			// r1 = data_mem[206] = 00000001 (b10)
neq r2, r1      	// r2 = (r2 != r1) = (b11^b10) = (00000000 != 00000001) = 00000001
add r3, r0			// r3 = 205 (addr b9)
ldr r1, r3			// r1 = data_mem[205] = 00000001 (b9)
neq r2, r1  		// r2 = (r2 != r1) = (b11^b10)^b9 = (00000001 != 00000001) = 00000000
add r3, r0 			// r3 = 204
ldr r1, r3			// r1 = data_mem[204] = 00000000 (b8)  
neq r2, r1			// r2 = (r2 != r1) = (b11^b10^b9)^b8 = (00000000 != 00000000) = 00000000
ldi r3, #6 			// r3 = 00000110
ls r3, #2 			// r3 = 00011000
addi r3, #1 		// r3 = 00011001
ls r3, #3 			// r3 = 200 = 11001000
ldr r1, r3			// r1 = data_mem[200] = 00000000 (b4)
neq r2, r1			// r2 = (r2 != r1) = (b11^b10^b9^b8)^b4 = 00000000 != 00000000 = 0
add r3, r0			// r3 = 199
ldr r1, r3			// r1 = data_mem[199] = 00000000 (b3)
neq r2, r1			// r2 = 0 = (r2 != r1) = (b11^b10^b9^b8^b4)^b3 = 00000000 != 00000000 = 0
add r3, r0			// r3 = 198
ldr r1, r3			// r1 = data_mem[198] = 00000001 (b2)
neq r2, r1 			// r2 = 1 = (r2 != r1) = (b11^b10^b9^b8^b4^b3)^b2 = 00000000 != 00000001 = 1
addi r3, #7 		//r3 = 205
addi r3, #6 		//r2 = 211
str r3, r2 			// data_mem[211] = r2 = 1 = (b11^b10^b9^b8^b4^b3)^b2 = p4 ('p4_end:')
ldi r2, #6 			// 00000110
ls r2, #2 			// 00011000
addi r2, #1 		// 00011001
ls r2, #3 			// r2 = 200 = 11001000
ldr r1, r2			// r1 = data_mem[200] = 00000000
ls r1, #1			// r1 = r1 << 1 = 00000000
add r2, r0 			// r2 = 199
ldr r3, r2			// r3 = data_mem[199]  = 00000000
or r1, r3			// r1 = 0 = r1 | r2 = 00000000 | 00000000 = 00000000
ls r1, #1			// r1 = r1 << 1 = 00000000
add r2, r0			// r2 = 198
ldr r3, r2			// r3 = data_mem[198] = 00000001 (b2)
or r1, r3			// r1 = r1 | r3 = 00000000 | 00000001 = 00000001
ls r1, #1			// r1 = r1 << 1 = 00000010
addi r2, #7			// r2 = 205
addi r2, #6			// r2 = 211
ldr r3, r2			// r3 = data_mem[211] = p4 = 00000001
or r1, r3			// r1 = r1 | r3 = 00000010 | 00000001 = 00000011
ls r1, #1			// r1 = r1 << 1 = 00000110
ldi r3, #6          // r3 = 00000110
ls r3, #1			// r3 = 00001100
addi r3, #1         // r3 = 00001101
ls r3, #4           // r3 = 208 = 11010000	
str r3, r1			// data_mem[208] = 00000110
add r3, r0			// r3 = 207
ldr r1, r3			// r1 = data_mem[207] ('p2_loop:') = 00000000 (b11) 
add r3, r0 			// r3 = 206
ldr r2, r3			// r2 = data_mem[206] = 00000001(b10)
neq r1, r2			// r1 = 1 = (b11^b10) = (r1 != r2) = 00000000 != 00000001 = 00000001
ldi r0, #3			// r0 = 3		
neg r0, r0 			// r0 = -3
add r3, r0 			// r3 = 203
ldr r2, r3			// r2 = data_mem[203] = 00000001
neq r1, r2			// r1 = 0 = (b11^b10)^b7 = (r1 != r2) = 00000001 != 00000001 = 00000000
ldi r0, #1			// r0 = 0
neg r0, r0 			// r0 = -1
add r3, r0 			// r3 = 202
ldr r2, r3			// r2 = data_mem[202] = 00000000
neq r1, r2			// r1 = 0 = (b11^b10^b7)^b6 = (r1 != r2) = 00000000 != 00000000 = 00000000
ldi r0, #2			// r0 = 2		
neg r0, r0 			// r0 = -2
add r3, r0 			// r3 = 200
ldr r2, r3			// r2 = data_mem[200] = 00000000
neq r1, r2			// r1 = 0 = (b11^b10^b7^b6)^b4 = (r1 != r2) = 00000000 != 00000000 = 00000000
ldi r0, #1			// r0 = 1
neg r1, r1 			// r0 = -1
add r3, r0 			// r3 = 199
ldr r2, r3			// r2 = data_mem[199] = 00000000
neq r1, r2			// r1 = 0 = (b11^b10^b7^b6^b4)^b3 = (r1 != r2) = 00000000 != 00000000 = 00000000
ldi r0, #2			// r0 = 2
neg r0, r0 			// r0 = -2
add r3, r0 			// r3 = 197
ldr r2, r3			// r2 = data_mem[197] = 00000000	
neq r1, r2			// r1 = 0 = (b11^b10^b7^b6^b4^b3)^b2 = (r1 != r2) = 00000000 != 00000000 = 00000000
ldi r2, #6 			// r2 = 00000110
ls r2, #2 			// r2 = 00011000
addi r2, #1 		// r2 = 00011001
ls r2, #3 			// r2 = 200
addi r2, #7 		// r2 = 207
addi r2, #5 		// r2 = 212
str r2, r1 			// data_mem[212] = r1 = 0 ('p2_end:')
ldi r3, #4			// r3 = 4
neg r3, r3 			// r3 = -4
add r2, r3 			// r2 = 208
ldr r1, r2			// r1 = data_mem[208] = 00000110 (W.I.P. LSW)
ldi r3, #3  		// r3 = 00000011
ls r3, #6   		// r3 = 11000000
addi r3, #5 		// r3 = 197
ldr r2, r3			// r2 = data_mem[197] = 00000000 (b1)
or r1, r2			// r1 = r1 | r2 = 00000110 | 00000000 = 00000110
ls r1, #1			// r1 = r1 << 1 = 00001100
addi r3, #7			// r3 = 204
addi r3, #7			// r3 = 211
addi r3, #1			// r3 = 212
ldr r2, r3			// r2 = data_mem[212] = 00000000 (p2)
or r1, r2			// r1 = (r1 | r2) = 00001100 | 	00000000 = 00001100		
ls r1, #1			// r1 = r1 << 1 = 00011000
ldi r3, #6          // r3 = 00000110
ls r3, #1			// r3 = 00001100
addi r3, #1         // r3 = 00001101
ls r3, #4           // r3 = 208
str r3, r1			// data_mem[208] = r1 = 00011000 (W.I.P. LSW)
ldi r0, #1			// r0 = 1
neg r0, r0 			// r0 = -1
add r3, r0 			// r3 = 207
ldr r1, r3 			// r1 = data_mem[207] = 00000000 (b11) // ('p1_loop:')
ldi r0, #2			// r0 = 2	
neg r0, r0 			// r0 = -2
add r3, r0 			// r3 = 205
ldr r2, r3			// r2 = data_mem[205] = 00000001 (b9)
neq r1, r2   		// r1 = 1 = (b11^b9) = (r1 != r2) = 00000000 != 00000001 
add r3, r0 			// r3 = 203
ldr r2, r3			// r2 = data_mem[203] = 00000001 (b7)
neq r1, r2			// r1 = 0 = (b11^b9)^b7 = (r1 != r2) = 00000001 != 00000001 
add r3, r0 			// r3 = 201
ldr r2, r3			// r2 = data_mem[201] = 00000001 (b5)
neq r1, r2			// r1 = 0 = (b11^b9^b7)^b5 = (r1 != r2) = 00000001 != 00000001 
ldi r0, #1			// r0 = 1
neg r0, r0 			// r0 = -1
add r3, r0 			// r3 = 200
ldr r2, r3			// r2 = data_mem[200] = 00000000 (b4)
neq r1, r2			// r1 = 1 = (b11^b9^b7^b5)^b4 = (r1 != r2) = 00000001 != 00000000 
ldi r0, #2			// r0 = 2
neg r0, r0 			// r0 = -2
add r3, r0 			// r3 = 198
ldr r2, r3			// r2 = data_mem[198] = 00000001 (b2)		
neq r1, r2			// r1 = 0 = (b11^b9^b7^b5^b4)^b2 = (r1 != r2) = 00000001 != 00000001
ldi r0, #1			// r0 = 1
neg r0, r0 			// r0 = -1
add r3, r0 			// r3 = 197
ldr r2, r3			// r2 = data_mem[197] = 00000000 (b1)
neq r1, r2			// r1 = 0 = (b11^b9^b7^b5^b4^b2)^b1 = (r1 != r2) = 00000000 != 00000000 
ldi r3, #6          // r3 = 00000110
ls r3, #1			// r3 = 00001100
addi r3, #1         // r3 = 00001101
ls r3, #4           // r3 = 208	
addi r3, #5 		// r3 = 213
str r3, r1 			// data_mem[213] = r1 = 00000000 (store p1) ('p1_end:')
ldi r3, #6          // r3 = 00000110
ls r3, #1			// r3 = 00001100
addi r3, #1         // r3 = 00001101
ls r3, #4           // r3 = 208	
ldr r2, r3			// r2 = data_mem[208] = 00011000
or r2, r1 			// r2 = r2 | r1 = (00011000 | 00000000) = 00011000 (insert p1 into W.I.P. LSW)
ls r2, #1			// r2 = r2 << r1 = 00110000
str r3, r2 			// data_mem[208] = 00110000 (store W.I.P. LSW into its spot)
addi r3, #2			// r3 = 210 (addr of p8 = ^b11:b5)
ldr r1, r3			// r1 = 0 = data_mem[210] (p8 = ^b11:b5) = 00000000
ldi r0, #5			// r0 = 5
neg r0, r0			// r0 = -5
add r3, r0			// r3 = 205
add r3, r0			// r3 = 200
ldr r2, r3			// r2 = data_mem[200] = 00000000 (b4)
neq r1, r2			// r1 = (^b11:b4) = (r1 != r2) = 00000000 != 00000000 = 0
ldi r0, #1			// r0 = 1
neg r0, r0			// r0 = -1
add r3, r0			// r3 = 199
ldr r2, r3			// r2 = data_mem[199] = 00000000 (b3)
neq r1, r2			// r1 = 0 (^b11:b3) = (r1 != r2) = (00000000 != 00000000) = 0
add r3, r0			// r3 = 198
ldr r2, r3			// r2 = data_mem[198] = 00000001 (b2)
neq r1, r2			// r1 = 1 = (^b11:b2) = (r1 != r2) = (00000000 != 00000001) = 00000001
add r3, r0			// r3 = 197
ldr r2, r3			// r2 = data_mem[197] = 00000000 (b1)
neq r1, r2			// r1 = 1 = (^b11:b1) = (r1 != r2) = (00000001 != 00000000) = 00000001
addi r3, #7			// r3 = 204
addi r3, #6			// r3 = 210 (p8)
ldr r2, r3			// r2 = data_mem[210] = p8 = 00000000
neq r1, r2			// r1 = 1 = (^b11:b1)^p8 = (r1 != r2) = (00000001 != 00000000) = 00000001
addi r3, #1			// r3 = 211 (p4)
ldr r2, r3			// r2 = data_mem[211] = 00000001 (p4)
neq r1, r2			// r1 = 0 = (^b11:b1^p8)^p4 = (r1 != r2) = (00000001 != 00000001) = 00000000
addi r3, #1			// r3 = 212 (p2)
ldr r2, r3			// r2 = data_mem[212] = 00000000 (p2)
neq r1, r2			// r1 = 0 = (^b11:b1^p8^p4)^p2 = (r1 != r2) = (00000000 != 00000000) = 00000000
addi r3, #1			// r3 = 213 (p1)
ldr r2, r3			// r2 = data_mem[213] = 00000000 (p1)
neq r1, r2			// r1 = 0 = (^b11:b1^p8^p4^p2)^p1 = (r1 != r2) = (00000000 != 00000000) = 00000000
ldi r0, #5			// r0 = 5
neg r0, r0			// r0 = -5
add r3, r0			// r3 = 208
ldr r2, r3			// r2 = data_mem[208] = 00110000 (W.I.P. LSW) ('p16_end'):
or r2, r1			// r2 = r2 | r1 = (00110000 | 00000000) = 00110000
str r3, r2			// data_mem[208] = 00110000	(LSW DONE)
addi r3, #7 		// r3 = 215
addi r3, #1 		// r3 = 216
ldr r0, r3 			// r0 = data_mem[216] = 30 initially ('gen_word:')
ldi r3, #6          // r3 = 00000110
ls r3, #1			// r3 = 00001100
addi r3, #1         // r3 = 00001101
ls r3, #4           // r3 = 208 	
ldr r1, r3			// r1 = data_mem[208] (LSW)
str r0, r1			// data_mem[r0] = r1 (data_mem[30] initially) (store LSW)
addi r0, #1 		// r0 = 31
addi r3, #1 		// r3 = 209
ldr r1, r3			// r1 = data_mem[209] = 01101010
str r0, r1			// data_mem[31] = 01101010 (store MSW)
addi r0, #1			// r0 = 32
addi r3, #7      // r3 = 216
str r3, r0			// data_mem[216] = 32
ldi r1, #7 			// r1 = 00000111
ls r1, #3 			// r1 = 00111000
addi r1, #4 		// r1 = 60
ldi r2, #0 			// r2 = 0 (index into LUT for offset to "func1_loop")
neq r0, r1 			// r0 = (r0 != r1)
bnzl r2, r0 		// OFFSET: -370; r2 holds index into LUT and get offset to func1_loop (on line 19)
