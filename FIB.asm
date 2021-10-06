code segment 
assume cs:code
start:
mov ax,0000h
mov bx,0001h
mov dx,0000h
mov cx,0005h
RPT:mov ax,0000h
    add ax,bx
    add ax,dx
    mov dx,bx
    mov bx,ax
    loop RPT
hlt
code ends
end start
