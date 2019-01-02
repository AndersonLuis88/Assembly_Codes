.MODEL SMALL
.STACK
.DATA

    texto1 DB 'Valor entre 0 e 8: ','$'
    texto2 DB 0AH,'---',0AH,'Fatorial de ','$'
    texto3 DB ' equivale a ','$'
    texto4 DB 0AH,'---',0AH,'valor inv?lido','$'

.CODE

PROGRAMA_3 PROC

    MOV AX,@DATA
    MOV DS,AX
    LEA DX, texto1
    CALL EXIBIR
    CALL ENTRADA
    PUSH AX

    LEA DX, texto2
    CALL EXIBIR
    POP AX
    MOV DL,AL
    CALL RETORNO
    SUB AL,30H
    MOV CL,AL

    LEA DX,texto3
    CALL EXIBIR
    CALL FATORIAL
    CALL VALOR
    CALL TERMINA

    EXIBIR:
        MOV AH,09H
        INT 21H
        RET

    ENTRADA:
        MOV AH,01H
        INT 21H
        CMP AL,30H
        JL  ERRO
        CMP AL,39H
        JGE ERRO
        JMP FIM_VALIDACAO

        ERRO:
        LEA DX,texto4
            CALL EXIBIR
            JMP TERMINA

            FIM_VALIDACAO:
                RET

    RETORNO:
        MOV AH,02H
        INT 21H
        RET
        
    FATORIAL:
        MOV AX,01H
        CMP CX,0H
        JE FIM_LACO

        REPITA1:
            MUL CX
            LOOPNE REPITA1

            FIM_LACO:
                RET

    VALOR:
    PUSH AX     ;coloca na pilha o valor do registrador AX
        MOV BX,0AH
        SUB CX,CX

        REPITA2:
            SUB DX,DX
            DIV BX
            PUSH DX  ;coloca na pilha o valor do registrador DX
            INC CX
            CMP AX,0H
            JNZ REPITA2

    SAIDA:
    POP AX   ;retira da pilha o valor do registrador AX
        ADD AL,30H
        MOV DL,AL
        CALL RETORNO
        DEC CX
        JNBE SAIDA
        POP DX   ;retira da pilha o valor do registrador DX
        RET

    TERMINA:
        MOV AH,4CH
        INT 21H

END PROGRAMA_3