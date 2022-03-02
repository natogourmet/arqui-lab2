
.data
letters_size: 		.byte 98
digram_dict_pos:	.word 0
printing: 		.word 0
input_buffer_size:	.half 20480
dict_buffer_size:	.half 20480

input_file: 		.asciiz "digram_test.java"
dict_file: 		.asciiz "dictionary.txt"
output_file: 		.asciiz "output.txt"

.align 2
dict_buffer: 		.space 20480
input_buffer:	 	.space 20480



.text

Main:

	li $s6, 2
	lbu $s7, letters_size
	la $t0, dict_buffer
	add $t0, $t0, $s7
	sw $t0, digram_dict_pos


	la 	$a0, input_file		# Opens input file as read-only mode
	la	$a1, input_buffer
	lh	$a2, input_buffer_size
	jal	Open_Read
	
	la 	$a0, dict_file		# Opens dict file as read-only mode
	la	$a1, dict_buffer
	lh	$a2, dict_buffer_size
	jal	Open_Read
	
	li 	$v0, 13			# Opens output file as create, write and append mode
	la 	$a0, output_file
	li 	$a1, 9
	li 	$a2, 0
	syscall
	move 	$s2, $v0
	
	
	

	la $t0, input_buffer
Loop1:

	lbu $t1, ($t0)			# Loads input value
	lbu $t2, 1($t0)			# Loads input value
	sll $t2, $t2, 8
	add $t1, $t1, $t2
	
	beqz $t1, End_Loop1		# Finaliza si el digrama es null
	
	lw $t2, digram_dict_pos		# Loads dict buffer
	
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
			lw	$t8, digram_dict_pos
			
			move $a0, $t1
			jal Print
			
			Loop3:
			
				lbu	$t3, ($t2)	# Se carga letra del dict
				
				bge $t2, $t8, End_Loop3 # Si final de letras en diccionario
				
				bne $t1, $t3, Else1_Loop3 # Si letras no son iguales
				
				
				move 	$a0, $t2	# Sets to write code
				la 	$a1, dict_buffer
				move	$a2, $s2
				jal Write_Code
				
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



####################################################################################################
# PROCEDURE: Open Read
# Sets the SYSCALL to Open a File and Reads it, saving the data in Buffer
# params:
#	- a0: Memory address of the File's name
#	- a1: Buffer address
#	- a2: Buffer size
Open_Read:

	move 	$t0, $a1	# Saves the parameter a1 'cause it's replaced afterwards
	move 	$t1, $a2	# Saves the parameter a2 'cause it's replaced afterwards
	
	li 	$v0, 13		# Sets SYSCALL to Open File
	move 	$a0, $a0
	li 	$a1, 0
	li 	$a2, 0
	syscall
	
	move 	$a0, $v0	# Uses the previous Return, the File's Descriptor
	li 	$v0, 14		# Sets SYSCALL to Read File
	move 	$a1, $t0
	move 	$a2, $t1
	syscall
	
	jr	$ra
	
####################################################################################################
# PROCEDURE: Write Code
# Gets the Encoded value of a DirDigram and sets the SYSCALL to Write it on a File 
# params:
#	- a0: Digram dictionary POS
#	- a1: Dict buffer pos
#	- a2: File descriptor
Write_Code:

	addi 	$sp, $sp, -4
	sw   	$ra, 0($sp)
	jal	Encoder	
	lw   	$ra, 0($sp)
	addi 	$sp, $sp, 4
		
	sw	$v0, printing	# Saving encoded value in Memory
	li 	$v0, 15		# System call for write to a file
	move 	$a0, $a2	# Restore file descriptor (open for writing)
	la 	$a1, printing	# Address of buffer from which to write
	li 	$a2, 1		# Number of characters to write
	syscall
		
	#li   $v0, 16      	# system call for close file
	#move $a0, $a0    	# file descriptor to close
	#syscall			# close file
	
	jr	$ra
	

####################################################################################################
# PROCEDURE: Encoder
# Returns a code based on the position recieved (dictionary position of a character or digram)
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


####################################################################################################
# PROCEDURE: Print
# Prints a recieved value and makes a line feed
# params:
#	- a0: data to print
# return:
Print:
	sw $a0, printing
	li $v0, 4
	la $a0, printing
	syscall
	
	li $a0, 0x0a
	sw $a0, printing
	li $v0, 4
	la $a0, printing
	syscall
	jr	$ra

End_Program:
