.intel_syntax noprefix
.global _start

.equ zero_char, 48
.equ nein_char, 57

.macro swrite stri le
     mov rax, 1
     mov rdi, 1
     lea rsi, [rip+\stri]
     mov rdx, OFFSET \le
     syscall
.endm

.macro dwrite stri len
     mov rax, 1
     mov rdi, 1
     mov rsi, \stri
     mov rdx, \len
     syscall
.endm

.macro exit code=0
     mov rax, 60
     mov rdi, \code
     syscall
.endm

.section .text
_start:
     # error when more than two params (argv > 3)
     mov r8, [rsp]
     cmp r8, 3
     jg toomany
     jl toofew

     # store argv[1] in r15 (1st arg)
     mov r14, [rsp+16]
     mov r15, 0

     # r12 13 for argv[2] (2nd arg)
     mov r12, [rsp+24]
     mov r13, 0

     # print strs
     jmp getstrlen
     gslb:
     # cmp byte

     # nums 48(0) - 57(9)
     # ascii-48
     jmp countcountstrlen
     ctb:
     mov r9, 0
     jmp checkForNaN
     cfnb:
     cmp r13, 1
     jg checkForLeadingZero
     cflzb:
     je checkForZero
     cfzb:
     swrite theNis theNislen
     exit 0

countcountstrlen:
     cmp byte ptr [r12+r13], 0
     je ctb
     inc r13
     jmp countcountstrlen

checkForZero:
     cmp byte ptr [r12], zero_char
     jne cfzb
     swrite zc zclen
     exit 0

checkForLeadingZero:
     cmp byte ptr [r12], zero_char
     jne cflzb
     swrite nlz nlzlen
     exit 1

# complain if <count> argument is not a number 48,57
checkForNaN:
     cmp r13, r9
     je cfnb
     cmp byte ptr [r12+r9], zero_char
     jl nancomplain
     cmp byte ptr [r12+r9], nein_char
     jg nancomplain 
     inc r9
     jmp checkForNaN

nancomplain:
     swrite nanstr nanstrlen
     exit 1

getstrlen:
     cmp BYTE ptr [r14+r15], 0
     je gslb
     inc r15
     jmp getstrlen
toomany:
     swrite tmstr tmstrlen
     exit 0

toofew:
     swrite tfstr tfstrlen
     exit 0

.section .data
     stri: .string "Hello, World!\n"
     strlen = . - stri

     tmstr: .string "Too many arguments!\nUsage: testg <text> <count>"
     tmstrlen = . - tmstr

     tfstr: .string "Too few arguments!\nUsage: testg <text> <count>"
     tfstrlen = . - tfstr

     nanstr: .string "repeat count must be a number!\nUsage: testg <text> <count>"
     nanstrlen = . - nanstr

     theNis: .string "The Number is: "
     theNislen = . - theNis

     nlz: .string "Leading zeros/octal count (e.g. 042) is not supported!\nUsage: testg <text> <count>"
     nlzlen = . - nlz

     zc: .string "Are you wasting my time?!\n<count> cannot be zero!\nUsage: testg <text> <count > 0!>"
     zclen = . - zc
