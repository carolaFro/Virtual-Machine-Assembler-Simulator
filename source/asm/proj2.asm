; data segment
I       .BYT 'I'
S       .BYT 's'

EVEN    .BYT 'e'
        .BYT 'v'
        .BYT 'e'
        .BYT 'n'

ODD     .BYT 'o'
        .BYT 'd'
        .BYT 'd'

SUM     .BYT 'S'
        .BYT 'u'
        .BYT 'm'

DAGS    .BYT 'D'
        .BYT 'A'
        .BYT 'G'
        .BYT 'S'

spc     .BYT '\s'
nl      .BYT '\n'
cmm     .BYT ','
rel     .BYT '='
        .BYT '>'
        .BYT '<'

GADS    .INT #-99
SIZE    .INT #10
INDEX   .INT #0
COUNT   .INT #1
SUM_RES .INT #0
ARRAY   .INT #10
        .INT #2
        .INT #3
        .INT #4
        .INT #15
        .INT #-6
        .INT #7
        .INT #8
        .INT #9
        .INT #10

        JMP MAIN
        ;program segment
MAIN    LDA R0, ARRAY
        LDR R1, INDEX
        LDR R2, SIZE
        ADI R13, #1
        ADI R14, #2

WHILE   LDR R6, R0
        ADD R5, R6 ;r5 is sum
        STR R5, SUM_RES
        LDR R7, R0 ; saving original current
        MOV R3, R7
        TRP #1
        LDB R3, spc
        TRP #3
        LDB R3, I
        TRP #3
        LDB R3, S
        TRP #3
        LDB R3, spc
        TRP #3
        DIVI R6, #2
        MULI R6, #2 ; finishing modulus
        CMP R6, R7 ;comparing original with modulus
        BRZ R6, P_EVEN  ; go to sub routine
        BNZ R6, P_ODD ;go to sub routine
CONT1   LDB R3, nl
        TRP #3
        MULI R4, #0
        MULI R11, #0
        MULI R12, #0
        ADI R0, #4 ; move to next addr
        ADI R1, #1 ;increment by 1
        MOV R8, R1
        CMP R8, R2
        BRZ R8, END_WHL
        BLT R8, WHILE

P_EVEN  MOVI R4, #4 ;size of even
        LDA R9, EVEN
        JMP PRINT

P_ODD   MOVI R4, #3 ;size of even
        LDA R9, ODD
        JMP PRINT

END_WHL MOVI R4, #3
        LDA R9, SUM
        LDR R13, R9
        LDR R14, R9
        JMP PRINT
CONT2   LDB R3, spc
        TRP #3
        LDB R3, I
        TRP #3
        LDB R3, S
        TRP #3
        LDB R3, spc
        TRP #3
        LDR R3, SUM_RES
        TRP #1
        LDB R3, nl
        TRP #3
        TRP #3
        JMP 2ND_P

PRINT   LDB R3, R9
        TRP #3
        ADI R9, #1
        ADI R11, #1
        MOV R12, R11
        CMP R12, R4
        BNZ R12, PRINT
        CMP R13, R14
        BRZ R13, CONT2
        BRZ R12, CONT1

;GADS DAGS PART
2ND_P   LDA R0, DAGS
        LDA R1, GADS

        ADI R0, #2
        LDB R4, R0 ;D
        STB R4, R1
        ADI R1, #1
        ADI R0, #-1
        LDB R4, R0 ;A
        STB R4, R1
        ADI R1, #1
        ADI R0, #-1
        LDB R4, R0 ;G
        STB R4, R1
        ADI R1, #1
        ADI R0, #3
        LDB R4, R0 ;S
        STB R4, R1
        LDR R7, INDEX
        ADI R0, #-3
        ADI R1, #-3
        MULI R8, #0

WHILE1  LDB R4, R0 ;dags
        LDB R5, R1 ;gads
        LDA R2, rel
        CMP R4, R5
        BLT R4, REL_V2
        BGT R4, REL_V1
        BRZ R4, REL_V0 ;rel array positon
CONT8   ADI R1, #1
        ADI R0, #1
        ADI R7, #1 ;increment by 1
        MOV R8, R7
        CMPI R8, #4
        BRZ R8, END
        BLT R8, WHILE1

REL_V0  LDB R6, R2
        JMP PRINT1

REL_V1  ADI R2, #1
        LDB R6, R2
        JMP PRINT1

REL_V2  ADI R2, #2
        LDB R6, R2
        JMP PRINT1

PRINT1  LDB R3, R0
        TRP #3
        LDB R3, spc
        TRP #3
        MOV R3, R6
        TRP #3
        LDB R3, spc
        TRP #3
        MOV R3, R5
        TRP #3
        MOVI R3, #45
        TRP #3
        TRP #3
        MULI R2, #0
        JMP CONT8

END     LDB R3, nl
        TRP #3
        TRP #3
        LDR R0, DAGS
        LDR R1, GADS
        MOV R3, R0
        TRP #1
        MOVI R3, #45
        TRP #3
        MOV R3, R1
        TRP #1
        LDB R3, spc
        TRP #3
        LDB R3, rel
        TRP #3
        LDB R3, spc
        TRP #3
        SUB R0, R1
        MOV R3, R0
        TRP #1
        LDB R3, nl
        TRP #3
        TRP #0
