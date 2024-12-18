.text
.globl call_find_sub_string
call_find_sub_string:
.data

main_string: .asciiz "\nEnter the main string: "
sub_string: .asciiz "\nEnter the substring: "
result: .asciiz "\nFount at index: "
main: .space 51
subt: .space 51
Not_found: .asciiz "\nsubstring not found: -1\n"

.text
li $v0, 4
la $a0, main_string
syscall 

li $v0, 8
la $a0, main
li $a1, 51
syscall # input(main_string)

li $v0, 4
la $a0, sub_string
syscall 

li $v0, 8
la $a0, subt
li $a1, 51
syscall # input(sub_string)


la $s1, main # & $s1 = & main
la $s2, subt # & $s2 = & sub

addiu $sp, $sp, -12
sw $s1, 0($sp)
sw $s2, 4($sp)
sw $ra, 8($sp)
jal find_substring
sw $t3, 0($sp) # index at which found
lw $ra, 8($sp)
addiu $sp, $sp, 12

beq $t3, -1, not_found 
b found

not_found:
li $v0, 4
la $a0, Not_found
syscall
b end

found:
li $v0, 4
la $a0, result
syscall

li $v0, 1
move $a0, $t3
syscall

end:
jr $ra
