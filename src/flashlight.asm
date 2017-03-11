#include "p10F322.inc"

    __CONFIG _FOSC_INTOSC & _BOREN_OFF & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _LVP_ON & _LPBOR_OFF & _BORV_LO & _WRT_OFF

    CBLOCK 0x40
    KEY0
    KEY1
    MODE
    I
    J
    ADCFVR
    ADCAN2
    ENDC

RES_VECT CODE 0x00
    goto START

MAIN_PROG CODE

START
    clrf LATA
    movlw b'00000100'
    movwf ANSELA

    movlw b'11111111'
    movwf PR2
    clrf PWM2DCL
    clrf PWM2DCH
    clrf TMR2
    movlw b'11000000'
    movwf PWM2CON
    movlw b'00000101'
    movwf TRISA

    movlw b'10000001'
    movwf FVRCON

    movlw d'100'
    movwf I
LOOPI
    movwf J
LOOPJ
    decfsz J,F
    goto LOOPJ
    decfsz I,F
    goto LOOPI

TEST
    movlw b'10100101'
    subwf KEY0,W
    btfss STATUS,Z
    goto INIT

    movlw b'01011010'
    subwf KEY1,W
    btfss STATUS,Z
    goto INIT

    goto SWITCH

INIT
    movlw b'10100101'
    movwf KEY0
    movlw b'01011010'
    movwf KEY1
    clrf MODE

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
    movlw b'01011101'
    movwf ADCON
    movlw d'10'
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
    movlw d'10'
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
    rrf ADCFVR,W
    movwf ADCFVR
    subwf ADCAN2,F
    btfss STATUS,C
    goto STOP

    bcf STATUS,C
    rrf ADCFVR,W
    movwf ADCFVR
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
