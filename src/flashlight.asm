#include "p10F322.inc"

    __CONFIG _FOSC_INTOSC & _BOREN_OFF & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _LVP_ON & _LPBOR_OFF & _BORV_LO & _WRT_OFF

GPR_VARS UDATA 0x40
TEST RES 1
MODE RES 1
FLAGS RES 1
I RES 1
ADCFVR RES 1
ADCAN2 RES 1

INT_VARS UDATA 0x70
TMP_STATUS RES 1
TMP_W RES 1

RES_VECT CODE 0x0000
    goto START

INT_VECT CODE 0x0004
    movwf TMP_W
    swapf STATUS,W
    movwf TMP_STATUS

    btfss INTCON,2
    goto DONE
    bsf FLAGS,0
    bcf INTCON,2
DONE
    swapf TMP_STATUS,W
    movwf STATUS
    swapf TMP_W,F
    swapf TMP_W,W
    retfie

MAIN_PROG CODE

START
    clrf LATA
    movlw b'00000100'
    movwf ANSELA

    clrf FLAGS
    movlw b'10000111'
    movwf OPTION_REG
    movlw b'10100000'
    movwf INTCON

    movlw b'11111111'
    movwf PR2
    clrf PWM2DCL
    clrf PWM2DCH
    clrf TMR2
    movlw b'11000000'
    movwf PWM2CON
    movlw b'00001101'
    movwf TRISA

    movlw b'10000001'
    movwf FVRCON

DEBOUNCE
    btfss FLAGS,0
    goto DEBOUNCE
    bcf FLAGS,0

    movlw b'10101010'
    subwf TEST,F
    btfss STATUS,Z
    clrf MODE
    movwf TEST

SWITCH
    incf MODE,F
    movf MODE,W
    xorlw 1
    bz MODE1
    xorlw 2^1
    bz MODE2
    xorlw 3^2
    bz MODE3

MODE1
    movlw b'01000000'
    movwf PWM2DCL
    clrf PWM2DCH
    goto PWM

MODE2
    movlw b'11000000'
    movwf PWM2DCL
    movlw b'00000011'
    movwf PWM2DCH
    goto PWM

MODE3
    clrf MODE
    bsf TRISA,1
    goto LOOP

PWM
    movlw b'00000100'
    movwf T2CON

LOOP
    btfss FLAGS,0
    goto LOOP
    bcf FLAGS,0

    movlw b'01011101'
    movwf ADCON
    movlw d'3'
    movwf I
DELAY1
    decfsz I,F
    goto DELAY1
    bsf ADCON,GO_NOT_DONE
DELAY2
    btfsc ADCON,GO_NOT_DONE
    goto DELAY2
    movf ADRES,W
    movwf ADCFVR

    movlw b'01001001'
    movwf ADCON
    movlw d'3'
    movwf I
DELAY3
    decfsz I,F
    goto DELAY3
    bsf ADCON,GO_NOT_DONE
DELAY4
    btfsc ADCON,GO_NOT_DONE
    goto DELAY4
    movf ADRES,W
    movwf ADCAN2

    bcf STATUS,C
    rrf ADCFVR,F
    movf ADCFVR,W
    subwf ADCAN2,F
    btfss STATUS,C
    goto STOP

    bcf STATUS,C
    rrf ADCFVR,F
    movf ADCFVR,W
    subwf ADCAN2,F
    btfss STATUS,C
    goto STOP

    goto LOOP

STOP
    clrf T2CON
    clrf PWM2CON
    bcf TRISA,1
    bcf PORTA,1
    sleep

    END
