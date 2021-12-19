.section .data
input_prompt    :   .asciz  "Input a string: "
input_spec      :   .asciz  "%[^\n]"
input           :   .space  8
length_spec     :   .asciz  "String length: %d\n"
palindrome_spec :   .asciz  "String is a palindrome (T/F): %s\n"
true            :   .string "T\n"
false           :   .string "F\n"
checkError      :   .string "Check\n"

.section .text
.global main

# program execution begins here
main:
    ldr x0, =input_prompt
    bl printf

    ldr x0, =input_spec
    ldr x1, =input
    bl scanf

    ldr x20, =input
    ldrsw x0, [x20]
    bl get_length


    bl palindromeCheck

    b exit

# add code and other labels here
get_length:
    
    mov x19, xzr
    

    get_length_loop:
        ldrb w22, [x20, x19]
        cbz w22, out
    

    add x19, x19, 1
    #add x20, x20, #1
    B get_length_loop

out:
mov x1, x19
ldr x0, =length_spec
bl printf


palindromeCheck:
    cbz x19, L1
    sub x9, x19, 1
    cbz x9, L1
    
    mov x24, x19
    mov x25, 1
    sub x24, x24, 1
    mov x26, x19
    add x26, x26, 1

    palindromeCheck_loop:
        
        ldrb w22, [x20, x23]
        ldrb w18, [x20, x24]
        sub w11, w22, w18
        cbnz w11, L2

    add x23, x23, 1
    sub x24, x24, 1
    cbz x24, L1

    B palindromeCheck_loop
    
L1:
    ldr x1, =true
    ldr x0, =palindrome_spec
    bl printf
    b exit

L2:
    ldr x1, =false
    ldr x0, =palindrome_spec
    bl printf
    b exit



# branch to this label on program completion
exit:
mov x0, 0
mov x8, 93
svc 0
ret
