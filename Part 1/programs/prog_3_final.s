






















































































































































































































































































































































































































































































































































































































































































































































































































































































ldi r2, #0              // r2 = 0: number of times 5-bit pattern recognized within byte boundaries initially 0
ldi r1, #3              // r1 = 00000011
ls r1, #6               // r1 = 11000000 = 192
str r1, r2              // data_mem[192] = 0: total number of times the 5-bit pattern occurs (byte boundaries ON) is initially 0
addi r1, #1             // r1 = 193
str r1, r2              // data_mem[193] = 0: total number of bytes within which the 5-bit pattern occurs is initially 0
addi r1, #1             // r1 = 194
str r1, r2              // data_mem[194] = 0: total number of times the 5-bit pattern occurs (byte boundaries OFF) is initially 0
ldi r3, #1              // r3 = 00000001
ls r3, #7               // r3 = 10000000 = 128: index of the current byte of memory we are referencing while scanning the input string initially 128 (first byte)
addi r1, #1             // r1 = 194+1=195: this is the address we will store the index  
str r1, r3              // data_mem[195] = 128: keeping track of current index by storing it in memory (because we will need all three registers sometimes)
ldi r2, #0              // r2 = 0 'L1:' flag indicating the pattern was recognized within the current byte initially 0 (false)
addi r1, #1             // r1 = 196
str r1, r2              // data_mem[196] = 0
ldi r3, #5              // r3 = 00000101
ls r3, #5               // r3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldr r0, r3              // r0 = 01010xxx = data_mem[160] (get the byte with pattern stored in bits 7:3)
rs r0, #3               // r0 = 00001010
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000
addi r3, #3             // r3 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
ldr r2, r3              // r2 = 128 = data_mem[195] = index of current byte in string = 128 initially
ldr r1, r2              // r1 = 01011010 = data_mem[128]
rs r1, #3               // r1 = 00001011 (i.e. 000_(bits 7:3 of input string))
eq r1, r0               // r1 = 0 = (r1 == r0) = (00001011 == 00001010)
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000 = 192
addi r3, #2             // r3 = 11000010 = 194 (i.e. storage addr for total number of times 5-bit pattern occurs with byte boundaries OFF)
ldr r2, r3              // r2 = 0 = data_mem[194] (current total number of times 5-bit pattern occurs with byte boundaries OFF)
add r2, r1              // r2 = 0 = 0 + 0 = r2 + r1 (+1 if the pattern was recognized, +0 if not)
str r3, r2              // data_mem[194] = 0 = r2 (store updated total)
ldi r0, #1              // r0 = 1
neq r0, r1              // r0 = 1 = (r0 != r1) = (1 != 0)
ldi r3 #1               // r3 = 00000001
ls r3, #4               // r3 = 00010000 = 16
addi r3, #2             // r3 = 00010010 = 18 (OFFSET to 'NEXT_STEP_1')
bnzr r3, r0             // r0 = 1 => branch to NEXT_STEP_1 (pattern not found)
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000 = 192
ldr r2, r3              // r2 = data_mem[192]: if here, we did not jump, therefore we know R1 == 1 (i.e. pattern found in current byte)
addi r2, #1             // first, increment number of times pattern found with byte boundaries ON
str r3, r2              // data_mem[192] = R2 (i.e. previous data_mem[192] + 1)
addi r3, #4             // r3 = 192+4=196
ldr r2, r3              // r2 = data_mem[196] (get flag indicating pattern was found in current byte)
str r3, #1              // we found the pattern, so set the --pattern found in current byte-- byte to 1
neq r1, r2              // r1 = R1 != R2 : used to increment number of bytes containing pattern if necessary. since we know R1 = 1, it will stay 1 if R2 is 0 (pattern not found in current byte), and become 0 otherwise
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000 = 192
addi r3, #1             // r3 = 192+1=193
ldr r2, r3              // r2 = data_mem[193] (i.e. number of bytes in which pattern was recognized)
ldr r2, r3              // r2 = data_mem[193] (i.e. number of bytes in which pattern was recognized)
ldr r2, r3              // r2 = data_mem[193] (i.e. number of bytes in which pattern was recognized)
add r2, r1              // r2 = R2 + R1 (+1 if pattern was not already found in current byte, +0 otherwise
str r3, r2              // data_mem[193] = R2 (update number of bytes in which pattern was recognized)
ldi r2, #5              // r2 = 00000101   'NEXT_STEP_1:'
ls r2, #5               // r2 = 10100000 = 160 put 5-bit pattern to recognize in R0
ldr r0, r2              // r0 = 01010xxx = data_mem[160] (get the byte with pattern stored in bits 7:3)
rs r0, #3               // r0 = 00001010 (shift the top 5 bits to the lower 5, padding most significant bits with 0s to get 0007:3)
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000
addi r3, #3             // r3 = 11000011 = 195
ldr r2, r3              // r2 = 128 = data_mem[195] = current index // going for bits 6:2
ldr r1, r2              // r1 = 01011010 = data_mem[128]
ls r1, #1               // r1 = 10110100 (we have [6:0]0 now)
rs r1, #3               // r1 = 00010110 (we have 000[6:2] now)
eq r1, r0               // r1 = 0 = (r1 == r0) = (00010110 == 00001010)
ldi r3, #3              // r3 = 00000011 = 3
ls r3, #6               // r3 = 11000000
addi r3, #2             // r3 = 11000010 = 194
ldr r2, r3              // r2 = 0 = data_mem[194] (total number of times 5-bit pattern occurs with byte boundaries OFF)
add r2, r1              // r2 = 0 (pattern was not recognized)
str r3, r2              // data_mem[194] = 0 (updated total)
neq r0, r1              // r0 = 1 = (r0 != r1) = (1 != 0)
ldi r3 #1               // r3 = 00000001
ls r3, #4               // r3 = 00010000 = 16 (OFFSET to 'NEXT_STEP_2')
bnzr r3, r0             // r0 = 1 => branch, goto NEXT_STEP_2
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000 = 192
ldr r2, r3              // r2 = data_mem[192] (if here, we did not jump, therefore we know R1 == 1 (i.e. pattern found in current byte)) // first, increment number of times pattern found with byte boundaries ON
addi r2, #1             // r2 = R2 + 1
str r3, r2              // data_mem[192] = R2
addi r3, #4             // r3 = 196
ldr r2, r3              // r2 = data_mem[196] (second, increment number of bytes containing pattern if necessary) // get flag indicating pattern was found in current byte   
neq r1, r2              // since we know R1 = 1, this will be 1 if R2 is 0, and 0 otherwise
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000 = 192
addi r3, #1             // r3 = 11000001 = 193
ldr r2, r3              // get number of bytes in which pattern was recognized
add r2, r1              // recall that R1 is now 1 if the pattern was found and the "pattern found in current byte" byte was false, 0 otherwise, so we increment in the proper instance
addi r3, #3             // r3 = 196
str r3, #1              // we found the pattern, so set the "pattern found in current byte" byte to 1   
ldi r3, #5              // r3 = 00000101  'NEXT_STEP_2:'
ls r3, #5               // r3 = 10100000 = 160  (5-bit pattern to recognize)
ldr r0, r3              // r0 = 01010000 = data_mem[160] = (5-bit pattern)_000
rs r0, #3               // r0 = 00001010 = 0007:3 = 5-bit pattern
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000
addi r3, #3             // r3 = 11000011 = 195
ldr r2, r3              // r2 = 128 = data_mem[195] (going for data_mem[idx] bits 5:1), R2 = current index
ldr r1, r2              // r1 = 01011010 = data_mem[128] = data_mem[current_index]
ls r1, #2               // r1 = 01101000 ([5:0]00)
rs r1, #3               // r1 = 00001101 (000[5:1])
eq r1, r0               // r1 = 0 = (00001101 == 00001010) = (R1 == R0)
ldi r3, #3              // r3 = 00000011 = 3
ls r3, #6               // r3 = 11000000
addi r3, #2             // r3 = 11000010 = 194
ldr r2, r3              // r2 = 0 = data_mem[194] (# recognized with byte boundaries OFF)
add r2, r1              // r2 = 0 = (0 + 0) = (r2 + r1)
str r3, r2              // data_mem[194] = 0 = R2 (store updated total)
ldi r0, #1              // r0 = 1
neq r0, r1              // r0 = 1 = (1 != 0) = (r0 != r1)
ldi r3 #1               // r3 = 00000001
ls r3, #4               // r3 = 00010000 = 16
addi r3, #4             // r3 = 20 (OFFSET to 'NEXT_STEP_3')
bnzr r3, r0             // r0 == 1 => branch to NEXT_STEP_3
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000 = 192
ldr r2, r3              // if here, we did not jump, therefore we know R1 == 1 (i.e. pattern found in current byte) // first, increment number of times pattern found with byte boundaries ON
addi r2, #1
str r3, r2
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000 = 192
addi r3, #4             // r3 = 11000100 = 196
ldr r2, r3              // second, increment number of bytes containing pattern if necessary // get flag indicating pattern was found in current byte   
neq r1, r2              // since we know R1 = 1, this will be 1 if R2 is 0, and 0 otherwise
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000 = 192
addi r3, #1             // r3 = 11000001 = 193
ldr r2, r3              // get number of bytes in which pattern was recognized
add r2, r1              // recall that R1 is now 1 if the pattern was found and the "pattern found in current byte" byte was false, 0 otherwise, so we increment in the proper instance
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000 = 192
addi r3, #4             // r3 = 11000100 = 196
str r3, #1              // we found the pattern, so set the "pattern found in current byte" byte to 1   
ldi r3, #5              // r3 = 00000101 'NEXT_STEP_3:'
ls r3, #5               // r3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldr r0, r2              // r0 = 01010000 = data_mem[160]
rs r0, #3               // r0 = 00001010
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000
addi r3, #3             // r3 = 11000011 = 195
ldr r2, r3              // r2 = 128 = data_mem[195]
ldr r1, r2              // r1 = 01011010 = data_mem[128]
ls r1, #3               // r1 = 11010000 = [4:0]000
rs r1, #4               // r1 = 00011010 = 000[4:0]
eq r1, r0               // r1 = 0 = (00011010 == 01010000) = (r1 == r0)
ldi r3, #3              // r3 = 00000011 = 3
ls r3, #6               // r3 = 11000000
addi r3, #2             // r3 = 11000010 = 194 (boundaries OFF addr)
ldr r2, r3              // r2 = 0 = data_mem[194] = stored number of times 5-bit pattern occurs byte boundaries OFF
add r2, r1              // r2 = 0 = 0+0 = r2 + r1
str r3, r2              // data_mem[194] = 0 (store updated total)
ldi r0, #1              // r0 = 1
neq r0, r1              // r0 = 1 = (r0 != r1) = (1 != 0)
ldi r3 #1               // r3 = 00000001
ls r3, #4               // r3 = 00010000 = 16
addi r3, #4             // r3 = 20 (OFFSET to 'NEXT_STEP_4')
bnzr r3, r0             // r0 == 1 => branch
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000 = 192
ldr r2, r3              // if here, we did not jump, therefore we know r1 == 1 (i.e. pattern found in current byte) // first, increment number of times pattern found with byte boundaries ON
addi r2, #1
str r3, r2
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000 = 192
addi r3, #4             // r3 = 11000100 = 196
ldr r2, r3              // second, increment number of bytes containing pattern if necessary // get flag indicating pattern was found in current byte   
neq r1, r2              // since we know R1 = 1, this will be 1 if R2 is 0, and 0 otherwise
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000 = 192
addi r3, #1             // r3 = 11000001 = 193
ldr r2, r3              // get number of bytes in which pattern was recognized
add r2, r1              // recall that R1 is now 1 if the pattern was found and the "pattern found in current byte" byte was false, 0 otherwise, so we increment in the proper instance
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000 = 192
addi r3, #4             // r3 = 11000100 = 196
str r3, #1              // we found the pattern, so set the "pattern found in current byte" byte to 1
ldi r3, #5              // r3 = 00000101 'NEXT_STEP_4:'
ls r3, #5               // r3 = 10100000 = 160 (addr of 5-bit pattern to recognize)
ldr r0, r3              // r0 = 01010000 = data_mem[160]
rs r0, #3               // r0 = 00001010 
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000
addi r3, #3             // r3 = 11000011 = 195 
ldr r2, r3              // r2 = 128 = data_mem[195] (going for data_mem[idx] bits 3:0 , data_mem[idx+1] bit 7)
ldr r1, r2              // r1  = 01011010 = data_mem[128] = current byte in the string
ls r1, #4               // r1 = 10100000i ([3:0]0000)
rs r1, #4               // r1 = 00001010 (0000[3:0])
rs r0, #1               // r0 = 00000101 (0000[first four bits of the pattern])
neq r1, r0              // r1 = 1 = (00001010 != 00000101) = (r1 != r0) = last four bits of the current string byte are not == the first four bits of the pattern
ldi r3, #3              // r3 = 00000011
ls r3, #3               // r3 = 00011000 = 24
addi r3, #1             // r3 = 00011011 = 25 = OFFSET to NEXT_STEP_5
bnzr r3, r1             // r1 == 1 => branch (goto NEXT_STEP_5)
ldi r3, #5              // R3 = 00000101
ls r3, #5               // R3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldr r2, r3              // put 5-bit pattern to recognize in R0
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
ldi r3, #4
addi r3, #3             // OFFSET to NEXT_STEP_5 = 7
bnzr r3, r1             // go to NEXT_STEP_5 if the remainder of the pattern is not a match, otherwise PC=PC+1 (default increment)
ldi r3, #3              // R3 = 00000011 = 3
ls r3, #6               // R3 = 11000000
addi r3, #2             // R3 = 11000010 = 194
ldr r1, r3              // pattern was found crossing over bytes, increment the number of times pattern was found without regard to byte boundaries
addi r1, #1
str r3, r1
ldi r3, #5              // r3 = 00000101 'NEXT_STEP_5:'
ls r3, #5               // r3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldr r0, r3              // r0 = = 01010000 = data_mem[160] = pattern byte
rs r0, #3               // r0 = 00001010 = 0007:3
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000
addi r3, #3             // r3 = 11000011 = 195
ldr r2, r3              // r2 = 128 = data_mem[195] (want bits 2:0 || data_mem[idx+1] bits 7:6)
ldr r1, r2              // r1 = 01011010 = data_mem[128]
ls r1, #5               // r1 = 01000000    ([2:0]0000)
rs r1, #5               // r1 = 00000010    (00000[2:0])
rs r0, #2               // r0 = 00000010    (00000[first 3 bits of the pattern])
neq r1, r0              // r1 = 0 = (r1 != r0) = (00000010 != 00000010)
ldi r3, #3              // r3 = 00000011
ls r3, #3               // r3 = 00011000 = 24 = OFFSET to NEXT_STEP_6
bnzr r3, r1             // r1 == 0 => the pattern is currently a partial match, PC=PC+1 (no branch)
ldi r3, #5              // r3 = 00000101
ls r3, #5               // r3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldr r0, r3              // r0 = 01010000 = data_mem[160]  (pattern byte)
rs r0, #3               // r0 = 00001010  (0007:3)
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000
addi r3, #3             // r3 = 11000011 = 195
ldr r2, r3              // r2 = 128 = data_mem[195] 
addi r2, #1             // r2 = 129 (looking into bits 7:6) of the next byte to complete the pattern
ldr r1, r2              // r1 = 01011010 = data_mem[129] (the next byte in the string)
rs r1, #6               // r1 = 00000001    (bits 7:6 of the next byte)
ls r0, #6               // r0 = 10000000   (PP000000 where Ps are last two bits in pattern)
rs r0, #6               // r0 = 00000010    (000000PP where Ps are last two bit in pattern))
neq r1, r0              // r1 = 1 = (r1 != r0) = (00000001 != 0000010)
ldi r3, #6              
addi r3, #1             // r3 = 7 = OFFSET to NEXT_STEP_6
bnzr r3, r1             // r1 != 0 => take the branch! no pattern here
ldi r3, #3              // R3 = 00000011 = 3
ls r3, #6               // R3 = 11000000
addi r3, #2             // R3 = 11000010 = 194
ldr r1, r3              // pattern was found crossing over bytes, increment the number of times pattern was found without regard to byte boundaries
addi r1, #1
str r3, r1
ldi r3, #5              // r3 = 00000101 'NEXT_STEP_6:'
ls r3, #5               // r3 = 10100000 = 160  (address of pattern byte)
ldr r0, r3              // r0 = 01010000 = data_mem[160]   (pattern byte)
rs r0, #3               // r0 = 00001010      ( 0007:3 )
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000
addi r3, #3             // r3 = 11000011 = 195  (addr of stored index)
ldr r2, r3              // r2 = 128 = data_mem[195]   (checking curr byte bits 1:0 , next byte bits 7:5 )
ldr r1, r2              // r1 = 01011010 = data_mem[128]   (curr byte)
ls r1, #6               // r1 = 10000000    ([1:0]00000)
rs r1, #6               // r1 = 00000010    (000000[1:0])
rs r0, #3               // r0 = 00000001    (000000[first 2 bits of the pattern])
neq r1, r0              // r1 = 1 = (r1 != r0) = (00000010 != 00000001)
ldi r3, #6              // r3 = 00000110
ls r3, #2               // r3 = 00011000 = 24 
addi r2, #2             // r3 = 00011010 = 26 (OFFSET to NEXT_STEP_7)
bnzr r3, r1             // r1 = 1 => branch to NEXT_STEP_7, no pattern match here
ldi r3, #5              // R3 = 00000101
ls r3, #5               // R3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldi r2, r3              // put 5-bit pattern to recognize in R0
ldr r0, r2              // get the byte with pattern stored in bits 7:3
rs r0, #3               // shift the top 5 bits to the lower 5, padding msb's with 0's to get 0007:3
ldi r3, #3              // R3 = 00000011
ls r3, #6               // R3 = 11000000 = 192
addi r3, #3             // R3 = 11000011 = 195
ldr r2, r3              // data_mem[idx+1] bits 7:5 // R2 is the index of the current byte in the string
addi r2, #1             // R2 is the index of the next byte in the string
ldr r1, r2              // R1 is the next byte in the string
rs r1, #5               // R1 is 000007:5 (bits 7:5 of the next byte in the string)
ls r0, #5               // R0 is PPP00000 (Ps are last three bits in pattern)
rs r0, #5               // R0 is 00000PPP (Ps are last three bit in pattern)
neq r1, r0              // true if bit 7:5 in next string byte is last bit in the pattern
ldi r0, #0
ldi r3, #6
addi r3, #1             // r3 = 7 = OFFSET to NEXT_STEP_7
bnzr r3, r1             // go to NEXT_STEP_7 if the remainder of the pattern is not a match, otherwise PC=PC+1 (default increment)
ldi r3, #3              // R3 = 00000011 = 3
ls r3, #6               // R3 = 11000000
addi r3, #2             // R3 = 11000010 = 194
ldi r1, r3              // pattern was found crossing over bytes, increment the number of times pattern was found without regard to byte boundaries
addi r1, #1
str r3, r1
ldi r3, #5              // R3 = 00000101 'NEXT_STEP_7:'
ls r3, #5               // R3 = 10100000 = 160 (address of 5-bit pattern to recognize)
ldr r0, r3              // r0 = 01010000 = data_mem[160] (pattern byte)
rs r0, #3               // r0 = 00001010    (0007:3)
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000
addi r3, #3             // r3 = 11000011 = 195 (addr of stored index)
ldr r2, r3              // r2 = 128 = data_mem[195]    (looking at curr byte bit 0 , next byte bits 7:4
ldr r1, r2              // r1 = 01011010 = data_mem[128]       (current byte in the string)
ls r1, #7               // r1 = 00000000    ([bit 0 of current byte of string]0000000)
rs r1, #7               // r1 = 00000000    (0000000[bit 0 of current byte of string])
rs r0, #4               // r0 = 00000000    (0000000[first bit of the pattern])
neq r1, r0              // r1 = 0 (r1 != r0) = (00000000 != 00000000) 
ldi r3, #3              // r3 = 00000011
ls r3, #3               // r3 = 00011000 = 24
addi r3, #0             // r3 = 24 = OFFSET to NEXT_STEP_8
bnzr r3, r1             // r1 == 0 => dont take the branch, partial pattern recognized so far
ldi r3, #5              // r3 = 00000101
ls r3, #5               // r3 = 10100000 = 160  (address of 5-bit pattern to recognize)
ldr r0, r3              // r0 = 01010000 = data_mem[160]   (pattern byte)
rs r0, #3               // r0 = 00001010    (0007:3)
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000
addi r3, #3             // r3 = 11000011 = 195 (addr of stored index)
ldr r2, r3              // r2 = 128 = data_mem[195]   (checking remaining bits 7:4)
addi r2, #1             // r2 = 129     (addr of next byte)
ldr r1, r2              // r1 = 01011010 = data_mem[129]   (next byte)
rs r1, #4               // r1 = 00000101    (0000[bits 7:4 of next byte]
ls r0, #4               // r0 = 10100000    (PPPP0000 where Ps are last 4 bits in pattern)
rs r0, #4               // r0 = 00001010    (0000PPPP where Ps are last 4 bits in pattern)
neq r1, r0              // r1 = 1 = (r1 != r0) = (00000101 != 00001010)
ldi r3, #4
addi r3, #3             // r3 = 7 = OFFSET to NEXT_STEP_8
bnzr r3, r1             // r1 == 1 => branch to NEXT_STEP_8
ldi r3, #3              // R3 = 00000011 = 3
ls r3, #6               // R3 = 11000000
addi r3, #2             // R3 = 11000010 = 194
ldr r1, r3              // pattern was found crossing over bytes, increment the number of times pattern was found without regard to byte boundaries
addi r1, #1
str r3, r1
ldi r3, #3              // r3 = 00000011 'NEXT_STEP_8:'
ls r3, #6               // r3 = 11000000
addi r3, #3             // r3 = 11000011 = 195 (index of current byte in string [data_mem[idx] bits 7:3])
ldr r1, r3              // r1 = 128 = data_mem[195] 
addi r1, #1             // r1 = 129     (increment index of current byte in string)
str r3, r1              // data_mem[195] = 129
ldi r2, #5              // r2 = 00000101
ls r2, #5               // r2 = 10100000 = 160  (branch back to L1 if idx < 160)
ldr r0, r3              // r0 = 01010000 = data_mem[160]
ldi r3, #3              // r3 = 00000011
ls r3, #6               // r3 = 11000000
addi r3, #3             // r3 = 11000011 = 195  (addr of stored index)
ldr r1, r3              // r1 = 128 data_mem[195]   (current index)
neq r1, r2              // r1 = 1 = (r1 != r2) = (128 != 160)   (true until current index reaches 160)
ldi r3, #7              // branch by offset at LUT[7] = -343
bnzl r3, r1             // r1 == 1 => branch to L1!     (in general, go to L1 while r1, the current index, is not equal to 160, continue, until program is finished [end]