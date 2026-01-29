;Data Segment
C       .BYT '\0'
        .BYT '\0'
        .BYT '\0'
        .BYT '\0'
        .BYT '\0'
        .BYT '\0'
        .BYT '\0'

DATA    .INT #0
SIZE    .INT #7
CNT     .INT #0
TENTH   .INT #0
FLAG    .INT #0
OPDV    .INT #0
;Code segment
        JMP MAIN

MAIN    LDA R0, C
        LDA R1, CNT
        LDA R2, TENTH
        MOV R14, PC ; getting current pc to set ret addrs
        JMP AR1 ; Activation record for reset
CONT1   JMP RESET
        MOVI R3, #65 ; A
        TRP #3
        MOV R14, PC ; getting current pc to set ret addrs
        JMP AR2 ; activarion record for getdata()
CONT2   JMP GETDAT
WHILE1  LDB R4, R0 ; r4 contains c[0] data, ret address #2, 24
        MOV R5, R4
        CMPI R5, #64 ;@
        BRZ R5, EXIT ;If @ is put, end program
IF1     MOV R5, R4
        MOV R6, R4
        ADI R5, #-43 ;OR
        BRZ R5, TRUE
        ADI R6, #-45
        BNZ R6, ELSE1
TRUE    MOV R14, PC ; getting current pc to set ret addrs
        JMP AR6 ; activarion record for getdata()
CONT10  JMP GETDAT
WHILE2  LDR R5, DATA
        CMPI R5, #1 ;if we have data, we keep going
        MOVI R3, #66 ; B
        TRP #3
        BNZ R5, ENDWHL1
        LDR R6, CNT ; to make c[cnt-1]
        ADI R6, #-1 ; cnt-1
        MOV R5, R0 ;movin c[0] address to r5
        ADD R5, R6 ;moving to c[cnt-1]
        LDB R6, R5 ;getting data c[cnt-1]
        MOVI R3, #69 ; E
        TRP #3
IF2     CMPI R6, #10 ; R6 == \n?, if2
        MOVI R3, #72 ; H
        TRP #3
        BNZ R6, ELSE2
        LDA R5, DATA ;gettin data address
        MOVI R6, #0
        STR R6, R5  ;zeroing data content
        MOVI R6, #1
        STR R6, R2 ;tenth = 1
        LDR R14, R1 ;R1 is cnt
        ADI R14, #-2 ; TOTAL is cnt - 2
        STR R14, R1 ; storing cnt - 2
WHILE3  LDR R5, FLAG
        MOVI R3, #89; Y
        TRP #3
        CMPI R14, #0 ;r14 still has the current val of cnt
        CMPI R5, #0 ;cheking if flag is 1
        AND R5, R14 ; This shouldn't be 0, then no loop
        BRZ R5, IF3 ; if and is 0, then go to if(!flag)
        MOV R14, PC
        JMP AR4 ; activation record for OPD
CONT3   JMP OPD
        MOVI R3, #82 ; R
        TRP #3
        LDR R14, R1 ;R1 is cnt
        ADI R14, #-1 ; cnt--
        STR R14, R1 ; storing cnt--
        LDR R5, R2; getting tenth
        MULI R5, #10
        STR R5, R2
        JMP WHILE3
IF3     LDR R5, FLAG
        CMPI R5, #1
        BRZ R5, WHILE2
        JMP PRINT1 ; print operand is %d\n
CONT4   JMP WHILE2

ELSE2   MOV R14, PC ; getting current pc to set ret addrs
        JMP AR7 ; Activation record for reset
CONT5   JMP GETDAT
        JMP WHILE2

ENDWHL1 MOV R14, PC ; getting current pc to set ret addrs
        JMP AR5 ; Activation record for reset
CONT6   JMP RESET ;
        MOV R14, PC
        JMP AR8
LSTCALL JMP GETDAT
        JMP WHILE1 ;need to keep looping?

; else1 correspond to if(c[0] != @)
ELSE1   ADI R0, #1 ;moving to c[1]
        STB R4, R0 ;C[1] = C[0]
        ADI R0, #-1 ;moving back to c[0]
        MOVI R4, #43 ;'+'
        STB R4, R0 ;C[0] = '+'
        LDR R14, R1 ;R1 is cnt
        ADI R14, #1 ; cnt++
        STR R14, R1 ; storing cnt++
        LDR R3, CNT
        TRP #1
        JMP WHILE2

;Activation record for reset(1, 0, 0, 0)
AR1     MOV R13, FP ;Save fp in r13, so r3=pfp
        MOV FP, SP ;point at current AR
        ADI SP, #-4 ;Adjust stack Pointer to new top (return addrs)
        STR R13, SP ;PFP to top of the stack
        ADI SP, #-4 ;Adjust stack Pointer to new top
        ; passed by value params
        MOVI R5, #1 ; first param
        STR R5, SP
        ADI SP, #-4 ;Adjust stack Pointer to new top

        MOVI R5, #0 ; 2nd param and 3rd are the same
        STR R5, SP
        ADI SP, #-4 ;Adjust stack Pointer to new top

        STR R5, SP
        ADI SP, #-4 ;Adjust stack Pointer to new top

        STR R5, SP
        ADI SP, #-4 ;Adjust stack Pointer to new top

        ADI R14, #24 ; SETTING RET ADDRS
        STR R14, FP
        JMP CONT1 ; going back to call rst()

AR5     MOV R13, FP ;Save fp in r3, so r3=pfp
        MOV FP, SP ;point at current AR
        ADI SP, #-4 ;Adjust stack Pointer to new top (return addrs)
        STR R13, SP ;PFP to top of the stack
        ADI SP, #-4 ;Adjust stack Pointer to new top
        ; passed by value params
        MOVI R5, #1 ; first param
        STR R5, SP
        ADI SP, #-4 ;Adjust stack Pointer to new top
        MOVI R5, #0 ; 2nd param and 3rd are the same
        STR R5, SP
        ADI SP, #-4 ;Adjust stack Pointer to new top

        STR R5, SP
        ADI SP, #-4 ;Adjust stack Pointer to new top

        STR R5, SP
        ADI SP, #-4 ;Adjust stack Pointer to new top

        ADI R14, #24 ; SETTING RET ADDRS
        STR R14, FP
        JMP CONT6 ; going back to call rst()

RESET   MOVI R5, #0 ; this is gonna be k
        MOVI R12, #0
        MOV R11, R0
FOR1    ADI R5, #1
        MOV R6, R5
        LDR R7, SIZE
        CMP R6, R7
        BRZ R6, OUT1
        STB R12, R11
        ADI R11, #1
        JMP FOR1
OUT1    MOV R13, FP
        ADI R13, #-20; Accessing 4th param
        LDR R5, R13
        STR R5, FLAG
        ADI R13, #-16; Accessing 3rd param
        LDR R5, R13
        STR R5, CNT
        ADI R13, #-12; Accessing 2nd param
        LDR R5, R13
        STR R5, OPDV
        ADI R13, #-8; Accessing 1st param
        LDR R5, R13
        STR R5, DATA

        MOV SP, FP ; dealloc
        ADI R13, #-4
        MOV FP, R13
        JMR R14

; Using r13 as pfp for this funct
AR2     MOV R13, FP ;Save fp in r13, so r3=pfp
        MOV FP, SP ;point at current AR
        ADI SP, #-4 ;Adjust stack Pointer to new top (return addrs)
        STR R13, SP ;PFP to top of the stack
        ADI SP, #-4 ;Adjust stack Pointer to new top

        ADI R14, #24 ; SETTING RET ADDRS
        STR R14, FP
        JMP CONT2 ; going back to call GETDAT

AR6     MOV R13, FP ;Save fp in r13, so r3=pfp
        MOV FP, SP ;point at current AR
        ADI SP, #-4 ;Adjust stack Pointer to new top (return addrs)
        STR R13, SP ;PFP to top of the stack
        ADI SP, #-4 ;Adjust stack Pointer to new top

        ADI R14, #24 ; SETTING RET ADDRS
        STR R14, FP
        JMP CONT10 ; going back to call GETDAT

AR7     MOV R13, FP ;Save fp in r13, so r3=pfp
        MOV FP, SP ;point at current AR
        ADI SP, #-4 ;Adjust stack Pointer to new top (return addrs)
        STR R13, SP ;PFP to top of the stack
        ADI SP, #-4 ;Adjust stack Pointer to new top

        ADI R14, #24 ; SETTING RET ADDRS
        STR R14, FP
        JMP CONT5 ; going back to call GETDAT

AR8     MOV R13, FP ;Save fp in r13, so r3=pfp
        MOV FP, SP ;point at current AR
        ADI SP, #-4 ;Adjust stack Pointer to new top (return addrs)
        STR R13, SP ;PFP to top of the stack
        ADI SP, #-4 ;Adjust stack Pointer to new top

        ADI R14, #24 ; SETTING RET ADDRS
        STR R14, FP
        JMP LSTCALL ; going back to call GETDAT

GETDAT  LDR R5, CNT ;cnt
        MOV R6, R5
        LDR R7, SIZE
IF4     CMP R6, R7
        BRZ R6, ELSE4 ;r6 is free again here
        MOV R6, R0 ; getting c[]
        ADD R6, R5 ;moving to address c[cnt]
        TRP #4     ;getchar()
        STB R3, R6 ;c[cnt] = getchar()
        ADI R5, #1 ;cnt ++
        STR R5, R1
        LDR R3, CNT
        TRP #3
        JMP OUT2
ELSE4   JMP PRINT2
CONT8   MOV R11, PC ; getting current pc to set ret addrs
        JMP AR3 ; Activation record for flush
CONT9   JMP FLUSH
OUT2    MOV SP, FP ; dealloc
        ADI R13, #-4
        MOV FP, R13
        JMR R14

; Using r12 as pfp for this funct
AR3     MOV R12, FP ;Save fp in r13, so r3=pfp
        MOV FP, SP ;point at current AR
        ADI SP, #-4 ;Adjust stack Pointer to new top (return addrs)
        STR R12, SP ;PFP to top of the stack
        ADI SP, #-4 ;Adjust stack Pointer to new top

        ADI R11, #24 ; SETTING RET ADDRS
        STR R11, FP
        JMP CONT9 ; going back to call GETDAT

FLUSH   MOVI R5, #0
        STB R5, DATA
        TRP #4
        STB R3, R0
WHILE4  LDB R5, R0
        CMPI R5, #10
        BRZ R5, ENDWHL4
        TRP #4
        STB R3, R0
        JMP WHILE4
ENDWHL4 MOV SP, FP ; dealloc
        ADI R11, #-4
        MOV FP, R13
        JMR R11

AR4     MOV R13, FP ;Save fp in r13, so r13=pfp
        MOV FP, SP ;point at current AR
        ADI SP, #-4 ;Adjust stack Pointer to new top (return addrs)
        STR R13, SP ;PFP to top of the stack
        ADI SP, #-4 ;Adjust stack Pointer to new top
        ; passed by value params
        LDB R5, R0 ; first param c[0]
        STR R5, SP
        ADI SP, #-4 ;Adjust stack Pointer to new top

        LDR R5, R2 ; 2ND param tenth
        STR R5, SP
        ADI SP, #-4 ;Adjust stack Pointer to new top

        MOV R5, R1 ; 3RD param C[cnt]
        MOV R6, R0
        ADD R6, R5
        LDB R5, R6
        STR R5, SP
        ADI SP, #-4 ;Adjust stack Pointer to new top

        ADI R14, #24 ; SETTING RET ADDRS
        STR R14, FP
        JMP CONT3 ; going back to call opd()
OPD     TRP #0

PRINT1  MOVI R3, #79 ;O
        TRP #3
        MOVI R3, #112 ;p
        TRP #3
        MOVI R3, #101 ;e
        TRP #3
        MOVI R3, #114 ;r
        TRP #3
        MOVI R3, #97 ;a
        TRP #3
        MOVI R3, #110 ;n
        TRP #3
        MOVI R3, #100 ;d
        TRP #3
        MOVI R3, #112 ;p
        TRP #3
        MOVI R3, #32 ;\s
        TRP #3
        MOVI R3, #105 ;i
        TRP #3
        MOVI R3, #115 ;s
        TRP #3
        MOVI R3, #32 ;\s
        TRP #3
        LDB R3, OPDV
        TRP #3
        MOVI R3, #10 ;\n
        TRP #3
        JMP CONT4

PRINT2  MOVI R3, #78 ; N
        TRP #3
        MOVI R3, #117 ;u
        TRP #3
        MOVI R3, #109 ;m
        TRP #3
        MOVI R3, #98 ;b
        TRP #3
        MOVI R3, #101 ;e
        TRP #3
        MOVI R3, #114 ;r
        TRP #3
        MOVI R3, #32 ;\s
        TRP #3
        MOVI R3, #116 ;t
        TRP #3
        MOVI R3, #111 ;o
        TRP #3
        TRP #3
        MOVI R3, #32 ;\s
        TRP #3
        MOVI R3, #98 ;b
        TRP #3
        MOVI R3, #105 ;i
        TRP #3
        MOVI R3, #103 ;g
        TRP #3
        MOVI R3, #10 ;\n
        TRP #3
        JMP CONT8

EXIT    TRP #0