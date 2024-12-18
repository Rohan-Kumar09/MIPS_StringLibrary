.text
.globl call_comparison
call_comparison:
.data
prompt1: .asciiz "\nEnter the first string: "
prompt2: .asciiz "\nEnter the second string: "
result1: .asciiz "\nFirst string is bigger.\n"
result2: .asciiz "\nSecond string is bigger.\n"
result3: .asciiz "\nBoth strings are equal.\n"
string1: .space 52
string2: .space 52

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

addiu $sp, $sp, -12
sw $s1, 0($sp)
sw $s2, 4($sp)
sw $ra, 8($sp)
jal comparison
lw $t1, 0($sp)
lw $ra, 8($sp)
addiu $sp, $sp, 12

beq $t1, 1, fisg # first is greater
beq $t1, 0, sisg # second is greater
beq $t1, -1, bae # both are equal

fisg:
li $v0, 4
la $a0, result1
syscall
b EndofProgram

sisg:
li $v0, 4
la $a0, result2
syscall
b EndofProgram

bae:
li $v0, 4
la $a0, result3
syscall
b EndofProgram

EndofProgram: # return back to main
jr $ra
