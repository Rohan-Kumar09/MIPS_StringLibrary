.text
.globl call_truncate
call_truncate:
.data
prompt: .asciiz "Enter a string: "
index: .asciiz "Enter the index: "
result: .asciiz "Truncated string: "
string: .space 52
truncatedString: .space 52
.text

li $v0, 4
la $a0, prompt
syscall

li $v0, 8
la $a0, string
li $a1, 50
syscall
move $s1, $a0 # s1 has main string

li $v0, 4
la $a0, index
syscall

li $v0, 5
syscall
move $s3, $v0 # s3 has index

la $s2, truncatedString

addiu $sp, $sp, -16
sw $s1, 0($sp)
sw $s2, 4($sp)
sw $s3, 8($sp)
sw $ra, 12($sp)
jal truncate
lw $ra, 12($sp)
addiu $sp, $sp, 16

li $v0, 4
la $a0, result
syscall

la $a0, truncatedString
syscall

jr $ra