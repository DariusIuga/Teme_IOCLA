section .data
	; declare global vars here

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
	pusha

	xor edx, edx
	xor eax, eax
	xor ecx, ecx
	xor esi, esi
	add esi, [ebp + 8]

find_length:
	cmp byte [esi + ecx], 0
	je loop1
	inc ecx 
	jmp find_length

loop1:
	cmp edx, ecx
	jl find_vowels
	je intermediar

find_vowels:
	cmp byte [esi + edx], 'a'
	je push_vowel
	cmp byte [esi + edx], 'e'
	je push_vowel
	cmp byte [esi + edx], 'i'
	je push_vowel
	cmp byte [esi + edx], 'o'
	je push_vowel
	cmp byte [esi + edx], 'u'
	je push_vowel
	inc edx
	jmp loop1

push_vowel:
	push dword [esi + edx]
	inc edx
	jmp loop1

intermediar:
	xor edx, edx

loop2:
	cmp edx, ecx
	jl write_vowels
	je end

write_vowels:
	cmp byte [esi + edx], 'a'
	je pop_vowel
	cmp byte [esi + edx], 'e'
	je pop_vowel
	cmp byte [esi + edx], 'i'
	je pop_vowel
	cmp byte [esi + edx], 'o'
	je pop_vowel
	cmp byte [esi + edx], 'u'
	je pop_vowel
	inc edx
	jmp loop2

pop_vowel:

	and byte [esi + edx], 0
	pop eax
	add byte [esi + edx], al
	inc edx
	jmp loop2

end:

	popa
	push esp
	pop ebp
	pop ebp
	ret
