.data
	prompt1: .asciiz "Insert a:"
	prompt2: .asciiz "Insert b:"
	prompt3: .asciiz "Insert c:"
	prompt4: .asciiz "Insert d:"
	prompt5: .asciiz "F = "
	prompt6: .asciiz ", "
	prompt7: .asciiz "remainder = "
.text
	#print and input a
	li $v0, 4
	la $a0, prompt1
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0

	#print and input b
	li $v0, 4
	la $a0, prompt2
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0

	#print and input c
	li $v0, 4
	la $a0, prompt3
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0

	#print and input d
	li $v0, 4
	la $a0, prompt4
	syscall
	
	li $v0, 5
	syscall
	move $t3, $v0
	
	#calculate
	add $s1, $t0, $t1 # a+b+c
	add $s1, $s1, $t2
	
	addi $s2, $t0, 10 #a+10
	sub $s3, $t1, $t3 #b-d

	add $s4, $t0, $t0
	sub $s4, $t2, $s4
	
	mul $s5, $s2, $s3
	mul $s5, $s5, $s4
	
	div $s5, $s1
	mflo $t4
	mfhi $t5
	
	#print results
	li $v0, 4
	la $a0, prompt5
	syscall
	
	add $a0, $0, $t4
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, prompt6
	syscall
	
	li $v0, 4
	la $a0, prompt7
	syscall
	
	add $a0, $0, $t5
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
	 