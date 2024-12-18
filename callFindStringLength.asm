.text
.globl call_find_string_length
call_find_string_length:
.data
prompt: .asciiz "\nEnter a string: "
string: .space 52
result: .asciiz "\nThe string length is: "

.text
li $v0, 4
la $a0, prompt
syscall

li $v0, 8
la $a0, string
la $a1, 50
syscall
move $s1, $a0

addiu $sp, $sp, -12
sw $s1, 0($sp) # string
sw $ra, 8($sp)
jal find_string_length
lw $t1, 4($sp) # returned counter
lw $ra, 8($sp)
addiu $sp, $sp, 12

li $v0, 4
la $a0, result
syscall

move $a0, $t1
li $v0, 1
syscall

jr $ra
