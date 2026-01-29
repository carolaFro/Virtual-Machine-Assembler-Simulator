; all the data start here
A1      .INT #1
A2      .INT #2
A3      .INT #3
A4      .INT #4
A5      .INT #5
A6      .INT #6

B1      .INT #300
B2      .INT #150
B3      .INT #50
B4      .INT #20
B5      .INT #10
B6      .INT #5

C1      .INT #500
C2      .INT #2
C3      .INT #5
C4      .INT #10
; my name is Carolina Rojas, 
C       .BYT 'C'
a       .BYT 'a'
r       .BYT 'r'
o       .BYT 'o'
l       .BYT 'l'
i       .BYT 'i'
n       .BYT 'n'

R       .BYT 'R'
j       .BYT 'j'
s       .BYT 's'

nl      .BYT '\n'
spc     .BYT '\s'
cmm     .BYT ','
;end of data segment
        JMP MAIN
; print my name
MAIN    LDB R3, R
        TRP #3
        LDB R3, o
        TRP #3
        LDB R3, j
        TRP #3
        LDB R3, a
        TRP #3
        LDB R3, s
        TRP #3
        LDB R3, cmm
        TRP #3

        LDB R3, spc
        TRP #3

        LDB R3, C
        TRP #3
        LDB R3, a
        TRP #3
        LDB R3, r
        TRP #3
        LDB R3, o
        TRP #3
        LDB R3, l
        TRP #3
        LDB R3, i
        TRP #3
        LDB R3, n
        TRP #3
        LDB R3, a
        TRP #3

        LDB R3, nl
        TRP #3
        TRP #3 ; print a blank like

        ; adding all elements of B
        LDR R0, B1
        LDR R1, B2
        ADD R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3
        ; two spaces

        LDR R1, B3
        ADD R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3

        LDR R1, B4
        ADD R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3

        LDR R1, B5
        ADD R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3

        LDR R1, B6
        ADD R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3

        LDB R3, nl
        TRP #3
        TRP #3 ; print a blank like

        ; multiplying all element of A
        LDR R0, A1
        LDR R1, A2
        MUL R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3 

        LDR R1, A3
        MUL R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3 

        LDR R1, A4
        MUL R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3 

        LDR R1, A5
        MUL R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3  

        LDR R1, A6
        MUL R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3 
        MOV R4, R0 ; Result of all A's

        LDB R3, nl
        TRP #3
        TRP #3 ; print a blank like

        ; divide all results from last step 
        ; with every element of B 
        LDR R1, B1
        DIV R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3 

        MOV R0, R4
        LDR R1, B2
        DIV R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3 

        MOV R0, R4
        LDR R1, B3
        DIV R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3 

        MOV R0, R4
        LDR R1, B4
        DIV R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3 

        MOV R0, R4
        LDR R1, B5
        DIV R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3 

        MOV R0, R4
        LDR R1, B6
        DIV R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3 

        LDB R3, nl
        TRP #3
        TRP #3 ; print a blank like

        ;substract every element of step e
        ; with elements in c
        MOV R0, R4
        LDR R1, C1
        SUB R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3 

        MOV R0, R4
        LDR R1, C2
        SUB R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3 

        MOV R0, R4
        LDR R1, C3
        SUB R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3 

        MOV R0, R4
        LDR R1, C4
        SUB R0, R1
        MOV R3, R0
        TRP #1 ; PRINT
        LDB R3, spc
        TRP #3
        TRP #3

        TRP #0