W       .BYT 'W'
        .BYT 'e'
        .BYT ' '
Uno     .INT #-1
        .INT #-2
        JMP  MAIN ; this is a comment

MAIN    LDA  R4, W
        LDB R3, R4
        TRP  #3
        ADI  R4, #1
        LDB R3, R4
        TRP  #3
        ADI R4, #1
        LDB R3, R4
        TRP #3
J       LDA R4, Uno
        LDR R1, R4
        ADI R4, #4
        LDR R0, R4
        ADD  R1, R0
        MOV  R3, R1
        TRP  #1
        TRP  #0