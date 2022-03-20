%include "my_print_function.asm"		; this will simply get replaced by the contents of the file 

mov al, 'H'					; Store 'H' in al so our funciotn will print it. 
call my_print_function

times 510-($-$$) db 'b'				;
dw 0xaa55					;
