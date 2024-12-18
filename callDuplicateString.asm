.text
.globl call_duplicate_string
call_duplicate_string:
.data
prompt1: .asciiz "\nEnter a string: "
string1: .space 202
stringCopy: .space 202
.text

li $v0, 4
la $a0, prompt1
syscall

li $v0, 8
la $a0, string1
li $a1, 200
syscall
move $s1, $a0

la $s2, stringCopy

addiu $sp, $sp, -12
sw $s1, 0($sp)
sw $s2, 4($sp)
sw $ra, 8($sp)
jal duplicate_string
lw $s2, 4($sp) # & of dubString
lw $ra, 8($sp) # & to main
addiu $sp, $sp, 12

printLoop: # print the copy of string
    lb $a0, ($s2)
    beq $a0, 10, printLoopEnd
    beq $a0, 0, printLoopEnd
    li $v0, 11
    syscall
    addi $s2, $s2, 1
    b printLoop
printLoopEnd:
jr $ra # back to main
