DATA SEGMENT
	MSG1 DB "ENTER STRING1: $"
	MSG2 DB "ENTER STRING2: $"
    	string1 DB 50 DUP ('$')     ; First string
    	string2 DB 50 DUP ('$')     ; Second string
    	result_buffer DB 50 DUP(0)  ; Buffer to store the concatenated string
DATA ENDS

CODE SEGMENT
    	ASSUME CS:CODE, DS:DATA

START:
   	MOV AX, DATA
    	MOV DS, AX

	MOV DX, OFFSET MSG1
	MOV AH,09H
	INT 21H

	
	


    ; Load addresses of strings into registers
    LEA SI, string1  ; Source address of string1
    LEA DI, string2  ; Source address of string2
    LEA BX, result_buffer ; Destination buffer address

    ; Copy string1 to result_buffer
    MOV CX, 0      ; Counter for string1
COPY_STRING1:
    MOV AL, [SI]   ; Load byte from string1
    CMP AL, 0      ; Check for string terminator (null character)
    JE CONCAT_STRINGS   ; If end of string1, jump to concatenate strings
    MOV [BX], AL   ; Copy byte from string1 to result_buffer
    INC SI         ; Move to next byte in string1
    INC BX         ; Move to next position in result_buffer
    INC CX         ; Increment counter
    CMP CX, 50     ; Check for maximum length of result_buffer
    JE CONCAT_STRINGS   ; If reached max length, jump to concatenate strings
    JMP COPY_STRING1    ; Continue copying string1

CONCAT_STRINGS:
    ; Copy string2 to result_buffer
    MOV CX, 0      ; Counter for string2
COPY_STRING2:
    MOV AL, [DI]   ; Load byte from string2
    CMP AL, 0      ; Check for string terminator (null character)
    JE DISPLAY_RESULT   ; If end of string2, jump to display result
    MOV [BX], AL   ; Copy byte from string2 to result_buffer
    INC DI         ; Move to next byte in string2
    INC BX         ; Move to next position in result_buffer
    INC CX         ; Increment counter
    CMP CX, 50     ; Check for maximum length of result_buffer
    JE DISPLAY_RESULT   ; If reached max length, jump to display result
    JMP COPY_STRING2    ; Continue copying string2

DISPLAY_RESULT:
    ; Display the concatenated string
    MOV DX, OFFSET result_buffer
    MOV AH, 09H
    INT 21H

STOP:
    MOV AH, 4CH
    INT 21H

CODE ENDS
END START
