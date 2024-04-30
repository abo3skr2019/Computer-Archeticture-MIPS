# Setting up the environment
.data
A: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10  # Array A
B: .word 0, -1, 5, -3, 4                 # Array B

.text
# Main function for SPIM Execution
.globl main
main:
    la $a0, A    # Load base address of A into $a0
    la $a1, B    # Load base address of B into $a1

    # Load B[2] into $t0
    addi $t1, $zero, 2          # $t1 = 2 (index)
    sll $t1, $t1, 2             # $t1 = $t1 * 4 (byte offset)
    add $t1, $a1, $t1           # $t1 = base address of B + byte offset
    lw $t0, 0($t1)              # $t0 = B[2]
    
    # Check if B[2] is greater than or equal to 0
    bgez $t0, compute           # if B[2] >= 0, jump to compute

    # If B[2] is less than 0, we do nothing and exit
    j exit

    compute:
    # Load A[B[2]] into $t2
    sll $t0, $t0, 2             # $t0 = B[2] * 4 (byte offset)
    add $t0, $a0, $t0           # $t0 = base address of A + byte offset
    lw $t2, 0($t0)              # $t2 = A[B[2]]


    # Print A[B[2]]
    move $a0, $t2  # Move the value of $t2 to $a0
    li $v0, 1      # Load the system call code for print_int into $v0
    syscall        # Make the system call
    # Print New Line
    li $a0, 10     # Load ASCII value of newline into $a0
    li $v0, 11     # Load the system call code for print_char into $v0
    syscall        # Make the system call

    # Compute A[B[2]] * 2 and store in X ($s0)
    sll $s0, $t2, 1             # $s0 = A[B[2]] * 2

exit:
    # Print X ($s0)
    move $a0, $s0  # Move the value of $s0 to $a0
    li $v0, 1      # Load the system call code for print_int into $v0
    syscall        # Make the system call

    # Exit point of the program
    li $v0, 10     # Load the system call code for exit into $v0
    syscall        # Make the system call