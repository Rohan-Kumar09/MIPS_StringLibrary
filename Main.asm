.data
choices1: .asciiz "\n ----------MENU----------\nconcatenate two strings = 1\nfind_substring (return_index) = 2"
choices2: .asciiz "\nreplace_string = 3\nduplicate_string = 4\nmake_all_upper = 5\nmake_all_lower = 6"
choices3: .asciiz "\nstring_length = 7\nCompare_strings = 8\nToken(splits string) = 9"
choices4: .asciiz "\nTruncate = 10\nQuit using program = 0\n"
choice: .asciiz "Enter your choice: "
.text

keep_going:
li $v0, 4
la $a0, choices1
syscall
la $a0, choices2
syscall
la $a0, choices3
syscall
la $a0, choices4
syscall

li $v0, 4
la $a0, choice
syscall

li $v0, 5
syscall

beq $v0, 1, one_concatenate
beq $v0, 2, two_find_substring_index
beq $v0, 3, three_replace_string
beq $v0, 4, four_duplicate_string
beq $v0, 5, five_make_all_upper
beq $v0, 6, six_make_all_lower
beq $v0, 7, seven_find_string_length
beq $v0, 8, eight_comparison
beq $v0, 9, nine_token
beq $v0, 10, ten_truncate
beq $v0, 0, zero_quit

one_concatenate:
jal call_concatenate
b keep_going

two_find_substring_index:
jal call_find_sub_string
b keep_going

three_replace_string:
jal call_replace_string
b keep_going

four_duplicate_string:
jal call_duplicate_string
b keep_going

five_make_all_upper:
jal call_make_upper
b keep_going

six_make_all_lower:
jal call_make_lower
b keep_going

seven_find_string_length:
jal call_find_string_length
b keep_going

eight_comparison:
jal call_comparison
b keep_going

nine_token:
jal call_token
b keep_going

ten_truncate:
jal call_truncate
b keep_going

zero_quit:
li $v0, 10
syscall
