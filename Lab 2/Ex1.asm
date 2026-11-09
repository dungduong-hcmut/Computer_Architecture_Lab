.data
	arr: .space 20
	prompt: .asciiz "Enter element "
	colon: .asciiz ": "
	result: .asciiz "Result array: "
	space: .asciiz " "

.text
main:
	la $s0, arr
	move $t5, $s0
	li $t1, 5
	li $t0, 0
loop1:	
	beq $t0, $t1, process
	
	li $v0, 4
	la $a0, prompt
	syscall
	
    	li   $v0, 1              
   	addi $a0, $t0, 1
    	syscall

	li $v0, 4
	la $a0, colon
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, 0($t5)
	
	addi $t5, $t5, 4
	addi $t0, $t0, 1
	
	j loop1
	
process:
	li $t0, 0
	li $t2, 4
	li $t3, 3
loop2:
	beq $t0, $t1, print
	
	sll $t5, $t0, 2
	add $t5, $s0, $t5        # t5 = address of arr[i]
	lw $t4, 0($t5)
	
	div $t4, $t2
	mfhi $s1
	
	bgez $s1, checkRemainder
	addi $s1, $s1, 4

checkRemainder:
	beq $s1, $zero, next
	beq $s1, $t3, round_up

	sub $t4, $t4, $s1
	j store	
	
round_up:
	addi $t4, $t4, 1
store:
	sw $t4, 0($t5)
next:
	addi $t0, $t0, 1
	j loop2
	
print:
	li $v0, 4
	la $a0, result
	syscall

	li $t0, 0
loop3:
	beq $t0, $t1, exit

	sll $t5, $t0, 2
	add $t5, $s0, $t5
	lw $a0, 0($t5)           # value goes into $a0
	li $v0, 1
	syscall

	li $v0, 4
	la $a0, space
	syscall

	addi $t0, $t0, 1
	j loop3
exit:
	li $v0, 10
	syscall
