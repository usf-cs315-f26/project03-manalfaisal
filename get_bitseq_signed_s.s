.global get_bitseq_signed_s
.global get_bitseq_s

get_bitseq_signed_s:
	addi sp, sp, -16
	sd ra, 0(sp)			# save return address

	sub t0, a2, a1
	addi t0, t0, 1			# len = end - start + 1

	li t1, 32
	sub t1, t1, t0			# shift amount = 32 - len

	sd t1, 8(sp)			# save shift amount across function call
	call get_bitseq_s 		# extract unsigned bit sequence

	ld t1, 8(sp)
	sllw a0, a0, t1			# move sign bit to bit 31
	sraw a0, a0, t1			# arithmetic shift to sign extend

	ld ra, 0(sp)
	addi sp, sp, 16
    ret
