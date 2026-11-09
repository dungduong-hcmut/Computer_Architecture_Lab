.data
	prompt:		.asciiz "Please insert a non-negative integer: "
    	error:		.asciiz "A factorial for your number can not be found."
	result:		.asciiz "Result: "
	overflow: 	.asciiz "Overflow"
    	newline:	.asciiz "\n"
.text
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	
	bltz $v0, invalid
	li $t0, 12
	bgt $v0, $t0, over

	move $a0, $v0
	jal factorial
	move $s0, $v0          

	li $v0, 4
	la $a0, newline
	syscall

	li $v0, 4
	la $a0, result
	syscall

	move $a0, $s0         
	li $v0, 1
	syscall

	j finish

factorial:
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	
	slti $t0, $a0, 1
	beq $t0, $zero, calculate
	addi $v0, $zero, 1
	
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	jr $ra

calculate:
	 addi $a0, $a0, -1
	 jal factorial
	 lw $a0, 0($sp)
	 lw $ra, 4($sp)
	 addi $sp, $sp, 8
	 mul $v0, $a0, $v0
	 jr $ra

invalid:
	li $v0, 4
	la $a0, error
	syscall
	j finish
	
over:
	li $v0, 4
	la $a0, overflow
	syscall

finish:
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 10
	syscall
	