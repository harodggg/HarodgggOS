;
; A simple boot sector program that demonstrates addressing.
;
	mov ah, 0eh;			; int 10/ah = 0eh -> scrolling teletype BIOS routine
	
	; First attempt
	mov al, the_secret 
	int 10 				; Does this print an X?
	
	; Second attempt 
	mov al, [the_secret] 		; Does this print an X?
	int 10

	; Third attmp 
	mov bx, the_secret		; 
	add bx, 0x7c00			;
	mov al, [bx]			; Does this print an X?
	int 0x10
	
	; Fourth attempt 		;
	mov al, [0x7c1e] 
	int 0x10			; Dos this print an X?

	jmp $

	the_secret:
		db "X"

	; Padding and magic BIOS number 
	times 510-($-$$) db 0
	dw 0xaa55
