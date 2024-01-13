DATA SEGMENT
	PROMPT_MSG DB "Enter a string: $"
    	INPUT_BUFFER DB 100 DUP ('$') ; Buffer to store the input string
DATA ENDS

CODE SEGMENT
    	ASSUME CS:CODE, DS:DATA

START:
    	MOV AX, DATA
    	MOV DS, AX

    	; Display prompt for input
    	MOV DX, OFFSET PROMPT_MSG
    	MOV AH, 09H
    	INT 21H

    	; Read a string of characters
    	MOV SI, OFFSET INPUT_BUFFER  ; Point SI to start of buffer
READ_LOOP:
    	MOV AH, 01H         ; Function to read character
    	INT 21H             ; Read character into AL
    
    	CMP AL, 0DH         ; Check if Enter key (carriage return)
    	JE END_INPUT        ; Jump to end of input if Enter is pressed
    
    	MOV [SI], AL        ; Store character in buffer
    	INC SI              ; Move to the next position in the buffer
    	JMP READ_LOOP       ; Repeat loop to read next character
    
END_INPUT:
    	MOV BYTE PTR [SI], '$' ; Add string terminator
    	; Now INPUT_BUFFER contains the entered string
    	
    	; Display the entered string (for demonstration)
    	MOV DX, OFFSET INPUT_BUFFER
    	MOV AH, 09H
    	INT 21H

STOP:
    	MOV AH, 4CH
    	INT 21H

CODE ENDS
END START


