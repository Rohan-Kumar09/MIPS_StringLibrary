.text
.globl call_token
call_token:
.data
prompt: .asciiz "\nEnter a string: "
result: .asciiz "\nHere's the split string: "
string1: .space 52
string2: .space 52
.text

li $v0, 4
la $a0, prompt
syscall

li $v0, 8
la $a0, string1
li $a1, 50
syscall
move $s1, $a0

la $s2, string2

addiu $sp, $sp, -12
sw $s1, 0($sp) # & main string
sw $s2, 4($sp) # & resulting string
sw $ra, 8($sp)
jal token
lw $ra, 8($sp)
addiu $sp, $sp, 12

li $v0, 4
la $a0, result
syscall

la $a0, string2 # load & string2 for display
syscall

jr $ra