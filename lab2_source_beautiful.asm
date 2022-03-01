
.data
input_file: .asciiz "digram_test.java"
dict_file: .asciiz "dictionary.txt"
output_file: .asciiz "output.txt"

.align 2
buffer: .space 20480



.text

Main:
	
	la $a0, input_file
	la $a1, dict_file
	la $a2, output_file
	la $a3, buffer
	jal 	Load_Files # Calling Load_File with the previously set params
	
	

	

# Loads all the files needed for the program to work
# params:
#	- a0: input file name
#	- a1: dict file name
#	- a2: output file name
#	- a3: buffer location
# return:
#	- v0: 
#	- v1: 
Load_Files:
	
	addi 	$sp, $sp, -8
	sw   	$s0, 0($sp)		# $s0 al stack
	sw   	$s1, 4($sp)		# $s1 al stack

	# Opens input file as read-only mode
	li 	$v0, 13
	la 	$a0, input_file
	li 	$a1, 0
	li 	$a2, 0
	syscall
	move 	$s0, $v0
	
	
	# Opens output file as wirint and append mode
	li 	$v0, 13
	la 	$a0, output_file
	li 	$a1, 9
	li 	$a2, 0
	syscall
	move 	$s1, $v0
	
	
	# Sets reading from input file
	li 	$v0, 14
	move 	$a0, $s0
	la 	$a1, buffer
	li 	$a2, 20480
	syscall
	move 	$t1, $v0
	
	move $v0, $s0
	move $v1, $s1
	

	lw   	$s1, 4($sp)		# $s1 al stack
	lw   	$s0, 0($sp)		# $s0 al stack
	addi 	$sp, $sp, 8
	
	
	
	
#	li 	$t8, 0
#	lw 	$t7, 4($a1)
#	andi 	$t7, $t7, 0xFF00FFFF
#	sw 	$t7, 4($a1)
#	
#	li 	$v0, 4
#	la 	$a0, buffer
#	syscall