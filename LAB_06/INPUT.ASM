public INPUT_NUM

dseg segment para public 'DATA'
    typeMsg db "Please input number less than 256: $"
    number  db 2h dup(0)
dseg ends

cseg segment para public 'CODE'
    assume cs:cseg
READ_CHAR_ECHO:
    mov ah, 01h
    int 21h
    ret
INPUT_NUM proc near
    mov ah, 09h
    mov dx, offset typeMsg
    int 21h

    xor bx, bx
INPUT_LOOP:
    call read_char_echo

    cmp al, 0dh
    je  end_input_loop 

    sub al, '0'
    xor ah, ah
    push ax

    mov ax, bx
    mov cx, 10
    mul cx

    pop dx

    add ax, dx
    mov bx, ax

    jmp INPUT_LOOP

END_INPUT_LOOP:
    ret
INPUT_NUM endp

cseg ends
end

