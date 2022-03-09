// Describe Hardware to assembler
	.arch armv6
	.cpu  cortex-a53
	.syntax unified

// Constants


Func1_start:
	// Registers available: r0 - r2

	// load from data mem[0:29] store to data mem[30:59]
	ldi r0, #0  		// Prepare to load data mem[0]
	str r0, [215]		// store data mem[0] for later
	ldi r0, #30			// load data mem[30]
	str r0, [216]		// store data mem[30] for later

Func1_loop:
	ldr r0, [215]		// Load current input address
	ldr r1, (r0)		// Load LSW of input string into r1 

	addi r0, #1			// Prepare to load MSW of input string
  ldr r2, (r0)    // Load MSW of input string into r2

	addi r0, #1			// Increment input address for the next input if applicable
	str r0, [215]   // store input address to use later

	// store LSW and MSW vals into memory. From here, we'll just call everything by its decimal number for brevity
	str r1, [195]
	str r2, [196]

	// store each individual bit of the string into its own memory address
	// b1 (We're now on the LSB)
	ls r1, #7
	rs r1, #7
	str r1, [197]
	ldr r1, [195]

	//b2
	ls r1, #6
	rs r1, #7
	str r1, [198]
	ldr r1, [195]

	//b3
	ls r1, #5
	rs r1, #7
	str r1, [199]
	ldr r1, [195]

	//b4
	ls r1, #4
	rs r1, #7
	str r1, [200]
	ldr r1, [195]

	//b5
	ls r1, #3
	rs r1, #7
	str r1, [201]
	ldr r1, [195]

	//b6
	ls r1, #2
	rs r1, #7
	str r1, [202]
	ldr r1, [195]

	//b7
	ls r1, #1
	rs r1, #7
	str r1, [203]
	ldr r1, [195]

	//b8
	rs r1, #7
	str r1, [204]

	//b9 (We're now on the MSB)
	ls r2, #7
	rs r2, #7
	str r2, [205]
	ldr r2, [196]

	//b10
	ls r2, #6
	rs r2, #7
	str r2, [206]
	ldr r2, [196]

	//b11
	rs r2, #2
	str r2, [207]
	ldr r2, [196]

	// parity bit creation 
	// p8 = ^(b11:b5)
p8_loop:
	// b11^b10
	ldi r2, #207
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

p8_end:
	//store p8 for when we process p16
	str r0, [210]
	//start building the final string
	// b11
	ldr r1, [207]
	ls r1, #1
	// b10
	ldr r2, [206]
	or r1, r2
	ls r1, #1
	// b9
	ldr r2, [205]
	or r1, r2
	ls r1, #1
	// b8
	ldr r2, [204]
	or r1, r2
	ls r1, #1
	// b7
	ldr r2, [203]
	or r1, r2
	ls r1, #1
	// b6
	ldr r2, [202]
	or r1, r2
	ls r1, #1
	// b5
	ldr r2, [201]
	or r1, r2
	ls r1, #1
	// insert p8 here. Now the MSW is finished
	or r1, r0
	ls r1, #1
	str r1, [208]

p4_loop:
	// p4 = ^(b11:b8, b4, b3, b2)
	// b11^b10
	ldi r2, #207
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
	ldi r2, #200
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

p4_end:
	// store p4 for when we process p16
	str r0, [211]
	// b4
	ldr r1, [200]
	ls r1, #1
	// b3
	ldr r2, [199]
	or r1, r2
	ls r1, #1
	// b2
	ldr r2, [198]
	or r1, r2
	ls r1, #1	
	// insert p4 here
	or r1, r0
	ls r1, #1
	str r1, [209]

p2_loop:
	// p2 = ^(b11, b10, b7, b6, b4, b3, b1)
	// b11^b10
	ldi r2, #207
	ldr r0, (r2)
	add r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// (b11^b10)^b7        
	ldi r2, #203
	ldr r1, (r2)
	neq r0, r1
	// ((b11^b10)^b7)^b6  
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// (b11^b10^b7^b6)^b4
	ldi r2, #200
	ldr r1, (r2)
	neq r0, r1
	// (b11^b10^b7^b6)^b4^b3
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// (b11^b10^b7^b6)^b4^b1
	ldi r2, #197
	ldr r1, (r2)
	neq r0, r1 

p2_end:
	// store p2 for when we process p16
	str r0, [212]
	// b1
	ldr r1, [209]
	ldr r2, [197]
	or r1, r2
	ls r1, #1
	// insert p2 here
	or r1, r0
	ls r1, #1
	str r1, [209]

p1_loop:
	// p1 = ^(b11, b9, b7, b5, b4, b2, b1)
	// b11^b9
	ldi r2, #207
	ldr r0, (r2)
	ldi r2, #205
	ldr r1, (r2)
	neq r0, r1
	// (b11^b9)^b7        
	ldi r2, #203
	ldr r1, (r2)
	neq r0, r1
	// ((b11^b9)^b7)^b5  
	ldi r2, #201
	ldr r1, (r2)
	neq r0, r1
	// (b11^b9^b7^b5)^b4
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	// (b11^b9^b7^b5^b4)^b2
	ldi r2, #198
	ldr r1, (r2)
	neq r0, r1
	// (b11^b9^b7^b5^b4^b2)^b1
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1

p1_end:
	// store p1 for when we process p16
	str r0, [213]
	// insert p1 here
	ldr r1, [209]
	or r1, r0
	ls r1, #1
	str r1, [209]

p16_loop:
	// p16 = ^(b11:1, p8, p4, p2, p1)
	// b11^b10
	ldi r2, #207
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
	ldi r2, #210
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b1)^p8^p4
	addi r2, #1
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b1)^p8^p4^p2 
	addi r2, #1
	ldr r1, (r2)
	neq r0, r1
	// ^(b11:b1)^p8^p4^p2^p1
	addi r2, #1
	ldr r1, (r2)
	neq r0, r1

p16_end:
	// insert p16
	ldr r1, [209]
	or r1, r0
	str r1, [209]

gen_word:
	// load memory address we need to load finalized output into
	// store lsw
	ldr r0, [216]
	ldr r1, [208]
	str r1, (r0)
	// store msw
	addi r0, #1
	ldr r1, [209]
	str r1, (r0)
	// increment output mem storage address for the next string
	addi r0, #1
	str r0, [216]
	// check if we're done
	ldi r1, #59
	ldr r2, Func1_loop
	neq r0, r1
	ldi r1, #1
	beq r0, r1

end:
// yay we're done
	fin
