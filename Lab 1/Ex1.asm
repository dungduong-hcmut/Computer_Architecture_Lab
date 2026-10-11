.data
strIn: .space 100
greeting: .asciiz "Hello, "
exclamation: .asciiz "!"

.text
main:
	#Input name
	la $a0, strIn
	addi $a1, $zero, 10
	li $v0, 8
	syscall
	
	#print
	li $v0, 4
	la $a0, greeting
	syscall
	
	li $v0, 4
	la $a0, strIn
	syscall
	
	li $v0, 4
	la $a0, exclamation
	syscall

	li $v0, 10
	syscall