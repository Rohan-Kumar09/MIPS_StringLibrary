.text
.globl call_replace_string
call_replace_string:
.data
prompt1: .asciiz "\nEnter the First string: "
prompt2: .asciiz "\nEnter the Old SubString: "
prompt3: .asciiz "\nEnter the New SubString: "
result: .asciiz "\nThe New String is: "
string1: .space 52
string2: .space 52
string3: .space 52
string4: .space 200
.text

li $v0, 4
la $a0, prompt1
syscall

li $v0, 8
la $a0, string1
li $a1, 50
syscall
move $s1, $a0

li $v0, 4
la $a0, prompt2
syscall

li $v0, 8
la $a0, string2
li $a1, 50
syscall
move $s2, $a0

li $v0, 4
la $a0, prompt3
syscall

li $v0, 8
la $a0, string3
li $a1, 50
syscall
move $s3, $a0

la $s4, string4
addiu $sp, $sp, -20
sw $s1, 0($sp)
sw $s2, 4($sp)
sw $s3, 8($sp)
sw $s4, 12($sp)
sw $ra, 16($sp)
jal replace_string
lw $ra, 16($sp)
addiu $sp, $sp, 20

li $v0, 4
la $a0, result
syscall

la $a0, string4
li $v0, 4
syscall

EndProgram:
jr $ra