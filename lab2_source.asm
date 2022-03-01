
.data
letters_size: .byte 52
digram_dict_pos:	.word 0
printing: .word 0

input_file: .asciiz "digram_test.java"
dict_file: .asciiz "dictionary.txt"
output_file: .asciiz "output.txt"



.align 2
dict_buffer: .space 20480
input_buffer: .space 20480



.text

Main:

	li $s6, 2
	lbu $s7, letters_size
	la $t0, dict_buffer
	add $t0, $t0, $s7
	sw $t0, digram_dict_pos

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

	lbu $t1, ($t0)			# Loads input value
	lbu $t2, 1($t0)			# Loads input value
	sll $t2, $t2, 8
	add $t1, $t1, $t2
	beqz $t1, End_Loop1		# Finaliza si el digrama es null
	
	la $t2, digram_dict_pos		# Loads dict buffer
	
	Loop2:
	
		lhu $t3, ($t2)
		beqz $t3, Else2_Loop2	# Si no hay mas digramas en dict
		
		bne $t1, $t3, Else1_Loop2	# Si el digrama no es igual
		
		move 	$a0, $t2	# Encoder first parameter
		la 	$a1, dict_buffer# Encoder second parameter
		jal	Encoder		# Encoder call
		move 	$t4, $v0	# Encoder returned value
		
		sw	$t4, printing	# Saving encoded value in Memory
		li 	$v0, 15		# System call for write to a file
		move 	$a0, $s2	# Restore file descriptor (open for writing)
		la 	$a1, printing	# Address of buffer from which to write
		li 	$a2, 1		# Number of characters to write
		syscall
		
		li   $v0, 16      	# system call for close file
		move $a0, $s0    	# file descriptor to close
		syscall			# close file
		
		j End_Loop2
		
		Else1_Loop2:		# Si el digrama no es igual
			
			addi 	$t2, $t2, 2
			j Loop2
		
		
		Else2_Loop2:		# Si no existe digrama en dict
		
			li	$s6, 1
			lbu 	$t1, ($t0)	# Se carga letra del input
			la 	$t2, dict_buffer# Se carga pos del dict
			la	$t8, digram_dict_pos
			
			Loop3:
			
				lbu	$t3, ($t2)	# Se carga letra del dict
				
				bge $t2, $t8, End_Loop3 # Si final de letras en diccionario
				
				bne $t1, $t3, Else1_Loop3 # Si letras no son iguales
				
				move 	$a0, $t2	# Encoder first parameter
				la 	$a1, dict_buffer# Encoder second parameter
				jal	Encoder		# Encoder call
				move 	$t4, $v0	# Encoder returned value
		
				sw	$t4, printing	# Saving encoded value in Memory
				li 	$v0, 15		# System call for write to a file
				move 	$a0, $s2	# Restore file descriptor (open for writing)
				la 	$a1, printing	# Address of buffer from which to write
				li 	$a2, 1		# Number of characters to write
				syscall
		
				li   $v0, 16      	# system call for close file
				move $a0, $s0    	# file descriptor to close
				syscall			# close file
		
				j End_Loop3
				
				
			
				Else1_Loop3:
					
					addi 	$t2, $t2, 1
					j Loop3
			
			End_Loop3:
			
			# TODO: ON CHAR NOT FOUND, DO SOMETHING (CURRENTLY NOT DOING SHIT)
		
	End_Loop2:
	
	add $t0, $t0, $s6
	li $s6, 2
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