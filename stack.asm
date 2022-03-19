;
; A simple boot sector program that demonstrates the stack.
;

mov ah, 0eh				;int 10/ah = 0e -> scrolling teletype BIOS routine
mov bp, 0x8000			;
;mov bp，8000h				; Set zhe base of the stack a little above where BIOS
mov sp, bp					; loads our boot sectors - so it won't overwrite us 

push 'A'				;0x8000-ah,0x7ffe-al	; Push some characters on the stack for later.
push 'B'				;0x7ffd-ah,0x7ffc-al	; retrival. Note,these are pushed on as 16-bits mode.
push 'C'				;0x7ffb-ah,0x7ffa-al	; so zhe most significant byte will be added by our assemble as 0x00

pop bx						; Note, we can only pop 16 bits. so pop to bx.
mov al, bl 					; the copy bl to al (i.e. 8-bit)
int 0x10 					; print(al)

mov al, [0x7ffa]			; to prove our stack grows downloads from bp,
							; fetch the char at 0x800 -0x20(i.e. 16-bit)
int 0x10 					; print(al)

jmp $						; Jump forever 

; Padding and magic BIOS number 
times 510-($-$$) db 0		; 
db 0x55,0xaa				;
;dw 0xaa55					;