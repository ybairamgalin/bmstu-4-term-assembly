public PRINT_BINARY

cseg segment para public 'CODE'
    assume cs:cseg

PRINT_BINARY proc near
    push bp
    mov  bp, sp
    mov  dx, [bp+4]

    mov cx, 16

PRINT_LOOP:
    mov ax, 8000h
    and ax, dx
    push dx
    cmp ax, 0
    jne ONE
ZERO:
    mov dl, '0'
    jmp m_end 
ONE:
    mov dl, '1'

M_END:
    mov ah, 2h
    int 21h
    pop dx
    rol dx, 1

    LOOP PRINT_LOOP

    mov ah, 01h
    int 21h
    pop bp
    ret
PRINT_BINARY endp

cseg ends
end

