# MILESTONE 1 Document
### Date Created: 1/24/2022
### Date Last Updated: 1/24/2022
### Group Members: Daisuke Chon, Angelica Consengco, Matthew Larkins
* * *
## Component 1: Introduction
Our group's processor, named "INSERT NAME HERE" is designed to perform the following 3 programs:
1. Hamming Encoding of 11-bit strings
2. SECDED Hamming Decoding of 11-bit strings
3. Pattern matching 5-bit strings on 11-bit strings

The machine takes major influence from typical load-store architectures.
* * *
## Component 2: Architectural Overview
* * *
## Component 3: Machine Specification
### **Instruction Formats:**

**R-type: 4 Opcode | 2 Rd | 2 Rs | 1 Unused**

Example:

	add r0, r1   <--> 1011 00 01 x  
	r0 = r0 + r1 <--> add  r0 r1 x
	x = unused

**I-type: 4 Opcode | 2 Rs | 3 Immediate**
Example:

	ldi r0, 0 <--> 0100 00 000
	r0 = 0    <--> 0100 00 000

Note: The max value we can represent naively with 3 bits is 7. We can represent values larger than this by repeatedly operating on values stored in 8-bit registers until they contain our desired values.

### **Operations:**
| Opcode | Format | Operation   | Assembly | Example | Machine Code |
| ------ | ------ | --------- | -------- | ------- | ------------ |
| 0000 | I | left shift  | ls | ls r0, 2 | 0000 00 010 |
| 0010 | I | right shift | rs | rs r0, 2 | 0001 00 010 | 
| 0011 | 


## Component 4: Programmer's Model
## Component 5: Program Implementations