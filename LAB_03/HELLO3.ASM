StkSeg SEGMENT PARA STACK 'STACK'
	DB 200h DUP (?)
StkSeg ENDS

DataS SEGMENT WORD 'DATA'
	HelloMessage DB 'Hello world!', 0Ah, '$' 
DataS ENDS

Code SEGMENT WORD 'CODE'
	ASSUME CS:Code, DS:DataS
DispMsg:
	MOV AX, DataS
	MOV DS, AX

	MOV CX, 3h
L1:
	MOV DX, OFFSET HelloMessage
	MOV AH, 9h
	INT 21h
	LOOP L1

	MOV AH, 7h
	INT 21h
	MOV AH, 4ch
	INT 21h
Code ENDS
END DispMsg

