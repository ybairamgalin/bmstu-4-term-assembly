public PRINT_HEX

dseg segment para public 'DATA'
    hexDigits db "0123456789abcdef"
dseg ends

cseg segment para public 'CODE'
    assume cs:cseg

M_PRINT_HEX_DIGIT:
    push bp
    mov  bp, sp
    mov bx, [bp+4]
    mov si, bx

    mov dl, [ds:hexDigits+bx]
    mov ah, 02h
    int 21h
    pop bp
    ret

PRINT_HEX proc near
    push bp
    mov bp, sp
    mov dx, [bp+4]

    mov ax, 8000h
    and ax, dx
    cmp ax, 0
    je  m_print

    dec dx
    not dx
    push dx

    mov ah, 02h
    mov dl, '-'
    int 21h
    pop dx

M_PRINT:
    mov cx, 4

M_PRINT_LOOP:
    mov ax, dx
    mov bx, 61440
    and ax, bx
    push cx
    mov cx, 12
    ror ax, cl
    pop cx

    push dx
    push ax
    call M_PRINT_HEX_DIGIT
    pop ax
    pop dx

    push cx
    mov cx, 4
    rol dx, cl
    pop cx

    LOOP M_PRINT_LOOP

    mov ah, 01h
    int 21h
    pop bp
    ret
PRINT_HEX endp

cseg ends
end

