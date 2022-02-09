#!/usr/bin/env python3

import os
import sys

#try:
#	data_mem_f = open(sys.argv[1])
#except IndexError:
#	data_mem_f = open('data_mem.txt')


def xor_reduce_11bit(number):
	# Since xor commutes, this can be simplified to popcount
	## i.e. ^(1_0000_0001) == ^(0_0000_0101) == ^(0_0000_0011) etc
	## Popcount intuition:
	##  Any number of 0 ^ 0 ^ 0 ^ ... is 0
	##
	##  if there are an even number of 1's, then all the ones will
	##  reduce 1 ^ 1 to 0, for a final 0 ^ 0 = 0
	##
	##  if there are an odd number of 1's, then all the ones will
	##  reduce 1 ^ 1 ^ 1 to 1, for a final 1 ^ 0 = 1
	return bin(number).count('1') % 2


# Actually, this more general function is going to be more useful
def xor_reduce_bitstring(bitstring):
	# Strip '0b' prefix if needed
	if bitstring[:2] == '0b':
		bitstring = bitstring[2:]

	r = 0
	for b in bitstring:
		if b == '1':
			r = r ^ 1
		elif b == '0':
			r = r ^ 0
		else:
			raise TypeError
	return r


# This implementation is a pretty literal reading of the program spec
def p1_encode(eleven_bit):
	assert eleven_bit >= 0
	assert eleven_bit < 2**11

	#            109_8765_4321
	p8_mask = 0b_111_1111_0000
	p4_mask = 0b_111_1000_1110
	p2_mask = 0b_110_0110_1101
	p1_mask = 0b_101_0101_1011

	p8 = xor_reduce_bitstring(bin(eleven_bit & p8_mask))
	p4 = xor_reduce_bitstring(bin(eleven_bit & p4_mask))
	p2 = xor_reduce_bitstring(bin(eleven_bit & p2_mask))
	p1 = xor_reduce_bitstring(bin(eleven_bit & p1_mask))

	p16 = xor_reduce_bitstring(bin(eleven_bit) + str(p8) + str(p4) + str(p2) + str(p1))

	high_byte = ((eleven_bit >> 3) & 0xfe) | p8
	low_byte = \
			(((eleven_bit >> 1) & 0x7) << 5) | \
			(((p4             ) & 0x1) << 4) | \
			(((eleven_bit     ) & 0x1) << 3) | \
			(((p2             ) & 0x1) << 2) | \
			(((p1             ) & 0x1) << 1) | \
			(((p16            ) & 0x1) << 0)

	parity = (p16 << 4 | p8 << 3 | p4 << 2 | p2 << 1 | p1)
	#print("1\t{:011b}   {:08b} {:08b}   {:05b}".format(eleven_bit, high_byte, low_byte, parity))

	return (high_byte, low_byte, parity)


# This implementation shows more of what students will hopefully think about
def p2_decode(sixteen_bit):
	assert sixteen_bit >= 0
	assert sixteen_bit < 2**16

	high_byte = (sixteen_bit >> 8) & 0xff
	low_byte = sixteen_bit & 0xff

	# Compute all the things to be able to demonstrate how pieces work

	# What were the `x`mitted parity bits?
	x8 = (sixteen_bit & 0b1_0000_0000) >> 8
	x4 = (sixteen_bit & 0b0_0001_0000) >> 4
	x2 = (sixteen_bit & 0b0_0000_0100) >> 2
	x1 = (sixteen_bit & 0b0_0000_0010) >> 1
	x16 = (sixteen_bit & 0b1)

	xarity = (x16 << 4 | x8 << 3 | x4 << 2 | x2 << 1 | x1)


	# Compute the parity of the received bitstream
	p8  = xor_reduce_bitstring(bin(sixteen_bit & 0b1111_1110_0000_0000))
	p4  = xor_reduce_bitstring(bin(sixteen_bit & 0b1111_0000_1110_0000))
	p2  = xor_reduce_bitstring(bin(sixteen_bit & 0b1100_1100_1100_1000))
	p1  = xor_reduce_bitstring(bin(sixteen_bit & 0b1010_1010_1010_1000))
	# Example of using computed mask, equivalent appraoch for p16
	# i.e., p16 = b11 ^ b8 ^ b6 ^ b5 ^ b3 ^ b2 ^ b1
	# insight: write out p16 as all the xors in p1,2,4,8 and cancel
	#          out duplicate bits; p16 is just a different mask
	# Using this mask is an easier HW implementationn.
	p16 = xor_reduce_bitstring(bin(sixteen_bit & 0b1001_0110_0110_1000))

	parity = (p16 << 4 | p8 << 3 | p4 << 2 | p2 << 1 | p1)


	# Can also extract the (nominal) original message
	eleven_bit = \
			((sixteen_bit & 0b1111_1110_0000_0000) >> 5) | \
			((sixteen_bit & 0b0000_0000_1110_0000) >> 4) | \
			((sixteen_bit & 0b0000_0000_0000_1000) >> 3)

	# If no xmit error, re-encoding will match; if there are errors, it may not
	h,l,p = p1_encode(eleven_bit)

	# This can also double-check our two parity math approaches
	assert p == parity

	# Easiest way to generate this is just pen & paper probably
	# Written as bit index here to match spec notation
	sec_lut = {
			0b1_1111: 11,
			0b0_1110: 10,
			0b0_1101: 9,
			0b1_1100: 8,
			0b0_1011: 7,
			0b1_1010: 6,
			0b1_1001: 5,
			0b0_0111: 4,
			0b1_0110: 3,
			0b1_0101: 2,
			0b1_0011: 1,
	}

	corrected_eleven_bit = eleven_bit
	bad_parity_bits = xarity ^ parity
	if bad_parity_bits != 0:
		# Error Detected
		if bin(bad_parity_bits).count('1') == 1:
			# Single bit mismatch means parity bit flipped; ignore
			pass
		else:
			idx = sec_lut[bad_parity_bits]
			corrected_eleven_bit = eleven_bit ^ (1 << (idx-1))

	# This is useful to show examples
	#print("2\t{:011b}   {:08b} {:08b}   {:05b} {:02X}   {:05b} {:02X}   {:05b} {:02X}   {:011b}".
	#		format(eleven_bit, high_byte, low_byte, xarity, xarity, parity,
	#			parity, bad_parity_bits, bad_parity_bits, corrected_eleven_bit))

	return corrected_eleven_bit


##################
# Simple Examples

to_encode = 0b101_0101_0101
h,l,p = p1_encode(to_encode)

sixteen = h << 8 | l

#print("No Change")
#assert to_encode == p2_decode(sixteen)
#
#print("Single Bit Error")
#assert to_encode == p2_decode(sixteen ^ 0b1000_0000_0000_0000)
#assert to_encode == p2_decode(sixteen ^ 0b0100_0000_0000_0000)
#assert to_encode == p2_decode(sixteen ^ 0b0010_0000_0000_0000)
#assert to_encode == p2_decode(sixteen ^ 0b0001_0000_0000_0000)
#assert to_encode == p2_decode(sixteen ^ 0b0000_1000_0000_0000)
#assert to_encode == p2_decode(sixteen ^ 0b0000_0100_0000_0000)
#assert to_encode == p2_decode(sixteen ^ 0b0000_0010_0000_0000)
#assert to_encode == p2_decode(sixteen ^ 0b0000_0001_0000_0000)
#assert to_encode == p2_decode(sixteen ^ 0b0000_0000_1000_0000)
#assert to_encode == p2_decode(sixteen ^ 0b0000_0000_0100_0000)
#assert to_encode == p2_decode(sixteen ^ 0b0000_0000_0010_0000)
#assert to_encode == p2_decode(sixteen ^ 0b0000_0000_0001_0000)
#assert to_encode == p2_decode(sixteen ^ 0b0000_0000_0000_1000)
#assert to_encode == p2_decode(sixteen ^ 0b0000_0000_0000_0100)
#assert to_encode == p2_decode(sixteen ^ 0b0000_0000_0000_0010)
#assert to_encode == p2_decode(sixteen ^ 0b0000_0000_0000_0001)
#
#print("Some Two Bit Errors?")
#p2_decode(sixteen ^ 0b1100_0000_0000_0000)
#p2_decode(sixteen ^ 0b0110_0000_0000_0000)
#p2_decode(sixteen ^ 0b0011_0000_0000_0000)
#p2_decode(sixteen ^ 0b0001_1000_0000_0000)
#p2_decode(sixteen ^ 0b0000_1100_0000_0000)
#p2_decode(sixteen ^ 0b0000_0110_0000_0000)
#p2_decode(sixteen ^ 0b0000_0011_0000_0000)
#p2_decode(sixteen ^ 0b0000_0001_1000_0000)
#p2_decode(sixteen ^ 0b0000_0000_1100_0000)
#p2_decode(sixteen ^ 0b0000_0000_0110_0000)
#p2_decode(sixteen ^ 0b0000_0000_0011_0000)
#p2_decode(sixteen ^ 0b0000_0000_0001_1000)
#p2_decode(sixteen ^ 0b0000_0000_0000_1100)
#p2_decode(sixteen ^ 0b0000_0000_0000_0110)
#p2_decode(sixteen ^ 0b0000_0000_0000_0011)


# Correctness Testing
print("=== Begin correctness test ===")
for n in range(2**11):
	break
	h,l,p = p1_encode(n)
	sixteen = h << 8 | l

	assert n == p2_decode(sixteen)
	for i in range(2**4):
		try:
			assert n == p2_decode(sixteen ^ (1 << i))
		except AssertionError:
			print('-'*40)
			print("{:011b}   {:016b} {:04X}   {}".format(n, sixteen, sixteen, i))
			print("{:011b}".format(p2_decode(sixteen ^ (1 << i))))
			raise

print("=== P1/P2 All good. ===")


# Expects message_string array of 32 integer bytes and 5-bit pattern
def p3_search(message_string, pattern):
	assert len(message_string) == 32
	assert min(message_string) >= 0
	assert max(message_string) < 2**8

	# Part a
	total_in_bytes = 0
	bytes_with_pattern = 0
	for m in message_string:
		if\
		((m >> 0) & 0x1f) == pattern or\
		((m >> 1) & 0x1f) == pattern or\
		((m >> 2) & 0x1f) == pattern or\
		((m >> 3) & 0x1f) == pattern:
			bytes_with_pattern += 1

		if ((m >> 0) & 0x1f) == pattern:
			total_in_bytes += 1
		if ((m >> 1) & 0x1f) == pattern:
			total_in_bytes += 1
		if ((m >> 2) & 0x1f) == pattern:
			total_in_bytes += 1
		if ((m >> 3) & 0x1f) == pattern:
			total_in_bytes += 1
	
	# Part b
	message_as_text = ''
	for m in message_string:
		message_as_text += '{:08b}'.format(m)
	pattern_as_text = '{:05b}'.format(pattern)
	#print(message_as_text)
	#print(pattern_as_text)
	total_in_stream = 0
	for i in range(len(message_as_text) - len(pattern_as_text) +1):
		if message_as_text[i:i+len(pattern_as_text)] == pattern_as_text:
			total_in_stream += 1

	return (total_in_bytes, bytes_with_pattern, total_in_stream)


# Spec example
mem = [0 for x in range(32)]
pattern = 0
print(p3_search(mem, pattern))

# Mildly more interesting (0xaa8a repeating)
mem = [x for t in zip(*[[0xaa for x in range(16)], [0x8a for x in range(16)]]) for x in t]
pattern = 0x15
print(p3_search(mem, pattern))
