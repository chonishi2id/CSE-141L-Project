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
        'bnzr' : '0111',
        'geq' : '1000',
        'eq' : '1001',
        'neg' : '1010',
        'add' : '1011',
        'addi' : '1100',
        'neq' : '1101',
        'bnzl' : '1110'
        }

# This is a neat trick to catch programming errors
TOTAL_IMEM_SIZE = 2**10

# Don't need to do anything fancy here
with open('prog2_final_2.s') as ifile, open('machine_out_prog2.hex', 'w') as imem, open('gtkwave/mcode.fmt', 'w') as wavefmt:
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
            print("Error Parsing Line ", lineno + 1)
            print(">>>{}<<<".format(line))
            print()
            raise
    #append nop to end for ACK signal
    imem.write('111111111')
    # This is a neat trick to catch programming errors:
    # Fill the rest of instruction memory with illegal instructions.
    wavefmt.write('xxxxxxxxx ILLEGAL!')
    #while TOTAL_IMEM_SIZE:
    #    imem.write('xxxxxxxxx\n')
    #    TOTAL_IMEM_SIZE -= 1

