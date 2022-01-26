// Describe Hardware to assembler
	.arch armv6
	.cpu  cortex-a53
	.syntax unified

// Constants

// For brevity, we'll just call everything by its decimal number
Func2_start:
	// Registers available: r0 - r2

	// load from data mem[64:93] store to data mem[94:123]
	ldi r0, #64  		// Prepare to load data mem[64]
	str r0, [224]		// store data mem[0] for later
	ldi r0, #94			// load data mem[94]
	str r0, [225]		// store data mem[30] for later

Func2_loop:
	ldr r0, [221]		// Load current input address
	ldr r1, (r0)		// Load LSW of input string into r1 

	addi r0, #1			// Prepare to load MSW of input string
  ldr r2, (r0)    // Load MSW of input string into r2

	addi r0, #1			// Increment input address for the next input if applicable
	str r0, [221]   // store input address to use later

	// store LSW and MSW vals into memory. 
	str r1, [195]
	str r2, [196]

	// store each individual bit of the string into its own memory address
	// p16 (We're now on the LSB)
	ls r1, #7
	rs r1, #7
	str r1, [197]
	ldr r1, [195]

	//p1
	ls r1, #6
	rs r1, #7
	str r1, [198]
	ldr r1, [195]

	//p2
	ls r1, #5
	rs r1, #7
	str r1, [199]
	ldr r1, [195]

	//b1
	ls r1, #4
	rs r1, #7
	str r1, [200]
	ldr r1, [195]

	//p4
	ls r1, #3
	rs r1, #7
	str r1, [201]
	ldr r1, [195]

	//b2
	ls r1, #2
	rs r1, #7
	str r1, [202]
	ldr r1, [195]

	//b3
	ls r1, #1
	rs r1, #7
	str r1, [203]
	ldr r1, [195]

	//b4
	rs r1, #7
	str r1, [204]

	//p8 (We're now on the MSB)
	ls r2, #7
	rs r2, #7
	str r2, [205]
	ldr r2, [196]

	//b5
	ls r2, #6
	rs r2, #7
	str r2, [206]
	ldr r2, [196]

	//b6
	ls r2, #5
	rs r2, #7
	str r2, [207]
	ldr r2, [196]

	//b7
	ls r2, #4
	rs r2, #7
	str r2, [208]
	ldr r2, [196]

	//b8
	ls r2, #3
	rs r2, #7
	str r2, [209]
	ldr r2, [196]

	//b9
	ls r2, #2
	rs r2, #7
	str r2, [210]
	ldr r2, [196]

	//b10
	ls r2, #1
	rs r2, #7
	str r2, [211]
	ldr r2, [196]

	//b11
	rs r2, #7
	str r2, [212]

p8_exp:
	// b11^b10
	ldi r2, #212
	ldr r0, (r2)
  ldi r1, #1
	eq r0, r1
	
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1  
	// (b11^b10)^b9        
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ((b11^b10)^b9)^b8  
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b8)^b7  
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1 
	// ^(b11:b7)^b6 
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b6)^b5 
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1

p8_comparison:
	str r0, [213] //store expected p8 in address 213
	//compare actual parity with expected parity
	// load p8 
	ldr r1, [205]
	eq r0, r1 //check if parity bits match
	str r0, [220] //store result in address 220

p4_exp:
	// p4 = ^(b11:b8, b4, b3, b2)
	// b11^b10
	ldi r2, #212
	ldr r0, (r2)
	add r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// (b11^b10)^b9        
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ((b11^b10)^b9)^b8  
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b8)^b4
	ldi r2, #204
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b8)^b4^b3
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b8)^b4^b3^b2
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1 

p4_comparison:
	str r0, [214] //store expected p4 in address 214
	//compare actual parity with expected parity
	// load p4
	ldr r1, [201] 
	eq r0, r1 //check if parity bits match
	str r0, [221] //store result in address 221

p2_exp:
// p2 = ^(b11, b10, b7, b6, b4, b3, b1)
	// b11^b10
	ldi r2, #212
	ldr r0, (r2)
	add r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// (b11^b10)^b7        
	ldi r2, #208
	ldr r1, (r2)
	neq r0, r1
	// ((b11^b10)^b7)^b6  
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// (b11^b10^b7^b6)^b4
	ldi r2, #204
	ldr r1, (r2)
	neq r0, r1
	// (b11^b10^b7^b6)^b4^b3
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// (b11^b10^b7^b6)^b4^b1
	ldi r2, #200
	ldr r1, (r2)
	neq r0, r1 

p2_comparison:
	str r0, [215] //store expected p2 in address 215
	//compare actual parity with expected parity
	// load p8 
	ldr r1, [199] 
	eq r0, r1 //check if parity bits match
	str r0, [222] //store result in address 222


p1_exp:
	// p1 = ^(b11, b9, b7, b5, b4, b2, b1)
	// b11^b9
	ldi r2, #212
	ldr r0, (r2)
	ldi r2, #210
	ldr r1, (r2)
	neq r0, r1
	// (b11^b9)^b7        
	ldi r2, #208
	ldr r1, (r2)
	neq r0, r1
	// ((b11^b9)^b7)^b5  
	ldi r2, #206
	ldr r1, (r2)
	neq r0, r1
	// (b11^b9^b7^b5)^b4
	ldi r2, #204
	ldr r1, (r2)
	neq r0, r1
	// (b11^b9^b7^b5^b4)^b2
	ldi r2, #202
	ldr r1, (r2)
	neq r0, r1
	// (b11^b9^b7^b5^b4^b2)^b1
	ldi r2, #200
	ldr r1, (r2)
	neq r0, r1



p1_comparison:
	str r0, [216] //store expected p1 in address 216
	//compare actual parity with expected parity
	// load p1
	ldr r1, [198] 
	eq r0, r1 //check if parity bits match
	str r0, [223] //store result in address 223



p16_loop:
	// p16 = ^(b11:1, p8, p4, p2, p1)
	// b11^b10
	ldi r2, #212
	ldr r0, (r2)
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1  
	// (b11^b10)^b9        
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ((b11^b10)^b9)^b8  
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b8)^b7  
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1 
	// ^(b11:b7)^b6 
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b6)^b5 
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b5)^b4        
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b4)^b3  
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b3)^b2  
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1 
	// ^(b11:b2)^b1 
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b1)^p8 
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b1)^p8^p4
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b1)^p8^p4^p2 
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b1)^p8^p4^p2^p1
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1



p16_comparison:
	str r0, [220] //store expected p16 in address 220
	//compare actual parity with expected parity
	// load p16
	ldr r1, [197] 
	eq r0, r1 //check if parity bits match
	str r0, [224] //store result in address 224

check_error:
	//r2 will store number of errors
	ldi r2, #0
	//p8
	ldr r0, [220] //get result of comparing expected parity with actual parity
	add r2, r0
	//p4
	ldr r0, [221] //get result of comparing expected parity with actual parity
	add r2, r0
	//p2
	ldr r0, [222] //get result of comparing expected parity with actual parity
	add r2, r0
	//p1
	ldr r0, [223] //get result of comparing expected parity with actual parity
	add r2, r0

	// check number of errors
	ldi r1, #4
	// if number of errors == 0
	ldr r0, r2
	ldr r2, output
	beq r0, r1
	// if number of errors == 1
	ldi r1, #3
	ldr r2, error_correction
	beq r0, r1
	// if number of errors == 2
	ldi r1, #2
	ldr r2, error_detection
	beq r0, r1

error_correction:
	// calculate which bit is incorrect
	ldr r0, [220]
	ls r0, #1
	ldr r1, [221]
	or r0, r1
	ls r0, #1
	ldr r1, [222]
	or r0, r1
	ls r0, #1
	ldr r1, [223]
	or r0, r1

	// Find the incorrect bit and flip it
	ldi r1, #197
	add r1, r0
	ldr r2, (r0)
	ldi r1, #0
	// if incorrect bit = 1, eq 1, 0 gives us 0. If incorrect bit = 0, eq 0, 0 gives us 1
	eq r2, r1
	str r2, (r0)
	// jump to output
	ldi r0, #0
	ldr r2, output
	beq r0, r1
	
error_detection:
	//if p16 is correct (as expected) then there is a two-bit error
	ldi r2, #1
	//load result of comparing expected parity with actual parity
	ldr r0, [224]
	//if p16_exp == p16
	eq r2, r0
	//we assume we do nothing if two errors are detected (from a Piazza post)

output:
	//LSW
  //b8
  ldr r0, [209]
  ls r0, #1
  //b7
  ldr r1 [208]
  or r0, r1
  ls r0, #1
  //b6
  ldr r1, [207]
  or r0, r1
  ls r0, #1
  //b5
  ldr r1, [206]
  or r0, r1
  ls r0, #1
  //b4
  ldr r1, [204]
  or r0, r1
  ls r0, #1
  //b3
  ldr r1, [203]
  or r0, r1
  ls r0, #1
  //b2
  ldr r1, [202]
  or r0, r1
  ls r0, #1
  //b1
  ldr r1, [200]
  or r0, r1
  // store LSW
  // load output address for LSW
  ldr r1, [225]
  // store LSW in output address
  str r0, (r1)
  // increment output address
  addi r1, #1
  
  //MSW
  //b11
  ldr r0, [212]
  ls r0, #1
  //b10
  ldr r1, [211]
  or r0, r1
  ls r0, #1
  //b9
  ldr r1, [210]
  or r0, r1
  ls r0, #1
  
  
  //store MSW
  // we already have output address in r1
  // store MSW in output address
  str r0, (r1)
  // increment output address
  addi r1, #1
  // store output address
  str r1, [225]

	// check if we're done
	ldi r1, #123
	ldr r2, Func2_loop
	neq r0, r1
	ldi r1, #1
	beq r0, r1

end:
	// we're done, yay
	fin





