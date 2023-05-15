section .data

section .text
    global bonus

bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    ; edx will be used for bit operations
    xor edx,edx

    ; The first int is stored in edi
    mov edi, dword [ecx]
    ; The second int is stored in esi
    mov esi, dword [ecx+4]

    ; The cl register is used for bit shifting
    push ecx

    ; top-left
    cmp eax,6
    jg pass_top_left
    cmp ebx,1
    jl pass_top_left
    cmp eax,3
    jl lower_top_left
upper_top_left:
    ; The 1 in edx is moved to the position in edi or esi
    ; that we want to toggle
    mov edx,1
    lea ecx,[eax*8-ebx-16]
    mov cl, [ecx]
    shl edx, cl
    ; The bit will be activated using a xor
    xor edi,edx

lower_top_left:
    mov edx,1
    shl edx, 8-ebx+8*(eax+1)
    xor edi,edx

pass_top_left:
    ; top-right
    cmp eax,6
    jg pass_top_right
    cmp ebx,6
    jg pass_top_right
    cmp eax,3
    jl lower_top_right
upper_top_right:
    ; TODO
lower_top_right:
    ; TODO


pass_top_right:
    ; bottom-left
    cmp eax,1
    jl pass_bottom_left
    cmp ebx,1
    jl pass_bottom_left
    cmp eax,5
    jl lower_bottom_left
upper_bottom_left:
    ; TODO
lower_bottom_left:
    ; TODO


pass_bottom_left:
    ; bottom-right
    cmp eax,1
    jl pass_bottom_right
    cmp ebx,6
    jg pass_bottom_right
    cmp eax,5
    jl lower_bottom_right
upper_bottom_right:
    ; TODO
lower_bottom_right:
    ; TODO


pass_bottom_right:


    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY