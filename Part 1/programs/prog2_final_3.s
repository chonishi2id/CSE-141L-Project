ldi r0, #4  		// Func2_start: Prepare to load 64 = 1000000 
ls r0, #4
ldi r1, #7			// Prepare to store into data mem[225] = 111000001
ls r1, #5
addi r1, #1
str r1, r0			// store 64 for later
ldi r0, #5			// load 94 = 1011110
ls r0, #3
addi r0, #7
ls r0, #1
addi r1, #1     // Prepare to store into data mem[226] = 11100010 inc from 225
str r1, r0			// store 94 for later
ldi r3, #7      // Func2_loop: Prepare to load address 225 = 11100001 
ls r3, #5
addi r3, #1
ldr r0, r3			// Load current input address
ldr r1, r0			// Load LSW of input string into r1 
addi r0, #1			// Prepare to load MSW of input string
ldr r2, r0    	// Load MSW of input string into r2
addi r0, #1			// Increment input address for the next input if applicable
str r3, r0   		// store input address to use later
ldi r3, #6     	// Store LSW and MSW vals into memory Prepare to store into data mem195 = 11000011 and data mem[196] = 11000100
ls r3, #5			// Prepare to store into data mem195 = 11000011 and data mem[196] = 11000100
addi r3, #3
str r3, r1
addi r3, #1		 	// Prepare to store into dm196 inc from 195
str r3, r2
ls r1, #7				// p16 We're now on the LSW
rs r1, #7
addi r3, #1			// Prepare to store into dm197 inc from 196
str r3, r1
ldi r0, #6			// Prepare to load from dm195
ls r0, #5
addi r0, #3
ldr r1, r0
ls r1, #6				// p1
rs r1, #7
addi r3, #1			// Prepare to store into dm198 inc from 197
str r3, r1
ldr r1, r0
ls r1, #5				// p2
rs r1, #7
addi r3, #1			// Prepare to store into dm199 inc from 198
str r3, r1
ldr r1, r0
ls r1, #4				// b1
rs r1, #7
addi r3, #1			// Prepare to store into dm200 inc from 199
str r3, r1
ldr r1, r0
ls r1, #3				// p4
rs r1, #7
addi r3, #1			// Prepare to store into dm201 inc from 200
str r3, r1
ldr r1, r0
ls r1, #2				// b2
rs r1, #7
addi r3, #1			// Prepare to store into dm202 inc from 201
str r3, r1
ldr r1, r0
ls r1, #1				// b3
rs r1, #7
addi r3, #1			// Prepare to store into dm203 inc from 202
str r3, r1
ldr r1, r0
rs r1, #7				// b4
addi r3, #1 		// Prepare to store into dm204 inc from 203
str r3, r1		
ls r2, #7				// p8. We're now on MSB
rs r2, #7
addi r3, #1			// Prepare to store into dm205 inc from 204
str r3, r2
addi r0, #1     // Prepare to load from dm196 inc from 195
ldr r2, r0
ls r2, #6				// b5
rs r2, #7
addi r3, #1			// Prepare to store into dm206 inc from 205
str r3, r2
ldr r2, r0
ls r2, #5				// b6
rs r2, #7
addi r3, #1			// Prepare to store into dm207 inc from 206
str r3, r2
ldr r2, r0
ls r2, #4				// b7
rs r2, #7
addi r3, #1			// Prepare to store into dm208 inc from 207
str r3, r2
ldr r2, r0
ls r2, #3				// b8
rs r2, #7
addi r3, #1			// Prepare to store into dm209 inc from 208
str r3, r2
ldr r2, r0
ls r2, #2				// b9
rs r2, #7
addi r3, #1			// Prepare to store into dm210 inc from 209
str r3, r2
ldr r2, r0
ls r2, #1				// b10
rs r2, #7
addi r3, #1			// Prepare to store into dm211 inc from 210
str r3, r2
ldr r2, r0
rs r2, #7				// b11			
addi r3, #1			// Prepare to store into dm212 inc from 211
str r3, r2
ldr r0, r3			// p8_exp: b11^b10
ldi r2, #1			// Load from dm212
neg r2, r2
add r3, r2  		// Load from dm211 dec from 212
ldr r1, r3
neq r0, r1  
add r3, r2  		// b11^b10^b9        
ldr r1, r3			//Load from dm210
neq r0, r1
add r3, r2			// (b11^b10^b9)^b8  
ldr r1, r3			// Load from dm209
neq r0, r1
add r3, r2			// ^b11:b8^b7  
ldr r1, r3			// Load from dm208
neq r0, r1 
add r3, r2			// ^b11:b7^b6 
ldr r1, r3			// Load from dm207
neq r0, r1
add r3, r2			// ^b11:b6^b5 
ldr r1, r3			// Load from dm206
neq r0, r1
addi r3, #7 		// p8_comparison: Prepare to store into dm213 by inc 7 from 206
str r3, r0 			//store expected p8 in address 213
ldi r3, #5			//Prepare to load given p8 from dm205 = 110101101
ls r3, #3
addi r3, #3
ls r3, #2
addi r3, #1
ldr r1, r3
eq r0, r1 			//check if parity bits match
ldi r3, #6			// Prepare to load from dm220
ls r3, #3
addi r3, #7
ls r3, #3
str r3, r0 			//store result in address 220
ldi r3, #6			// p4_exp: b11^b10
ls r3, #3
addi r3, #5
ls r3, #2			//Prepare to load from dm212 = 11010100 dec from 213
ldr r0, r3
addi r3, r2   	// dec to load dm211
ldr r1, r3
neq r0, r1
addi r3, r2   	// b11^b10^b9
ldr r1, r3			// dec to load dm210
neq r0, r1
addi r3, r2			// (b11^b10^b9)^b8
ldr r1, r3			// dec to load dm209
neq r0, r1
ldi r3, #6			// ^b11:b8^b4
ls r3, #3			// Prepare to load from dm204 = 11001100
addi r3, #3
ls r3, #2
ldr r1, r3
neq r0, r1
addi r3, r2			// ^b11:b8^b4^b3
ldr r1, r3			// dec to load dm203
neq r0, r1
addi r3, r2			// ^b11:b8^b4^b3^b2
ldr r1, r3			// dec to load dm202
neq r0, r1 
addi r3, r2 		// p4_comparison: dec to load dm201 a few instructions later
ldi r2, #6  		// Prepare to store into 214
ls r2, #3
addi r2, #5
ls r2, #2
addi r2, #2
str r2, r0 			//store expected p4 in address 214
ldr r1, r3			// loading given p4 from dm[201] 
eq r0, r1 			//check if parity bits match
ldi r3, #6			// Prepare to store into dm221 = 11011101
ls r3, #5
ldi r3, #7
ls r3, #2
addi r3, #1
str r3, r0 		//store result in address 221
ldi r2, #6			// p2_exp: Prepare to load from dm212 = 11010100
ls r2, #3			// b11^b10
addi r2, #5
ls r2, #3
ldr r0, r2
ldi r3, #1			// dec to load dm211
neg r3, r3
add r2, r3		
ldr r1, r2
neq r0, r1
ldi r2, #6			// b11^b10^b7   
ls r2, #3			// Prepare to load from dm208 = 11010000
addi r2, #4
ls r2, #3
ldr r1, r2
neq r0, r1
addi r2, r3			// (b11^b10^b7)^b6
ldr r1, r2			// dec to load dm207
neq r0, r1
ldi r2, #6			// b11^b10^b7^b6^b4
ls r2, #3			// Prepare to load from dm204 = 11001100
addi r2, #3
ls r2, #3
ldr r1, r2
neq r0, r1
addi r2, r3			// b11^b10^b7^b6^b4^b3
ldr r1, r2			// dec to load dm203
neq r0, r1
ldi r2, #6			// b11^b10^b7^b6^b4^b1
ls r2, #3			// Prepare to load from dm200 = 110010000
addi r2, #2
ls r2, #3
ldr r1, r2
neq r0, r1 
ldi r2, #6			// p2_comparison: Prepare to load from dm215 = 11010111
ls r2, #3
addi r2, #5
ls r2, #3
addi r2, #3
str r2, r0 			//store expected p2 in address 215
ldi r2, #6  		// prep to load actual p8 from dm199 = 11000111
ls r2, #4
addi r2, #7
ldr r1, r2 
eq r0, r1 			//check if parity bits match
ldi r2, #6			// prep to load from dm222 = 11011110
ls r2, #3
addi r2, #7
ls r2, #3
addi r2, #2
str r2, r0 			//store result in address 222
ldi r2, #6			// p1_exp: Prepare to load from dm212 = 11010100
ls r2, #3			// b11^b9
addi r2, #5
ls r2, #3
ldr r0, r2
ldi r3, #2
neg r3, r3
add r2, r3			// dec by 2 to load from dm210
ldr r1, r2
neq r0, r1
add r2, r3			// b11^b9^b7        
ldr r1, r2			// dec by 2 to load from dm208
neq r0, r1
add r2, r3			// (b11^b9^b7)^b5  
ldr r1, r2			// dec by 2 to load from dm206
neq r0, r1
add r2, r3			// b11^b9^b7^b5^b4
ldr r1, r2			// dec by 2 to load from dm204
neq r0, r1
add r2, r3			// b11^b9^b7^b5^b4^b2
ldr r1, r2			// dec by 2 to load from dm202
neq r0, r1
add r2, r3			// b11^b9^b7^b5^b4^b2^b1
ldr r1, r2			// dec by 2 to load from dm200
neq r0, r1
ldi r2, #6			// p1_comparison: Prep to load from dm216 = 11011000
ls r2, #3
addi r2, #6
ls r2, #3
str r2, r0 			//store expected p1 in address 216
ldi r3, #6			// Prep to load given p1 from dm198 = 11000110
ls r3, #5
addi r3, #6
ldr r1, r3 
eq r0, r1 			//check if parity bits match
addi r2, #7			// Prep to store to dm223 by inc 7 from 216
str r3, r0 			//store result in address 223
ldi r2, #6			// p16_loop: Prep dm205 = 11001101
ls r2, #3			// p8^b4
addi r2, #3
ls r2, #2
addi r2, #1
ldr r0, r2
ldi r3, #1			// Prep dm204 by dec 1
neg r3, r3
add r2, r3
ldr r1, r2
neq r0, r1
add r2, r3			// p8^b4^b3
ldr r1, r2			// Prep dm203 by dec 1
neq r0, r1
add r2, r3			// p8^(b4:b2)
ldr r1, r2			// Prep dm202 by dec 1
neq r0, r1
add r2, r3			// p8^(b4:b2)^p4
ldr r1, r2			// Prep dm201 by dec 1
neq r0, r1
add r2, r3			// p8^(b4:b1)^p4
ldr r1, r2			// Prep dm 200 by dec 1
neq r0, r1
add r2, r3			// p8^(b4:b1)^p4^p2
ldr r1, r2			// Prep dm199 by dec 1
neq r0, r1
add r2, r3			// p8^(b4:b1)^p4^p2^p1
ldr r1, r2			// Prep dm198 by dec 1
neq r0, r1
addi r2, #7			// p8^(b4:b1)^p4^p2^p1^p8
ldr r1, r2			// Prep 205 by inc 7 from 198
neq r0, r1
ldi r2, #6			// p16_comparison: Prep to load dm217 = 11011001
ls r2, #3
addi r2, #6
ls r2, #2
addi r2, #1
str r2, r0 			// store expected p16 in address 220
ldi r2, #6			// Prep to load given p16 at dm197 = 11000101
ls r2, #5
addi r2, #5
ldr r1, r2 
eq r0, r1 			// check if parity bits match
ldi r2, #7			// Prep to load dm224 = 11100000
ls r2, #5
str r2, r0 			// store result in address 224
ldi r2, #0			// check_error: r2 will store number of errors
ldi r3, #6   		// Prep to load p8 from dm220 = 11011100
ls r3, #3
addi r3, #7
ls r3, #2
ldr r0, r3 			// get result of comparing expected parity with actual parity
add r2, r0
addi r3, #1			// inc 220 to load p4 from dm221
ldr r0, r3 			// get result of comparing expected parity with actual parity
add r2, r0
addi r3, #1			// inc 221 to load p2 from dm222
ldr r0, r3 			//get result of comparing expected parity with actual parity
add r2, r0
addi r3, #1			// inc 222 to load p1 from dm223
ldr r0, r3 			//get result of comparing expected parity with actual parity
add r2, r0
ldi r1, #4			// check number of errors
ldr r0, r2			// if number of errors == 0
ldi r3, #6			// Jump by 48 = 110000 to output
ls r3, #3
eq r0, r1				// If r0 == r1, r0 = 1
bnzr r3, r0   	// Jump by value in r3 if r0 = 1.
ldi r1, #3			// if number of errors == 1
ldi r3, #1			// To error Correction: Jump by 8
ls r3, #3
ldr r0, r2			// reload num errors
eq r0, r1				// If r0 == r1, r0 = 1
bnzr r3, r0			// Jump by value in r3 if r0 = 1
ldi r1, #2			// if number of errors == 2
ldi r3, #7  		// To error_detection: 30 lines
ls r2, #2
addi r2, #2
ldr r0, r2			// reload num errors
eq r0, r1
bnzr r3, r0			// Jump by value in r3 if r0 = 1
ldi r3, #6   		// error_correction: Prep to load dm220 = 11011100
ls r3, #3
addi r3, #7
ls r3, #2
ldr r0, r3
ls r0, #1
addi r3, #1	 		// Inc to load dm221
ldr r1, r3
or r0, r1
ls r0, #1
addi r3, #1			// Inc to load dm222
ldr r1, r3
or r0, r1
ls r0, #1
addi r3, #1			// Inc to load dm223
ldr r1, r3
or r0, r1
ldi r1, #6			// Find the incorrect bit and flip it: load 197 = 11000101 as that's where p16 is
ls r1, #5
addi r1, #5
add r1, r0
ldr r2, r1
ldi r0, #0
eq r2, r1				// if incorrect bit = 1, eq(1, 0) gives us 0. If incorrect bit = 0, eq(0, 0) gives us 1
str r1, r2  
ldi r1, #0			
ldi r3, #6			// jump output by 6
eq r0, r1				// r0 = 1 if r0 == r1
bnzr r3, r0 		// Jump by value in r3 if r0 = 1
ldi r2, #1			// error_detection: if p16 is correct as expected then there is a two-bit error
ldi r3, #7			// load result of comparing expected parity with actual parity 
ls r3, #5			// Prep to load dm224 = 11100000
ldr r0, r3
eq r2, r0				// if p16_exp == p16	we assume we do nothing if two errors are detected from a Piazza post
ldi r2, #6			// output: Start with LSW. Prep to load dm209 = 11010001
ls r2, #3			// Prep to laod b8 from dm 209 = 11010001
addi r2, #4
ls r2, #2
addi r2, #1
ldr r0, r2
ls r0, #1
ldi r3, #1			// Dec to load b7 from dm208
neg r3, r3
add r2, r3
ldr r1 r2
or r0, r1
ls r0, #1
add r2, r3			// Dec to load b6 from dm207
ldr r1, r2
or r0, r1
ls r0, #1
add r2, r3			// Dec to load b5 from dm206
ldr r1, r2
or r0, r1
ls r0, #1
add r2, r3			// Dec x2 to load b4 from dm204
add r2, r3
ldr r1, r2
or r0, r1
ls r0, #1
add r2, r3			// Dec to load b3 from dm203
ldr r1, r2
or r0, r1
ls r0, #1
add r2, r3			// Dec to load b2 from dm202
ldr r1, r2
or r0, r1
ls r0, #1
add r2, r3			// Dec x2 to load b1 from dm200
add r2, r3
ldr r1, r2
or r0, r1
ldi r2, #7			// prep to load LSW output address from dm226=11100010
ls r2, #5
addi r2, #2
ldr r1, r2
str r1, r0			// store LSW in output address
addi r1, #1			// increment output address
ldi r2, #6			// MSW: prep to load b11 from dm212 = 11010100
ls r2, #3
addi r2, #5
ls r2, #2
ldr r0, r2
ls r0, #1
ldi r3, #1
neg r3, r3
add r2, r3			// dec to load b10 from dm211
ldr r3, r2
or r0, r3
ls r0, #1
ldi r3, #1
neg r3, r3
add r2, r3			// dec to load b9 from dm210
ldr r3, r2
or r0, r3
str r1, r0			// We already have output address in r1 so we use it to store MSW
addi r1, #1			// increment output address
ldi r2, #7			// prep to load dm226=11100010 to store output address
ls r2, #5
addi r2, #2
str r2, r1
ldi r0, #7			// check if we're done by loading final output address: 124 = 01111100
ls r0, #3
addi r0, #6
ls r0, #1
ldi r3, #1			// To Func 2 loop. Use the lut
neq r0, r1
bnzl r3, r1			// jump to lutr3 if r1 =1 0