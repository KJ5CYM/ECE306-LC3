.ORIG x3000
; Initialize registers
AND R0, R0, #0
AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0
AND R6, R6, #0
AND R7, R7, #0

; Load the pointers to the input linked lists (l1 and l2)
LDI R1, LIST1    ; Load the address of the first linked list (l1)
LDI R2, LIST2    ; Load the address of the second linked list (l2)
; R1 = pointer to first node in l1
; R2 = pointer to first node in l2
AND R6, R6, #0    ; n = list head pointer = NULL
AND R5, R5, #0    ; head

LOOP
    ; Check if either of the lists is empty
    ADD R1, R1, #0        ; Is it null?
    BRz LISTS_EMPTY       ; Branch to LIST1_EMPTY if l1 is NULL
    ADD R2, R2, #0        ; Is it null?
    BRz LISTS_EMPTY       ; Branch to LIST2_EMPTY if l2 is NULL
    
    ADD R3, R1, #0   ; Copy l1 address to R3
    ADD R3, R3, #1   ; Descend into l1 address
    LDR R3, R3, #0   ; Load the pointer to letter
    ADD R4, R2, #0   ; Copy l2 address to R4
    ADD R4, R4, #1   ; Descend into l2 address
    LDR R4, R4, #0   ; Load the pointer to letter
AGAIN
; Load first letter at l1 pointer into R3
    LDR R3, R3, #0   ; Load the letter itself
; Load first letter at l2 pointer into R4
    LDR R4, R4, #0   ; Load the letter itself
    BR COMPARE
    DONE_COMPARE
    ADD R0, R0, #0   ; Set condition codes (What's the news?)
    BRp L2_LESS
    BRn L1_LESS
    ADD R7, R7, #1
    BRz SAME_LETTER
    
SAME_LETTER
    ADD R3, R1, #0   ; Copy l1 address to R3
    ADD R3, R3, #1   ; Descend into l1 address
    LDR R3, R3, #0   ; Load the pointer to letter
    ADD R3, R3, R7   ; next letter
    ADD R4, R2, #0   ; Copy l2 address to R4
    ADD R4, R4, #1   ; Descend into l2 address
    LDR R4, R4, #0   ; Load the pointer to letter
    ADD R4, R4, R7   ; next letter
    BR AGAIN 
    
L2_LESS
    ADD R6, R6, #0
    BRz N_NULL_2
    BRnp N_NOT_NULL2
    N_NULL_2
    ADD R6, R2, #0                  ; n = l2
    ADD R5, R2, #0                  ; head = l2
    BR ADV_L2
    N_NOT_NULL2
    STR R2, R6, #0                  ; n->next = l2
    ADD R6, R2, #0                  ; n = l2
    ; QUESTION
    ADV_L2
    LDR R2, R2, #0                  ; l2 = l2 -> next
    BR LOOP
    
L1_LESS
    ADD R6, R6, #0
    BRz N_NULL_1
    BRnp N_NOT_NULL1
    N_NULL_1
    ADD R6, R1, #0                  ; n = l1
    ADD R5, R1, #0                  ; head = l1
    BR ADV_L1
    N_NOT_NULL1
    STR R1, R6, #0                  ; n->next = l1
    ADD R6, R1, #0                  ; n = l1
    ; QUESTION
    ADV_L1
    LDR R1, R1, #0                  ; l1 = l1 -> next
    BR LOOP
    
COMPARE
    NOT R0, R4        ; Calculate two's complement of R4 and store in R0
    ADD R0, R0, #1    ; Negate R0 by adding 1
    ADD R0, R3, R0    ; R0 = R3 + -R4(which is R0)
; R0 now contains a comparison result
; Usage: If the result is 0, you need to move to the next letter because l1 and l2 were the same.
; If the result was negative, it means l1 is alphabetically prior to l2
; If the result was positive, it means l2 is alphabetically prior to l1
    BR DONE_COMPARE
    
; Load the letters for comparison
; Start of the loop for loading strings from the lists
; When using, R1 needs to point to the node of l1 that contains string to compare
; When using, R2 needs to point to the node of l2 that contains string to compare
LOAD_LETTERS
; Load first letter at l1 pointer into R3
    LDR R3, R3, #0   ; Load the letter itself
; Load first letter at l2 pointer into R4
    LDR R4, R4, #0   ; Load the letter itself
; At this point, the address in R1 contains the next pointer for l1
; At this point, the address in R2 contains the next pointer for l2
; At this point, R3 contains the letter from l1
; At this point, R4 contains the letter from l2
    RET    

LISTS_EMPTY
    ADD R1, R1, #0        ; Is l1 null?
    BRnp LIST2_EMPTY      ; Branch to LIST2_EMPTY if l1 is not NULL
    BRz LIST1_EMPTY       ; Else branch to LIST1_EMPTY
    
    LIST2_EMPTY
    ADD R6, R6, #0
    BRz N_NULL_3
    BRnp N_NOT_NULL3
    N_NULL_3
    ADD R5, R1, #0                  ; head = l1
    BR DONE
    N_NOT_NULL3
    STR R1, R6, #0                  ; n->next = l1
    BR DONE
    
    LIST1_EMPTY
    ADD R6, R6, #0
    BRz N_NULL_4
    BRnp N_NOT_NULL4
    N_NULL_4
    ADD R5, R2, #0                  ; head = l2
    BR DONE
    N_NOT_NULL4
    STR R2, R6, #0                  ; n->next = l2
    BR DONE
    
DONE
    STI R5, MERGED_LIST
    HALT

; Data section
LIST1 .FILL x4000       ; Pointer to the first linked list
LIST2 .FILL x4001       ; Pointer to the second linked list
MERGED_LIST .FILL x4002 ; Pointer to the result (merged) linked list
FLAG .BLKW 1            ; Flag
.END

; Test case loading
.ORIG x4000
.FILL x4050
.FILL x4100
.END

.ORIG x4050
.FILL x4150
.FILL x4025
.END

.ORIG x4025
.STRINGZ "Baa"
.END

.ORIG x4077
.STRINGZ "Bab"
.END

.ORIG x4100
.FILL x454D
.FILL x5650
.END

.ORIG x4150
.FILL x0000
.FILL x4077
.END

.ORIG x454D
.FILL x0000
.FILL x5525
.END

.ORIG x5525
.STRINGZ "Aaaaz"
.END

.ORIG x5650
.STRINGZ "Aaaab"
.END

