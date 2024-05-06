.data
A: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10  # Array A
B: .word 0, -1, 5, -3, 4                 # Array B
C : .space 400                           # Array C
.text
# Main function for SPIM Execution
.globl main

main:
    la $s0, A  # Load base address of array A into $s0
    la $s1, B  # Load base address of array B into $s1
    la $s2, C  # Load base address of array C into $s2
    addi $t0, $zero, 0

loop:
    sll $t1,$t0,2 # t1 = i*4
    add $s3,$s0,$t1 # s3 = A[i]
    add $s4,$s1,$t1 # s4 = B[i]
    lw $t4,0($s3) # Load A[i] into t4
    lw $t7,4($s3) # Load A[i+1] into t7
    lw $t8,8($s4) # Load B[i+2] into t8
    sub $t9,$t7,$t4 # t9 = A[i+1] - A[i]
    add $t6,$t8,$t9 # t6 = B[i+2] + (A[i+1] - A[i])
    sw $t6,0($s2) # Store C[i] into C
    # Debug print statements
    move $a0, $t6
    li $v0, 1
    syscall
    # Print an empty line
    li $a0, 10  # ASCII value for newline
    li $v0, 11  # System call for print_char
    syscall

    addi $t0,$t0,1 # Increment i
    bne $t0,98,loop # Loop back to loop if i < 98
