.global unpack_bytes_s

unpack_bytes_s:
	li t1, 0

loop:
	andi t0, a0, 0xFF		# extract lowest byte
	sw t0, 0(a1)			# store byte in array
	srli a0, a0, 8			# shift to next byte			

	addi a1, a1, 4			# move to next array element
	addi t1, t1, 1

	li t2, 4
	blt t1, t2, loop		# loop through all 4 bytes
	
    ret
