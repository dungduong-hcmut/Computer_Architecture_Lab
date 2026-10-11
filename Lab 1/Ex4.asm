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
	
	#calculate
	addi $t1, $0, 2 #i = 2
	
	#first bit
	div $t0, $t1
	mflo $t0
	mfhi $t2
	
	#second bit
	div $t0, $t1
	mflo $t0
	mfhi $t3
	
	#third bit
	div $t0, $t1
	mflo $t0
	mfhi $t4
	
	#fourth bit
	div $t0, $t1
	mflo $t0
	mfhi $t5

	#print result
	li $v0, 4
	la $a0, prompt2
	syscall
	
	add $a0, $0, $t5
	li $v0, 1
	syscall
	add $a0, $0, $t4
	li $v0, 1
	syscall
	add $a0, $0, $t3
	li $v0, 1
	syscall
	add $a0, $0, $t2
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall