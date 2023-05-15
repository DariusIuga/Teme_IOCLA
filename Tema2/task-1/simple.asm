%include "../include/io.mac"

section .text
    global simple

    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here
    
    xor eax, eax	        ; clear eax to use as counter i

loop:
	cmp eax, ecx ; check if i >= len
	jge done ; if true, go to done
	mov bl, byte [esi + eax] ; load plain[i] into bl
	add bl, dl ; add step to plain[i]
	cmp bl, 'Z' ; check if enc_string[i] > 'Z'
	jle no_wrap ; if not, skip wrap
	sub bl, 26 ; subtract 26 to wrap around to 'A'
no_wrap:
	mov [edi + eax], byte bl ; store enc_string[i]
	inc eax ; increment i
	jmp loop ; go to loop

    ;; Your code ends here
    
    ;; DO NOT MODIFY

done:
    popa
    leave
    ret
    
    ;; DO NOT MODIFY
