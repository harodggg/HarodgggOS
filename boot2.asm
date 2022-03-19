section MBR vstart=0x7c00
    ; 初始化段寄存器
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov sp, 0x7c00

    ; 上卷屏幕
    mov ax, 0x600  ; ah: 中断功能号 al: 上卷行数, 0表示全部
    mov bx, 0x700  ; bh: 上卷行属性
    mov cx, 0x0    ; (cl, ch): 左上角坐标
    mov dx, 0x184f ; (dl, dh): 右下角坐标
    int 0x10

    ; 获取光标位置
    mov ah, 3 ; 中断功能号 
    mov bh, 0 ; 页号
    int 0x10

    ; 输出
    mov ax, message
    mov bp, ax      ; es:bp为字符串首地址，es已被置为0x7c00, 只需将偏移量送入bp
    mov cx, 0x0b    ; 输出字符串长度
    mov ax, 0x1301  ; 13号中断功能: 输出字符串 01: 输出属性，光标跟随输出移动
    mov bx, 0x2     ; bh: 页号 bl: 输出字体: 0x02(黑底绿字)
    int 0x10

    jmp $ ; 死循环，在此悬停

    message db "MBR RUNNING" ; 待输出的字符串
    times 510-($-$$) db 0    ; 以0x00填充整个扇区剩余的部分
    db 0x55, 0xaa            ; 魔数, 表示这个扇区存储MBR主引导记录

