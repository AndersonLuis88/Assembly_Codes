.MODEL SMALL
.STACK
.DATA

    texto1 DB 'Valor do Primeiro Registrador...: ','$'
    texto2 DB 0AH,'Valor do Segundo Registrador....: ','$'
    texto3 DB 0AH,'---',0AH,'Se iguais soma 1 ao Primeiro',0AH,'Se diferentes, subtra? do Segundo',0AH,'---',0AH,'Valor do Primeiro...: ','$'
    texto4 DB 0AH,'Valor do Segundo....: ','$'

.CODE

PROG_001 PROC

    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,texto1
    CALL Tela
    CALL RECEBER
    PUSH AX
    
    LEA DX,texto2
    CALL Tela
    CALL RECEBER
    MOV BX,AX
    
    LEA DX,texto3
    CALL Tela
    POP AX
    CALL CONDICIONAL
    MOV DX,AX
    CALL RETORNO
    
    LEA DX,texto4
    CALL Tela
    MOV DX,BX
    CALL RETORNO
    
    
    MOV AH,4CH
    INT 21H
    
    Tela:
        MOV AH,09H
        INT 21H
        RET
        
    RECEBER:
        MOV AH,01H
        INT 21H
        RET
        
    CONDICIONAL:
        CMP AX,BX
        JE REG_1
        JNE REG_2
        
        REG_1:
            INC AX
            RET
        REG_2:
            DEC BX
            RET
            
    RETORNO:
        MOV AH,02H
        INT 21H
        RET
        
END PROG_001