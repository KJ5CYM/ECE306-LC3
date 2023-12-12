.ORIG x3000
BRnzp INIT
     PLAYA2 .STRINGZ "Player 2, choose a row and number of rocks:"
       PLAYA1 .STRINGZ "Player 1, choose a row and number of rocks:"
INIT
    JSR CLEAR_REG
    ADD R1, R1, #3
    ST R1, NUM_A
    AND R1, R1, #0
    ADD R1, R1, #5
    ST R1, NUM_B
    AND R1, R1, #0
    ADD R1, R1, #8
    ST R1, NUM_C
    AND R1, R1, #0
    JSR UPDATE
    
PLAYER1
    LEA R0, PLAYA1
    PUTS
    AND R5, R5, #0
    ADD R5, R5, #-1
    JSR INPUT
    JSR WINNER
    JSR UPDATE
PLAYER2
    LEA R0, PLAYA2
    PUTS
    AND R5, R5, #0
    ADD R5, R5, #1
    JSR INPUT
    JSR WINNER
    JSR UPDATE
    BR PLAYER1
tempFirst .fill x0001
UPDATE
    ST R7, JSR_SAVE
    LD R7 tempFirst
    BRz CR
    AND R7 R7 #0
    ST R7 tempFirst
    BR first


CR    LD R0, CARRIAGE_RETURN
    PUTC
    LD R0, CARRIAGE_RETURN
    PUTC
first    LEA R0, ROW_A_INIT
    PUTS
    LD R1, NUM_A
    JSR DUMPROCKS
    LD R0, CARRIAGE_RETURN
    PUTC
    LEA R0, ROW_B_INIT
    PUTS
    LD R1, NUM_B
    JSR DUMPROCKS
    LD R0, CARRIAGE_RETURN
    PUTC
    LEA R0, ROW_C_INIT
    PUTS
    LD R1, NUM_C
    JSR DUMPROCKS
    LD R0, CARRIAGE_RETURN
    PUTC
    LD R7, JSR_SAVE
    RET
    
DUMPROCKS
    LEA R0, ROCK
    ADD R1, R1, #-1
    BRzp DUMP
    BRn DUM
    DUMP
    LEA R0, ROCK
    PUTS
    BR DUMPROCKS
DUM RET
    
INPUT
    LD R1, HEX_A
    LD R2, HEX_B
    LD R3, HEX_C
    GETC
    PUTC
    ADD R4, R0, #0
    ADD R4, R4, R1
    ADD R4, R4, #0
    BRz A
    ADD R4, R0, #0
    ADD R4, R4, R2
    ADD R4, R4, #0
    BRz B
    ADD R4, R0, #0
    ADD R4, R4, R3
    ADD R4, R4, #0
    BRz C
    GETC
    PUTC
FAIL
    LD R0, CARRIAGE_RETURN
    PUTC
    LEA R0, STOOPID
    PUTS
    LD R0, CARRIAGE_RETURN
    PUTC
    ADD R5, R5, #0
    BRn PLAYER1
    BRp PLAYER2
C
    GETC
    PUTC
    LD R1, NUM_C
    
    ADD R6, R0, #0
    LD R4, HEX_OFFSET
    AND R6, R6, R4
    LD R4, NEG_THIRTY
    ADD R6, R6, R4
    BRnp FAIL
    
    AND R0, R0, x000F
    NOT R0, R0
    ADD R0, R0, #1
    
    ADD R3, R1, #0  ;Copy to R3
    ADD R4, R3, R0  ;Subtraction result to R4
    NOT R4, R4      
    ADD R4, R4, #1  ;2's comp
    ADD R3, R3, R4
    BRz FAIL
    
    ADD R2, R1, R0
    BRn FAIL
    ST R2, NUM_C
    RET
B
    GETC
    PUTC
    LD R1, NUM_B
    
    ADD R6, R0, #0
    LD R4, HEX_OFFSET
    AND R6, R6, R4
    LD R4, NEG_THIRTY
    ADD R6, R6, R4
    BRnp FAIL
    
    AND R0, R0, x000F
    NOT R0, R0
    ADD R0, R0, #1
    
    ADD R3, R1, #0  ;Copy to R3
    ADD R4, R3, R0  ;Subtraction result to R4
    NOT R4, R4      
    ADD R4, R4, #1  ;2's comp
    ADD R3, R3, R4
    BRz FAIL
    
    ADD R2, R1, R0
    BRn FAIL
    ST R2, NUM_B
    RET
A
    GETC
    PUTC
    LD R1, NUM_A
    
    ADD R6, R0, #0
    LD R4, HEX_OFFSET
    AND R6, R6, R4
    LD R4, NEG_THIRTY
    ADD R6, R6, R4
    BRnp FAIL
    
    AND R0, R0, x000F
    NOT R0, R0
    ADD R0, R0, #1
    
    ADD R3, R1, #0  ;Copy to R3
    ADD R4, R3, R0  ;Subtraction result to R4
    NOT R4, R4      
    ADD R4, R4, #1  ;2's comp
    ADD R3, R3, R4
    BRz FAIL
    
    ADD R2, R1, R0
    BRn FAIL
    ST R2, NUM_A
    RET

CLEAR_REG
    AND R0, R0, #0
    AND R1, R1, #0
    AND R2, R2, #0
    AND R3, R3, #0
    AND R4, R4, #0
    AND R5, R5, #0
    AND R6, R6, #0
    RET
    
WINNER
    LD R1, NUM_A
    LD R2, NUM_B
    LD R3, NUM_C
    ADD R1, R1, #0
    BRnz CHECKB
    BRp NOPE
    CHECKB
    ADD R2, R2, #0
    BRnz CHECKC
    BRp NOPE
    CHECKC
    ADD R3, R3, #0
    BRz ALL_ZERO
    BRp NOPE
    ALL_ZERO
    ADD R5, R5, #0
    BRp P1_WIN
    BRn P2_WIN
    P1_WIN
    LD R0, CARRIAGE_RETURN
    PUTC
    LD R0, CARRIAGE_RETURN
    PUTC
    LEA R0, WIN1
    PUTS
    HALT
    P2_WIN
    LD R0, CARRIAGE_RETURN
    PUTC
    LD R0, CARRIAGE_RETURN
    PUTC
    LEA R0, WIN2
    PUTS
    HALT
    NOPE
    RET
    
    NUM_A .BLKW 1
    NUM_B .BLKW 1
    NUM_C .BLKW 1
    JSR_SAVE .BLKW 1
    HEX_A .FILL xFFBF
    HEX_B .FILL xFFBE
    HEX_C .FILL xFFBD
    HEX_OFFSET .FILL x00F0
    NEG_THIRTY .FILL xFFD0
    CARRIAGE_RETURN .FILL x0A
    ROW_A_INIT .STRINGZ "ROW A: "
    ROW_B_INIT .STRINGZ "ROW B: "
    ROW_C_INIT .STRINGZ "ROW C: "
    ROCK .STRINGZ "o"
    STOOPID .STRINGZ "Invalid move. Try again."
    WIN1 .STRINGZ "Player 1 Wins."
    WIN2 .STRINGZ "Player 2 Wins."
    .END