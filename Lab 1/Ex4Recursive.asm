.data
	prompt1: .asciiz "Please enter a positive integer less than 16:"
	prompt2: .asciiz "Its binary form is: "
.text
	#print prompt1
	li $v0, 4
	la $a0, prompt1
	syscall
	
	#input
	li $v0, 5
	syscall
	move $t0, $v0
	
main:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $a0, 
	
	
Recursive: