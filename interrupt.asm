; Unfortunately we have not YET installed Windows or Linux on the LC-3,
; so we are going to have to write some operating system code to enable
; keyboard interrupts. The OS code does three things:
;
;    (1) Initializes the interrupt vector table with the starting
;        address of the interrupt service routine. The keyboard
;        interrupt vector is x80. The keyboard interrupt service routine
;        begins at x1000. 
;    (2) Sets bit 14 of the KBSR to enable interrupts.
;    (3) Pushes a PSR and PC to the system stack so that it can jump
;        to the user program at x3000 using an RTI instruction.
.ORIG x0800
; (1) Initialize the interrupt vector table.
LD R1, ISR
LD R2, VEC
STR R1, R2, #0

; (2) Set bit 14 of KBSR.
LD R1, MASK
LDI R2, KBSR
NOT R1, R1
NOT R2, R2
AND R1, R1, R2
NOT R1, R1
STI R1, KBSR

; (3) Set up the system stack to enter user space.
LD R0, PSR
ADD R6, R6, #-1
STR R0, R6, #0
LD R0, PC
ADD R6, R6, #-1
STR R0, R6, #0
; Enter user space.
RTI
    
; Fill out these values to init the machine properly
VEC     .FILL x0180  ;address of keyboard interrupt vector
ISR     .FILL x1000  ;address of interrupt service routine
KBSR    .FILL xFE00  ;address of keyboard status register
MASK    .FILL x4000  ;used to set bit 14 of kbsr
PSR     .FILL x8002  ;process status register
PC      .FILL x3000  ;program counter
.END

.ORIG x3000
; *** Begin user program code here ***
MAIN
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
    DELAY   
    ST  R1, SAVE_R1
    LD  R1, COUNT
    REPEAT     
    ADD R1, R1, #-1
    BRnp REPEAT
    LD  R1, SAVE_R1
    BR MAIN
COUNT   .FILL x7FFF 
SAVE_R1  .BLKW #1
NEW_LINE .STRINGZ "\n"
L1 .STRINGZ "====================\n"
L2 .STRINGZ "*    *  *******\n"
L3 .STRINGZ "*    *     *   \n"
L6 .STRINGZ " ****      *   \n"
L7 .STRINGZ "****   ****  ****\n"
L8 .STRINGZ "*     *      *\n"
L9 .STRINGZ "****  *      ****\n"
; *** End user program code here ***
.END

.ORIG x1000
; *** Begin interrupt service routine code here ***
ST R0, SAVER0
ST R1, SAVER1
ST R2, SAVER2
ST R3, SAVER3
ST R4, SAVER4
ST R5, SAVER5

TEST
    LEA R0, LINE_FEED
    PUTS
    LDI R0, KBDR
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
    ; Well, i guess it was a number...
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
    LEA R0, LINE_FEED
    PUTS
    BR ALLDONE
    NO
    BR AGAIN
ZERO
    BR ALLDONE
FAIL
    PUTC
    LEA R0, STOOPID
    PUTS
ALLDONE    
LD R0, SAVER0
LD R1, SAVER1
LD R2, SAVER2
LD R3, SAVER3
LD R4, SAVER4
LD R5, SAVER5
RTI
SAVER0 .BLKW #1
SAVER1 .BLKW #1
SAVER2 .BLKW #1
SAVER3 .BLKW #1
SAVER4 .BLKW #1
SAVER5 .BLKW #1
KBDR .FILL xFE02
THIRTY .FILL x30
NEG_THIRTY .FILL xFFD0
NEG_THIRTY_NINE .FILL xFFC7
HEX_OFFSET .FILL x00F0
LINE_FEED .STRINGZ "\n"
STOOPID .STRINGZ " is not a decimal digit.\n"
; *** End interrupt service routine code here ***
.END