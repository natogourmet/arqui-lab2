
.data
letters_size: 		.byte 98
digram_dict_pos:	.word 0
printing: 		.byte 0
input_buffer_size:	.half 30000
dict_buffer_size:	.half 414

input_file: 		.asciiz "digram_test.java"
dict_file: 		.asciiz "dictionary.txt"
output_file: 		.asciiz "output.txt"
message1: 		.asciiz "The received file has a size of: "
message2: 		.asciiz "The compressed file has a size of: "
message3: 		.asciiz "The compression rate achieved was: "

.align 2
input_buffer:	 	.space 30000
null_space:		.space 4
dict_buffer: 		.space 414




.text

li	$s5, 0			# Written characters counter (output file size)
li 	$s7, 2			# Input movement rate (moving 1 or 2 chars)

la 	$t0, dict_buffer
lbu 	$t1, letters_size
add 	$t0, $t0, $t1
sw 	$t0, digram_dict_pos	# Pos in dict where digrams start

la 	$a0, input_file		# Opens input file as read-only mode
la	$a1, input_buffer
lh	$a2, input_buffer_size
jal	Open_Read
move	$s6, $v0

la 	$a0, dict_file		# Opens dict file as read-only mode
la	$a1, dict_buffer
lh	$a2, dict_buffer_size
jal	Open_Read

li 	$v0, 13			# Opens output file as create, write and append mode
la 	$a0, output_file
li 	$a1, 9
li 	$a2, 0
syscall
move 	$s4, $v0


la 	$s0, input_buffer	# Input pointer to iterate through it
Loop1:

	lbu 	$t0, ($s0)		# Loads first char of input digram
	lbu 	$t1, 1($s0)		# Loads second char of input digram
	sll 	$t1, $t1, 8		# Concats both chars
	add 	$s1, $t0, $t1
	
	beqz 	$s1, End_Loop1		# Ends if the char value is 0 (End of String)
	
	move	$a0, $s1
	jal	Search_Digram		# Search for digram in dict
	move	$s2, $v0
	
	bnez 	$v0, On_Found		# If (digValue == 0) Digram not found
	li 	$s7, 1			# Changes moving factor (Since only one char is being read, the next input pos is +1)
	lbu	$s1, ($s0)
	move	$a0, $s1
	jal	Search_Char		# Searches for char in dict
	move	$s2, $v0
	
	On_Found:
	move	$a0, $s2		# When a digram or char was found
	move	$a1, $s4
	jal	Write_Code
	addi	$s5, $s5, 1
	
	add $s0, $s0, $s7
	li $s7, 2			# Resets the moving factor to 2
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
#	- a1: File descriptor
Write_Code:

	addi 	$sp, $sp, -4
	sw   	$ra, 0($sp)
	jal	Encoder	
	lw   	$ra, 0($sp)
	addi 	$sp, $sp, 4
		
	sw	$v0, printing	# Saving encoded value in Memory
	li 	$v0, 15		# System call for write to a file
	move 	$a0, $a1	# Restore file descriptor (open for writing)
	la 	$a1, printing	# Address of buffer from which to write
	li 	$a2, 1		# Number of characters to write
	syscall
	
	jr	$ra
	

####################################################################################################
# PROCEDURE: Encoder
# Returns a code based on the position recieved (dictionary position of a character or digram)
# params:
#	- a0: current digram pos
# return:
#	- v0: encoded value
Encoder: 
	la	$t0, dict_buffer
	sub 	$t0, $a0, $t0
	
	lw	$t1, letters_size
	bleu 	$t0, $t1, End_Encoder
	sub 	$t0, $t0, $t1
	srl 	$t0, $t0, 1
	add 	$t0, $t0, $t1
	
	End_Encoder:
	move	$v0, $t0
	jr	$ra

####################################################################################################
# PROCEDURE: Search Digram
# Searches for the same Digram inside of the dictionary
# params:
#	- a0: digram to look for
# return:
#	- v0: dictionary's matching digram address, or 0 if not found
Search_Digram:
	move 	$t0, $a0
	lw	$t1, digram_dict_pos
	
	Search_Digram_Loop:
		lhu	$t2, ($t1)
		beqz 	$t2, Search_Digram_Null
		bne	$t0, $t2, Search_Digram_Loop_Again

		move	$v0, $t1
		jr	$ra

	Search_Digram_Loop_Again:
		addi 	$t1, $t1, 2
		j	Search_Digram_Loop
	
	Search_Digram_Null:
		li	$v0, 0
		jr	$ra


####################################################################################################
# PROCEDURE: Search Character
# Searches for the same Character inside of the dictionary
# params:
#	- a0: character to look for
# return:
#	- v0: dictionary's matching character address, or 0 if not found
Search_Char:
	move 	$t0, $a0
	la	$t1, dict_buffer
	
	Search_Char_Loop:
		lbu	$t2, ($t1)
		beqz 	$t2, Search_Char_Null
		bne	$t0, $t2, Search_Char_Loop_Again
		
		move	$v0, $t1
		jr	$ra
	
	Search_Char_Loop_Again:
		addi 	$t1, $t1, 1
		j	Search_Char_Loop
	
	Search_Char_Null:
		li	$v0, 0
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


####################################################################################################
# END OF THE PROGRAM
End_Program:

mtc1	$s6, $f0
cvt.s.w	$f0, $f0
mtc1	$s5, $f1
cvt.s.w	$f1, $f1
div.s	$f2, $f0, $f1

li	$v0, 4
la	$a0, message1
syscall
mov.s	$f12, $f0
li	$v0, 2
syscall
li	$a0, 0
jal	Print

li	$v0, 4
la	$a0, message2
syscall
mov.s	$f12, $f1
li	$v0, 2
syscall
li	$a0, 0
jal	Print

li	$v0, 4
la	$a0, message3
syscall
mov.s	$f12, $f2
li	$v0, 2
syscall
li	$a0, 0
jal	Print
