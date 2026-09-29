.global int_to_str_s

int_to_str_s:
    	addi sp, sp, -48             # space for tmp string

    	li t0, 0                     # len = 0
    	li t1, 0                     # j = 0

    	bne a0, zero, convert

    	li t2, '0'
    	sb t2, (sp)                  # tmp[0] = '0'
    	addi t0, t0, 1
    	j prefix

convert:
    	divu t2, a0, a2               
    	remu t3, a0, a2               

    	li t4, 9
    	bgt t3, t4, hex_digit

    	li t4, '0'
    	add t3, t3, t4               # convert 0-9 to char
    	j store_digit

hex_digit:
    	li t4, 'a'
    	addi t3, t3, -10
    	add t3, t3, t4               # convert 10-15 to a-f

store_digit:
    	add t4, sp, t0
    	sb t3, (t4)                  # tmp[len] = digit
    	addi t0, t0, 1

    	mv a0, t2                    # value = div
    	bne a0, zero, convert

prefix:
    	li t2, 2
    	bne a2, t2, check_hex

    	li t2, '0'
    	sb t2, 0(a1)
    	li t2, 'b'
    	sb t2, 1(a1)
    	addi t1, t1, 2
    	j reverse

check_hex:
    	li t2, 16
    	bne a2, t2, reverse
    
        li t2, '0'
        sb t2, 0(a1)
        li t2, 'x'
        sb t2, 1(a1)
        addi t1, t1, 2
    
    reverse:
        beq t0, zero, done
    
        addi t0, t0, -1              # move backwards through tmp
        add t2, sp, t0
        lb t3, (t2)
    
        add t4, a1, t1
        sb t3, (t4)                  # copy into result string
        addi t1, t1, 1
    
        j reverse
    
    done:
        add t2, a1, t1
        sb zero, (t2)                # end string with null
    
        addi sp, sp, 48
        ret
