.data
	arr: .word 1, 2, 5, 8, 12, 44, 3, 9, 0, 10
	comma: .asciiz ", "
.text
main:
	la $t0, arr
	li $t1, 9
	
	sll $t2, $t1, 2
	add $t0, $t0, $t2

loop:
	lw $t3, 0($t0)
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	beq $t1, $zero, exit
	
	li $v0, 4
	la $a0, comma
	syscall
	
	addi $t1, $t1, -1
	addi $t0, $t0, -4
	
	j loop
	
exit:
	li $v0, 10
	syscall