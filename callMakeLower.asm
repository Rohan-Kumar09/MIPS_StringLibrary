.text
.globl call_make_lower
call_make_lower:
.data
prompt: .asciiz "\nEnter a string: "
result: .asciiz "\nString in lower: "
arr1: .space 52
arr2: .space 52
.text

li $v0, 4
la $a0, prompt
syscall

li $v0, 8
la $a0, arr1
li $a1, 50
syscall
move $s1, $a0

la $s2, arr2

addiu $sp, $sp, -12
sw $s1, 0($sp)
sw $s2, 4($sp)
sw $ra, 8($sp)
jal make_lower
lw $ra, 8($sp)
addiu $sp, $sp, 12

li $v0, 4
la $a0, result
syscall

sb $zero, ($s2)
la $s2, arr2

move $a0, $s2
li $v0, 4
syscall

jr $ra
