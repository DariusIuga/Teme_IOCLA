section .text
	global reverse_vowels

;;	void reverse_vowels(char *string)
;	Cauta toate vocalele din string-ul `string` si afiseaza-le
;	in ordine inversa. Consoanele raman nemodificate.
;	Modificare se va face in-place
reverse_vowels:
	push ebp
	push esp
	pop ebp
	; salvam valorile care erau in registre inainte de apelarea functiei
	pusha

	; eax retine sirul de caractere
	xor eax, eax
	add eax, [ebp + 8]
	; ecx retine lungimea sirului
	xor ecx, ecx
	; edx retine indexul caracterului curent din sir
	xor edx, edx

	dec ecx
find_length:
	inc ecx 
	cmp byte [eax + ecx], 0
	jne find_length

loop1:
	; parcurge sirul de caractere si pune vocalele gasite in sir pe stiva
	cmp edx, ecx
	jl find_vowels
	xor edx, edx
	je loop2

find_vowels:
	cmp byte [eax + edx], 'a'
	je push_vowel
	cmp byte [eax + edx], 'e'
	je push_vowel
	cmp byte [eax + edx], 'i'
	je push_vowel
	cmp byte [eax + edx], 'o'
	je push_vowel
	cmp byte [eax + edx], 'u'
	je push_vowel
	inc edx
	jmp loop1

push_vowel:
	push dword [eax + edx]
	inc edx
	jmp loop1

loop2:
	; parcurge sirul si da pop la vocalele din stiva atunci
	; cand gaseste o vocala in sir
	cmp edx, ecx
	jl write_vowels
	je end

write_vowels:
	cmp byte [eax + edx], 'a'
	je pop_vowel
	cmp byte [eax + edx], 'e'
	je pop_vowel
	cmp byte [eax + edx], 'i'
	je pop_vowel
	cmp byte [eax + edx], 'o'
	je pop_vowel
	cmp byte [eax + edx], 'u'
	je pop_vowel
	inc edx
	jmp loop2

pop_vowel:
	and byte [eax + edx], 0
	pop ebx
	add byte [eax + edx], bl
	inc edx
	jmp loop2

end:
	; restauram stiva si registrele
	popa
	push esp
	pop ebp
	pop ebp
	ret
