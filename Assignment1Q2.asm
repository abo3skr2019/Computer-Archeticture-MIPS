main:
addi $t0, $zero, 3  # int t0 = 3;
addi $t1, $zero, 7  # int t1 = 7;

slt $t2, $t0, $t1   # if (t0 < 7)
beq $t2, $zero, Else

add $t1, $t1, $t0   # t1 = 7 + t0;
j Exit

Else:
add $t1, $t0, $t0   # t1 = t0 + t0;

Exit:
# Print $t0
move $a0, $t0       # Move the value of $t0 to $a0
li $v0, 1           # Load immediate value 1 to $v0 for print integer service
syscall             # Perform the system call

# Print newline
li $v0, 11          # Load immediate value 11 to $v0 for print character service
li $a0, 10          # Load ASCII value of newline character to $a0
syscall             # Perform the system call

# Print $t1
move $a0, $t1       # Move the value of $t1 to $a0
li $v0, 1           # Load immediate value 1 to $v0 for print integer service
syscall             # Perform the system call

jr $ra              # Return from main function