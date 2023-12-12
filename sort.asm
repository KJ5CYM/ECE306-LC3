.ORIG x3000

AND R0, R0, #0
AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0
AND R6, R6, #0
AND R7, R7, #0

LD R0, ARRAY_START
LDI R7, ARRAY_LENGTH
ADD R7, R7, #-1        ;distance of last item from current item
BRnz INVALID_LENGTH
LDI R1 ARRAY_START     ;Put the first item of the array in R1
BR FIRST
AGAIN
ADD R7, R7, #-1        ;distance of last item from current item
BRz DONE
LDR R1, R0, #0         ;Put the first item of the itterated array in R1
FIRST
ADD R6, R0, R7         ;The address of the last item in the array is now in R6
LDR R2, R6, #0         ;Put the last item in the array in R2
;first item in R1
;last item in R2
NOT R4, R2     ; Calculate two's complement of R2
ADD R4, R4, #1 ; Negate R4 by adding 1
ADD R3, R1, R4 ; R3 = R1 - R4 (-R2)
BRp GREATER
BRn LESS

LESS        ; First item in the array was less than the last item, swap em'
STR R2, R0, #0
STR R1, R6, #0
ADD R0, R0, #1
BR AGAIN

GREATER           ; First item in the array was already greater than the last item, increment address of first item
ADD R0, R0, #1
BR AGAIN 

DONE
BR HORSES_ASS

;###########################################################################
INVALID_LENGTH
HALT

HORSES_ASS
AND R0, R0, #0
AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0
AND R6, R6, #0
AND R7, R7, #0

LD R0, ARRAY_START
LDI R7, ARRAY_LENGTH
LDI R1 ARRAY_START     ;Put the first item of the array in R1
BR FIRST2
AGAIN2
ADD R7, R7, #-1        ;distance of last item from current item
BRz DONE2
LDR R1, R0, #0         ;Put the first item of the itterated array in R1
FIRST2
ADD R6, R0, #1         ;The address of the next item in the array is now in R6
LDR R2, R6, #0         ;Put the next item in the array in R2
;first item in R1
;second item in R2
NOT R4, R2     ; Calculate two's complement of R2
ADD R4, R4, #1 ; Negate R4 by adding 1
ADD R3, R1, R4 ; R3 = R1 - R4 (-R2)
BRp GREATER2
BRn LESS2

LESS2        ; First item in the array was less than the next item, swap em'
STR R2, R0, #0
STR R1, R6, #0
ADD R0, R0, #1
BR AGAIN2

GREATER2           ; First item in the array was already greater than the last item, increment address of first item
ADD R0, R0, #1
BR AGAIN2 

DONE2
HALT

ARRAY_START .FILL x3300
ARRAY_LENGTH .FILL x3201
.END

.ORIG x3200
.FILL x3300
.FILL x0000
.END

.ORIG x3300
.FILL x0003
.FILL x0005
.FILL x0004
.FILL x0002
.FILL x0001
.END
