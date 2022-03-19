;
; A simple boot sector program that demonstrates the cmp.
;

;
; mov bx, 30
; if (bx <= 4) {
;	mov al, ’A’
; }
; else if (bx < 40) {
;	mov al, ’B’
; } 
; else {
;	mov al, ’C’
; }
mov bx, 3				;
cmp bx, 4				; compare bx to 4;
jge then_block 			;
mov al, 'A'
jmp the_end				;

then_block:
	cmp bx, 40			;good
	jg else 
	mov al, 'B'
	jmp the_end 		;

else:
	mov al, 'C' 		;
bb:
	mov al, 'H'			;

the_end:



mov ah, 0eh				;int 10/ah = 0e -> scrolling teletype BIOS routine
int 0x10 					; print(al)

jmp $						; Jump forever 

; Padding and magic BIOS number 
times 510-($-$$) db 0		; 
db 0x55,0xaa				;
;dw 0xaa55					;