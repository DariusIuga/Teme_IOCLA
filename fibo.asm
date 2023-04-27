%include "printf32.asm"

section .data
    N dd 9 ; compute the sum of the first N fibonacci numbers
    sum_print_format db "Sum first %d fibonacci numbers is %d", 10, 0
    a dd 0
    b dd 1
    c dd 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp
    xor eax, eax     ;store the sum in eax

    ; TODO: calculate the sum of first N fibonacci numbers
    ;       (f(0) = 0, f(1) = 1)
    mov ecx, N
    fibo:
        add ebx,a
        add ebx,b
        mov c,ebx
        mov edx,b
        add eax,edx
        mov edx,b
        mov a,edx
        mov edx,c
        mov a,edx
    loop fibo    

    ; use loop instruction

    push eax
    push dword [N]
    push sum_print_format
    call printf
    add esp, 12

    xor eax, eax
    leave
    ret
