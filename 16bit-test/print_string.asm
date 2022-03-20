print_string:
	mov ah, 0x0e			;
	
loop:	
	mov al, [bx]			;[bx] 2 byte to save address, to al。
	cmp al, 0 			;
	je out				;
	int 0x10 				;
	add bx, 0x01			;
	jmp loop 			;

out:
	mov al, ' ' 			;
	int 0x10			;
	ret 				;
