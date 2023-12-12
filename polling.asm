.ORIG x3000

MAIN
JSR CLEAR_REG
JSR PRINT_BANNER
JSR POLL-N-PRINT
HALT

CLEAR_REG
    AND R0, R0, #0
    AND R1, R1, #0
    AND R2, R2, #0
    AND R3, R3, #0
    AND R4, R4, #0
    AND R5, R5, #0
    AND R6, R6, #0
    RET
PRINT_BANNER
    LEA R0, L1
    PUTS
    LEA R0, L2
    PUTS
    LEA R0, L3
    PUTS
    PUTS
    PUTS
    LEA R0, L6
    PUTS
    LEA R0, NEW_LINE
    PUTS
    LEA R0, L7
    PUTS
    LEA R0, L8
    PUTS
    LEA R0, L9
    PUTS
    LEA R0, L8
    PUTS
    LEA R0, L7
    PUTS
    LEA R0, L1
    PUTS
    RET
POLL-N-PRINT
    GETC               ;get char
    LD R1, NEG_THIRTY
    ADD R1, R0, R1
    BRz ZERO
    LD R1, NEG_THIRTY_NINE
    ADD R1, R0, R1
    BRp FAIL
    ADD R2, R0, #0     ;copy char to R2
    LD R4, HEX_OFFSET  ;load bitmask
    AND R2, R2, R4     ;apply mask, R2 contains 30 if # entered
    LD R4, NEG_THIRTY  ;R4 contains #-30
    ADD R2, R2, R4     ;R2 is zero if R0 was a #
    BRnp FAIL          ;If it wasn't a number, FAIL...
    ; Else
    LD R4, THIRTY      ;Get x30
    ADD R3, R3, R4     ;R3 is ready to become an ascii code...
    
    AGAIN
    ADD R3, R3, x1     ;X3# + 1
    ADD R5, R0, #0     ;Copy input to R5
    ADD R7, R0, #0     ;SAVE R0
    NOT R5, R5
    ADD R5, R5, #1
    ADD R0, R3, #0
    PUTC
    ADD R0, R7, #0     ;RESTORE R0
    ADD R2, R3, #0
    NOT R2, R2
    ADD R2, R2, #1
    ADD R5, R0, R2     ;Is input same as constructed value???
    BRz YES
    BRnp NO
    
    YES
    LEA R0, NEW_LINE
    PUTS
    BR MAIN
    
    NO
    BR AGAIN
FAIL
    PUTC
    LEA R0, STOOPID
    PUTS
    BR MAIN
    RET
ZERO
    BR MAIN

THIRTY .FILL x30
NEG_THIRTY .FILL xFFD0
NEG_THIRTY_NINE .FILL xFFC7
HEX_OFFSET .FILL x00F0
NEW_LINE .STRINGZ "\n"
L1 .STRINGZ "====================\n"
L2 .STRINGZ "*    *  *******\n"
L3 .STRINGZ "*    *     *   \n"
L6 .STRINGZ " ****      *   \n"
L7 .STRINGZ "****   ****  ****\n"
L8 .STRINGZ "*     *      *\n"
L9 .STRINGZ "****  *      ****\n"
STOOPID .STRINGZ " is not a decimal digit.\n"
.END