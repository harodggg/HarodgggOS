
mov al, 'H' 			; store 'h' in al, so our function will print it.


;jmp my_print_function		
;return_to_here: 		; This lable is our life-line so we can get back.
;	jmp $			;



;my_print_function:
;	mov ah, 0x0e		; 
;	int 0x10		;
;	jmp return_to_here	;

;call my_print_function		;
call some_function
jmp $				;

my_print_function:		;
	mov ah, 0x0e		;
	int 0x10		;
	ret 

some_function:			;
	pusha			; Push all register values to the stack 
	mov bx, 10		
	add bx, 20 		
	mov ax, bx		;
	mov ah, 0x0e		; int=10/ah=0x0e -> BIOS tele-type output 
	int 0x10 		; 
	popa 			; Restore original register values 
	ret



times 510-($-$$) db 'a'		;
dw 0xaa55			;
