[org 0x7c00]

jmp start

start:
	mov bx, string_start
	call println_string

main:
	mov bx, string_test
	call println_string
	mov bx, string_test2
	call println_string

exit:
	mov bx, string_exit
	call println_string
	jmp $



%include "io.asm"

string_test:
	db "This is a test string.", 0

string_test2:
	db "Hello, world!", 0

string_start:
	db "[OS] Starting!", 0

string_exit:
	db "[OS] Exiting!", 0

; Padding
times 510-($-$$) db 0
dw 0xaa55
