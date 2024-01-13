DATA SEGMENT
    MSG1 DB "Enter your string: $"
    MSG2 DB "Enter which character you want to replace: $"
    MSG3 DB "Enter new character: $"
    MSG4 DB "Resulting string: $"
    
    STRING DB 100 DUP ('$')
    RCHAR DB 1              ; Single character for replacement
    NCHAR DB 1              ; Single character for replacement

DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

START:
    MOV AX, DATA
    MOV DS, AX

    ; MSG1
    MOV DX, OFFSET MSG1
    MOV AH, 09H
    INT 21H

    MOV SI, OFFSET STRING
    CALL READ_STRING

    ; MSG2
    MOV DX, OFFSET MSG2
    MOV AH, 09H
    INT 21H

    MOV SI, OFFSET RCHAR
    CALL READ_STRING

    ; MSG3
    MOV DX, OFFSET MSG3
    MOV AH, 09H
    INT 21H

    MOV SI, OFFSET NCHAR
    CALL READ_STRING

    ; REPLACE CHARACTER
    MOV SI, OFFSET STRING
    MOV AL, RCHAR           ; Load the character to replace into AL
    MOV AH, NCHAR          ; Load the character to replace with into AH
    CALL REPLACE_STRING

    ; PRINTING RESULT
    MOV DX, OFFSET MSG4
    MOV AH, 09H
    INT 21H

    MOV DX, OFFSET STRING
    MOV AH, 09H
    INT 21H

STOP:
    MOV AH, 4CH
    INT 21H

READ_STRING PROC
    LOOP1:
        MOV AH, 01H
        INT 21H

        CMP AL, 0DH
        JE LOOP1_END

        MOV [SI], AL
        INC SI
        JMP LOOP1
    LOOP1_END:
        MOV BYTE PTR [SI], '$'  ; Terminate the string correctly
        RET
READ_STRING ENDP

REPLACE_STRING PROC
    LOOP2:
        CMP BYTE PTR [SI], 0
        JE LOOP2_END

        CMP BYTE PTR [SI], AL
        JNE NOT_REPLACE

        MOV BYTE PTR [SI], AH  ; Replace the character
    NOT_REPLACE:
        INC SI
        JMP LOOP2

    LOOP2_END:
        RET
REPLACE_STRING ENDP

CODE ENDS
END START
