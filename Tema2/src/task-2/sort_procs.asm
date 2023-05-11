%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here

    ;; Setting all used registers to 0
    xor ebx, ebx    ;;i
    xor ecx, ecx    ;;j
    xor esi, esi
    xor edi, edi

loop1:
    cmp ebx, eax
    jge end

    mov ecx, ebx
    inc ecx     ;j = i+1
    mov esi,edi
    add esi,5
loop2:
    cmp ecx,eax
    jl pass1
    inc ebx
    add edi,5
    jmp loop1

pass1:
    ; The first if, for sorting the processes by priority
    push eax
    xor eax,eax
    mov ah, byte [edx+edi + proc.prio]
    mov al, byte [edx+esi + proc.prio]
    cmp ah,al
    pop eax
    jg swap

    ; if (procs[i].prio == procs[j].prio) we check time
    jne next

    ; The second if, for sorting the processes by time
    push ebx
    push ecx
    xor ebx,ebx
    xor ecx,ecx
    mov bx, word [edx+edi + proc.time]
    mov cx, word [edx+esi + proc.time]
    cmp bx,cx
    pop ecx
    pop ebx
    jg swap

    ; if (procs[i].time == procs[j].time) we check pid
    jne next

    ; The third if, for sorting processes by pid
    push ebx
    push ecx
    xor ebx,ebx
    xor ecx,ecx
    mov bx, word [edx+edi + proc.pid]
    mov cx, word [edx+esi + proc.pid]
    cmp bx,cx
    pop ecx
    pop ebx
    jg swap




next:
    inc ecx
    add esi,5
    jmp loop2

end:
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

swap:
    ; Exchange the pid of the two processes
    ; Use edi and esi for storing the fields
    push eax
    push ebx

    ; pid
    xor eax,eax
    xor ebx,ebx

    mov ax, word [edx+edi + proc.pid]
    mov bx, word [edx+esi + proc.pid]
    mov word [edx+edi + proc.pid], bx
    mov word [edx+esi + proc.pid], ax

    ; prio
    xor eax,eax
    xor ebx,ebx

    mov ah, byte [edx+edi + proc.prio]
    mov al, byte [edx+esi + proc.prio]
    mov byte [edx+edi + proc.prio], al
    mov byte [edx+esi + proc.prio], ah

    ;time
    xor eax,eax
    xor ebx,ebx

    mov ax, word [edx+edi + proc.time]
    mov bx, word [edx+esi + proc.time]
    mov word [edx+edi + proc.time], bx
    mov word [edx+esi + proc.time], ax

    pop ebx
    pop eax


    jmp next



