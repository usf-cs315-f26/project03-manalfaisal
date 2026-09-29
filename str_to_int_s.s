.global str_to_int_s

str_to_int_s:
	li t0, 0
	li t1, 1

	# find the end of the string
	mv t2, a0

find_end:
	lb t3, (t2)
	beq t3, zero, found_end
	addi t2, t2, 1
	j find_end

found_end:
	add t2, t2, -1			# point to last character

loop:
	blt t2, a0, done
	lb t3, (t2)				# current character
	li t4, '9'
	bgt t3, t4, hex_digit

	li t4, '0'
	sub t3, t3, t4			# digit = ch - '0'
	j have_digit

hex_digit:
	li t4, 'a'
    blt t3, t4, upper_digit

    sub t3, t3, t4
    addi t3, t3, 10        # digit for a-f
    j have_digit

upper_digit:
    li t4, 'A'
    sub t3, t3, t4
    addi t3, t3, 10        # digit for A-F

have_digit:
    # digit * place_val using repeated addition
    li t4, 0
    li t5, 0

digit_mult:
    beq t5, t3, digit_done
    add t4, t4, t1
    addi t5, t5, 1
    j digit_mult

digit_done:
    add t0, t0, t4         # retval += digit * place_val

    # place_val *= base using repeated addition
    li t4, 0
    li t5, 0

place_mult:
    beq t5, a1, place_done
    add t4, t4, t1
    addi t5, t5, 1
    j place_mult

place_done:
    mv t1, t4
    addi t2, t2, -1        # move to previous character
    j loop

done:
    mv a0, t0
    ret
