* BIG PICTURE LOGIC

1. "Main.asm" run this file to test functions.
2. "call_____.asm" such files are entire functions themselves 
that call / test the functions in "StringLibrary.asm".
3. "StringLibrary.asm" contains all the functions that are called by 
"call_____.asm" files. "StringLibrary.asm" contains the main logic.


*IMPORTANT NOTICE* - since the menu is big it might not 
                     show everything on Run I/O please scroll down. 


* COMMON REGISTER USAGE

$t registers are used as COUNTERS and ARRAY_ITERATORS
$s registers are used as ARRAY'S ADDRESS
$a in one instance being used in place of $t, DATA RETRIEVAL AND PRINTING
$v only for SYSCALLS and VALUE_RETRIEVAL



* About "Main.asm"

1. Uses Switch case to call for file selected by user.
Must input 0 to quit.

* About "call_____.asm"

1. The file/function always jump back to the "Main.asm".
2. All the "call_____.asm" file have a space in $sp for $ra
please don't get confused by that as the call files are functions
and return back to main.

* About "StringLibrary.asm"

1. The functions in this file always jump back 
to their respective "call_____.asm".
2. only functions in StringLibrary.asm are indented. 

* About token function in StringLibrary.asm

the only way i found of having "and" logic with < and > signs.
every non number and alpha character is found 3 times.
while every number or alpha is found 2 times.
in code:
c = 0
x = ascii char EXAMPLES: "a = 97 (a gets 2 y)"   /: = 58 (: gets 3 y)\ 
if x < 48: c += 1 "n" /n\ 
if x > 57: c += 1 "y" /y\
if x < 65: c += 1 "n" /y\
if x > 90: c += 1 "y" /n\
if x < 97: c += 1 "n" /y\
if x > 122: c += 1 "n" /n\

if c == 3: save "\n"
else : save the character

* About replace_string function in StringLibrary.asm

most complex one. returns every old instance of string replaced
with new substring. (their may be bugs works fine for most cases)

code:
Example: ''

s1 = mainstring "warship_warship"
s2 = old substring 'war'
s3 = new substring 'battle'
s4 = new string (resulting string) ''

A = findLength(old substring) | '3' | 
loop starts:
---------------------------------------- # s1 and s4 index move in sync sometimes
B = findSubString(s1, s2) | I = '0' | s1='ship_warship' I = '5'| I = '-1' not found:
save s1 into s4 up till index B. | s4='' | s4='battleship_'|
$s1 += B, skip by index found. | s1='warship warship'| s1='warship'
s4 += s3. | s4='battle'| s4='battleship_battle'
$s1 + A | s1= "ship warship" loop->| s1 = "ship" loop->
Loop back^
----------------------------------------
loop ends when findSubString returns -1 : if not found
branching to add_leftovers: which : save remaining stuff in $s1 to $s4 s4='battleship_battleship' added"ship"
return after string reaches null.