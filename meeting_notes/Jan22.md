# CSE 141L Project Meeting 2
## Date: Jan 22, 2022
**Goal: Create a draft ISA encoding and maybe start trying to implement the three programs with the ISA**

## Part 1: Operations
As we agreed in the last meeting, there are 9 operations we need to encode for:
1. Logical Shift Left 
2. Logical Shift Right
3. AND operator
4. ORR operator
5. Load
6. Store
7. Branch (look more into this)
8. Comparators (probably just greater than or equal to) ==> can implement with add op like in ALU
9. Add operator

These operations will be encoded using 3 bits as such:
- lsl: 000
- lsr: 001
- and: 010
- orr: 011
- ldr: 100
- str: 101
- beq (or bne): 110
- add: 111

## Part 2: Immediates
The way MIPS handles an I-format instruction with 16 bits, you can really only represent half the numbers in 32 bits using
a naive approach. However, if you treat bne/beq as relative offsets, you can cleverly represent 32 bit addresses

Matt found the following video that could help: https://www.youtube.com/watch?v=1bP6alXjDrw

## Part 3: Tentative Encodings
### R-type:
- 3 bits to opcode
- 1 bit to rs
- 1 bit to rt
- 1 bit to rd
- 2 bit to shamt
- 1 bits to funct - maybe not needed, reserve for later

Example Encoding:
ADD r0, r1, r0

ADD | r0 | r1 | r0 | shamt | funct(?)
111 | 0  | 1  | 0  | 00    | 0

### I-type: 
- 3 bits to opcode
- 1 bit to rs
- 1 bit to rt
- 4 bits to immediates
  - Refer to Matt's video for calculating addresses during branches to see how we can represent 8 bits with 4

Example Encoding:
ADD r0, r1, #5

ADD | r0 | r1 | immed
111 | 0  | 1  | 0100
NOTE: The immediate is tentative until we figure out a way to encode 8 bits worth of numbers into 4 bits

### J-type:
We probably don't need J-type instructions