DATA SEGMENT
    MSG1 DB "Enter a: $"
    MSG2 DB "Enter b: $"
    MSG3 DB "a+b= $"
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA

    INPUT PROC
        MOV DX,OFFSET MSG1
        MOV AH,09H
        INT 21H

        MOV AH,01H
        INT 21H
        MOV BL,AL

        MOV AH,01H
        INT 21H
        MOV BH,AL

        ;new space
        MOV DL,0AH
        MOV AH,02H
        INT 21H

        MOV DX,OFFSET MSG2
        MOV AH,09H
        INT 21H

        MOV AH,01H
        INT 21H
        MOV CL,AL

        MOV AH,01H
        INT 21H
        MOV CH,AL

        SUB BL,48
        SUB BH,48
        SUB CL,48
        SUB CH,48

        MOV AL,10
        MUL BL
        MOV BL,AL
        ADD BL,BH

        MOV AL,10
        MUL CL
        MOV CL,AL
        ADD CL,CH

        RET
    INPUT ENDP

    PRINT PROC
        MOV DL,BL
        MOV AH,02H
        INT 21H
        RET    
    PRINT ENDP

    DISPLAY PROC
        CMP BL,9
        JC TWO

    ONE:
        ADD BL,48
        CALL PRINT
        JMP ENDD

    TWO:
        MOV AL,BL
        SUB AH,AH
        MOV BL,10
        DIV BL

        MOV BH,AH
        MOV BL,AL

        PUSH BX
        CALL DISPLAY
        POP BX

        ADD BL,48
        CALL PRINT 

    ENDD:
        RET
    DISPLAY ENDP

    START:
        MOV AX,DATA
        MOV DS,AX

        CALL INPUT
            ADD BL,CL
        
        ;new space
        MOV DL,0AH
        MOV AH,02H
        INT 21H

        MOV DX,OFFSET MSG3
        MOV AH,09H
        INT 21H

        CALL DISPLAY
    STOP:
        MOV AH,4CH
        INT 21H


CODE ENDS
END START