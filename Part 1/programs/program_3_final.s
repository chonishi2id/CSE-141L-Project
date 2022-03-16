ldi R2, #0              // R2 = 0: number of times 5-bit pattern recognized within byte boundaries initially 0
ldi R1, #3              // R1 = 00000011
ls  R1, #6              // R1 = 11000000 = 192
str R1, R2              // data_mem[192] = 0: total number of times the 5-bit pattern occurs (byte boundaries ON) is initially 0
addi R1, #1             // R1 = 193
str R1, R2              // data_mem[193] = 0: total number of bytes within which the 5-bit pattern occurs is initially 0
addi R1, #1             // R1 = 194
str R1, R2              // data_mem[194] = 0: total number of times the 5-bit pattern occurs (byte boundaries OFF) is initially 0
ldi R2, #1              // R2 = 00000001
ls R2, #7               // R2 = 10000000 = 128: index of the current byte of memory we are referencing while scanning the input string initially 128 (first byte)
addi R1, #1             // R1 = 194+1=195: this is the address we will store the index  
str R1, R2              // data_mem[195] = 128: keeping track of current index by storing it in memory (because we will need all three registers sometimes)
ldi R2, #0              // 'L1:' flag indicating the pattern was recognized within the current byte initially 0 (false)
addi R1, #1             // R1 = 195+1=196
str R1, R2              // data_mem[196] = 0
ldi R2, #5              // R2 = 00000101
ls R2, #5               // R2 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldr R0, R2              // R0 = data_mem[160] = PPPPPxxx (get the byte with pattern stored in bits 7:3)
rs R0, 3                // R0 = 000PPPPP (shift the top 5 bits to the lower 5, padding most significant bits with 0s to get 000PPPPP)
ldi R2, #3              // R2 = 00000011
ls R2, #6               // R2 = 11000000
addi R2, #3             // R2 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
ldr R1, R2              // R1 = data_mem[195] = index of current byte in string = 128 initially
rs R1, #3               // right shift R1 by 3, padding with 0s...we have 000_(bits 7:3 of input string)
eq R1, R0               // R1 = (R1 == R0); [1 if true, 0 if false]
ldi R4, #3              // R4 = 00000011
ls  R4, #6              // R4 = 11000000 = 192
addi R4, #2             // R4 = 11000010 = 194 (i.e. storage addr for total number of times 5-bit pattern occurs with byte boundaries OFF)
ldr R2, R4              // R2 = data_mem[194] (current total number of times 5-bit pattern occurs with byte boundaries OFF)
add R2, R1              // R2 = R2 + R1 (+1 if the pattern was recognized, +0 if not)
str R4, R2              // data_mem[194] = R2 (store updated total)
ldi R2, ['NEXT_STEP_1'] // check whether R1 is 1, else go to NEXT_STEP_2
ldi R0, 1
beq                     // if (R0==R1) PC = [R2] (jump to that instruction address), else PC = PC + 1 (default PC increment)
ldi R4, #3              // R4 = 00000011
ls  R4, #6              // R4 = 11000000 = 192
ldr R2, R4              // R2 = data_mem[192]: if here, we did not jump, therefore we know R1 == 1 (i.e. pattern found in current byte)
addi R2, 1              // first, increment number of times pattern found with byte boundaries ON
str R4, R2              // data_mem[192] = R2 (i.e. previous data_mem[192] + 1)
addi R4, #4             // R4 = 192+4=196
ldr R2, R4              // R2 = data_mem[196] (get flag indicating pattern was found in current byte)
str R4, #1              // we found the pattern, so set the --pattern found in current byte-- byte to 1
neq R1, R2              // R1 = R1 != R2 : used to increment number of bytes containing pattern if necessary. since we know R1 = 1, it will stay 1 if R2 is 0 (pattern not found in current byte), and become 0 otherwise
ldi R4, #3              // R4 = 00000011
ls  R4, #6              // R4 = 11000000 = 192
addi R4, #1             // R4 = 192+1=193
ldr R2, R4              // R2 = data_mem[193] (i.e. number of bytes in which pattern was recognized)
add R2, R1              // R2 = R2 + R1 (+1 if pattern was not already found in current byte, +0 otherwise
str R4, R2              // data_mem[193] = R2 (update number of bytes in which pattern was recognized)
ldi R2, [160]           // 'NEXT_STEP_1:' put 5-bit pattern to recognize in R0
ldr R0, [R2]            // get the byte with pattern stored in bits 7:3
rs R0, 3                // shift the top 5 bits to the lower 5, padding most significant bits with 0s to get 0007:3
ldi R2, [195]           // R2 = current index // data_mem[idx] bits 6:2
ldr R1, [R2]            // R1 = data_mem[current_index]
ls R1, 1                // left shift R1 by 1, fill least significant bits with 0s...we have [6:0]0
rs R1, 3                // right shift R1 by 2, padding most significant bits with 0s...we have 000[6:2]
eq R1, R0               // R1 = (R1 == R0); [1 if true, 0 if false]
ldr R2, [194]           // total number of times 5-bit pattern occurs with byte boundaries OFF
add R2, R1              // +1 if the pattern was recognized, +0 if not
str [194], R2           // max immediate is 7, will do shifts and adds to get 194...store updated total
ldi R2, [NEXT_STEP_2]   // check whether R1 is 1, else go to NEXT_STEP_2
ldi R0, 1
beq                     // if (R0==R1) PC = [R2] (jump to that instruction address), else PC = PC + 1 (default PC increment)
ldr R2, [192]           // if here, we did not jump, therefore we know R1 == 1 (i.e. pattern found in current byte) // first, increment number of times pattern found with byte boundaries ON
addi R2, 1
str [192], R2
ldr R2, [196]           // second, increment number of bytes containing pattern if necessary // get flag indicating pattern was found in current byte   
neq R1, R2              // since we know R1 = 1, this will be 1 if R2 is 0, and 0 otherwise
ldr R2, [193]           // get number of bytes in which pattern was recognized
add R2, R1              // recall that R1 is now 1 if the pattern was found and the "pattern found in current byte" byte was false, 0 otherwise, so we increment in the proper instance
str [196], 1            // we found the pattern, so set the "patter found in current byte" byte to 1   
ldi R2, [160]           // 'NEXT_STEP_2:' put 5-bit pattern to recognize in R0
ldr R0, [R2]            // get the byte with pattern stored in bits 7:3
rs R0, 3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldi R2, [195]           // data_mem[idx] bits 5:1 // max immediate is 7, will do shifts and adds to get 195...R2 = current index
ldr R1, [R2]            // R1 = data_mem[current_index]
ls R1, 2                // left shift R1 by 2, fill least significant bits with 0s...we have [5:0]00
rs R1, 3                // right shift R1 by 3, padding with 0s...we have 000[5:1]
eq R1, R0               // R1 = (R1 == R0); [1 if true, 0 if false]
ldr R2, [194]           // total number of times 5-bit pattern occurs with byte boundaries OFF
add R2, R1              // +1 if the pattern was recognized, +0 if not
str [194], R2           // max immediate is 7, will do shifts and adds to get 194...store updated total
ldi R2, [NEXT_STEP_3]   // check whether R1 is 1, else go to NEXT_STEP_3
ldi R0, 1
beq                     // if (R0==R1) PC = [R2] (jump to that instruction address), else PC = PC + 1 (default PC increment)
ldr R2, [192]           // if here, we did not jump, therefore we know R1 == 1 (i.e. pattern found in current byte) // first, increment number of times pattern found with byte boundaries ON
addi R2, 1
str [192], R2
ldr R2, [196]           // second, increment number of bytes containing pattern if necessary // get flag indicating pattern was found in current byte   
neq R1, R2              // since we know R1 = 1, this will be 1 if R2 is 0, and 0 otherwise
ldr R2, [193]           // get number of bytes in which pattern was recognized
add R2, R1              // recall that R1 is now 1 if the pattern was found and the "pattern found in current byte" byte was false, 0 otherwise, so we increment in the proper instance
str [196], 1            // we found the pattern, so set the "pattern found in current byte" byte to 1   
ldi R2, [160]           // 'NEXT_STEP_3:' put 5-bit pattern to recognize in R0
ldr R0, [R2]            // get the byte with pattern stored in bits 7:3
rs R0, 3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldi R2, [195]           // data_mem[idx] bits 4:0 // max immediate is 7, will do shifts and adds to get 195...R2 = current index
ldr R1, [R2]            // R1 = data_mem[current_index]
ls R1, 3                // left shift R1 by 3, fill least significant bits with 0s...we have [4:0]000
rs R1, 4                // right shift R1 by 3, padding with 0s...we have 0000[4:0]
eq R1, R0               // R1 = (R1 == R0); [1 if true, 0 if false]
ldr R2, [194]           // total number of times 5-bit pattern occurs with byte boundaries OFF
add R2, R1              // +1 if the pattern was recognized, +0 if not
str [194], R2           // max immediate is 7, will do shifts and adds to get 194...store updated total
ldi R2, [NEXT_STEP_4]   // check whether R1 is 1, else go to NEXT_STEP_4
ldi R0, 1
beq                     // if (R0==R1) PC = [R2] (jump to that instruction address), else PC = PC + 1 (default PC increment)
ldr R2, [192]           // if here, we did not jump, therefore we know R1 == 1 (i.e. pattern found in current byte) // first, increment number of times pattern found with byte boundaries ON
addi R2, 1
str [192], R2
ldr R2, [196]           // second, increment number of bytes containing pattern if necessary // get flag indicating pattern was found in current byte   
neq R1, R2              // since we know R1 = 1, this will be 1 if R2 is 0, and 0 otherwise
ldr R2, [193]           // get number of bytes in which pattern was recognized
add R2, R1              // recall that R1 is now 1 if the pattern was found and the "pattern found in current byte" byte was false, 0 otherwise, so we increment in the proper instance
str [196], 1            // we found the pattern, so set the "patter found in current byte" byte to 1
ldi R2, [160]           // 'NEXT_STEP_4:' put 5-bit pattern to recognize in R0
ldr R0, [R2]            // get the byte with pattern stored in bits 7:3
rs R0, 3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3 
ldr R2, [195]           // data_mem[idx] bits 3:0 , data_mem[idx+1] bit 7 // R2 is the index of the current byte in the string
ldr R1, [R2]            // R1 is the current byte in the string
ls R1, 4                // R1 is [3:0]0000
rs R1, 4                // R1 is 0000[3:0]
rs R0, 1                // R0 is 0000[first four bits of the pattern]
eq R1, R0               // R1 is 1 if the last four bits of the current string byte are the first four bits of the pattern, 0 otherwise
ldi R0, 0
ldi R2, [NEXT_STEP_5]
beq                     // go to NEXT_STEP_5 if the pattern is not already a partial match, otherwise PC=PC+1 (default increment)
ldi R2, [160]           // put 5-bit pattern to recognize in R0
ldr R0, [R2]            // get the byte with pattern stored in bits 7:3
rs R0, 3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldr R2, [195]           // data_mem[idx+1] bit 7 // R2 is the index of the current byte in the string
addi R2, 1              // R2 is the index of the next byte in the string
ldr R1, [R2]            // R1 is the next byte in the string
rs R1, 7                // R1 is 00000007 (bit 7 of the next byte in the string)
ls R0, 7                // R0 is P0000000 (P is last bit in pattern)
rs R0, 7                // R0 is 0000000P (P is last bit in pattern)
eq R1, R0               // true if bit 7 in next string byte is last bit in the pattern
ldi R0, 0
ldi R2, [NEXT_STEP_5]
beq                     // go to NEXT_STEP_5 if the remainder of the pattern is not a match, otherwise PC=PC+1 (default increment)
ldi R1, [194]           // pattern was found crossing over bytes, increment the number of times pattern was found without regard to byte boundaries
addi R1, 1
str [194], R1
ldi R2, [160]           // 'NEXT_STEP_5:' put 5-bit pattern to recognize in R0
ldr R0, [R2]            // get the byte with pattern stored in bits 7:3
rs R0, 3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldr R2, [195]           // data_mem[idx] bits 2:0 , data_mem[idx+1] bits 7:6 // R2 is the index of the current byte in the string
ldr R1, [R2]            // R1 is the current byte in the string
ls R1, 5                // R1 is [2:0]0000
rs R1, 5                // R1 is 00000[2:0]
rs R0, 2                // R0 is 00000[first 3 bits of the pattern]
eq R1, R0               // R1 is 1 if the last four bits of the current string byte are the first four bits of the pattern, 0 otherwise
ldi R0, 0
ldi R2, [NEXT_STEP_6]
beq                     // go to NEXT_STEP_5 if the pattern is not already a partial match, otherwise PC=PC+1 (default increment)
ldi R2, [160]           // put 5-bit pattern to recognize in R0
ldr R0, [R2]            // get the byte with pattern stored in bits 7:3
rs R0, 3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldr R2, [195]           // data_mem[idx+1] bits 7:6 // R2 is the index of the current byte in the string
addi R2, 1              // R2 is the index of the next byte in the string
ldr R1, [R2]            // R1 is the next byte in the string
rs R1, 6                // R1 is 0000007:6 (bits 7:6 of the next byte in the string)
ls R0, 6                // R0 is PP000000 (P's are last two bits in pattern)
rs R0, 6                // R0 is 000000PP (P's are last two bit in pattern)
eq R1, R0               // true if bits 7:6 in next string byte is last bit in the pattern
ldi R0, 0
ldi R2, [NEXT_STEP_6]
beq                     // go to NEXT_STEP_6 if the remainder of the pattern is not a match, otherwise PC=PC+1 (default increment)
ldi R1, [194]           // pattern was found crossing over bytes, increment the number of times pattern was found without regard to byte boundaries
addi R1, 1
str [194], R1
ldi R2, [160]           // 'NEXT_STEP_6:' put 5-bit pattern to recognize in R0
ldr R0, [R2]            // get the byte with pattern stored in bits 7:3
rs R0, 3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldr R2, [195]           // data_mem[idx] bits 1:0 , data_mem[idx+1] bits 7:5 // R2 is the index of the current byte in the string
ldr R1, [R2]            // R1 is the current byte in the string
ls R1, 6                // R1 is [1:0]00000
rs R1, 6                // R1 is 000000[1:0]
rs R0, 3                // R0 is 000000[first 2 bits of the pattern]
eq R1, R0               // R1 is 1 if the last four bits of the current string byte are the first four bits of the pattern, 0 otherwise
ldi R0, 0
ldi R2, [NEXT_STEP_7]
beq                     // go to NEXT_STEP_7 if the pattern is not already a partial match, otherwise PC=PC+1 (default increment)
ldi R2, [160]           // put 5-bit pattern to recognize in R0
ldr R0, [R2]            // get the byte with pattern stored in bits 7:3
rs R0, 3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldr R2, [195]           // data_mem[idx+1] bits 7:5 // R2 is the index of the current byte in the string
addi R2, 1              // R2 is the index of the next byte in the string
ldr R1, [R2]            // R1 is the next byte in the string
rs R1, 5                // R1 is 000007:5 (bits 7:5 of the next byte in the string)
ls R0, 5                // R0 is PPP00000 (P's are last three bits in pattern)
rs R0, 5                // R0 is 00000PPP (P's are last three bit in pattern)
eq R1, R0               // true if bit 7:5 in next string byte is last bit in the pattern
ldi R0, 0
ldi R2, [NEXT_STEP_7]
beq                     // go to NEXT_STEP_7 if the remainder of the pattern is not a match, otherwise PC=PC+1 (default increment)
ldi R1, [194]           // pattern was found crossing over bytes, increment the number of times pattern was found without regard to byte boundaries
addi R1, 1
str [194], R1
ldi R2, [160]           // 'NEXT_STEP_7:' put 5-bit pattern to recognize in R0
ldr R0, [R2]            // get the byte with pattern stored in bits 7:3
rs R0, 3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldr R2, [195]           // data_mem[idx] bit 0 , data_mem[idx+1] bits 7:4 // R2 is the index of the current byte in the string
ldr R1, [R2]            // R1 is the current byte in the string
ls R1, 7                // R1 is [bit 0 of current byte of string]0000000
rs R1, 7                // R1 is 0000000[bit 0 of current byte of string0]
rs R0, 4                // R0 is 0000000[first bit of the pattern]
eq R1, R0               // R1 is 1 if the last four bits of the current string byte are the first four bits of the pattern, 0 otherwise
ldi R0, 0
ldi R2, [NEXT_STEP_8]
beq                     // go to NEXT_STEP_8 if the pattern is not already a partial match, otherwise PC=PC+1 (default increment)
ldi R2, [160]           // put 5-bit pattern to recognize in R0
ldr R0, [R2]            // get the byte with pattern stored in bits 7:3
rs R0, 3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldr R2, [195]           // data_mem[idx+1] bits 7:4 // R2 is the index of the current byte in the string
addi R2, 1              // R2 is the index of the next byte in the string
ldr R1, [R2]            // R1 is the next byte in the string
rs R1, 4                // R1 is 00007:4 (bits 7:4 of the next byte in the string)
ls R0, 4                // R0 is PPPP00000 (P's are last 4 bits in pattern)
rs R0, 4                // R0 is 00000PPP (P's are last 4 bits in pattern)
eq R1, R0               // true if bits 7:4 in next string byte is last bit in the pattern
ldi R0, 0
ldi R2, [NEXT_STEP_8]
beq                     // go to NEXT_STEP_8 if the remainder of the pattern is not a match, otherwise PC=PC+1 (default increment)
ldi R1, [194]           // pattern was found crossing over bytes, increment the number of times pattern was found without regard to byte boundaries
addi R1, 1
str [194], R1
ldi R1, [195]           // 'NEXT_STEP_8:' increment index of current byte in string
addi R1, 1
str [195], R1
ldi R0, 160             // branch back to L1 if idx < 160 // 1 byte past the string (string is on bytes 128:159)
ldi R1, [195]           // get the current index
neq R1, R0              // true if current index has not yet reached 160
ldi R2, [address of L1] // preparing to conditionally branch here to repeat the operation
ldi R0, 1
beq                     // go to address of L1 if R0 != R1 (i.e. if R1, the current index, is not equal to 160)...otherwise, continue, i.e. program is finished // end
