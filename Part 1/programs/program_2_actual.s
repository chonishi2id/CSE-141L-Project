// loads are assumed to load from second register into first register. ldr r0, r3 loads address at r3 into r0
// stores are assumed to store from first register into second register. str r0, r3 stores contents of r0 into address at r3
// Describe Hardware to assembler
	.arch armv6
	.cpu  cortex-a53
	.syntax unified
// Constants
// For brevity, we'll just call everything by its decimal number
Func2_start:
	// Registers available: r0 - r2
	// load from data mem64:93 store to data mem[94:123]
	ldi r0, 4  			// Prepare to load data mem[64] = 1000000
	ls  r0, 4
	ldi r1, 7				// Prepare to store into data mem[224] = 11100000 
	ls	r1, 5
	str r0, r1			// store data mem[64] for later
	ldi r0, 5				// load data mem[94] = 1011110
	ls  r0, 3
	addi r0, 7
	ls  r0, 1
	addi r1, 1     	// Prepare to store into data mem[225] = 11100001 using what we had
	str r0, r1			// store data mem[30] for later

Func2_loop:
	ldi r3, 6      	// Prepare to load address 221 = 11011101
	ls  r3, 3
	addi r3, 7
	ls  r3, 2
	addi r3, 1
	ldr r0, r3			// Load current input address
	ldr r1, r0			// Load LSW of input string into r1 

	addi r0, 1			// Prepare to load MSW of input string
  ldr r2, r0    	// Load MSW of input string into r2

	addi r0, 1			// Increment input address for the next input if applicable
	str r0, r3   		// store input address to use later

	// store LSW and MSW vals into memory.
	ldi r3, 6     	// Prepare to store into data mem195 = 11000011 and data mem[196] = 11000100
	ls  r3, 5
	addi r3, 3
	str r1, r3
	addi r3, 1		 	// Prepare to store into dm196 inc from 195
	str r2, r3

	// store each individual bit of the string into its own memory address
	// p16 We're now on the LSB
	ls r1, 7
	rs r1, 7
	addi r3, 1			// Prepare to store into dm197 inc from 196
	str r1, r3
	ldi r0, 6				// Prepare to load from dm195
	ls 	r0, 5
	addi r0, 3
	ldr r1, r0

	//p1
	ls r1, 6
	rs r1, 7
	addi r3, 1			// Prepare to store into dm198 inc from 197
	str r1, r3
	ldr r1, r0

	//p2
	ls r1, 5
	rs r1, 7
	addi r3, 1			// Prepare to store into dm199 inc from 198
	str r1, r3
	ldr r1, r0

	//b1
	ls r1, 4
	rs r1, 7
	addi r3, 1			// Prepare to store into dm200 inc from 199
	str r1, r3
	ldr r1, r0

	//p4
	ls r1, 3
	rs r1, 7
	addi r3, 1			// Prepare to store into dm201 inc from 200
	str r1, r3
	ldr r1, r0

	//b2
	ls r1, 2
	rs r1, 7
	addi r3, 1			// Prepare to store into dm202 inc from 201
	str r1, r3
	ldr r1, r0

	//b3
	ls r1, 1
	rs r1, 7
	addi r3, 1			// Prepare to store into dm203 inc from 202
	str r1, r3
	ldr r1, r0

	//b4
	rs r1, 7
	addi r3, 1 			// Prepare to store into dm204 inc from 203
	str r1, r3		

	//p8 We're now on the MSB
	ls r2, 7
	rs r2, 7
	addi r3, 1			// Prepare to store into dm205 inc from 204
	str r1, r3
	addi r0, 1     	// Prepare to load from dm196 inc from 195
	ldr r1, r0


	//b5
	ls r2, 6
	rs r2, 7
	addi r3, 1			// Prepare to store into dm206 inc from 205
	str r1, r3
	ldr r1, r0

	//b6
	ls r2, 5
	rs r2, 7
	addi r3, 1			// Prepare to store into dm207 inc from 206
	str r1, r3
	ldr r1, r0

	//b7
	ls r2, 4
	rs r2, 7
	addi r3, 1			// Prepare to store into dm208 inc from 207
	str r1, r3
	ldr r1, r0

	//b8
	ls r2, 3
	rs r2, 7
	addi r3, 1			// Prepare to store into dm209 inc from 208
	str r1, r3
	ldr r1, r0

	//b9
	ls r2, 2
	rs r2, 7
	addi r3, 1			// Prepare to store into dm210 inc from 209
	str r1, r3
	ldr r1, r0

	//b10
	ls r2, 1
	rs r2, 7
	addi r3, 1			// Prepare to store into dm211 inc from 210
	str r1, r3
	ldr r1, r0

	//b11
	rs r2, 7
	addi r3, 1			// Prepare to store into dm212 inc from 211
	str r2, r3

p8_exp:
	// b11^b10
	ldr r0, r3			// Load from dm212
  ldi r1, 1
	eq r0, r1				// Flag: Don't know if this is correct given other code
	
	ldi r2, 1
	neg r2, r2
	add r3, r2  		// Load from dm211 dec from 212
	ldr r1, r3
	neq r0, r1  
	// b11^b10^b9        
	add r3, r2  		// Load from dm210
	ldr r1, r3
	neq r0, r1
	// (b11^b10^b9)^b8  
	addi r3, r2			// Load from dm209
	ldr r1, r3
	neq r0, r1
	// ^b11:b8^b7  
	addi r3, r2			// Load from dm208
	ldr r1, r3
	neq r0, r1 
	// ^b11:b7^b6 
	addi r3, r2			// Load from dm207
	ldr r1, r3
	neq r0, r1
	// ^b11:b6^b5 
	addi r3, r2			// Load from dm206
	ldr r1, r3
	neq r0, r1

p8_comparison:
	ldi r2, 6				// Prepare to store into dm213 = 11010101
	ls  r2, 3
	addi r2, 5
	ls 	r2, 2
	addi r2, 1
	str r0, r3 			//store expected p8 in address 213
	//compare actual parity with expected parity
	// load p8
	ldi r3, 5				//Prepare to load from dm205 = 110101101
	ls	r3, 3
	addi r3, 3
	ls	r3, 2
	addi r3, 1
	ldr r1, r3
	eq r0, r1 			//check if parity bits match
	ldi r3, 6				// Prepare to load from dm220
	ls	r3, 3
	addi r3, 7
	ls	r3, 3
	str r0, r3 			//store result in address 220

p4_exp:
	// p4 = ^b11:b8, b4, b3, b2
	// b11^b10
	ldi r3, 1
	neg r3, r3
	addi r2, r3			//Prepare to load from dm212 = 11010100 dec from 213
	ldr r0, r2
	addi r2, r3   	// dec to load dm211
	ldr r1, r2
	neq r0, r1
	// b11^b10^b9        
	addi r2, r3   	// dec to load dm210
	ldr r1, r2
	neq r0, r1
	// (b11^b10^b9)^b8  
	addi r2, r3			// dec to load dm209
	ldr r1, r2
	neq r0, r1
	// ^b11:b8^b4
	ldi r2, 6				// Prepare to load from dm204 = 11001100
	ls	r2, 3
	addi r2, 3
	ls	r2, 2
	ldr r1, r2
	neq r0, r1
	// ^b11:b8^b4^b3
	addi r2, r3			// dec to load dm203
	ldr r1, r2
	neq r0, r1
	// ^b11:b8^b4^b3^b2
	addi r2, r3			// dec to load dm202
	ldr r1, r2
	neq r0, r1 

p4_comparison:
	addi r2, r3 		// dec to load dm201 a few instructions later
	ldi r3, 6  			// Prepare to store into 214
	ls 	r3, 3
	addi r3, 5
	ls  r3, 2
	addi r3, 2
	str r0, r3 			//store expected p4 in address 214
	//compare actual parity with expected parity
	// load p4
	ldr r1, r2			// loading from dm[201] 
	eq r0, r1 			//check if parity bits match
	ldi r3, 6				// Prepare to store into dm221 = 11011101
	ls	r3, 5
	ldi r3, 7
	ls	r3, 2
	addi r3, 1
	str r0, 221 		//store result in address 221

p2_exp:
	// p2 = ^b11, b10, b7, b6, b4, b3, b1
	// b11^b10
	ldi r2, 6				// Prepare to load from dm212 = 11010100
	ls	r2, 3
	addi r2, 5
	ls	r2, 3
	ldr r0, r2

	ldi r3, 1				// dec to load dm211
	neg r3, r3
	add r2, r3		

	ldr r1, r2
	neq r0, r1
	// b11^b10^b7   
	ldi r2, 6				// Prepare to load from dm208 = 11010000
	ls	r2, 3
	addi r2, 4
	ls	r2, 3
	ldr r1, r2
	neq r0, r1
	// (b11^b10^b7)^b6  
	addi r2, r3			// dec to load dm207
	ldr r1, r2
	neq r0, r1
	// b11^b10^b7^b6^b4
	ldi r2, 6				// Prepare to load from dm204 = 11001100
	ls	r2, 3
	addi r2, 3
	ls	r2, 3
	ldr r1, r2
	neq r0, r1
	// b11^b10^b7^b6^b4^b3
	addi r2, r3			// dec to load dm203
	ldr r1, r2
	neq r0, r1
	// b11^b10^b7^b6^b4^b1
	ldi r2, 6				// Prepare to load from dm200 = 110010000
	ls	r2, 3
	addi r2, 2
	ls	r2, 3
	ldr r1, r2
	neq r0, r1 

p2_comparison:
	ldi r2, 6				// Prepare to load from dm215 = 11010111
	ls	r2, 3
	addi r2, 5
	ls	r2, 3
	addi r2, 3
	str r0, r2 			//store expected p2 in address 215
	//compare actual parity with expected parity
	// load p8 
	ldi r2, 6  			// prep to load from dm199 = 11000111
	ls	r2, 4
	addi r2, 7
	ldr r1, r2 
	eq r0, r1 			//check if parity bits match
	ldi r2, 6				// prep to load from dm222 = 11011110
	ls	r2, 3
	addi r2, 7
	ls	r2, 3
	addi r2, 2
	str r0, r2 			//store result in address 222

p1_exp:
	// p1 = ^b11, b9, b7, b5, b4, b2, b1
	// b11^b9
	ldi r2, 6				// Prepare to load from dm212 = 11010100
	ls	r2, 3
	addi r2, 5
	ls	r2, 3
	ldr r0, r2
	
	ldi r3, 2
	neg r3, r3
	add r2, r3			// dec by 2 to load from dm210

	ldr r1, r2
	neq r0, r1
	// b11^b9^b7        
	add r2, r3			// dec by 2 to load from dm208
	ldr r1, r2
	neq r0, r1
	// (b11^b9^b7)^b5  
	add r2, r3			// dec by 2 to load from dm206
	ldr r1, r2
	neq r0, r1
	// b11^b9^b7^b5^b4
	add r2, r3			// dec by 2 to load from dm204
	ldr r1, r2
	neq r0, r1
	// b11^b9^b7^b5^b4^b2
	add r2, r3			// dec by 2 to load from dm202
	ldr r1, r2
	neq r0, r1
	// b11^b9^b7^b5^b4^b2^b1
	add r2, r3			// dec by 2 to load from dm200
	ldr r1, r2
	neq r0, r1

p1_comparison:
	ldi r2, 6				// Prep to load from dm216 = 11011000
	ls  r2, 3
	addi r2, 6
	ls	r2, 3
	str r0, r2 			//store expected p1 in address 216
	//compare actual parity with expected parity
	// load p1
	ldi r3, 6				// Prep to load from dm198 = 11000110
	ls	r3, 5
	addi r3, 6
	ldr r1, r3 
	eq r0, r1 			//check if parity bits match
	ldi r3, 6				// Prep to store to dm223 = 11011111
	ls  r3, 3
	addi r3, 7
	ls	r3, 3
	addi r3, 3
	str r0, r3 			//store result in address 223

p16_loop:
	// p16 = ^b11:1, p8, p4, p2, p1
	// b11^b10
	ldi r3, 1				// Prep to dec by 1 for loading addresses
	neg r3, r3
	ldi r2, 6				// Prepare to load from dm212 = 11010100
	ls	r2, 3
	addi r2, 5
	ls	r2, 3
	ldr r0, r2
	addi r2, r3
	ldr r1, r2
	neq r0, r1  
	// b11^b10^b9        
	addi r2, r3
	ldr r1, r2
	neq r0, r1
	// (b11^b10^b9)^b8  
	addi r2, r3
	ldr r1, r2
	neq r0, r1
	// ^b11:b8^b7  
	addi r2, r3
	ldr r1, r2
	neq r0, r1 
	// ^b11:b7^b6 
	addi r2, r3
	ldr r1, r2
	neq r0, r1
	// ^b11:b6^b5 
	addi r2, r3
	ldr r1, r2
	neq r0, r1
	// ^b11:b5^b4        
	addi r2, r3
	ldr r1, r2
	neq r0, r1
	// ^b11:b4^b3  
	addi r2, r3
	ldr r1, r2
	neq r0, r1
	// ^b11:b3^b2  
	addi r2, r3
	ldr r1, r2
	neq r0, r1 
	// ^b11:b2^b1 
	addi r2, r3
	ldr r1, r2
	neq r0, r1
	// ^b11:b1^p8 
	addi r2, r3
	ldr r1, r2
	neq r0, r1
	// ^b11:b1^p8^p4
	addi r2, r3
	ldr r1, r2
	neq r0, r1
	// ^b11:b1^p8^p4^p2 
	addi r2, r3
	ldr r1, r2
	neq r0, r1
	// ^b11:b1^p8^p4^p2^p1
	addi r2, r3
	ldr r1, r2
	neq r0, r1

p16_comparison:
	ldi r2, 6				// Prep to load dm220 = 11011100
	ls	r2, 3
	addi r2, 7
	ls	r2, 3
	str r0, r2 			//store expected p16 in address 220
	//compare actual parity with expected parity
	// load p16
	ldi r2, 6				// Prep to load dm197 = 11000101
	ls 	r2, 5
	addi r2, 5
	ldr r1, r2 
	eq r0, r1 			//check if parity bits match
	ldi r2, 7				// Prep to load dm224 = 11100000
	ls  r2, 5
	str r0, r2 			//store result in address 224

check_error:
	//r2 will store number of errors
	ldi r2, 0
	//p8
	ldi r3, 6   		// Prep to load dm220 = 11011100
	ls  r3, 3
	addi r3, 7
	ls	r3, 2
	ldr r0, r3 			//get result of comparing expected parity with actual parity
	add r2, r0
	//p4
	addi r3, 1			// inc 220 to load dm221
	ldr r0, r3 			//get result of comparing expected parity with actual parity
	add r2, r0
	//p2
	addi r3, 1			// inc 221 to load dm222
	ldr r0, r3 			//get result of comparing expected parity with actual parity
	add r2, r0
	//p1
	addi r3, 1			// inc 222 to load dm223
	ldr r0, r3 			//get result of comparing expected parity with actual parity
	add r2, r0

	// check number of errors
	ldi r1, 4
	// if number of errors == 0
	ldr r0, r2
	ldi r3, 60			// Jump by 60 = 111100 to output
	eq r0, r1				// If r0 == r1, r0 = 1
	bnzr r3, r0   	// Jump by value in r3 if r0 = 1.
	// if number of errors == 1
	ldi r1, 3
	ldi r3, 9				// To error Correction
	eq r0, r1				// If r0 == r1, r0 = 1
	bnzr r3, r0			// Jump by value in r3 if r0 = 1
	// if number of errors == 2
	ldi r1, 2
	ldi r3, 40  		// To error detection
	eq r0, r1
	bnzr r3, r0			// Jump by value in r3 if r0 = 1
	
error_correction:
	// calculate which bit is incorrect
	ldi r3, 6   		// Prep to load dm220 = 11011100
	ls  r3, 3
	addi r3, 7
	ls	r3, 2
	ldr r0, r3
	ls r0, 1

	addi r3, 1	 		// Inc to load dm221
	ldr r1, r3
	or r0, r1
	ls r0, 1

	addi r3, 1			// Inc to load dm222
	ldr r1, r3
	or r0, r1
	ls r0, 1

	addi r3, 1			// Inc to load dm223
	ldr r1, r3
	or r0, r1

	// Find the incorrect bit and flip it
	ldi r1, 6				// load 197 = 11000101
	ls 	r1, 5
	addi r1, 5
	add r1, r0
	ldr r2, r0
	ldi r1, 0
	// if incorrect bit = 1, eq 1, 0 gives us 0. If incorrect bit = 0, eq 0, 0 gives us 1
	eq r2, r1
	str r2, r0
	// jump to output
	ldi r0, 0
	ldi r3, 20			// To output
	eq r0, r1				// r0 = 1 if r0 == r1
	bnzr r3, r0 		// Jump by value in r3 if r0 = 1

error_detection:
	//if p16 is correct as expected then there is a two-bit error
	ldi r2, 1
	//load result of comparing expected parity with actual parity
	ldi r3, 7				// Prep to load dm224 = 11100000
	ls  r3, 5
	ldr r0, r3
	//if p16_exp == p16
	eq r2, r0
	//we assume we do nothing if two errors are detected from a Piazza post

output:
	//LSW
  //b8
	ldi r2, 6				// Prep to load dm209 = 11010001
	ls  r2, 3
	addi r2, 4
	ls  r2, 3
	addi r2, 1
	ldr r0, r2
  ls r0, 1
  //b7
	ldi r3, 1				// Dec to load dm208
	neg r3, r3
	add r2, r3
  ldr r1 r2
  or r0, r1
  ls r0, 1
  //b6
	add r2, r3			// Dec to load dm207
  ldr r1, r2
  or r0, r1
  ls r0, 1
  //b5
	add r2, r3			// Dec to load dm206
  ldr r1, r2
  or r0, r1
  ls r0, 1
  //b4
	add r2, r3			// Dec x2 to load dm204
	add r2, r3
  ldr r1, r2
  or r0, r1
  ls r0, 1
  //b3
	add r2, r3			// Dec to load dm203
  ldr r1, r2
  or r0, r1
  ls r0, 1
  //b2
	add r2, r3			// Dec to load dm202
  ldr r1, r2
  or r0, r1
  ls r0, 1
  //b1
	add r2, r3			// Dec x2 to load dm200
	add r2, r3
  ldr r1, r2
  or r0, r1
  // store LSW
  // load output address for LSW
	ldi r2, 7				// prep to load dm225=11100001
	ls	r2, 5
	addi r2, 1
  ldr r1, r2
  // store LSW in output address
  str r0, r1
  // increment output address
  addi r1, 1
  
  //MSW
  //b11
	ldi r2, 6				// prep to load dm212 = 11010100
	ls  r2, 3
	ldi r2, 5
	ls	r2, 2
  ldr r0, r2
  ls r0, 1
  //b10
	ldi r3, 1  			// dec to load dm211
	neg r3, r3
	add r2, r3
  ldr r1, r2
  or r0, r1
  ls r0, 1
  //b9
	add r2, r3			// dec to load dm210
  ldr r1, r2
  or r0, r1
  ls r0, 1
  
  
  //store MSW
  // we already have output address in r1
  // store MSW in output address
  str r0, r1
  // increment output address
  addi r1, 1
  // store output address
	ldi r2, 7				// prep to load dm225=11100001
	ls	r2, 5
	addi r2, 1
  str r1, r2

	// check if we're done
	ldi r1, 7				// load 123
	ls	r1, 3
	addi r1, 5
	ls	r1, 1
	addi r1, 1
	ldi r3, 1				// To Func 2 loop. Use the lut
	neq r0, r1
	ldi r1, 1
	eq r0, r1				// r0 = 1 if r0 == r1
	bnzl r3, r1			// jump to lutr3 if r1 != 0

end:
	// we're done, yay
	fin