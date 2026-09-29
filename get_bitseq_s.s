.global get_bitseq_s

get_bitseq_s:
	sub t0, a2, a1
	addi t0, t0, 1			# get length of bit

	srl a0, a0, a1

	li t2, 32
	beq t0, t2, len_32

	li t1, 1
	sll t1, t1, t0
	addi t1, t1, -1			# create mask for desired bits
	j apply_mask

len_32:
	li t1, 0xFFFFFFFF		# mask for full 32-bit sequence

apply_mask:
	and a0, a0, t1			# keep only desired bits

	ret
