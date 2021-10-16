
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

;19pt04

org 100h  

mov ax,00h;register ax is assigned 0
mov cx,4;register cx is assigned 4 as the numbers added should be 4
mov si,offset a

start:
    add ax,[si];adding the 4 numbers and storing it in ax register itself
    add si,2h;since it is double word ,to go to next number we add 2h to si
loop start  

;this is to store the result in 3700
mov bx,3700h 
mov [bx],ax
hlt  

;the numbers are 1,2,3,4        
a dw 01h,02h,03h,04h
ret