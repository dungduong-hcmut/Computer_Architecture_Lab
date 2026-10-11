.data
strIn: .space 100
greeting: .asciiz "Hello, "
exclamation: .asciiz "!"

.text
main:
    # Input name
    la $a0, strIn
    li $a1, 100
    li $v0, 8
    syscall

    # Remove newline
    la $t0, strIn

remove_newline:
    lb $t1, 0($t0)
    beq $t1, $zero, print
    beq $t1, 10, replace
    addi $t0, $t0, 1
    j remove_newline

replace:
    sb $zero, 0($t0)

print:
    # Print greeting
    li $v0, 4
    la $a0, greeting
    syscall

    # Print name
    li $v0, 4
    la $a0, strIn
    syscall

    # Print exclamation
    li $v0, 4
    la $a0, exclamation
    syscall

    # Exit
    li $v0, 10
    syscall