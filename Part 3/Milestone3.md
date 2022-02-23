
# **MILESTONE 3 DOCUMENT**
### Date Created: 2/22/2022
### Date Last Updated: 2/23/2022
### Group Members: Daisuke Chon, Angelica Consengco, Matthew Larkins
### PIDs: A15388691, A14113566, A16052530
* * *
## **Component 1:** Changelog
1. Changed how jumps are done using the program counter. Information is updated on Milestone 1.
2. Changed design of how data addressing works. Information is updated on Milestone 1.

## **Component 2:** Input and Output Example
We wrote the assembler in python. We tested the output by comparing it with an expected output file that we made. The output matched what we specified in milestone 1.
### Code:
	import re
	#!/usr/bin/env python3

	# Totally optional, here's a neat thing:
	# You can create a reverse-mapping, such that waveform tools will show the
	# original instruction.
	# The waveform viewing tool needs a mapping of # `$value $display_string`.
	# Only want to write each unique machine code once though.
	mcodes = set()

	# Here's a lookup table for opcodes
	ops = {
					'ls': '0000',
					'rs': '0001',
					'and': '0010',
					'or' : '0011',
					'ldi' : '0100',
					'ldr' : '0101',
					'str' : '0110',
					'bnz' : '0111',
					'geq' : '1000',
					'eq' : '1001',
					'neg' : '1010',
					'add' : '1011',
					'addi' : '1100',
					'neq' : '1101'
					}

	# This is a neat trick to catch programming errors
	TOTAL_IMEM_SIZE = 2**10

	# Don't need to do anything fancy here
	with open('test_assembly.asm') as ifile, open('machine_out.hex', 'w') as imem, open('gtkwave/mcode.fmt', 'w') as wavefmt:
			for lineno, line in enumerate(ifile):
					try:
							# Skip over blank lines, remove comments
							line = line.strip()
							line = line.split('//')[0].strip()
							if line == '':
									continue
			
							# Special-case this:
							if line[:4] == 'halt':
									machine_code = '111111111'
							# I-Type: Op rs, imm
							# R-Type: Op rd, rs (plus one zero for padding unused bit)
							insn = re.split(' |, ', line)
							op = insn[0]
							#if instruction is I-Type: Op rs, imm
							if insn[2].startswith('#'):
									imm = '{:03b}'.format(int(insn[2].split('#')[1]))
									rs = '{:02b}'.format(int(insn[1].split('r')[1]))
									machine_code = ops[op] + rs + imm
							#if instruction is nop
							elif (op == 'nop'):
									machine_code = '111100000'
							#if instruction is R-type: Op rd, rs (plus one zero for padding unused bit)
							else:
									rd = '{:02b}'.format(int(insn[1].split('r')[1]))
									rs = '{:02b}'.format(int(insn[2].split('r')[1]))
									machine_code = ops[op] + rd + rs + '0'
							# Write the imem entry
							imem.write(machine_code + '\n')
							TOTAL_IMEM_SIZE -= 1

							# Write out our waveform decoder
							if machine_code not in mcodes:
									line = line.replace('\t', ' ')
									wavefmt.write('{} {}\n'.format(machine_code, line))
									mcodes.add(machine_code)
					except:
							print("Error Parsing Line ", lineno)
							print(">>>{}<<<".format(line))
							print()
							raise

			# This is a neat trick to catch programming errors:
			# Fill the rest of instruction memory with illegal instructions.
			#
			wavefmt.write('xxxxxxxxx ILLEGAL!')
			while TOTAL_IMEM_SIZE:
					imem.write('xxxxxxxxx\n')
					TOTAL_IMEM_SIZE -= 1



### Input: 
	//left shift: r0 = r0 << 2
	ls r0, #2 

	//right shift: r0 = r0 << 3
	rs r0, #3

	//bitwise AND: r0 = r0 & r1
	and r0, r1 

	//bitwise OR: r0 = r0 || r1
	or r0, r1

	//load immediate: r0 = 7
	ldi r0, #7

	//load register: r2 = MEM[r0]
	ldr r2, r0

	//store register: MEM[r0] = r2
	str r2, r0

	//equals: r1 = (r1 == r2)
	eq r1, r2 

	//branch if not equal to zero: if r1 == 1, go to address in R3
	bnz r3, r1

	//greater than or equal to: r0 = (r0 >= r1)
	geq r0, r1

	//2's complement: r1 = (~r1 + 1)
	neg r1, r1 

	//add: r0 = r0 + r1
	add r0, r1

	//add immediate: r0 = r0 + 3
	addi r0, #3

	//not equal to: r0 = (r0 != r1)
	neq r0, r1

### Output:
	000000010
	000100011
	001000010
	001100010
	010000111
	010110000
	011010000
	100101100
	011111010
	100000010
	101001010
	101100010
	110000011
	110100010
* * *
## **Component 3:** Architectural Overview figure
<img src="./architecturalFigure.PNG">

* * * 
