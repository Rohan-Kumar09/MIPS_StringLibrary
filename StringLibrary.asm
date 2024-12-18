.text
.globl concatinate # concatinate(&firstString, &secondString, &concatenatedString))
concatinate: # returns the address of concatenated string
    lw $s1, 0($sp) # first string
    lw $s2, 4($sp) # second string
    lw $s3, 8($sp) # resulting string ($s3 doesn't need to be sw bc it remains the same)
    loop:
    lb $t1, ($s1) # lb char[i] (first string)
    sb $t1, ($s3) # sb char[j]
    beq $t1, 0, string_ended # if \0 or \n: go to string_ended
    beq $t1, 10, string_ended
    addi $s1, $s1, 1 # i++
    addi $s3, $s3, 1 # j++
    b loop
    string_ended:
    lb $t2, ($s2) # lb char[i] (second string)
    sb $t2, ($s3) # sb char[j] to the end of saved first string in $s3 address
    beq $t2, 0, second_string_ended # if null: return back to callConcatinate.
    addi $s3, $s3, 1
    addi $s2, $s2, 1
    b string_ended
    second_string_ended:
    jr $ra


.globl find_substring # find_substring(&firststring, &secondstring)
find_substring: # returns the index first Substring, returns -1 if not found. 
	lw $s1, 0($sp)
	lw $s2, 4($sp)
	li $t3, 0 # main counter = 0
	li $t4, 0 # sub counter = 0
	
	main_loop: # Keep reading from main_string until you find a match with sub_string
	lb $a1, ($s1) # $a1 = *s1 which is main 
	lb $a2, ($s2) # $a2 = *s2 which is sub  
	beq $a1, $zero, end_main # if *main == null, branch to end_main
    beq $a1, $a2, sub_loop # if *main == *sub, branch to sub_loop
    bne $t4, 0, reset # if sub counter != 0, branch to reset
    addi $t3, $t3, 1 # main counter++                      
    addi $s1, $s1, 1 # main++                              
    b main_loop

    reset: # After every failed attempt to match reset the counter and sub_string to index 0.
    add $t3, $t3, $t4 # main counter += sub counter
    li $t4, 0 # sub counter = 0
    lw $s2, 4($sp) # & $s2 = & sub | sub to index 0
    b main_loop

    sub_loop: # Increment index of sub_string to check the next character.
    addi $s2, $s2, 1 # sub++
    lb $a2, ($s2) # $a2 = *sub.
    beq $a2, 10, end_sub # if *sub == 10, branch to end_sub
    beq $a2, $zero, end_sub # if *sub == null, branch to end_sub
    addi $s1, $s1, 1 # main++
    addi $t4, $t4, 1 # sub counter++
    b main_loop

    end_main: # if the main string ends first: not found
    li $t3, -1
    sw $t3, 0($sp)
    jr $ra

    end_sub: # if the substring makes it to \n char: return main counter
    sw $t3, 0($sp)
    jr $ra

.globl duplicate_string # duplicate_string(&string, &dubString)
duplicate_string: # returns the address of duplicated string
    la $t3, 0 # counter
    lw $s1, 0($sp) # string
    lw $s2, 4($sp) # dublicated string
    duplicate_string_loop:
    lb $t1, ($s1)
    sb $t1, ($s2)
    beq $t1, 10, copyMade
    beq $t1, 0, copyMade
    addi $s1, $s1, 1
    addi $s2, $s2, 1
    addi $t3, $t3, 1
    b duplicate_string_loop

    copyMade:
    sub $s2, $s2, $t3 # sub num of iterations to reset &dubString.
    sw $s2, 4($sp)
    jr $ra # return back to callDublicateString.asm

.globl make_upper # make_upper(&string, &upperString)
make_upper: # makes string at address $s1 uppercase, stores in $s2
	lw $s1, 0($sp) # main string
	lw $s2, 4($sp) # string in upper
	makeUpperLoop:
	lb $t1, ($s1) # lb char[i]
	beq $t1, 10, endMakeUpperLoop # if \n: return
	beq $t1, 0, endMakeUpperLoop # if \0: return
	blt $t1, 97, skip # if not lowerCase alphabet: skip
	bgt $t1, 122, skip
	addi $t1, $t1, -32 # Make upper
	skip: # everything that's not lowerCase alpha gets skiped and saved as it is.
	sb $t1, ($s2)
	addi $s1, $s1, 1
	addi $s2, $s2, 1
	b makeUpperLoop
	endMakeUpperLoop:
	jr $ra
	
.globl make_lower # make_lower(&string, &lowerString) logic is same as make_upper.
make_lower: # makes string at address $s1 lowercase, stores in $s2, returns $s2
	lw $s1, 0($sp)
	lw $s2, 4($sp)
	makeLowerLoop:
	lb $t1, ($s1)
	beq $t1, 10, endMakeLowerLoop
	beq $t1, 0, endMakeLowerLoop
	blt $t1, 65, skip1 # skip if not upperAlpha:
	bgt $t1, 90, skip1
	addi $t1, $t1, 32
	skip1:
	sb $t1, ($s2)
	addi $s1, $s1, 1
	addi $s2, $s2, 1
	b makeLowerLoop
	endMakeLowerLoop:
	jr $ra
	
.globl find_string_length # find_string_length(&string)
find_string_length: # returns string length as integer
	lw $s1, 0($sp) # string address[0]
	li $t1, 0 # counter
	fslloop:
	lb $t2, ($s1)
	beq $t2, 10, endfslloop
	beq $t2, 0, endfslloop
	addi $s1, $s1, 1
	addi $t1, $t1, 1
	b fslloop
	endfslloop:
	sw $t1, 4($sp) # return counter
	jr $ra
	
.globl comparison # comparison(&firstString, &secondString)
comparison: # returns 1 if first string is greater
	lw $s1, 0($sp) # returns 0 if second string is greater
	lw $s2, 4($sp) # returns -1 if both equal
	compLoop:
	lb $t1, ($s1)
	lb $t2, ($s2)
	bgt $t1, $t2, tGreaterThan
	blt $t1, $t2, tLessThan
	beq $t1, $t2, equal
	b compLoop
	equal:
	beq $t1, 10, endEqual
	beq $t1, 0, endEqual
	addi $s1, $s1, 1
	addi $s2, $s2, 1
	b compLoop
	tLessThan:
	la $t1, 0
	sw $t1, 0($sp)
	jr $ra
	tGreaterThan:
	la $t1, 1
	sw $t1, 0($sp)
	jr $ra
	endEqual:
	la $t1, -1
	sw $t1, 0($sp)
	jr $ra
	
# for simpler explaination go to README.txt ~ line 41
.globl token # token(&mainString, $tokenedString) (removes all ascii that are not alpha or number: adds \n instead)
token: # returned tokenedString& is accesable in main file.
	lw $s1, 0($sp) # main string
	lw $s2, 4($sp) # tokened string
	li $t3, 0 # counter
	li $t4, 10 # \n
	li $t5, 0
	token_loop:
	lb $t1, ($s1)
	beq $t1, $zero, token_exit_loop
	beq $t1, 10, token_exit_loop
	blt $t1, 48, token_add1
	token_continue1:
	bgt $t1, 57, token_add2
	token_continue2:
	blt $t1, 65, token_add3
	token_continue3:
	bgt $t1, 90, token_add4
	token_continue4:
	blt $t1, 97, token_add5
	token_continue5:
	bgt $t1, 122, token_add6
	token_continue6:
	beq $t5, 3, token_skip
	sb $t1, ($s2)
	li $t5, 0
	addi $s1, $s1, 1
	addi $s2, $s2, 1
	b token_loop

	token_skip:
	li $t5, 0
	sb $t4, ($s2)
	addi $s1, $s1, 1
	addi $s2, $s2, 1
	b token_loop

	token_add1:
	addi $t5, $t5, 1
	b token_continue1
	token_add2:
	addi $t5, $t5, 1
	b token_continue2
	token_add3:
	addi $t5, $t5, 1
	b token_continue3
	token_add4:
	addi $t5, $t5, 1
	b token_continue4
	token_add5:
	addi $t5, $t5, 1
	b token_continue5
	token_add6:
	addi $t5, $t5, 1
	b token_continue6

	token_exit_loop:
	sb $zero, ($s2)
	jr $ra

.globl truncate # truncate(&string, &truncatedstring, index)
truncate: # returns [index:end] till end as in python sliceing 
	lw $s1, 0($sp) # main string
	lw $s2, 4($sp) # truncatedString
	lw $s3, 8($sp) # index
	blez $s3, trunc_end # if index is innitially <= 0: return (don't do anything)
	trunc_loop:
	blez $s3, trunc_next
	addi $s1, $s1, 1
	addi $s3, $s3, -1
	b trunc_loop

	trunc_next:
	lb $t1, ($s1)
	sb $t1, ($s2)
	beq $t1, 10, trunc_end
	beq $t1, $zero, trunc_end
	addi $s1, $s1, 1
	addi $s2, $s2, 1
	b trunc_next
	trunc_end:
	jr $ra

.globl replace_string # for simpler code README.txt line 61
replace_string:
	lw $s1, 0($sp) # main string
	lw $s2, 4($sp) # old substring
	lw $s3, 8($sp) # new substring
	lw $s4, 12($sp) # new string 

	addiu $sp, $sp, -12 # length of old substring
	sw $s2, 0($sp) # string
	sw $ra, 8($sp)
	jal find_string_length
	lw $t2, 4($sp) # returned counter
	lw $ra, 8($sp)
	addiu $sp, $sp, 12
	lw $s1, 0($sp)
	lw $s2, 4($sp)

	find_old_string:
	move $s7, $s1
	addiu $sp, $sp, -20 # find old substring
	sw $s1, 0($sp)
	sw $s2, 4($sp)
	sw $ra, 8($sp)
	sw $t3, 12($sp)
	sw $t4, 16($sp)
	jal find_substring
	lw $t7, 0($sp) # index at which found
	lw $ra, 8($sp)
	lw $t3, 12($sp)
	lw $t4, 16($sp)
	addiu $sp, $sp, 20
	move $s1, $s7
	lw $s2, 4($sp)
	lw $s3, 8($sp)
	beq $t7, -1, add_leftovers # end condition

	string_save_loop:
	lb $t1, ($s1) # main string[i]
	sb $t1, ($s4)
	beqz $t7, truncate_it
	addi $s1, $s1, 1
	addi $s4, $s4, 1
	addi $t7, $t7, -1
	b string_save_loop

	truncate_it:
	add $s1, $s1, $t2
	b add_new_string

	add_new_string:
	lb $t6, ($s3)
	sb $t6, ($s4)
	beq $t6, 10, find_old_string
	beq $t6, 0, find_old_string
	addi $s3, $s3, 1
	addi $s4, $s4, 1
	b add_new_string

	add_leftovers:
	lb $t1, ($s1) # main string[i]
	sb $t1, ($s4)
	beq $t1, $zero, replace_string_end
	addi $s1, $s1, 1
	addi $s4, $s4, 1
	b add_leftovers

	replace_string_end:
	jr $ra
