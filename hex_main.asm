[org 0xc700]
mov dx, 0x1fb6 ; store the value to print in dx
;mov dx,0x1116;
;mov dx, 0xaaaa;
;mov dx,0x0129;
;mov dx,0xaaaa;
call print_hex ; call the function

mov bx, HEX_OUT ; print the string pointed to
call print_string ; by BX
ret

HEX_OUT: db '0x0000 ',0

%include "print_hex.asm"	;
%include "print_string.asm"	;

times 510-($-$$) db 0 		;
dw 0xaa55			;




