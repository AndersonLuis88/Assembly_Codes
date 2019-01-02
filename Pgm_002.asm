.MODEL SMALL
.STACK
.DATA

    texto1 DB 'Valor entre 0 e 8 para o primeiro registrador...: ','$'
    texto2 DB 0AH,'Valor entre 0 e 8 para o segundo registrador....: ','$'
    texto3 DB 0AH,'---',0AH,'Se primeiro registrador for maior que o segundo. primeiro recebe +1',0AH,'Se n?o segundo registrador recebe -1',0AH,'---','$'
    texto4 DB 0AH,'O Novo valor para o primeiro registrador...: ','$'
    texto5 DB 0AH,'O Novo valor para o segundo registrador....: ','$'
    texto6 DB 0AH,'Valor inv?lido','$'

.CODE

PROG_002 PROC

    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,texto1 ; armazena o valor no registrador
    CALL EXIBIR
    CALL RECEBER
    CMP AL,39H
    JE DIG_9
    PUSH AX
    
    LEA DX,texto2 ; armazena o valor no registrador
    CALL EXIBIR     ; Chama o proc EXIBIR
    CALL RECEBER   ; Chama o proc RECEBER
    MOV BX,AX
    
    LEA DX,texto3 ; armazena o valor no registrador
    CALL EXIBIR     ; Chama o proc EXIBIR
    POP AX
    CALL CONDICIONAL
    CALL TERMINA
    
    EXIBIR:
        MOV AH,09H
        INT 21H
        RET
        
    RECEBER:
    MOV AH,01H      ; Fun??o para exibir na tela 
    INT 21H         ; para o procedimento
        RET         ; Retorna para o procedimento que chamou
        
    CONDICIONAL:
        CMP AX,BX
        JG REG_1
        JNG REG_2
        
        REG_1:
        LEA DX,texto4
            CALL EXIBIR
            INC AX
            MOV DX,AX
            CALL RETORNO
           RET
            
        REG_2:
        LEA DX,texto5  ; armazena o valor no registrador
        CALL EXIBIR ; Chama o proc EXIBIR
            DEC BX
            MOV DX,BX
            CALL RETORNO
           RET
            
    RETORNO:
        MOV AH,02H
        INT 21H
        RET
        
    DIG_9:
        LEA DX,texto6 ; armazena o valor no registrador
        CALL EXIBIR
        CALL TERMINA
        
    TERMINA:
        MOV AH,4CH
        INT 21H
    
        END PROG_002