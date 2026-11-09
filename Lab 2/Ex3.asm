.data
    arr:     .space 40
    prompt:  .asciiz "Please insert a element: "
    result:  .asciiz "Second largest value is "
    found:   .asciiz ", found in index "
    comma:   .asciiz ", "
    error:   .asciiz "No second largest distinct value exists."
    newline: .asciiz "\n"

.text
.globl main
main:
    la $t0, arr
    li $t1, 10

# Read 10 integers.
input:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    sw $v0, 0($t0)

    addiu $t0, $t0, 4
    addiu $t1, $t1, -1
    bgtz $t1, input

# $s0 = largest
# $s1 = second largest (valid only when $s2 = 1)
# $s2 = whether a second distinct value exists
    la $t0, arr
    lw $s0, 0($t0)
    li $s1, 0
    li $s2, 0
    li $t1, 1

find:
    bge $t1, 10, findDone

    sll $t2, $t1, 2
    addu $t3, $t0, $t2
    lw $t4, 0($t3)

    bgt $t4, $s0, newMax
    beq $t4, $s0, nextFind

    # Here arr[i] < largest.
    beq $s2, $zero, setSecond
    ble $t4, $s1, nextFind

setSecond:
    move $s1, $t4
    li $s2, 1
    j nextFind

newMax:
    # Previous largest becomes second largest.
    move $s1, $s0
    move $s0, $t4
    li $s2, 1

nextFind:
    addiu $t1, $t1, 1
    j find

findDone:
    beq $s2, $zero, noFound

    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 4
    la $a0, found
    syscall

# Scan again to print every matching index.
    la $t0, arr
    li $t1, 0               # Current index
    li $t5, 0               # Has an index already been printed?

printIndexes:
    bge $t1, 10, finish

    sll $t2, $t1, 2
    addu $t3, $t0, $t2
    lw $t4, 0($t3)

    bne $t4, $s1, nextIndex
    beq $t5, $zero, printIndex

    # Print a separator before each subsequent index.
    li $v0, 4
    la $a0, comma
    syscall

printIndex:
    li $v0, 1
    move $a0, $t1
    syscall
    li $t5, 1

nextIndex:
    addiu $t1, $t1, 1
    j printIndexes

noFound:
    li $v0, 4
    la $a0, error
    syscall

finish:
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall