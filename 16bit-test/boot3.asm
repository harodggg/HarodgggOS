SECTION MBR vstart=0x7c00     ; 告诉编译器加载到7c00内存处
	; 清屏和设置光标位置
	mov ax,0x600      ; 清屏范围,也就是宽度
	mov bx,0x0
	mov cx,0x0        ; 清屏 左上角(0,0)
	mov dx,0x184f     ; 清屏 右下角(80=0x4f,25=0x18)
	int 0x10

	mov dh,0x0        ; 设置光标列号 左上角(0,0)
	mov dl,0x0        ; 设置光标行号 右下角(0,0)
	mov bh,0x0        ; 页码
	int 0x10

	; 初始化,使SP寄存器指向段基址0X7C0处,GS指向显存基地址
	mov ax,cs
	mov sp,0x7c00
	mov ax,0xb800
	mov gs,ax              ; 设置显存地址

	; 设置字符串长度与字符串基地址
	mov cx, msglen        ; 获取字符串长度
	mov si, message       ; 设置字符串基址
	xor di, di            ; 每次清空di寄存器

loop_str:
	mov al, [si]            ; 每次取出一个字符
	mov [gs:di], al         ; 将字符逐一赋值到显存中
	inc si
	inc di
	
	mov byte [gs:di], 000ch ; 设置字体颜色
	inc di
	loop loop_str

	hlt      ; 程序在此处终止

;message db "Hello LyShark...",0ah,0dh
message db "Hello LyShark..."
msglen  equ $ - message

times 510-($-$$) db 0  ; 填充剩余的510字节的空间为0
db 0x55,0xaa           ; mbr的结束标志

