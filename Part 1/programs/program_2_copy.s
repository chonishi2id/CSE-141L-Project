Func2_start:
	ldi r0, #4  		// Prepare to load data mem[64] = 1000000
	ls  r0, #4
	ldi r1, #7			// Prepare to store into data mem[224] = 11100000 
	ls	r1, #5
	str r0, [r1]		// store data mem[64] for later
	ldi r0, #5			// load data mem[94] = 1011110
	ls  r0, #3
	addi r0, #7
	ls  r0, #1
	addi r1, #1     // Prepare to store into data mem[225] = 11100001 using what we had
	str r0, [r1]		// store data mem[30] for later
Func2_loop:
	ldi r3, #6      // Prepare to laod address 221 = 11011101
	ls  r3, #3
	addi r3, #7
	ls  r3, #2
	addi r3, #1
	ldr r0, [r3]		// Load current input address
	ldr r1, (r0)		// Load LSW of input string into r1 
	addi r0, #1			// Prepare to load MSW of input string
  ldr r2, (r0)    // Load MSW of input string into r2
	addi r0, #1			// Increment input address for the next input if applicable
	str r0, [r3]   // store input address to use later
	ldi r3, #6     // Prepare to store into data mem[195] = 11000011 and data mem[196] = 11000100
	ls  r3, #5
	addi r3, #3
	str r1, [r3]
	addi r3, #1		 // Prepare to store into dm[196] (inc from 195)
	str r2, [r3]
	ls r1, #7
	rs r1, #7
	addi r3, #1			// Prepare to store into dm[197] (inc from 196)
	str r1, [r3]
	ldi r0, #6			// Prepare to load from dm[195]
	ls 	r0, #5
	addi r0, #3
	ldr r1, [r0]
	ls r1, #6
	rs r1, #7
	addi r3, #1			// Prepare to store into dm[198] (inc from 197)
	str r1, [r3]
	ldr r1, [r0]
	ls r1, #5
	rs r1, #7
	addi r3, #1			// Prepare to store into dm[199] (inc from 198)
	str r1, [r3]
	ldr r1, [r0]
	ls r1, #4
	rs r1, #7
	addi r3, #1			// Prepare to store into dm[200] (inc from 199)
	str r1, [r3]
	ldr r1, [r0]
	ls r1, #3
	rs r1, #7
	addi r3, #1			// Prepare to store into dm[201] (inc from 200)
	str r1, [r3]
	ldr r1, [r0]
	ls r1, #2
	rs r1, #7
	addi r3, #1			// Prepare to store into dm[202] (inc from 201)
	str r1, [r3]
	ldr r1, [r0]
	ls r1, #1
	rs r1, #7
	addi r3, #1			// Prepare to store into dm[203] (inc from 202)
	str r1, [r3]
	ldr r1, [r0]
	rs r1, #7
	addi r3, #1 		// Prepare to store into dm[204] (inc from 203)
	str r1, [r3]		
	ls r2, #7
	rs r2, #7
	addi r3, #1			// Prepare to store into dm[205] (inc from 204)
	str r1, [r3]
	addi r0, #1     // Prepare to load from dm[196] (inc from 195)
	ldr r1, [r0]
	ls r2, #6
	rs r2, #7
	addi r3, #1			// Prepare to store into dm[206] (inc from 205)
	str r1, [r3]
	ldr r1, [r0]
	ls r2, #5
	rs r2, #7
	addi r3, #1			// Prepare to store into dm[207] (inc from 206)
	str r1, [r3]
	ldr r1, [r0]
	ls r2, #4
	rs r2, #7
	addi r3, #1			// Prepare to store into dm[208] (inc from 207)
	str r1, [r3]
	ldr r1, [r0]
	ls r2, #3
	rs r2, #7
	addi r3, #1			// Prepare to store into dm[209] (inc from 208)
	str r1, [r3]
	ldr r1, [r0]
	ls r2, #2
	rs r2, #7
	addi r3, #1			// Prepare to store into dm[210] (inc from 209)
	str r1, [r3]
	ldr r1, [r0]
	ls r2, #1
	rs r2, #7
	addi r3, #1			// Prepare to store into dm[211] (inc from 210)
	str r1, [r3]
	ldr r1, [r0]
	rs r2, #7
	addi r3, #1			// Prepare to store into dm[212] (inc from 211)
	str r2, [r3]
p8_exp:
	ldr r0, (r3)		// Load from dm[212]
  ldi r1, #1
	eq r0, r1				// Flag: Don't know if this is correct given other code
	ldi r2, #1
	neg r2, r2
	add r3, r2  // Load from dm[211] (dec from 212)
	ldr r1, (r3)
	neq r0, r1  
	add r3, r2  // Load from dm[210]
	ldr r1, (r3)
	neq r0, r1
	addi r3, r2	// Load from dm[209]
	ldr r1, (r3)
	neq r0, r1
	addi r3, r2	// Load from dm[208]
	ldr r1, (r3)
	neq r0, r1 
	addi r3, r2	// Load from dm[207]
	ldr r1, (r3)
	neq r0, r1
	addi r3, r2	// Load from dm[206]
	ldr r1, (r3)
	neq r0, r1
p8_comparison:
	ldi r2, #6		// Prepare to store into dm[213] = 11010101
	ls  r2, #3
	addi r2, #5
	ls 	r2, #2
	addi r2, #1
	str r0, [r3] //store expected p8 in address 213
	ldi r3, #5	//Prepare to load from dm[205] = 110101101
	ls	r3, #3
	addi r3, #3
	ls	r3, #2
	addi r3, #1
	ldr r1, [r3]
	eq r0, r1 //check if parity bits match
	ldi r3, #6	// Prepare to load from dm[220]
	ls	r3, #3
	addi r3, #7
	ls	r3, #3
	str r0, [r3] //store result in address 220
p4_exp:
	ldi r3, #1
	neg r3, r3
	addi r2, r3		//Prepare to load from dm[212] = 11010100 (dec from 213)
	ldr r0, (r2)
	addi r2, r3   // dec to load dm[211]
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3   // dec to load dm[210]
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3		// dec to load dm[209]
	ldr r1, (r2)
	neq r0, r1
	ldi r2, #6		// Prepare to load from dm[204] = 11001100
	ls	r2, #3
	addi r2, #3
	ls	r2, #2
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3		// dec to load dm[203]
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3		// dec to load dm[202]
	ldr r1, (r2)
	neq r0, r1 
p4_comparison:
	addi r2, r3 // dec to load dm[201] a few instructions later
	ldi r3, #6  // Prepare to store into 214
	ls 	r3, #3
	addi r3, #5
	ls  r3, #2
	addi r3, #2
	str r0, [r3] //store expected p4 in address 214
	ldr r1, [r2]		// loading from dm[201] 
	eq r0, r1 		//check if parity bits match
	ldi r3, #6		// Prepare to store into dm[221] = 11011101
	ls	r3, #5
	ldi r3, #7
	ls	r3, #2
	addi r3, #1
	str r0, [221] //store result in address 221
p2_exp:
	ldi r2, #6		// Prepare to load from dm[212] = 11010100
	ls	r2, #3
	addi r2, #5
	ls	r2, #3
	ldr r0, (r2)
	ldi r3, #1		// dec to load dm[211]
	neg r3, r3
	add r2, r3		
	ldr r1, (r2)
	neq r0, r1
	ldi r2, #6		// Prepare to load from dm[208] = 11010000
	ls	r2, #3
	addi r2, #4
	ls	r2, #3
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3		// dec to load dm[207]
	ldr r1, (r2)
	neq r0, r1
	ldi r2, #6		// Prepare to load from dm[204] = 11001100
	ls	r2, #3
	addi r2, #3
	ls	r2, #3
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3		// dec to load dm[203]
	ldr r1, (r2)
	neq r0, r1
	ldi r2, #6		// Prepare to load from dm[200] = 110010000
	ls	r2, #3
	addi r2, #2
	ls	r2, #3
	ldr r1, (r2)
	neq r0, r1 
p2_comparison:
	ldi r2, #6		// Prepare to load from dm[215] = 11010111
	ls	r2, #3
	addi r2, #5
	ls	r2, #3
	addi r2, #3
	str r0, [r2] //store expected p2 in address 215
	ldi r2, #6  // prep to load from dm[199] = 11000111
	ls	r2, #4
	addi r2, #7
	ldr r1, [r2] 
	eq r0, r1 //check if parity bits match
	ldi r2, #6	// prep to load from dm[222] = 11011110
	ls	r2, #3
	addi r2, #7
	ls	r2, #3
	addi r2, #2
	str r0, [r2] //store result in address 222
p1_exp:
	ldi r2, #6		// Prepare to load from dm[212] = 11010100
	ls	r2, #3
	addi r2, #5
	ls	r2, #3
	ldr r0, (r2)
	ldi r3, #2
	neg r3, r3
	add r2, r3		// dec by 2 to load from dm[210]
	ldr r1, (r2)
	neq r0, r1
	add r2, r3		// dec by 2 to load from dm[208]
	ldr r1, (r2)
	neq r0, r1
	add r2, r3		// dec by 2 to load from dm[206]
	ldr r1, (r2)
	neq r0, r1
	add r2, r3		// dec by 2 to load from dm[204]
	ldr r1, (r2)
	neq r0, r1
	add r2, r3		// dec by 2 to load from dm[202]
	ldr r1, (r2)
	neq r0, r1
	add r2, r3		// dec by 2 to load from dm[200]
	ldr r1, (r2)
	neq r0, r1
p1_comparison:
	ldi r2, #6		// Prep to load from dm[216] = 11011000
	ls  r2, #3
	addi r2, #6
	ls	r2, #3
	str r0, [r2] //store expected p1 in address 216
	ldi r3, #6		// Prep to load from dm[198] = 11000110
	ls	r3, #5
	addi r3, #6
	ldr r1, [r3] 
	eq r0, r1 //check if parity bits match
	ldi r3, #6		// Prep to store to dm[223] = 11011111
	ls  r3, #3
	addi r3, #7
	ls	r3, #3
	addi r3, #3
	str r0, [r3] //store result in address 223
p16_loop:
	// p16 = ^(b11:1, p8, p4, p2, p1)
	ldi r3, #1		// Prep to dec by 1 for loading addresses
	neg r3, r3
	ldi r2, #6		// Prepare to load from dm[212] = 11010100
	ls	r2, #3
	addi r2, #5
	ls	r2, #3
	ldr r0, (r2)
	addi r2, r3
	ldr r1, (r2)
	neq r0, r1  
	addi r2, r3
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3
	ldr r1, (r2)
	neq r0, r1 
	addi r2, r3
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3
	ldr r1, (r2)
	neq r0, r1 
	addi r2, r3
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3
	ldr r1, (r2)
	neq r0, r1
	addi r2, r3
	ldr r1, (r2)
	neq r0, r1

p16_comparison:
	ldi r2, #6		// Prep to load dm[220] = 11011100
	ls	r2, #3
	addi r2, #7
	ls	r2, #3
	str r0, [r2] //store expected p16 in address 220
	ldi r2, #6	// Prep to load dm[197] = 11000101
	ls 	r2, #5
	addi r2, #5
	ldr r1, [r2] 
	eq r0, r1 //check if parity bits match
	ldi r2, #7	// Prep to load dm[224] = 11100000
	ls  r2, #5
	str r0, [r2] //store result in address 224
check_error:
	ldi r2, #0
	ldi r3, #6   // Prep to load dm[220] = 11011100
	ls  r3, #3
	addi r3, #7
	ls	r3, #2
	ldr r0, [r3] //get result of comparing expected parity with actual parity
	add r2, r0
	addi r3, #1		// inc 220 to load dm[221]
	ldr r0, [r3] //get result of comparing expected parity with actual parity
	add r2, r0
	addi r3, #1		// inc 221 to load dm[222]
	ldr r0, [r3] //get result of comparing expected parity with actual parity
	add r2, r0
	addi r3, #1		// inc 222 to load dm[223]
	ldr r0, [r3] //get result of comparing expected parity with actual parity
	add r2, r0
	ldi r1, #4
	ldr r0, r2
	ldr r2, output
	beq r0, r1
	ldi r1, #3
	ldr r2, error_correction
	beq r0, r1
	ldi r1, #2
	ldr r2, error_detection
	beq r0, r1
error_correction:
	ldi r3, #6   // Prep to load dm[220] = 11011100
	ls  r3, #3
	addi r3, #7
	ls	r3, #2
	ldr r0, [r3]
	ls r0, #1
	addi r3, #1	 // Inc to load dm[221]
	ldr r1, [r3]
	or r0, r1
	ls r0, #1
	addi r3, #1		// Inc to load dm[222]
	ldr r1, [r3]
	or r0, r1
	ls r0, #1
	addi r3, #1		// Inc to load dm[223]
	ldr r1, [r3]
	or r0, r1
	ldi r1, #6	// load 197 = 11000101
	ls 	r1, #5
	addi r1, #5
	add r1, r0
	ldr r2, (r0)
	ldi r1, #0
	eq r2, r1
	str r2, (r0)
	ldi r0, #0
	ldr r2, output
	beq r0, r1
error_detection:
	ldi r2, #1
	ldi r3, #7	// Prep to load dm[224] = 11100000
	ls  r3, #5
	ldr r0, [r3]
	eq r2, r0
output:
	ldi r2, #6		// Prep to load dm[209] = 11010001
	ls  r2, #3
	addi r2, #4
	ls  r2, #3
	addi r2, #1
	ldr r0, [r2]
  ls r0, #1
	ldi r3, #1	// Dec to load dm[208]
	neg r3, r3
	add r2, r3
  ldr r1 [r2]
  or r0, r1
  ls r0, #1
	add r2, r3	// Dec to load dm[207]
  ldr r1, [r2]
  or r0, r1
  ls r0, #1
	add r2, r3	// Dec to load dm[206]
  ldr r1, [r2]
  or r0, r1
  ls r0, #1
	add r2, r3	// Dec x2 to load dm[204]
	add r2, r3
  ldr r1, [r2]
  or r0, r1
  ls r0, #1
	add r2, r3	// Dec to load dm[203]
  ldr r1, [r2]
  or r0, r1
  ls r0, #1
	add r2, r3	// Dec to load dm[202]
  ldr r1, [r2]
  or r0, r1
  ls r0, #1
	add r2, r3	// Dec x2 to load dm[200]
	add r2, r3
  ldr r1, [r2]
  or r0, r1
	ldi r2, #7		// prep to load dm[225]=11100001
	ls	r2, #5
	addi r2, #1
  ldr r1, [r2]
  str r0, (r1)
  addi r1, #1
	ldi r2, #6	// prep to load dm[212] = 11010100
	ls  r2, #3
	ldi r2, #5
	ls	r2, #2
  ldr r0, [r2]
  ls r0, #1
	ldi r3, #1  // dec to load dm[211]
	neg r3, r3
	add r2, r3
  ldr r1, [r2]
  or r0, r1
  ls r0, #1
	add r2, r3	// dec to load dm[210]
  ldr r1, [r2]
  or r0, r1
  ls r0, #1
  str r0, (r1)
  addi r1, #1
	ldi r2, #7		// prep to load dm[225]=11100001
	ls	r2, #5
	addi r2, #1
  str r1, [r2]
	ldi r1, #7	// load 123
	ls	r1, #3
	addi r1, #5
	ls	r1, #1
	addi r1, #1
	ldr r2, Func2_loop
	neq r0, r1
	ldi r1, #1
	beq r0, r1
end:
	// we're done, yay
	fin