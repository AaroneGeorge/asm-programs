DATA SEGMENT
	MSG1 DB "ENTER STRING1: $"
	MSG2 DB "ENTER STRING2: $"
    	string1 DB 50 DUP ('$')     ; First string
    	string2 DB 50 DUP ('$')     ; Second string
    	result_buffer DB 100 DUP ('$')  ; Buffer to store the concatenated string
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

START:
    MOV AX, DATA
    MOV DS, AX

	; Display prompt for input 1
	MOV DX, OFFSET MSG1
	MOV AH, 09H
	INT 21H

	; Read string1
	MOV SI, OFFSET string1 ; Point SI to start of buffer
    	CALL READ_STRING

	; Display prompt for input 2
	MOV DX, OFFSET MSG2
	MOV AH, 09H
	INT 21H

	; Read string2
	MOV SI, OFFSET string2 ; Point SI to start of buffer
    	CALL READ_STRING

    	; Concatenate strings
    	MOV SI, OFFSET string1 ; Source address of string1
    	MOV DI, OFFSET result_buffer ; Destination buffer address
    	CALL CONCATENATE_STRINGS

    	MOV SI, OFFSET string2 ; Source address of string2
    	CALL CONCATENATE_STRINGS

   	; Display the concatenated string
   	MOV DX, OFFSET result_buffer
   	MOV AH, 09H
   	INT 21H

STOP:
    MOV AH, 4CH
    INT 21H

; Procedure to read a string
READ_STRING PROC
READ_LOOP:
    MOV AH, 01H         ; Function to read character
    INT 21H             ; Read character into AL
    CMP AL, 0DH         ; Check if Enter key (carriage return)
    JE END_READ         ; Jump to end of input if Enter is pressed
    MOV [SI], AL        ; Store character in buffer
    INC SI              ; Move to the next position in the buffer
    JMP READ_LOOP       ; Repeat loop to read next character
END_READ:
    MOV BYTE PTR [SI], '$' ; Add string terminator
    RET
READ_STRING ENDP

; Procedure to concatenate strings
CONCATENATE_STRINGS PROC
COPY_LOOP:
    MOV AL, [SI]   ; Load byte from source string
    CMP AL, '$'    ; Check for string terminator
    JE END_COPY    ; If end of string, jump to end
    MOV [DI], AL   ; Copy byte to destination buffer
    INC SI         ; Move to next byte in source string
    INC DI         ; Move to next position in destination buffer
    JMP COPY_LOOP  ; Continue copying characters
END_COPY:
    RET
CONCATENATE_STRINGS ENDP

CODE ENDS
END START
