.data
	arr: .space 20
	prompt1: .asciiz "Please input element "
	prompt2: .asciiz ":"
	prompt3: .asciiz "Please enter index:"

.text
	li $t0, 0
	li $t1, 5
	la $t2, arr
loop:
    	#Print prompt1
    	li $v0, 4
    	la $a0, prompt1
    	syscall

	#print index
	li $v0, 1
	move $a0, $t0
	syscall
	
	#print prompt2
	li $v0, 4
	la $a0, prompt2
	syscall
	
	#input element
	li $v0, 5
	syscall
	
	#store into array
	sw $v0, 0($t2)
	
	addi $t0, $t0, 1
	addi $t2, $t2, 4

	#number of elemet < 5?
	beq $t0, $t1, exit
	j loop
exit:
	#print prompt3
	li $v0, 4
	la $a0, prompt3
	syscall
	
	#input 
	li $v0, 5
	syscall
	
	#calculate address of the chosen element in the array
	sll $v0, $v0, 2
	la $t2, arr
	add $t2, $t2, $v0
	lw $t3, 0($t2)
	
	#print element
	li $v0, 1
	move $a0, $t3
	syscall
	
	#terminate
	li $v0, 10
	syscall

	
	
	