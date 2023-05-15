%include "../include/io.mac"

struc avg
    .quo: resw 1
    .remain resw 1
endstruc

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0 ;nr of processes with a certain priority
    time_result dd 0, 0, 0, 0, 0 ;sum of time

section .text
    global run_procs

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    xor edx,edx
    ; The char representing the current priority is stored in dh
    mov dh,'1' ;current
    ; The current index of the proc_avg vector is stored in dl
    xor dl,dl

    ; edi stores the index of the process array
    xor edi,edi ;i
    ; esi stores the offset from the start of the proc vector
    xor esi,esi

loop1:

    cmp edi,ebx
    jge done

loop2:
    cmp byte [ecx+esi+proc.prio], byte dh
    jne pass1
    
    push edx
    movzx  edx, dl



    push eax
    push ebx
    mov eax, dword [time_result + edx*4]
    mov ebx, dword [ecx+esi+proc.time]
    add eax, ebx
    mov dword [time_result + edx*4], eax
    pop ebx
    pop eax

    inc dword prio_result[edx*4]
    pop edx

    inc edi
    add esi,5
    jmp loop2

pass1:
    ; If no processes of a certain priority are found,
    ; the quotient and remainder are set to zero
    push edx
    movzx edx, dl
    cmp dword [prio_result + edx*4], 0
    pop edx
    jnz division

    push edx
    movzx edx,dl
    mov word [eax+edx*avg_size + avg.quo],word 0
    mov word [eax+edx*avg_size + avg.remain],word 0
    pop edx


next_prio:
    inc dh
    inc dl
    jmp loop1

done:


    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

division:

    jmp next_prio