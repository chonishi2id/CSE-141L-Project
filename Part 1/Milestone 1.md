# **Milestone 1 Document**
### Date Created: 1/24/2022
### Date Last Updated: 1/24/2022
### Group Members: Daisuke Chon, Angelica Consengco, Matthew Larkins
* * *
## **Component 1:** Introduction
Our group's processor, named "INSERT NAME HERE" is designed to perform the following 3 programs:
1. Hamming Encoding of 11-bit strings
2. SECDED Hamming Decoding of 11-bit strings
3. Pattern matching 5-bit strings on 11-bit strings

The machine takes major influence from typical load-store architectures.
* * *
## **Component 2:** Architectural Overview
<img src="https://media.discordapp.net/attachments/927665045213679638/935371997444177981/unknown.png?width=1253&height=910">

Full image should also be available in the submission
* * *
## **Component 3:** Machine Specification
### **Instruction Formats:**

*R-type: 4-Bits Opcode | 2-Bits Rd | 2-Bits Rs | 1-Bit Unused*

Example:

	add r0, r1   <--> 1011 00 01 x  
	r0 = r0 + r1 <--> add  r0 r1 x
	x = unused

*I-type: 4-Bits Opcode | 2-Bits Rs | 3-Bits Immediate*

Example:

	ldi r0, 0 <--> 0100 00 000
	r0 = 0    <--> 0100 00 000

Note: The max value we can represent naively with 3 bits is 7. We can represent values larger than this by repeatedly operating on values stored in 8-bit registers until they contain our desired values.

### **Operations:**
| Opcode | Format | Operation   | Assembly | Example | Machine Code |
| ------ | ------ | --------- | -------- | ------- | ------------ |
| 0000 | I | left shift  | ls  | ls r0, #2   | 0000 00 010  |
| 0001 | I | right shift | rs  | rs r0, #2   | 0001 00 010  | 
| 0010 | R | AND         | and | and r0, r1  | 0010 00 01 X |
| 0011 | R | OR          | or  | or r0, r1   | 0011 00 01 X |
| 0100 | I | load immediate | ldi | ldi r0, #7   | 0100 00 111  |
| 0101 | R | load register  | ldr | ldr r2, (r0) | 0101 10 00 X |
| 0110 | R | store register | str | str (r2), r0 | 0110 10 00 X |
| 0111 | R | branch if equal| beq | beq r0, r1   | 0111 00 01 X |
| 1000 | R | >=          | geq | geq r0, r1  | 1000 00 01 X |
| 1001 | R | ==          | eq  | eq r0, r1   | 1001 00 01 X |
| 1010 | R | 2's Comp Negation| neg | neg r1, r1 | 1010 01 01 X |
| 1011 | R | add         | add | add r0, r1  | 1011 00 01 X |
| 1100 | R | add immediate  | addi | addi r0, #3 | 1100 00 011  |
| 1101 | X | nop |
| 1110 | X | nop | 
| 1111 | X | nop |

### **Internal Operands/Registers:**
- r0 : 00 - general purpose
- r1 : 01 - general purpose
- r2 : 10 - general purpose
- PC : 11 = special (Program counter)

### **Control Flow (Branches):**
Wait what the heck does this part mean?

1. What types of branches are supported? 
2. How are the target addresses calculated? 
3. What is the maximum branch distance supported?

### **Addressing Modes:**
We support indirect memory addressing via registers. If a programmer wants to access a specific memory address, they must perform several shifting and masking operations. An example is outlined below: 

**Task: load address 01110101**
	
	ldi r1, 011  -- r1: 00000011
	ls r1, #5    -- r1: 01100000
	ldi r2, 101  -- r1: 01100000 r2: 00000101
	ls r2, #2    -- r1: 01100000 r2: 00010100
	or r1, r2    -- r1: 01110100 r2: 00010100
	ldi r2, 01   -- r1: 01110100 r2: 00000001
	or r1, r2    -- r1: 01110101 r2: 00000001
	ldr r0, (r1)
	
* * *
## **Component 4:** Programmer's Model
As mentioned in the introduction, our machine takes inspriation from a typical load-store architecture. As such, if a programmer wants to do anything, they must load values into a register, conduct the operation, and then store it back.

If a programmer wants to use a specific 8-bit address, then they must conduct shifting and masking operations as outlined in the previous part.

* * *
## **Component 5:** Program Implementations
Please check the attached program files in the submission