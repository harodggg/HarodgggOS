my_print_function:
pusha
mov ah, 0x0e			;int10/
int 0x10
popa
ret
