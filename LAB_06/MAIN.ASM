extrn INPUT_NUM    : NEAR
extrn PRINT_BINARY : NEAR
    
sseg segment para stack 'STACK'
    db 100h dup(0)
sseg ends
dseg segment para public 'DATA'
    selectedLine db  "^^^^^^^^^^^^^^^^", 0ah, "$"
    menuLine1    db  "1. Input number ", 0ah, "$"
    menuLine2    db  "2. Print usi bin", 0ah, "$"
    menuLine3    db  "3. Print sig hex", 0ah, "$"
    menuLine4    db  "4. Exit         ", 0ah, "$"
    curLinePos   db  0
    lineLng      equ 18
    menuLines    equ 4
    number       dw  0
dseg ends

cseg segment para 'CODE'
    assume cs:cseg, ds:dseg, ss:sseg
PRINT_LINE:
    push  bp           ; remember old value of bp
    mov   bp, sp       ; set bp = top of stack
    mov   dx, [bp+4]   ; last param is located here
    mov   ah, 09h 
    int   21h
    pop   bp           ; restore original bp value
    ret
PRINT_CHAR:
    push  bp
    mov   bp, sp
    mov   dx, [bp+4]
    mov   ah, 02h
    int   21h
    pop   bp
    ret
CLEAR_SCREEN:
    mov ax, 3
    int 10h
    ret
PRINT_MENU:
    call CLEAR_SCREEN

    mov ax, offset menuLine1
    mov cx, 0

MENU_LINE_LOOP:
    push  ax
    call  PRINT_LINE
    pop   ax

    xor   bx, bx
    mov   bl, [curLinePos]
    cmp   cx, bx
    jne   NOT_SELECTED_LINE  ; print line indicator when needed
    push  ax                 ; save ax value
    mov   bx, offset selectedLine
    push  bx
    call  PRINT_LINE
    pop   bx
    pop   ax                 ; restore ax value

NOT_SELECTED_LINE: 
    inc  cx
    add  ax, [lineLng]
    cmp  cx, [menuLines]
    jl   MENU_LINE_LOOP

    ret
READ_KEY:
    mov   ah, 08h
    int   21h
    ret
NAVIGATE:
    call PRINT_MENU
    call READ_KEY
    mov  bl, [curLinePos]

    cmp AL, 48h
    je  UP_ARROW
    cmp AL, 50h
    je  DOWN_ARROW
    cmp AL, 0dh
    je  ENTER_KEY

    jmp navigate
UP_ARROW:
    cmp bl, 0
    je  other_key   ; if first line is selected - do nothing
    dec bl
    mov [curLinePos], bl
    jmp navigate
DOWN_ARROW:
    cmp bl, [menuLines] - 1
    je navigate
    inc bl
    mov [curLinePos], bl
    jmp navigate
ENTER_KEY:
    cmp bl, 0
    je input_line

    cmp bl, 1
    je print_bin

    cmp bl, 3
    je exit

    jmp navigate
INPUT_LINE:
    call INPUT_NUM
    mov [number], bx
    jmp navigate
PRINT_BIN:
    mov ax, [number]
    push ax
    call print_binary
    pop ax
    jmp navigate
EXIT:
    ret
OTHER_KEY:
    jmp NAVIGATE
MAIN:
    mov   ax, dseg
    mov   ds, ax

    call NAVIGATE 

    mov   ah, 4ch
    int   21h
cseg ends
end MAIN
