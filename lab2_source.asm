
.data
letters_size: .byte 52
printing: .word 0

input_file: .asciiz "digram_test.java"
dict_file: .asciiz "dictionary.txt"
output_file: .asciiz "output.txt"



.align 2
dict_buffer: .space 20480
input_buffer: .space 20480



.text

Main:

	lbu $s7, letters_size

	# Opens input file as read-only mode
	li 	$v0, 13
	la 	$a0, input_file
	li 	$a1, 0
	li 	$a2, 0
	syscall
	move 	$s0, $v0
	
	
	# Opens dict file as read-only mode
	li 	$v0, 13
	la 	$a0, dict_file
	li 	$a1, 0
	li 	$a2, 0
	syscall
	move 	$s1, $v0
	
	
	# Opens output file as wirint and append mode
	li 	$v0, 13
	la 	$a0, output_file
	li 	$a1, 9
	li 	$a2, 0
	syscall
	move 	$s2, $v0
	
	
	# Sets reading from input file
	li 	$v0, 14
	move 	$a0, $s0
	la 	$a1, input_buffer
	li 	$a2, 20480
	syscall
	move 	$t1, $v0		# TODO: remove
	
	
	# Sets reading from dict file
	li 	$v0, 14
	move 	$a0, $s1
	la 	$a1, dict_buffer
	li 	$a2, 20480
	syscall
	move 	$t2, $v0		# TODO: remove
	
	

	la $t0, input_buffer
Loop1:

	lhu $a0, ($t0)			# Loads input value
	beqz $a0, End_Loop1		# Finaliza si el digrama es null
	
	la $t1, dict_buffer		# Loads dict buffer
	add $t1, $t1, $s7		# Prepara la primera posicion de digramas
	
	Loop2:
	
		lhu $a1, 0($t1)
		beqz $a1, End_Loop2	# Si no hay mas digramas en dict
		
		bne $a0, $a1, Else1_Loop2	# Si el digrama no es igual
		
		move 	$a0, $t1	# Encoder first parameter
		la 	$a1, dict_buffer# Encoder second parameter
		jal	Encoder		# Encoder call
		move 	$t2, $v0	# Encoder returned value
		
		sw	$t2, printing	# Saving encoded value in Memory
		li 	$v0, 15		# System call for write to a file
		move 	$a0, $s2	# Restore file descriptor (open for writing)
		la 	$a1, printing	# Address of buffer from which to write
		li 	$a2, 1		# Number of characters to write
		syscall
		
		li   $v0, 16      	# system call for close file
		move $a0, $s0    	# file descriptor to close
		syscall			# close file
		
		j End_Loop2
		
		Else1_Loop2:
			
			addi $t1, $t1, 2
			j Loop2
		
	End_Loop2:
	
	addi $t0, $t0, 2
	j Loop1
	
	
End_Loop1:

j End_Program


# Loads all the files needed for the program to work
# params:
#	- a0: current digram pos
#	- a1: digrams dict start pos
# return:
#	- v0: encoded value
Encoder: 
	sub 	$v0, $a0, $a1
	bleu 	$v0, $s7, End_Encoder
	sub 	$v0, $v0, $s7
	srl 	$v0, $v0, 1
	add 	$v0, $v0, $s7
	
	End_Encoder:
	jr	$ra


End_Program: