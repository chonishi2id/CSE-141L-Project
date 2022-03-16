ldi r2, #0              // R2 = 0: number of times 5-bit pattern recognized within byte boundaries initially 0
ldi r1, #3              // R1 = 00000011
ls r1, #6              // R1 = 11000000 = 192
str r1, r2              // data_mem[192] = 0: total number of times the 5-bit pattern occurs (byte boundaries ON) is initially 0
addi r1, #1             // R1 = 193
str r1, r2              // data_mem[193] = 0: total number of bytes within which the 5-bit pattern occurs is initially 0
addi r1, #1             // R1 = 194
str r1, r2              // data_mem[194] = 0: total number of times the 5-bit pattern occurs (byte boundaries OFF) is initially 0
ldi r2, #1              // R2 = 00000001
ls r2, #7               // R2 = 10000000 = 128: index of the current byte of memory we are referencing while scanning the input string initially 128 (first byte)
addi r1, #1             // R1 = 194+1=195: this is the address we will store the index  
str r1, r2              // data_mem[195] = 128: keeping track of current index by storing it in memory (because we will need all three registers sometimes)
ldi r2, #0              // 'L1:' flag indicating the pattern was recognized within the current byte initially 0 (false)
addi r1, #1             // R1 = 195+1=196
str r1, r2              // data_mem[196] = 0
ldi r3, #5              // R3 = 00000101
ls r3, #5               // R3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldr r0, r3              // R0 = data_mem[160] = PPPPPxxx (get the byte with pattern stored in bits 7:3)
rs r0, #3                // R0 = 000PPPPP (shift the top 5 bits to the lower 5, padding most significant bits with 0s to get 000PPPPP)
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000
addi r3, #3             // R3 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
ldr r1, r3              // R1 = data_mem[195] = index of current byte in string = 128 initially
rs r1, #3               // right shift R1 by 3, padding with 0s...we have 000_(bits 7:3 of input string)
eq r1, r0               // R1 = (R1 == R0); [1 if true, 0 if false]
ldi r3, #3              // R3 = 00000011
ls r3, #6              // R3 = 11000000 = 192
addi r3, #2             // R3 = 11000010 = 194 (i.e. storage addr for total number of times 5-bit pattern occurs with byte boundaries OFF)
ldr r2, r3              // R2 = data_mem[194] (current total number of times 5-bit pattern occurs with byte boundaries OFF)
add r2, r1              // R2 = R2 + R1 (+1 if the pattern was recognized, +0 if not)
str r3, r2              // data_mem[194] = R2 (store updated total)
ldi r0, #1
eq r0, r1
ldi r3 #1               // R3 = 00000001
ls r3, #4               // R3 = 00010000 = 16
addi r3, #2             // R3 = 00010010 = 18 (OFFSET to 'NEXT_STEP_1')
bnzr r3, r0             // if (R0==R1) PC += R3, else PC = PC + 1 (default PC increment)
ldi r3, #3              // R3 = 00000011
ls r3, #6              // R3 = 11000000 = 192
ldr r2, r3              // R2 = data_mem[192]: if here, we did not jump, therefore we know R1 == 1 (i.e. pattern found in current byte)
addi r2, #1              // first, increment number of times pattern found with byte boundaries ON
str r3, r2              // data_mem[192] = R2 (i.e. previous data_mem[192] + 1)
addi r3, #4             // R3 = 192+4=196
ldr r2, r3              // R2 = data_mem[196] (get flag indicating pattern was found in current byte)
str r3, #1              // we found the pattern, so set the --pattern found in current byte-- byte to 1
neq r1, r2              // R1 = R1 != R2 : used to increment number of bytes containing pattern if necessary. since we know R1 = 1, it will stay 1 if R2 is 0 (pattern not found in current byte), and become 0 otherwise
ldi r3, #3              // R3 = 00000011
ls r3, #6              // R3 = 11000000 = 192
addi r3, #1             // R3 = 192+1=193
ldr r2, r3              // R2 = data_mem[193] (i.e. number of bytes in which pattern was recognized)
add r2, r1              // R2 = R2 + R1 (+1 if pattern was not already found in current byte, +0 otherwise
str r3, r2              // data_mem[193] = R2 (update number of bytes in which pattern was recognized)
ldi r2, #5              // R2 = 00000101
ls r2, #5               // R2 = 10100000 = 160 'NEXT_STEP_1:' put 5-bit pattern to recognize in R0
ldr r0, r2              // R0 = data_mem[R2] (get the byte with pattern stored in bits 7:3)
rs r0, #3                // shift the top 5 bits to the lower 5, padding most significant bits with 0s to get 0007:3
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000
addi r3, #3             // R3 = 11000011 = 195
ldi r2, r3              // R2 = data_mem[195] = current index // data_mem[idx] bits 6:2
ldr r1, r2              // R1 = data_mem[current_index]
ls r1, #1                // left shift R1 by 1, fill least significant bits with 0s...we have [6:0]0
rs r1, #3                // right shift R1 by 2, padding most significant bits with 0s...we have 000[6:2]
eq r1, r0               // R1 = (R1 == R0); [1 if true, 0 if false]
ldi r3, #3              // R3 = 00000011 = 3
ls r3, #6               // R3 = 11000000
addi r3, #2             // R3 = 11000010 = 194
ldr r2, r3              // R2 = data_mem[194] (total number of times 5-bit pattern occurs with byte boundaries OFF)
add r2, r1              // +1 if the pattern was recognized, +0 if not
str r3, r2              // data_mem[194] = R2 store updated total
ldi r0, #1
eq r0, r1
ldi r3 #1               // R3 = 00000001
ls r3, #4               // R3 = 00010000 = 16
addi r3, #2             // R3 = 00010010 = 18 (OFFSET to 'NEXT_STEP_2')
bnzr r3, r0             // if (R0==R1) PC += OFFSET (to 'NEXT_STEP_2'), else PC = PC + 1 (default PC increment)
ldi r3, #3              // R3 = 00000011
ls r3, #6              // R3 = 11000000 = 192
ldr r2, r3              // R2 = data_mem[192] (if here, we did not jump, therefore we know R1 == 1 (i.e. pattern found in current byte)) // first, increment number of times pattern found with byte boundaries ON
addi r2, #1              // R2 = R2 + 1
str r3, r2              // data_mem[192] = R2
addi r3, #4             // R3 = 196
ldr r2, r3              // R2 = data_mem[196] (second, increment number of bytes containing pattern if necessary) // get flag indicating pattern was found in current byte   
neq r1, r2              // since we know R1 = 1, this will be 1 if R2 is 0, and 0 otherwise
ldi r3, #3              // R3 = 00000011
ls r3, #6              // R3 = 11000000 = 192
addi r3, #1             // R3 = 11000001 = 193
ldr r2, r3              // get number of bytes in which pattern was recognized
add r2, r1              // recall that R1 is now 1 if the pattern was found and the "pattern found in current byte" byte was false, 0 otherwise, so we increment in the proper instance
addi r3, #3             // R3 = 196
str r3, #1               // we found the pattern, so set the "pattern found in current byte" byte to 1   
ldi r3, #5              // R2 = 00000101
ls r3, #5               // R2 = 10100000 = 160 'NEXT_STEP_1:' put 5-bit pattern to recognize in R0
ldi r2, r3              // 'NEXT_STEP_2:' put 5-bit pattern to recognize in R0
ldr r0, r2              // R0 = data_mem[R2] (get the byte with pattern stored in bits 7:3)
rs r0, #3                // shift the top 5 bits to the lower 5, padding MSBs with 0s to get 0007:3
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000
addi r3, #3             // R3 = 11000011 = 195
ldi r2, r3              // R2 = data_mem[195] (going for data_mem[idx] bits 5:1), R2 = current index
ldr r1, r2              // R1 = data_mem[R2] = data_mem[current_index]
ls r1, #2                // left shift R1 by 2, fill least significant bits with 0s...we have [5:0]00
rs r1, #3                // right shift R1 by 3, padding with 0s...we have 000[5:1]
eq r1, r0               // R1 = (R1 == R0); [1 if true, 0 if false]
ldi r3, #3              // R3 = 00000011 = 3
ls r3, #6               // R3 = 11000000
addi r3, #2             // R3 = 11000010 = 194
ldr r2, r3              // R2 = data_mem[194] (total number of times 5-bit pattern occurs with byte boundaries OFF)
add r2, r1              // +1 if the pattern was recognized, +0 if not
str r3, r2              // data_mem[194] = R2 (store updated total_
ldi r0, #1
eq r0, r1
ldi r3 #1               // R3 = 00000001
ls r3, #4               // R3 = 00010000 = 16
addi r3, #6             // R3 = 00010010 = 22 (OFFSET to 'NEXT_STEP_3')
bnzr r3, r0             // if (R0==R1) PC += OFFSET to 'NEXT_STEP_3', else PC = PC + 1 (default PC increment)
ldi r3, #3              // R3 = 00000011
ls r3, #6              // R3 = 11000000 = 192
ldr r2, r3              // if here, we did not jump, therefore we know R1 == 1 (i.e. pattern found in current byte) // first, increment number of times pattern found with byte boundaries ON
addi r2, #1
str r3, r2
ldi r3, #3              // R3 = 00000011
ls r3, #6              // R3 = 11000000 = 192
addi r3, #4             // R3 = 11000100 = 196
ldr r2, r3              // second, increment number of bytes containing pattern if necessary // get flag indicating pattern was found in current byte   
neq r1, r2              // since we know R1 = 1, this will be 1 if R2 is 0, and 0 otherwise
ldi r3, #3              // R3 = 00000011
ls r3, #6              // R3 = 11000000 = 192
addi r3, #1             // R3 = 11000001 = 193
ldr r2, r3              // get number of bytes in which pattern was recognized
add r2, r1              // recall that R1 is now 1 if the pattern was found and the "pattern found in current byte" byte was false, 0 otherwise, so we increment in the proper instance
ldi r3, #3              // R3 = 00000011
ls r3, #6              // R3 = 11000000 = 192
addi r3, #4             // R3 = 11000100 = 196
str r3, #1               // we found the pattern, so set the "pattern found in current byte" byte to 1   
ldi r3, #5              // R3 = 00000101
ls r3, #5               // R3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldi r2, r3              // 'NEXT_STEP_3:' put 5-bit pattern to recognize in R0
ldr r0, r2              // get the byte with pattern stored in bits 7:3
rs r0, #3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000
addi r3, #3             // R3 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
ldi r2, r3              // data_mem[idx] bits 4:0 // max immediate is 7, will do shifts and adds to get 195...R2 = current index
ldr r1, r2              // R1 = data_mem[current_index]
ls r1, #3                // left shift R1 by 3, fill least significant bits with 0s...we have [4:0]000
rs r1, #4                // right shift R1 by 3, padding with 0s...we have 0000[4:0]
eq r1, r0               // R1 = (R1 == R0); [1 if true, 0 if false]
ldi r3, #3              // R3 = 00000011 = 3
ls r3, #6               // R3 = 11000000
addi r3, #2             // R3 = 11000010 = 194
ldr r2, r3              // total number of times 5-bit pattern occurs with byte boundaries OFF
add r2, r1              // +1 if the pattern was recognized, +0 if not
str r3, r2              // max immediate is 7, will do shifts and adds to get 194...store updated total
ldi r0, #1
eq r0, r1
ldi r3 #1               // R3 = 00000001
ls r3, #4               // R3 = 00010000 = 16
addi r3, #6             // R3 = 00010010 = 22 (OFFSET to 'NEXT_STEP_4')
bnzr r3, r0             // if (R0==R1) PC += OFFSET to 'NEXT_STEP_4', else PC = PC + 1 (default PC increment)
ldi r3, #3              // R3 = 00000011
ls r3, #6              // R3 = 11000000 = 192
ldr r2, r3              // if here, we did not jump, therefore we know R1 == 1 (i.e. pattern found in current byte) // first, increment number of times pattern found with byte boundaries ON
addi r2, #1
str r3, r2
ldi r3, #3              // R3 = 00000011
ls r3, #6              // R3 = 11000000 = 192
addi r3, #4             // R3 = 11000100 = 196
ldr r2, r3              // second, increment number of bytes containing pattern if necessary // get flag indicating pattern was found in current byte   
neq r1, r2              // since we know R1 = 1, this will be 1 if R2 is 0, and 0 otherwise
ldi r3, #3              // R3 = 00000011
ls r3, #6              // R3 = 11000000 = 192
addi r3, #1             // R3 = 11000001 = 193
ldr r2, r3              // get number of bytes in which pattern was recognized
add r2, r1              // recall that R1 is now 1 if the pattern was found and the "pattern found in current byte" byte was false, 0 otherwise, so we increment in the proper instance
ldi r3, #3              // R3 = 00000011
ls r3, #6              // R3 = 11000000 = 192
addi r3, #4             // R3 = 11000100 = 196
str r3, #1              // we found the pattern, so set the "pattern found in current byte" byte to 1
ldi r3, #5              // R3 = 00000101
ls r3, #5               // R3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldi r2, r3              // 'NEXT_STEP_4:' put 5-bit pattern to recognize in R0
ldr r0, r2              // get the byte with pattern stored in bits 7:3
rs r0, #3               // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3 
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000
addi r3, #3             // R3 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
ldr r2, r3              // data_mem[idx] bits 3:0 , data_mem[idx+1] bit 7 // R2 is the index of the current byte in the string
ldr r1, r2              // R1 is the current byte in the string
ls r1, #4               // R1 is [3:0]0000
rs r1, #4               // R1 is 0000[3:0]
rs r0, #1               // R0 is 0000[first four bits of the pattern]
neq r1, r0              // R1 is 0 if the last four bits of the current string byte are the first four bits of the pattern, 0 otherwise
ldi r3, #3              // R3 = 00000011
ls r3, #3               // R3 = 00011000
add r3, #3              // R3 = 00011011 = 27 = OFFSET to NEXT_STEP_5
bnzr r3, r1             // PC += OFFSET to NEXT_STEP_5 if the pattern is not already a partial match, otherwise PC=PC+1 (default increment)
ldi r3, #5              // R3 = 00000101
ls r3, #5               // R3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldi r2, r3              // put 5-bit pattern to recognize in R0
ldr r0, r2              // get the byte with pattern stored in bits 7:3
rs r0, #3               // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000
addi r3, #3             // R3 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
ldr r2, r3              // data_mem[idx+1] bit 7 // R2 is the index of the current byte in the string
addi r2, #1             // R2 is the index of the next byte in the string
ldr r1, r2              // R1 is the next byte in the string
rs r1, #7               // R1 is 00000007 (bit 7 of the next byte in the string)
ls r0, #7               // R0 is P0000000 (P is last bit in pattern)
rs r0, #7               // R0 is 0000000P (P is last bit in pattern)
neq r1, r0              // true if bit 7 in next string byte is last bit in the pattern
ldi r3, #7
addi r3, #3             // OFFSET to NEXT_STEP_5 = 10
bnzr r3, r1             // go to NEXT_STEP_5 if the remainder of the pattern is not a match, otherwise PC=PC+1 (default increment)
ldi r3, #3              // R3 = 00000011 = 3
ls r3, #6               // R3 = 11000000
addi r3, #2             // R3 = 11000010 = 194
ldi r1, r3              // pattern was found crossing over bytes, increment the number of times pattern was found without regard to byte boundaries
addi r1, #1
str r3, r1
ldi r3, #5              // R3 = 00000101
ls r3, #5               // R3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldi r2, r3              // 'NEXT_STEP_5:' put 5-bit pattern to recognize in R0
ldr r0, r2              // get the byte with pattern stored in bits 7:3
rs r0, #3               // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000
addi r3, #3             // R3 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
ldr r2, r3              // data_mem[idx] bits 2:0 , data_mem[idx+1] bits 7:6 // R2 is the index of the current byte in the string
ldr r1, r2              // R1 is the current byte in the string
ls r1, #5               // R1 is [2:0]0000
rs r1, #5               // R1 is 00000[2:0]
rs r0, #2               // R0 is 00000[first 3 bits of the pattern]
neq r1, r0              // R1 is 1 if the last four bits of the current string byte are the first four bits of the pattern, 0 otherwise
ldi r0, #0
ldi r3, #7              // R3 = 00000111
ls r3, #2               // R3 = 00011100 = 28 = OFFSET to NEXT_STEP_6
bnzr r3, r1             // go to NEXT_STEP_6 if the pattern is not already a partial match, otherwise PC=PC+1 (default increment)
ldi r3, #5              // R3 = 00000101
ls r3, #5               // R3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldi r2, r3              // put 5-bit pattern to recognize in R0
ldr r0, r2              // get the byte with pattern stored in bits 7:3
rs r0, #3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000
addi r3, #3             // R3 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
ldr r2, r3              // data_mem[idx+1] bits 7:6 // R2 is the index of the current byte in the string
addi r2, #1              // R2 is the index of the next byte in the string
ldr r1, r2              // R1 is the next byte in the string
rs r1, #6               // R1 is 0000007:6 (bits 7:6 of the next byte in the string)
ls r0, #6               // R0 is PP000000 (Ps are last two bits in pattern)
rs r0, #6               // R0 is 000000PP (Ps are last two bit in pattern)
neq r1, r0              // true if bits 7:6 in next string byte is last bit in the pattern
ldi r0, #0
ldi r3, #7
addi r3, #2             // R3 = 9 = OFFSET to NEXT_STEP_6
bnzr r3, r1             // go to NEXT_STEP_6 if the remainder of the pattern is not a match, otherwise PC=PC+1 (default increment)
ldi r3, #3              // R3 = 00000011 = 3
ls r3, #6               // R3 = 11000000
addi r3, #2             // R3 = 11000010 = 194
ldi r1, r3              // pattern was found crossing over bytes, increment the number of times pattern was found without regard to byte boundaries
addi r1, #1
str r3, r1
ldi r3, #5              // R3 = 00000101
ls r3, #5               // R3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldi r2, r3              // 'NEXT_STEP_6:' put 5-bit pattern to recognize in R0
ldr r0, r2              // get the byte with pattern stored in bits 7:3
rs r0, #3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000
addi r3, #3             // R3 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
ldr r2, r3              // data_mem[idx] bits 1:0 , data_mem[idx+1] bits 7:5 // R2 is the index of the current byte in the string
ldr r1, r2              // R1 is the current byte in the string
ls r1, #6                // R1 is [1:0]00000
rs r1, #6                // R1 is 000000[1:0]
rs r0, #3                // R0 is 000000[first 2 bits of the pattern]
neq r1, r0               // R1 is 1 if the last four bits of the current string byte are the first four bits of the pattern, 0 otherwise
ldi r0, #0
ldi r3, #7              // R3 = 00000111
ls r3, #2               // R3 = 00011100 = 28 = OFFSET to NEXT_STEP_6
bnzr r3, r1             // go to NEXT_STEP_7 if the pattern is not already a partial match, otherwise PC=PC+1 (default increment)
ldi r3, #5              // R3 = 00000101
ls r3, #5               // R3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldi r2, r3              // put 5-bit pattern to recognize in R0
ldr r0, r2              // get the byte with pattern stored in bits 7:3
rs r0, #3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldi r3, #3              // R3 = 00000011
ls r3, #6              // R3 = 11000000 = 192
addi r3, #3             // R3 = 11000011 = 195
ldr r2, r3              // data_mem[idx+1] bits 7:5 // R2 is the index of the current byte in the string
addi r2, #1              // R2 is the index of the next byte in the string
ldr r1, r2              // R1 is the next byte in the string
rs r1, #5                // R1 is 000007:5 (bits 7:5 of the next byte in the string)
ls r0, #5                // R0 is PPP00000 (Ps are last three bits in pattern)
rs r0, #5                // R0 is 00000PPP (Ps are last three bit in pattern)
neq r1, r0               // true if bit 7:5 in next string byte is last bit in the pattern
ldi r0, #0
ldi r3, #7
addi r3, #2             // R3 = 9 = OFFSET to NEXT_STEP_7
bnzr r3, r1             // go to NEXT_STEP_7 if the remainder of the pattern is not a match, otherwise PC=PC+1 (default increment)
ldi r3, #3              // R3 = 00000011 = 3
ls r3, #6               // R3 = 11000000
addi r3, #2             // R3 = 11000010 = 194
ldi r1, r3              // pattern was found crossing over bytes, increment the number of times pattern was found without regard to byte boundaries
addi r1, #1
str r3, r1
ldi r3, #5              // R3 = 00000101
ls r3, #5               // R3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldi r2, r3              // 'NEXT_STEP_7:' put 5-bit pattern to recognize in R0
ldr r0, r2              // get the byte with pattern stored in bits 7:3
rs r0, #3                // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000
addi r3, #3             // R3 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
ldr r2, r3              // data_mem[idx] bit 0 , data_mem[idx+1] bits 7:4 // R2 is the index of the current byte in the string
ldr r1, r2              // R1 is the current byte in the string
ls r1, #7                // R1 is [bit 0 of current byte of string]0000000
rs r1, #7                // R1 is 0000000[bit 0 of current byte of string0]
rs r0, #4                // R0 is 0000000[first bit of the pattern]
neq r1, r0               // R1 is 1 if the last four bits of the current string byte are the first four bits of the pattern, 0 otherwise
ldi r0, #0
ldi r3, #7              // R3 = 00000111
ls r3, #2               // R3 = 00011100
addi r3, #1             // R3 = 29 = OFFSET to NEXT_STEP_8
bnzr r3, r1             // go to NEXT_STEP_8 if the pattern is not already a partial match, otherwise PC=PC+1 (default increment)
ldi r3, #5              // R3 = 00000101
ls r3, #5               // R3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldi r2, r3              // put 5-bit pattern to recognize in R0
ldr r0, r2              // get the byte with pattern stored in bits 7:3
rs r0, #3               // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000
addi r3, #3             // R3 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
ldr r2, r3              // data_mem[idx+1] bits 7:4 // R2 is the index of the current byte in the string
addi r2, #1             // R2 is the index of the next byte in the string
ldr r1, r2              // R1 is the next byte in the string
rs r1, #4               // R1 is 00007:4 (bits 7:4 of the next byte in the string)
ls r0, #4               // R0 is PPPP00000 (Ps are last 4 bits in pattern)
rs r0, #4               // R0 is 00000PPP (Ps are last 4 bits in pattern)
neq r1, r0              // true if bits 7:4 in next string byte is last bit in the pattern
ldi r0, #0
ldi r3, #7
addi r3, #3             // R3 = 10 = OFFSET to NEXT_STEP_8
bnzr r3, r1             // go to NEXT_STEP_8 if the remainder of the pattern is not a match, otherwise PC=PC+1 (default increment)
ldi r3, #3              // R3 = 00000011 = 3
ls r3, #6               // R3 = 11000000
addi r3, #2             // R3 = 11000010 = 194
ldi r1, r3              // pattern was found crossing over bytes, increment the number of times pattern was found without regard to byte boundaries
addi r1, #1
str r3, r1
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000
addi r3, #3             // R3 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
ldi r1, r3              // 'NEXT_STEP_8:' increment index of current byte in string
addi r1, #1
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000
addi r3, #3             // R3 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
str r3, r1
ldi r3, #5              // R3 = 00000101
ls r3, #5                          // branch back to L1 if idx < 160 // 1 byte past the string (string is on bytes 128:159)
ldi r0, r3
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000
addi r3, #3             // R3 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
ldi r1, r3              // get the current index
neq r1, r0              // true if current index has not yet reached 160
ldi r3, #7             // branch by offset at LUT[7] = -356
bnzl r3, r1             // go to address of L1 if R0 != R1 (i.e. if R1, the current index, is not equal to 160)...otherwise, continue, i.e. program is finished // end