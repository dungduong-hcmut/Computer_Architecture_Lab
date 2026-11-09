.data
	prompt1: .asciiz "a = "
	prompt2: .asciiz "b = "
	prompt3: .asciiz "GCD = "
	prompt4: .asciiz "LCM = "
	newline: .asciiz "\n"
.text
	# input a
	li $v0, 4
	la $a0, prompt1
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	# check positivity
	ble $t0, $zero, exit
	
	# input b
	li $v0, 4
	la $a0, prompt2
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0

	# check positivity
	ble $t1, $zero, exit
	
	# calculate GCD
	move $a0, $t0
	move $a1, $t1
	jal gcdRecursion
	move $s0, $v0
	
	# calculate LCM
	div $s1, $t0, $s0
	mul $s2, $s1, $t1

	# print results
	li $v0, 4
	la $a0, prompt3
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, prompt4
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
exit:
	li $v0, 10
	syscall
	
	# GCD: Euclid algorithm for GCD (GCD (p, q) = GCD (q, p mod q))
gcdRecursion:
	beq $a1, $zero, baseCase
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	div $a0, $a1
	mfhi $t2
	
	move $t3, $a1
	move $a1, $t2
	move $a0, $t3
	
	jal gcdRecursion
	
	lw $ra, 0($sp)
    	addi $sp, $sp, 4
    	
	jr $ra
baseCase:
	move $v0, $a0
	jr $ra
