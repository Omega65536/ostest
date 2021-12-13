[org 0x7c00]

jmp start

; Prints a string and a newline
; bx Address of the string
println_string:
	mov ah, 0xe
	loop: ; Loop over the string and print the chars
		mov al, [bx]
		cmp al, 0
		je return
		int 0x10
		inc bx
		jmp loop

	return: ; Newline 
		mov al, 0xA
		int 0x10
		mov al, 0xD
		int 0x10
		ret

start:
	mov bx, _string_start
	call println_string

main:
	mov bx, _string_test
	call println_string
	mov bx, _string_test2
	call println_string

exit:
	mov bx, _string_exit
	call println_string
	ret
	jmp $

_string_test:
	db "123 abc ABC", 0

_string_test2:
	db "Hello, world!", 0

_string_start:
	db "[OS] Starting!", 0

_string_exit:
	db "[OS] Exiting!", 0

; Padding
times 510-($-$$) db 0
db 0x55, 0xaa
