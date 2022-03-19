print_hex:
	pusha 			;
	mov ah,0x0e
	mov cl,4		;
	
	mov bx, dx 		; 备份

	and dl,00001111b	;
	mov al,dl
	call hex_ascill
	int 0x10

	mov dx,bx		;

	shr dl,cl		;
	mov al,dl		;
	call hex_ascill
	int 0x10			;
	
	mov dx,bx		;

	and dh, 0fh 		;
	mov al,dh		;
	call hex_ascill
	int 0x10		;
	

	mov dx,bx		;

	shr dh,cl		;
	mov al,dh 		;
	call hex_ascill
	int 0x10	

	popa
	
	ret 			;



hex_ascill:
	;48h number
	; 0 ~ 9 48 ~57
	; char 65 ~ 70 
	; 10~ 15 55
	; hex 41 10 
	; hex 37;
	;

	cmp al,9 		;
	jle number	
	add al,37h		;
	ret
	
number:
	add al,30h		;
	ret
	
