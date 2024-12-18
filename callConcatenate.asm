.text
.globl call_concatenate
call_concatenate:
.data

prompt: .asciiz "\nEnter string: "
answer: .asciiz "\nConcatenated string: "
result: .space 104
str1: .space 52
str2: .space 52
.align 0
.text

li $v0, 4
la $a0, prompt
syscall

li $v0, 8
la $a0, str1
li $a1, 50
syscall
move $t1, $a0

la $a0, prompt
li $v0, 4
syscall

li $v0, 8
la $a0, str2
li $a1, 50
syscall
move $t2, $a0

la $t3, result

addiu $sp, $sp, -16
sw $t1, 0($sp) # first string
sw $t2, 4($sp) # second string
sw $t3, 8($sp) # resulting string
sw $ra, 12($sp) # this space is to store address of $ra to Main.asm
jal concatinate
lw $t0, 8($sp)
lw $ra, 12($sp)
addiu $sp, $sp, 16

li $v0, 4
la $a0, answer
syscall

move $a0, $t0
li $v0, 4
syscall

End:
jr $ra
