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
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

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

    ; The current priority
    mov dh, byte '0' ;char current
    ; Index of the corresponding fields in the avg_out vector
    mov dl, byte -1 ;char j

loop1:
    inc dh
    inc dl
    cmp dh,'5'
    jg done

    ; ebp will be used for storing the index of the proc array
    ;push ebp
    ;xor ebp,ebp ;int i
    ; esp will be used for storing the offset from the beginning
    ; of the proc vector (because proc_size is not a power of 2)
    ;push esp
    ;xor esp,esp

    ; edi and esi will store the sum and nr of processes with
    ; the current priority (in dh)
    xor edi,edi ;int sum
    xor esi,esi ;int nr

loop2:
    ;cmp ebp, ebx
    ;jge division

    ;cmp byte [ecx+esp + proc.prio], dh
    ;jne pass
    ;add edi, [ecx+esp + proc.time]
    ;inc esi

pass:
    ;inc ebp
    ;add esp,5
    ;jmp loop2

division:
    ;cmp esi,0
    ; If no processes with a certain priority are found,
    ; the quotient and remainder for that priority are set to zero
    ;jnz not_zero

    ;push ebx
    ;lea ebx, [eax + edx * avg_size + avg.quo]
    ;mov word [ebx], 0
    ;lea ebx, [eax + edx * avg_size + avg.remain]
    ;mov word [ebx], 0
    ;pop ebx

not_zero:
    ; ebx and acx aren't being used in this block and can be restored later
    ;push ebx
    ;push ecx
    ;push eax
    ;push edx

    ;xor edx,edx
    ;mov eax,edi
    ;div esi
    ;mov ebx,eax ; quotient
    ;mov ecx,edx ; remainder

    ; We restore j, current and the avg_out vector in which
    ; the values will be written
    ;pop edx
    ;pop eax

    ;push edi
    ;lea edi, [eax + edx * avg_size + avg.quo]
    ;mov word [edi], bx
    ;lea edi, [eax + edx * avg_size + avg.remain]
    ;mov word [edi], cx
    ;pop edi

    ; Finally, we restore the processes vector and the length
    ;pop ecx
    ;pop ebx

    ;pop esp
    ;pop ebp

    jmp loop1

done:


    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY