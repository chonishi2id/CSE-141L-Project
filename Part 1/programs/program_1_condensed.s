	//implement shifts
	//64 offset for nops
	
	ldi r0, #0  		// Func1_start:
	str r0, [215]		// store data mem[0] for later
	ldi r0, #30			// load data mem[30]
	str r0, [216]		// store data mem[30] for later
	ldr r0, [215]		// Func1_loop:
	ldr r1, (r0)		// Load LSW of input string into r1 
	addi r0, #1			// Prepare to load MSW of input string
  	ldr r2, (r0)    // Load MSW of input string into r2
	addi r0, #1			// Increment input address for the next input if applicable
	str r0, [215]   // store input address to use later
	str r1, [195]
	str r2, [196]
	ls r1, #7 // b1
	rs r1, #7
	str r1, [197]
	ldr r1, [195]
	ls r1, #6 //b2
	rs r1, #7
	str r1, [198]
	ldr r1, [195]
	ls r1, #5 //b3
	rs r1, #7
	str r1, [199]
	ldr r1, [195]
	ls r1, #4 //b4
	rs r1, #7
	str r1, [200]
	ldr r1, [195]
	ls r1, #3 //b5
	rs r1, #7
	str r1, [201]
	ldr r1, [195]
	ls r1, #2 //b6
	rs r1, #7
	str r1, [202]
	ldr r1, [195]
	ls r1, #1 //b7
	rs r1, #7
	str r1, [203]
	ldr r1, [195]
	rs r1, #7 //b8
	str r1, [204]
	ls r2, #7 //b9 (We're now on the MSB)
	rs r2, #7
	str r2, [205]
	ldr r2, [196]
	ls r2, #6 //b10
	rs r2, #7
	str r2, [206]
	ldr r2, [196]
	rs r2, #2 //b11
	str r2, [207]
	ldr r2, [196]
	ldi r2, #207 //p8_loop:
	ldr r0, (r2)
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1      
	addi r2, #(-1) // (b11^b10)^b9 
	ldr r1, (r2)
	neq r0, r1
	addi r2, #(-1)
	ldr r1, (r2)
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1 
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	str r0, [210] //p8_end:
	ldr r1, [207] // b11
	ls r1, #1
	ldr r2, [206] // b10
	or r1, r2
	ls r1, #1
	ldr r2, [205] // b9
	or r1, r2
	ls r1, #1
	ldr r2, [204] // b8
	or r1, r2
	ls r1, #1
	ldr r2, [203] // b7
	or r1, r2
	ls r1, #1
	ldr r2, [202] // b6
	or r1, r2
	ls r1, #1
	ldr r2, [201] // b5
	or r1, r2
	ls r1, #1
	or r1, r0 // insert p8 here. Now the MSW is finished
	ls r1, #1
	str r1, [208]
	ldi r2, #207 //p4_loop:
	ldr r0, (r2)
	add r2, #(-1)
	ldr r1, (r2)
	neq r0, r1      
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1  
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	ldi r2, #200
	ldr r1, (r2)
	neq r0, r1
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1 
	str r0, [211] //p4_end:
	ldr r1, [200]
	ls r1, #1
	ldr r2, [199]
	or r1, r2
	ls r1, #1
	ldr r2, [198]
	or r1, r2
	ls r1, #1	
	or r1, r0
	ls r1, #1
	str r1, [209]
	ldi r2, #207 //p2_loop:
	ldr r0, (r2)
	add r2, #(-1)
	ldr r1, (r2)
	neq r0, r1      
	ldi r2, #203
	ldr r1, (r2)
	neq r0, r1
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	ldi r2, #200
	ldr r1, (r2)
	neq r0, r1
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	ldi r2, #197
	ldr r1, (r2)
	neq r0, r1 
	str r0, [212] //p2_end:
	ldr r1, [209]
	ldr r2, [197]
	or r1, r2
	ls r1, #1
	or r1, r0
	ls r1, #1
	str r1, [209]
	ldi r2, #207 //p1_loop:
	ldr r0, (r2)
	ldi r2, #205
	ldr r1, (r2)
	neq r0, r1   
	ldi r2, #203
	ldr r1, (r2)
	neq r0, r1
	ldi r2, #201
	ldr r1, (r2)
	neq r0, r1
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	ldi r2, #198
	ldr r1, (r2)
	neq r0, r1
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	str r0, [213] //p1_end:
	ldr r1, [209]
	or r1, r0 // insert p1 here
	ls r1, #1
	str r1, [209]
	ldi r2, #207 //p16_loop:
	ldr r0, (r2)
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1     
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1 
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1 
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1 
	addi r2, #(-1)
	ldr r1, (r2)
	neq r0, r1
	ldi r2, #210
	ldr r1, (r2)
	neq r0, r1
	addi r2, #1
	ldr r1, (r2)
	neq r0, r1
	addi r2, #1
	ldr r1, (r2)
	neq r0, r1
	addi r2, #1
	ldr r1, (r2)
	neq r0, r1
	ldr r1, [209] //p16_end:
	or r1, r0
	str r1, [209]
	ldr r0, [216] //gen_word:
	ldr r1, [208]
	str r1, (r0)
	addi r0, #1 // store msw
	ldr r1, [209]
	str r1, (r0)
	addi r0, #1
	str r0, [216]
	ldi r1, #59
	ldr r2, Func1_loop
	neq r0, r1
	ldi r1, #1
	beq r0, r1