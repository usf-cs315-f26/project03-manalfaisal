.global pack_bytes_s

pack_bytes_s:
	slli a0, a0, 8
	or a0, a0, a1

	slli a0, a0, 8
	or a0, a0, a2

	slli a0, a0, 8
	or a0, a0, a3
	
    ret
