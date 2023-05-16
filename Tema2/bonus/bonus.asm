%include "../include/io.mac"

section .data

section .text
    global bonus
    extern printf

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
    xor edi,edi
    ; The second int is stored in esi
    xor esi,esi

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

    push eax
    push ebx
    ; The 1 in edx is moved to the position in edi or esi
    ; that we want to toggle
    mov edx,dword 1
    ;mov ecx,[ebx-1+8*(eax-3)] 
    sub eax,3
    shl eax,3 ;Multiplied by 8
    dec ebx
    add eax,ebx
    mov cl, al

    shl edx, cl
    ; The bit will be activated using an or
    or edi,edx

    pop ebx
    pop eax

    jmp pass_top_left

lower_top_left:

    push eax
    push ebx

    mov edx,1
    ;mov ecx,[ebx-1+8*(eax+1)] 
    add eax,1
    shl eax,3 ;Multiplied by 8
    dec ebx
    add eax,ebx
    mov cl, al

    shl edx, cl
    or esi,edx

    pop ebx
    pop eax

pass_top_left:

    ; top-right
    cmp eax,6
    jg pass_top_right
    cmp ebx,6
    jg pass_top_right
    cmp eax,3
    jl lower_top_right
upper_top_right:
    
    push eax
    push ebx
    mov edx,dword 1
    ;mov ecx,[ebx+1+8*(eax-3)] 
    sub eax,3
    shl eax,3 ;Multiplied by 8
    inc ebx
    add eax,ebx
    mov cl, al

    shl edx, cl
    or edi,edx

    pop ebx
    pop eax

    jmp pass_top_right

lower_top_right:

    push eax
    push ebx

    mov edx,1
    ;mov ecx,[ebx+1+8*(eax+1)] 
    add eax,1
    shl eax,3 ;Multiplied by 8
    inc ebx
    add eax,ebx
    mov cl, al

    shl edx, cl
    or esi,edx

    pop ebx
    pop eax


pass_top_right:

    ; bottom-left
    cmp eax,1
    jl pass_bottom_left
    cmp ebx,1
    jl pass_bottom_left
    cmp eax,5
    jl lower_bottom_left
upper_bottom_left:

    push eax
    push ebx

    mov edx,dword 1
    ;mov ecx,[ebx-1+8*(eax-5)] 
    sub eax,5
    shl eax,3 ;Multiplied by 8
    dec ebx
    add eax,ebx
    mov cl, al

    shl edx, cl
    or edi,edx

    pop ebx
    pop eax

    jmp pass_bottom_left

lower_bottom_left:

    push eax
    push ebx

    mov edx,1
    ;mov ecx,[ebx-1+8*(eax-1)] 
    sub eax,1
    shl eax,3 ;Multiplied by 8
    dec ebx
    add eax,ebx
    mov cl, al

    shl edx, cl
    or esi,edx

    pop ebx
    pop eax


pass_bottom_left:

    ; bottom-right
    cmp eax,1
    jl pass_bottom_right
    cmp ebx,6
    jg pass_bottom_right
    cmp eax,5
    jl lower_bottom_right
upper_bottom_right:
    
    push eax
    push ebx
    mov edx,dword 1
    ;mov ecx,[ebx+1+8*(eax-5)] 
    sub eax,5
    shl eax,3 ;Multiplied by 8
    inc ebx
    add eax,ebx
    mov cl, al

    shl edx, cl
    or edi,edx

    pop ebx
    pop eax

    jmp pass_bottom_right

lower_bottom_right:
    

    ;29

    push eax
    push ebx

    mov edx,1
    ;mov ecx,[ebx+1+8*(eax-1)] 
    sub eax,1
    shl eax,3 ;Multiplied by 8
    inc ebx
    add eax,ebx
    mov cl, al

    shl edx, cl
    or esi,edx

    pop ebx
    pop eax


pass_bottom_right:
    pop ecx
    mov [ecx+4], dword esi
    mov [ecx], dword edi
    ;mov [ecx],dword 4
    ;shl ecx,4


    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY