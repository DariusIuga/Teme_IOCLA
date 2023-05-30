section .data
	; declare global vars here
	vowels db "aeiou", 0


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

	; sirul va fi retinut in eax
	xor eax, eax
	add eax, [ebp+8]
	; edi retine contorul pentru sir
	xor edi,edi
	; esi retine contorul pentru sirul de vocale "aeiou"
	xor esi,esi


outer_loop1:
	; caracterul curent din sir e retinut in edx
	xor edx,edx
	add dl, byte [eax+edi]
	inc edi
	cmp dl, 0
	je write 

	xor esi,esi

inner_loop1:
	; vocala curenta din sirul "aeiou" e retinuta in ebx
	xor ebx,ebx
	add bl,byte [vowels+esi]
	inc esi
	cmp ebx, 0
	je outer_loop1
	cmp dl,bl
	jne not_this_vowel1

	; caracterul curent din sir este vocala din edi
	push edx

not_this_vowel1:
	jmp inner_loop1


write:
xor edi,edi

outer_loop2:
	; caracterul curent din sir e retinut in edx
	xor edx,edx
	add dl,byte [eax+edi]
	inc edi
	cmp dl, 0
	je done 

	xor ecx,ecx

inner_loop2:
	; vocala curenta din sirul "aeiou"
	xor ebx,ebx
	add bl,byte [vowels+esi]
	inc esi
	cmp bl, 0
	je outer_loop2
	cmp dl,bl
	jne not_this_vowel2

	; caracterul curent din sir este vocala din ebx
	xor ecx,ecx
	pop ecx
	add [eax+ebx-1], cl

not_this_vowel2:
	jmp inner_loop2


done:

	popa
	push esp
	pop ebp
	pop ebp
	ret