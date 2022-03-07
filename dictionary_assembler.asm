.data 
	digrams: 	.asciiz "digrams.bin"
	file: 		.asciiz "dictionary.txt"
	print: 		.word 0
	
.align 2
	buffer:		.space 20480
	
.text
	
	# Opening digrams as read only
	li 	$v0, 13
	la 	$a0, digrams
	li 	$a1, 0
	li 	$a2, 0
	syscall
	move 	$s6, $v0
	
	# Sets reading from input file
	li 	$v0, 14
	move 	$a0, $s6
	la 	$a1, buffer
	li 	$a2, 20480
	syscall
	move 	$s5,$v0 
	
	# Opening file as write and append mode
	li 	$v0, 13
	la 	$a0, file
	li 	$a1, 9
	li 	$a2, 0
	syscall
	move 	$s7, $v0
	
	
		li 	$s0, 0x0A
		sw 	$s0, print
		
		# Setting file for writing
		li 	$v0, 15		# System call for write to a file
		move 	$a0, $s7	# Restore file descriptor (open for writing)
		la 	$a1, print	# Address of buffer from which to write
		li 	$a2, 1		# Number of characters to write
		syscall
		
		li 	$s0, 0x0D
		sw 	$s0, print
		
		# Setting file for writing
		li 	$v0, 15		# System call for write to a file
		move 	$a0, $s7	# Restore file descriptor (open for writing)
		la 	$a1, print	# Address of buffer from which to write
		li 	$a2, 1		# Number of characters to write
		syscall


	li	$s1, 127
	li 	$s0, 32
	sw 	$s0, print
	
	Loop:
		
		beq $s0, $s1, End
		
		# Setting file for writing
		li 	$v0, 15		# System call for write to a file
		move 	$a0, $s7	# Restore file descriptor (open for writing)
		la 	$a1, print	# Address of buffer from which to write
		li 	$a2, 1		# Number of characters to write
		syscall
		
		addi 	$s0, $s0, 1
		sw 	$s0, print
		
		j Loop
		
End:

		li 	$s0, 0x00
		sw 	$s0, print
		
		# Setting file for writing
		li 	$v0, 15		# System call for write to a file
		move 	$a0, $s7	# Restore file descriptor (open for writing)
		la 	$a1, print	# Address of buffer from which to write
		li 	$a2, 1		# Number of characters to write
		syscall

# Setting file for writing
li 	$v0, 15		# System call for write to a file
move 	$a0, $s7	# Restore file descriptor (open for writing)
la 	$a1, buffer	# Address of buffer from which to write
move 	$a2, $s5	# Number of characters to write
syscall
			



li   $v0, 16      	# system call for close file
move $a0, $s0    	# file descriptor to close
syscall			# close file
