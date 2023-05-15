
section .data

section .text
	global checkers

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    ; The matrix is indexed unconventionally.
    ; edx stored the offset of the current element from the start of the table
    ; (bottom-left)
    lea edx, [eax*8 + ebx]

    ; top-left
    cmp eax,6
    jg pass_top_left
    cmp ebx,1
    jl pass_top_left
    mov [ecx + edx+7], dword 1

pass_top_left:
    ; top-right
    cmp eax,6
    jg pass_top_right
    cmp ebx,6
    jg pass_top_right
    mov [ecx + edx+9], dword 1


pass_top_right:
    ; bottom-left
    cmp eax,1
    jl pass_bottom_left
    cmp ebx,1
    jl pass_bottom_left
    mov [ecx + edx-9], dword 1


pass_bottom_left:
    ; bottom-right
    cmp eax,1
    jl pass_bottom_right
    cmp ebx,6
    jg pass_bottom_right
    mov [ecx + edx-7], dword 1


pass_bottom_right:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY