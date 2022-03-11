ldi R2, #0
ldi R1, #6		// Prep 192 = 11000000
ls 	R1, #5 
str [R1], R2 // total number of times the 5-bit pattern occurs (byte boundaries ON) is initially 0...192 will be loaded into a register with shifts and adds in true implementation
addi R1, #1		// inc to get 193
str [R1], R2 // total number of bytes within which the 5-bit pattern occurs is initially 0
addi R1, #1		// inc to get 194
str [R1], R2 // total number of times the 5-bit pattern occurs (byte boundaries OFF) is initially 0
ldi R2, #1		// Prep 128 = 10000000
ls  R2, #7
addi R1, #1		// inc to get 195
str [R1], R2  // keeping track of current index by storing it in memory (because we will need all three registers sometimes)
L1:
    ldi R2, #0
		addi R1, #1 // Prep 196 = 11000100 (incd from 195)
    str [R1], R2
		ldi R2, #5	// Prep 160 = 10100000
		ls 	R2, #5
    ldr R0, [R2]  // get the byte with pattern stored in bits 7:3
    rs R0, #3      // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
		ldi R3, #1		// Dec to load 195
		neg R3, R3
		add R1, R3
    ldi R2, [R1] // R2 = index of current byte in string
    ldr R1, [R2]  // R1 = data_mem[index of current byte in string]
    rs R1, 3      // right shift R1 by 3, padding with 0s...we have bits 7:3
    eq R1, R0     // R1 = (R1 == R0); [1 if true, 0 if false]
		ldi R3, #6		// Prep 194 = 11000010
		ls	R3, #5
		addi R3, #2
    ldr R2, [R3] // total number of times 5-bit pattern occurs with byte boundaries OFF
    add R2, R1    // +1 if the pattern was recognized, +0 if not
    str [R3], R2 // max immediate is 7, will do shifts and adds to get 194...store updated total
    ldi R2, [address of NEXT_STEP_1 instruction]
    ldi R0, 1
    beq           // if (R0==R1) PC = [R2] (jump to that instruction address), else PC = PC + 1 (default PC increment)
		ldi R3, #6		// Prep 192 = 11000000
		ls  R3, #5
    ldr R2, [R3]
    addi R2, 1
    str [R3], R2
		ldi R3, #6		// Prep 196 = 11000100
		ls	R3, #5
		addi R3, #4
    ldr R2, [R3] // get flag indicating pattern was found in current byte   
    neq R1, R2    // since we know R1 = 1, this will be 1 if R2 is 0, and 0 otherwise
		ldi R3, #6		// Prep 193 = 11000001
		ls	R3, #5
		addi R3, #1
    ldr R2, [R3] // get number of bytes in which pattern was recognized
    add R2, R1    // recall that R1 is now 1 if the pattern was found and the "pattern found in current byte" byte was false, 0 otherwise, so we increment in the proper instance
		addi R3, #3
		str [R3], 1  // we found the pattern, so set the "patter found in current byte" byte to 1
NEXT_STEP_1:
		ldi R3, #5	// Prep 160 = 10100000
		ls 	R3, #5
    ldi R2, [R3]
    ldr R0, [R2]  // get the byte with pattern stored in bits 7:3
    rs R0, 3      // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
		ldi R3, #6		// Prep 195 = 11000011
		ls	R3, #5
		addi R3, #3
    ldi R2, [R3] // max immediate is 7, will do shifts and adds to get 195...R2 = current index
    ldr R1, [R2]  // R1 = data_mem[current_index]
    ls R1, 1      // left shift R1 by 1, fill lsb's with 0s...we have [6:0]0
    rs R1, 3      // right shift R1 by 2, padding msb's with 0s...we have 000[6:2]
    eq R1, R0     // R1 = (R1 == R0); [1 if true, 0 if false]
		ldi R3, #6		// Prep 194 = 11000010
		ls R3, #5
		addi R3, #2
    ldr R2, [R3] // total number of times 5-bit pattern occurs with byte boundaries OFF
    add R2, R1    // +1 if the pattern was recognized, +0 if not
    str [R3], R2 // max immediate is 7, will do shifts and adds to get 194...store updated total
    ldi R2, [address of NEXT_STEP_2 instruction]
    ldi R0, 1
    beq           // if (R0==R1) PC = [R2] (jump to that instruction address), else PC = PC + 1 (default PC increment)
		ldi R3, #6		// Prep 192 = 11000000
		ls  R3, #5
		ldr R2, [R3]
    addi R2, 1
    str [R3], R2
		addi R3, #4   // Inc 192 by 4 to get 196
    ldr R2, [R3] // get flag indicating pattern was found in current byte   
    neq R1, R2    // since we know R1 = 1, this will be 1 if R2 is 0, and 0 otherwise
		ldi R3, #6		// Prep 193 = 11000001
		ls 	R3, #5
		addi R3, #1
    ldr R2, [R3] // get number of bytes in which pattern was recognized
    add R2, R1    // recall that R1 is now 1 if the pattern was found and the "pattern found in current byte" byte was false, 0 otherwise, so we increment in the proper instance
		addi R3, #3		// Inc 193 by 3 to get 196
		str [R3], 1  // we found the pattern, so set the "patter found in current byte" byte to 1
NEXT_STEP_2:
		ldi R3, #5	// Prep 160 = 10100000
		ls 	R3, #5
    ldi R2, [R3]
    ldr R0, [R2]  // get the byte with pattern stored in bits 7:3
    rs R0, 3      // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
		ldi R3, #6		// Prep 195 = 11000011
		ls	R3, #5
		addi R3, #3
    ldi R2, [R3] // max immediate is 7, will do shifts and adds to get 195...R2 = current index
    ldr R1, [R2]  // R1 = data_mem[current_index]
    ls R1, 2      // left shift R1 by 2, fill lsb's with 0s...we have [5:0]00
    rs R1, 3      // right shift R1 by 3, padding with 0s...we have 000[5:1]
    eq R1, R0     // R1 = (R1 == R0); [1 if true, 0 if false]
		ldi R3, #6		// Prep 194 = 11000010
		ls R3, #5
		addi R3, #2
    ldr R2, [R3] // total number of times 5-bit pattern occurs with byte boundaries OFF
    add R2, R1    // +1 if the pattern was recognized, +0 if not
    str [R3], R2 // max immediate is 7, will do shifts and adds to get 194...store updated total
    ldi R2, [address of NEXT_STEP_3 instruction]
    ldi R0, 1
    beq           // if (R0==R1) PC = [R2] (jump to that instruction address), else PC = PC + 1 (default PC increment)
		ldi R3, #6		// Prep 192 = 11000000
		ls  R3, #5
    ldr R2, [R3]
    addi R2, 1
    str [R3], R2
		addi R3, #4   // Inc 192 by 4 to get 196
    ldr R2, [R3] // get flag indicating pattern was found in current byte   
    neq R1, R2    // since we know R1 = 1, this will be 1 if R2 is 0, and 0 otherwise
		ldi R3, #6		// Prep 193 = 11000001
		ls 	R3, #5
		addi R3, #1
    ldr R2, [R3] // get number of bytes in which pattern was recognized
    add R2, R1    // recall that R1 is now 1 if the pattern was found and the "pattern found in current byte" byte was false, 0 otherwise, so we increment in the proper instance
		addi R3, #3		// Inc 193 by 3 to get 196
    str [R3], 1  // we found the pattern, so set the "pattern found in current byte" byte to 1
NEXT_STEP_3:
		ldi R3, #5	// Prep 160 = 10100000
		ls 	R3, #5
    ldi R2, [R3]
    ldr R0, [R2]  // get the byte with pattern stored in bits 7:3
    rs R0, 3      // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
		ldi R3, #6		// Prep 195 = 11000011
		ls	R3, #5
		addi R3, #3
    ldi R2, [R3] // max immediate is 7, will do shifts and adds to get 195...R2 = current index
    ldr R1, [R2]  // R1 = data_mem[current_index]
    ls R1, 3      // left shift R1 by 3, fill lsb's with 0s...we have [4:0]000
    rs R1, 4      // right shift R1 by 3, padding with 0s...we have 0000[4:0]
    eq R1, R0     // R1 = (R1 == R0); [1 if true, 0 if false]
		ldi R3, #6		// Prep 194 = 11000010
		ls R3, #5
		addi R3, #2
    ldr R2, [R3] // total number of times 5-bit pattern occurs with byte boundaries OFF
    add R2, R1    // +1 if the pattern was recognized, +0 if not
    str [R3], R2 // max immediate is 7, will do shifts and adds to get 194...store updated total
    ldi R2, [address of NEXT_STEP_4 instruction]
    ldi R0, 1
    beq           // if (R0==R1) PC = [R2] (jump to that instruction address), else PC = PC + 1 (default PC increment)
		ldi R3, #6		// Prep 192 = 11000000
		ls  R3, #5
    ldr R2, [R3]
    addi R2, 1
    str [R3], R2
		addi R3, #4   // Inc 192 by 4 to get 196
    ldr R2, [R3] // get flag indicating pattern was found in current byte   
    neq R1, R2    // since we know R1 = 1, this will be 1 if R2 is 0, and 0 otherwise
		ldi R3, #6		// Prep 193 = 11000001
		ls 	R3, #5
		addi R3, #1
    ldr R2, [R3] // get number of bytes in which pattern was recognized
    add R2, R1    // recall that R1 is now 1 if the pattern was found and the "pattern found in current byte" byte was false, 0 otherwise, so we increment in the proper instance
		addi R3, #3		// Inc 193 by 3 to get 196
		str [R3], 1  // we found the pattern, so set the "patter found in current byte" byte to 1
NEXT_STEP_4:
		ldi R3, #5	// Prep 160 = 10100000
		ls 	R3, #5
    ldi R2, [R3]
    ldr R0, [R2]  // get the byte with pattern stored in bits 7:3
    rs R0, 3      // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
		ldi R3, #6		// Prep 195 = 11000011
		ls	R3, #5
		addi R3, #3   
	  ldr R2, [R3] // R2 is the index of the current byte in the string
    ldr R1, [R2]  // R1 is the current byte in the string
    ls R1, 4      // R1 is [3:0]0000
    rs R1, 4      // R1 is 0000[3:0]
    rs R0, 1      // R0 is 0000[first four bits of the pattern]
    eq R1, R0     // R1 is 1 if the last four bits of the current string byte are the first four bits of the pattern, 0 otherwise
    ldi R0, 0
    ldi R2, [address of NEXT_STEP_5]
    beq // go to NEXT_STEP_5 if the pattern is not already a partial match, otherwise PC=PC+1 (default increment)
  	ldi R3, #5	// Prep 160 = 10100000
		ls 	R3, #5
		ldi R2, [R3]
    ldr R0, [R2]  // get the byte with pattern stored in bits 7:3
    rs R0, 3      // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
		ldi R3, #6		// Prep 195
		ls 	R3, #5
		addi R3, #3
    ldr R2, [R3] // R2 is the index of the current byte in the string
    addi R2, 1    // R2 is the index of the next byte in the string
    ldr R1, [R2]  // R1 is the next byte in the string
    rs R1, 7      // R1 is 00000007 (bit 7 of the next byte in the string)
    ls R0, 7      // R0 is P0000000 (P is last bit in pattern)
    rs R0, 7      // R0 is 0000000P (P is last bit in pattern)
    eq R1, R0     // true if bit 7 in next string byte is last bit in the pattern
    ldi R0, 0
    ldi R2, [address of NEXT_STEP_5]
    beq           // go to NEXT_STEP_5 if the remainder of the pattern is not a match, otherwise PC=PC+1 (default increment)
		ldi R3, #6		// Prep 194
		ls 	R3, #5
		addi R3, #2		
		ldi R1, [R3]
    addi R1, 1
    str [R3], R1
NEXT_STEP_5:
		ldi R3, #5	// Prep 160 = 10100000
		ls 	R3, #5
    ldi R2, [R3]
    ldr R0, [R2]  // get the byte with pattern stored in bits 7:3
    rs R0, 3      // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
		ldi R3, #6		// Prep 195
		ls 	R3, #5
		addi R3, #3		
    ldr R2, [R3] // R2 is the index of the current byte in the string
    ldr R1, [R2]  // R1 is the current byte in the string
    ls R1, 5      // R1 is [2:0]0000
    rs R1, 5      // R1 is 00000[2:0]
    rs R0, 2      // R0 is 00000[first 3 bits of the pattern]
    eq R1, R0     // R1 is 1 if the last four bits of the current string byte are the first four bits of the pattern, 0 otherwise
    ldi R0, 0
    ldi R2, [address of NEXT_STEP_6]
    beq // go to NEXT_STEP_5 if the pattern is not already a partial match, otherwise PC=PC+1 (default increment)
		ldi R3, #5	// Prep 160 = 10100000
		ls 	R3, #5
    ldi R2, [R3]
    ldr R0, [R2]  // get the byte with pattern stored in bits 7:3
    rs R0, 3      // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
		ldi R3, #6		// Prep 195
		ls 	R3, #5
		addi R3, #3
    ldr R2, [R3] // R2 is the index of the current byte in the string
    addi R2, 1    // R2 is the index of the next byte in the string
    ldr R1, [R2]  // R1 is the next byte in the string
    rs R1, 6      // R1 is 0000007:6 (bits 7:6 of the next byte in the string)
    ls R0, 6      // R0 is PP000000 (P's are last two bits in pattern)
    rs R0, 6      // R0 is 000000PP (P's are last two bit in pattern)
    eq R1, R0     // true if bits 7:6 in next string byte is last bit in the pattern
    ldi R0, 0
    ldi R2, [address of NEXT_STEP_6]
    beq           // go to NEXT_STEP_6 if the remainder of the pattern is not a match, otherwise PC=PC+1 (default increment)
		ldi R3, #6		// Prep 194 = 11000010
		ls R3, #5
		addi R3, #2    
		ldi R1, [R3]
    addi R1, 1
    str [R3], R1
NEXT_STEP_6:
		ldi R3, #5	// Prep 160 = 10100000
		ls 	R3, #5
    ldi R2, [R3]
    ldr R0, [R2]  // get the byte with pattern stored in bits 7:3
    rs R0, 3      // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
		ldi R3, #6		// Prep 195
		ls 	R3, #5
		addi R3, #3
    ldr R2, [R3] // R2 is the index of the current byte in the string
    ldr R1, [R2]  // R1 is the current byte in the string
    ls R1, 6      // R1 is [1:0]00000
    rs R1, 6      // R1 is 000000[1:0]
    rs R0, 3      // R0 is 000000[first 2 bits of the pattern]
    eq R1, R0     // R1 is 1 if the last four bits of the current string byte are the first four bits of the pattern, 0 otherwise
    ldi R0, 0
    ldi R2, [address of NEXT_STEP_7]
    beq // go to NEXT_STEP_7 if the pattern is not already a partial match, otherwise PC=PC+1 (default increment)
		ldi R3, #5	// Prep 160 = 10100000
		ls 	R3, #5
    ldi R2, [R3]
    ldr R0, [R2]  // get the byte with pattern stored in bits 7:3
    rs R0, 3      // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
		ldi R3, #6		// Prep 195
		ls 	R3, #5
		addi R3, #3
    ldr R2, [R3] // R2 is the index of the current byte in the string
    addi R2, 1    // R2 is the index of the next byte in the string
    ldr R1, [R2]  // R1 is the next byte in the string
    rs R1, 5      // R1 is 000007:5 (bits 7:5 of the next byte in the string)
    ls R0, 5      // R0 is PPP00000 (P's are last three bits in pattern)
    rs R0, 5      // R0 is 00000PPP (P's are last three bit in pattern)
    eq R1, R0     // true if bit 7:5 in next string byte is last bit in the pattern
    ldi R0, 0
    ldi R2, [address of NEXT_STEP_7]
    beq           // go to NEXT_STEP_7 if the remainder of the pattern is not a match, otherwise PC=PC+1 (default increment)
		ldi R3, #6		// Prep 194 = 11000010
		ls R3, #5
		addi R3, #2        
		ldi R1, [R3]
    addi R1, 1
    str [R3], R1
NEXT_STEP_7:
		ldi R3, #5	// Prep 160 = 10100000
		ls 	R3, #5
    ldi R2, [R3]
    ldr R0, [R2]  // get the byte with pattern stored in bits 7:3
    rs R0, 3      // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
		ldi R3, #6		// Prep 195
		ls 	R3, #5
		addi R3, #3
    ldr R2, [R3] // R2 is the index of the current byte in the string
    ldr R1, [R2]  // R1 is the current byte in the string
    ls R1, 7      // R1 is [bit 0 of current byte of string]0000000
    rs R1, 7      // R1 is 0000000[bit 0 of current byte of string0]
    rs R0, 4      // R0 is 0000000[first bit of the pattern]
    eq R1, R0     // R1 is 1 if the last four bits of the current string byte are the first four bits of the pattern, 0 otherwise
    ldi R0, 0
    ldi R2, [address of NEXT_STEP_8]
    beq // go to NEXT_STEP_8 if the pattern is not already a partial match, otherwise PC=PC+1 (default increment)
		ldi R3, #5	// Prep 160 = 10100000
		ls 	R3, #5
    ldi R2, [R3]
    ldr R0, [R2]  // get the byte with pattern stored in bits 7:3
    rs R0, 3      // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
		ldi R3, #6		// Prep 195
		ls 	R3, #5
		addi R3, #3
    ldr R2, [R3] // R2 is the index of the current byte in the string
    addi R2, 1    // R2 is the index of the next byte in the string
    ldr R1, [R2]  // R1 is the next byte in the string
    rs R1, 4      // R1 is 00007:4 (bits 7:4 of the next byte in the string)
    ls R0, 4      // R0 is PPPP00000 (P's are last 4 bits in pattern)
    rs R0, 4      // R0 is 00000PPP (P's are last 4 bits in pattern)
    eq R1, R0     // true if bits 7:4 in next string byte is last bit in the pattern
    ldi R0, 0
    ldi R2, [address of NEXT_STEP_8]
    beq           // go to NEXT_STEP_8 if the remainder of the pattern is not a match, otherwise PC=PC+1 (default increment)
		ldi R3, #6		// Prep 194 = 11000010
		ls R3, #5
		addi R3, #2      
	  ldi R1, [R3]
    addi R1, 1
    str [R3], R1
NEXT_STEP_8
		ldi R3, #6		// Prep 195
		ls 	R3, #5
		addi R3, #3
    ldi R1, [R3]
    addi R1, 1
    str [R3], R1
		ldi R0, #5	// Prep 160 = 10100000
		ls 	R0, #5  // 1 byte past the string (string is on bytes 128:159)
		ldi R3, #6		// Prep 195
		ls 	R3, #5
		addi R3, #3    
		ldi R1, [R3]   // get the current index
    neq R1, R0      // true if current index has not yet reached 160
    ldi R2, [address of L1] // preparing to conditionally branch here to repeat the operation
    ldi R0, 1
    beq // go to address of L1 if R0 != R1 (i.e. if R1, the current index, is not equal to 160)...otherwise, continue, i.e. program is finished
    end