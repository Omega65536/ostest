; Prints a string
; bx Address of the string
print_string:
	mov ah, 0xe
	loop: ; Loop over the string and print the chars
		mov al, [bx]
		cmp al, 0
		je return
		int 0x10
		inc bx
		jmp loop
	return: ; return
		ret

; Prints a string and a newline
; bx Address of the string
println_string:
	call print_string
	mov al, 0xA ; Print a carriage return
	int 0x10
	mov al, 0xD ; Print a newline
	int 0x10
	ret
