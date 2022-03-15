	ldi r0, 0  			// 'Func1_start:'
	ldi r1, 6          	// 6 = 00000110
	ls r1, 1			// 12 = 00001100
	addi r1, 1         	// 13 = 00001101
	ls r1, 4           	// 208 = 11010000	
	addi r1, 7         	// r1 = 215 = 11010111
	str r0, r1		    // store 0 into datamem[215] for later
	ldi r2, 7   		// 7 = 00000111
	ls r2, 2    		// 28 = 00011100
	addi r2, 2  		// r2 = 30 = 00011110
	ldi r0, r2			// load data mem[30]
	addi r1, 1  		// r1 = 216
	str r0, r1			// store data mem[30] for later
	ldi r2, 6   		// 6 = 00000110
	ls r2, 1			// 12 = 00001100
	addi r2, 1  		// 13 = 00001101
	ls r2, 4    		// 208 = 11010000	
	addi r2, 7			// r2 = 215
	ldr r0, r2			// 'Func1_loop:'
	ldr r1, r0			// Load LSW of input string into r1 
	addi r0, 1			// Prepare to load MSW of input string
  	ldr r2, r0    		// Load MSW of input string into r2
	addi r0, 1			// Increment input address for the next input if applicable
	ldi r3, 6          	// 6 = 00000110
	ls r3, 1			// 12 = 00001100
	addi r3, 1         	// 13 = 00001101
	ls r3, 4           	// 208 = 11010000	
	addi r3, 7         	// r3 = 215 = 11010111
	str r0, r3   		// store input address to use later
	ldi r3, 3  			//00000011
	ls r3, 6   			//11000000
	addi r3, 3 			// r3 = 195 = 11000011
	str r1, r3
	addi r3, 1 			//r3 = 196
	str r2, r3
	ls r1, 7 			// b1
	rs r1, 7
	addi r3, 1 			//r3 = 197
	str r1, r3
	ldi r2, 3  			//00000011
	ls r2, 6   			//11000000
	addi r2, 3 			// r2 = 195 = 11000011
	ldr r1, r2
	ls r1, 6 			//b2
	rs r1, 7
	addi r3, 1 			//r3 = 198
	str r1, r3
	ldr r1, r2
	ls r1, 5 			//b3
	rs r1, 7
	addi r3, 1 			//r3 = 199
	str r1, r3
	ldr r1, r2
	ls r1, 4 			//b4
	rs r1, 7
	addi r3, 1 			//r3 = 200
	str r1, r3
	ldr r1, r2
	ls r1, 3 			//b5
	rs r1, 7
	addi r3, 1 			//r3 = 201
	str r1, r3
	ldr r1, r2
	ls r1, 2 			//b6
	rs r1, 7
	addi r3, 1 			//r3 = 202
	str r1, r3
	ldr r1, r2
	ls r1, 1 			//b7
	rs r1, 7
	addi r3, 1 			//r3 = 203
	str r1, r3
	ldr r1, r2
	rs r1, 7 			//b8
	addi r3, 1 			//r3 = 204
	str r1, r3
	addi r2, 1 			//r2 = 196
	ldr r2, r2 			//load back value of MSW from datamem[196]
	ls r2, 7 			//b9 (We aare now on the MSB)
	rs r2, 7
	addi r3, 1 			//r3 = 205
	str r2, r3
	ldi r1, 3  			//00000011
	ls r1, 6   			//11000000
	addi r1, 2			// r1 = 196
	ldr r2, r1
	ls r2, 6 			//b10
	rs r2, 7
	addi r3, 1 			//r3 = 206
	str r2, r3
	ldr r2, r1
	rs r2, 2 			//b11
	addi r3, 1 			//r3 = 207
	str r2, r3
	ldr r2, r1
	ldi r2, r3 			//'p8_loop:'
	ldr r0, r2
	ldi r1, 1
	neg r1, r1 			//(r1 = -1)
	add r2, r1
	ldr r1, r2
	neq r0, r1 
	ldi r1, 1
	neg r1, r1 			//(r1 = -1)
	add r2, r1 			// (b11^b10)^b9 
	ldr r1, r2
	neq r0, r1
	ldi r1, 1
	neg r1, r1 			//(r1 = -1)
	add r2, r1
	ldr r1, r2
	ldi r1, 1
	neg r1, r1 			//(r1 = -1)
	add r2, r1
	ldr r1, r2
	neq r0, r1 
	ldi r1, 1
	neg r1, r1 			//(r1 = -1)
	add r2, r1
	ldr r1, r2
	neq r0, r1
	ldi r1, 1
	neg r1, r1 			//(r1 = -1)
	add r2, r1
	ldr r1, r2
	neq r0, r1
	addi r3, 3 			//r3 = 210
	str r0, r3 			//'p8_end:'
	ldi r0, 1
	neg r0, r0 			//r0 = -3
	add r3, r0 			//r3 = 207
	ldr r1, 207			// b11
	ls r1, 1
	ldi r0, 1
	neg r0, r0 			//r0 = -1
	add r3, r0 			//r3 = 206
	ldr r2, r3 			// b10
	or r1, r2			
	ls r1, 1			
	add r3, r0 			//r3 = 205
	ldr r2, r3 			// b9
	or r1, r2			
	ls r1, 1			
	add r3, r0 			//r3 = 204
	ldr r2, r3 			// b8
	or r1, r2			
	ls r1, 1			
	add r3, r0 			//r3 = 203
	ldr r2, r3 			// b7
	or r1, r2			
	ls r1, 1			
	add r3, r0 			//r3 = 202
	ldr r2, r3 			// b6
	or r1, r2			
	ls r1, 1			
	add r3, r0 			//r3 = 201
	ldr r2, r3 			// b5
	or r1, r2
	ls r1, 1
	ldi r3, 6          	// 6 = 00000110
	ls r3, 1			// 12 = 00001100
	addi r3, 1         	// 13 = 00001101
	ls r3, 4           	// 208 = 11010000	
	addi r3, 2 			//r3 = 210
	ldr r0, r3
	or r1, r0 			// insert p8 here. Now the MSW is finished
	ls r1, 1
	ldi r3, 6          	// 6 = 00000110
	ls r3, 1			// 12 = 00001100
	addi r3, 1         	// 13 = 00001101
	ls r3, 4           	// r3 = 208 
	str r1, r3
	ldi r0, 1
	neg r0, r0 			//r0 = -1
	add r3, r0 			//r3 = 207
	ldr r2, r3 			//'p4_loop:'
	ldr r0, r2
	ldi r3, 1
	neg r3, r3 			//r3 = -1
	add r2, r3
	ldr r1, r2
	neq r0, r1      
	addi r2, r3
	ldr r1, r2
	neq r0, r1  
	addi r2, r3 		// r2 = r2 -1
	ldr r1, r2
	neq r0, r1
	ldi r2, 6 			// 00000110
	ls r2, 2 			// 00011000
	addi r2, 1 			// 00011001
	ls r2, 3 			//r2 = 200 = 11001000
	ldr r1, r2
	neq r0, r1
	addi r2, r3
	ldr r1, r2
	neq r0, r1
	addi r2, r3
	ldr r1, r2
	neq r0, r1 
	addi r2, 7 			//r2 = 207
	addi r2, 4 			//r2 = 211
	str r0, r2 			//'p4_end:'
	ldi r2, 6 			// 00000110
	ls r2, 2 			// 00011000
	addi r2, 1 			// 00011001
	ls r2, 3 			//r2 = 200 = 11001000
	ldr r1, r2
	ls r1, 1
	addi r2, r3 		//r2 = 199
	ldr r2, r2
	or r1, r2
	ls r1, 1
	ldi r3, 3  			//00000011
	ls r3, 6   			//11000000 = 192
	addi r3, 6 			// r3 = 198
	ldr r2, r3
	or r1, r2
	ls r1, 1	
	or r1, r0
	ls r1, 1
	ldi r3, 6          	// 6 = 00000110
	ls r3, 1			// 12 = 00001100
	addi r3, 1         	// 13 = 00001101
	ls r3, 4           	// 208 = 11010000	
	addi r3, 1 			//r3 = 209
	str r1, r3
	ldi r2, 6 			// 00000110
	ls r2, 2 			// 00011000
	addi r2, 1 			// 00011001
	ls r2, 3 			//r2 = 200 = 11001000
	addi r2, 7 			//r2 =207
	ldr r0, r2
	ldi r3, 1
	neg r3, r3 			// r3 = -1
	add r2, r3 			//r2 = 206
	ldr r1, r2			
	neq r0, r1			
	ldi r3, 3			
	neg r3, r3 			// r3 = -3
	add r2, r3 			//r2 = 203
	ldr r1, r2			
	neq r0, r1			
	ldi r3, 1			
	neg r3, r3 			// r3 = -1
	add r2, r3 			//r2 = 202
	ldr r1, r2			
	neq r0, r1			
	ldi r3, 2			
	neg r3, r3 			// r3 = -2
	add r2, r3 			//r2 = 200
	ldr r1, r2			
	neq r0, r1			
	ldi r3, 1			
	neg r3, r3 			// r3 = -1
	add r2, r3 			//r2 = 199
	ldr r1, r2			
	neq r0, r1			
	ldi r3, 2			
	neg r3, r3 			// r3 = -2
	add r2, r3 			//r2 = 197
	ldr r1, r2
	neq r0, r1 
	ldi r2, 6 			// 00000110
	ls r2, 2 			// 00011000
	addi r2, 1 			// 00011001
	ls r2, 3 			// 200
	addi r2, 7 			// 207
	addi r2, 5 			// r2 = 212
	str r0, r2 			//'p2_end:'
	ldi r3, 3			
	neg r3, r3 			// r3 = -3
	add r2, r3 			//r2 = 209
	ldr r1, r2			
	ldi r3, 3  			//00000011
	ls r3, 6   			//11000000
	addi r3, 5 			// r3 = 197
	ldr r2, r3
	or r1, r2
	ls r1, 1
	or r1, r0
	ls r1, 1
	ldi r3, 6          	// 6 = 00000110
	ls r3, 1			// 12 = 00001100
	addi r3, 1         	// 13 = 00001101
	ls r3, 4           
	addi r3, 1  		// r3 = 209
	str r1, r3
	ldi r0, 2
	neg r0, r0 			// r0 = -2
	add r3, r0 			//r3 = 207
	ldr r2, r3 			//r2 = 207 //'p1_loop:'
	ldr r0, r2			
	ldi r3, 2			
	neg r3, r3 			// r3 = -2
	add r2, r3 			//r2 = 205
	ldr r1, r2			
	neq r0, r1 			  
	ldi r3, 2			
	neg r3, r3 			// r3 = -2
	add r2, r3 			//r2 = 203
	ldr r1, r2			
	neq r0, r1			
	ldi r3, 2			
	neg r3, r3 			// r3 = -2
	add r2, r3 			//r2 = 201
	ldr r1, r2			
	neq r0, r1			
	ldi r3, 1			
	neg r3, r3 			// r3 = -1
	add r2, r3 			//r2 = r2 - 1 = 200
	ldr r1, r2			
	neq r0, r1			
	ldi r3, 2			
	neg r3, r3 			// r3 = -2
	add r2, r3 			//r2 = 198
	ldr r1, r2			
	neq r0, r1			
	ldi r3, 1			
	neg r3, r3 			// r3 = -1
	add r2, r3 			//r2 = r2 - 1 = 197
	ldr r1, r2
	neq r0, r1
	ldi r3, 6          	// 6 = 00000110
	ls r3, 1			// 12 = 00001100
	addi r3, 1         	// 13 = 00001101
	ls r3, 4           	// 208 = 11010000	
	addi r3, 5 			//r3 = 213
	str r0, r3 			//'p1_end:'
	ldi r3, 6          	// 6 = 00000110
	ls r3, 1			// 12 = 00001100
	addi r3, 1         	// 13 = 00001101
	ls r3, 4           	// 208 = 11010000	
	addi r3, 1 			//r3 = 209
	ldr r1, r3
	or r1, r0 			// insert p1 here
	ls r1, 1
	str r1, r3 			//r3 = 209
	ldi r2, 6 			// 00000110
	ls r2, 2 			// 00011000
	addi r2, 1 			// 00011001
	ls r2, 3 			//r2 = 200 = 11001000
	addi r2, 7 			//r2 =207
	ldr r0, r2
	ldi r3, 1
	neg r3, r3 			// r3 = -1
	add r2, r3 			//r2 = r2 - 1 = 206
	ldr r1, r2			
	neq r0, r1			
	add r2, r3 			//r2 = r2 - 1 = 205     
	ldr r1, r2			
	neq r0, r1			
	add r2, r3 			//r2 = r2 - 1 = 204
	ldr r1, r2			
	neq r0, r1			
	add r2, r3 			//r2 = r2 - 1 = 203    
	ldr r1, r2			
	neq r0, r1 			
	add r2, r3 			//r2 = r2 - 1 = 202    
	ldr r1, r2			
	neq r0, r1			
	add r2, r3 			//r2 = r2 - 1 = 201   
	ldr r1, r2			
	neq r0, r1 			
	add r2, r3 			//r2 = r2 - 1 = 200 
	ldr r1, r2			
	neq r0, r1			
	add r2, r3 			//r2 = r2 - 1 = 199 
	ldr r1, r2			
	neq r0, r1			
	add r2, r3 			//r2 = r2 - 1 = 198
	ldr r1, r2			
	neq r0, r1 			
	add r2, r3 			//r2 = r2 - 1 = 197
	ldr r1, r2
	neq r0, r1
	ldi r2, 6          	// 6 = 00000110
	ls r2, 1			// 12 = 00001100
	addi r2, 1         	// 13 = 00001101
	ls r2, 4           	// 208 = 11010000	
	addi r2, 2 			//r2 = 210
	ldr r1, r2
	neq r0, r1
	addi r2, 1
	ldr r1, r2
	neq r0, r1
	addi r2, 1
	ldr r1, r2
	neq r0, r1
	addi r2, 1
	ldr r1, r2
	neq r0, r1
	ldi r3, 6          	// 6 = 00000110
	ls r3, 1			// 12 = 00001100
	addi r3, 1         	// 13 = 00001101
	ls r3, 4           	// 208 = 11010000	
	addi r3, 1 			//r3 = 209
	ldr r1, r3 			//'p16_end:'
	or r1, r0			
	str r1, r3			
	addi r3, 7 			//r3 = 215
	addi r3, 1 			//r3 = 216
	ldr r0, r3 			//'gen_word:'
	ldi r3, 6          	// 6 = 00000110
	ls r3, 1			// 12 = 00001100
	addi r3, 1         	// 13 = 00001101
	ls r3, 4           	// r3 = 208 	
	ldr r1, r3
	str r1, r0
	addi r0, 1 			// store msw
	addi r3, 1 			//r3 = 209
	ldr r1, r3
	str r1, r0
	addi r0, 1
	ldi r3, 6          	// 6 = 00000110
	ls r3, 1			// 12 = 00001100
	addi r3, 1         	// 13 = 00001101
	ls r3, 4           	// 208 = 11010000	
	addi r3, 7         	// 215
	addi r3, 1         	// r3 = 216
	str r0, r3
	ldi r1, 7 			//00000111
	ls r1, 3 			// 00111000
	addi r1, 3 			// r1 = 59 = 00111011
	ldr r2, Func1_loop 	// change with index into LUT
	neq r0, r1 			// r0 = (r0 != r1)
	bnzl r2, r0 		//OFFSET: -408; r2 holds offset to index LUT and get offset to func1_loop (on line 19)