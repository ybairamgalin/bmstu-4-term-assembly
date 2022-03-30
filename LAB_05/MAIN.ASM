STK SEGMENT PARA STACK 'STACK'
    DB 100h DUP(0)
STK ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'
    MATRIX DB 51h DUP(0)
    ROWS DB 1h DUP(0)
    COLS DB 1h DUP(0)
DSEG ENDS

CSEG SEGMENT PARA 'CODE'
    ASSUME CS:CSEG, DS:DSEG, SS:STK
READ_SYMBOL:
    MOV AH, 01H
    INT 21H
    RET
PRINT_SYMBOL:
    MOV AH, 02H
    INT 21H
    RET
PRINT_NEW_LINE:
    MOV DL, 0AH
    CALL PRINT_SYMBOL
    RET
READ_MATRIX:
    XOR CX, CX     ; make cx = 0
    MOV CL, [ROWS]

BY_ROW:
    MOV AL, 9
    MOV DL, [ROWS] 
    SUB DL, CL     ; dl - current row
    MUL DL         ; ax - current index
    MOV SI, AX     ; set si to the beginning of row

    MOV BX, CX     ; save in bx current row count

    MOV CL, [COLS] ; 

BY_COL:
    CALL READ_SYMBOL

    CMP AL, '1'
    JL M_01 
    CMP AL, '9'
    JG M_01
    ADD AL, 10H
M_01: 
    MOV [MATRIX+SI], AL
    INC SI
    LOOP BY_COL

    CALL READ_SYMBOL

    MOV CX, BX   ; move row count back to cx
    LOOP BY_ROW

    RET
PRINT_MATRIX:
    XOR CX, CX
    MOV CL, [ROWS]

PRINT_ROW_CYCLE:
    MOV AL, 9
    MOV DL, [ROWS]
    SUB DL, CL
    MUL DL
    MOV SI, AX

    MOV BX, CX

    MOV CL, [COLS]

PRINT_COL_CYCLE:
    MOV DL, [MATRIX+SI]
    CALL PRINT_SYMBOL
    INC SI
    LOOP PRINT_COL_CYCLE

    CALL PRINT_NEW_LINE

    MOV CX, BX
    LOOP PRINT_ROW_CYCLE

    RET
MAIN:
    MOV AX, DSEG
    MOV DS, AX

    CALL READ_SYMBOL ; ROWS
    ADD AL, -48
    MOV ROWS, AL

    CALL READ_SYMBOL ; COLS
    ADD AL, -48
    MOV COLS, AL

    CALL READ_SYMBOL

    CALL READ_MATRIX
    CALL PRINT_MATRIX

    MOV AH, 4CH
    INT 21H
CSEG ENDS
END MAIN

