#include "p10F322.inc"

    __CONFIG _FOSC_INTOSC & _BOREN_OFF & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _LVP_ON & _LPBOR_OFF & _BORV_LO & _WRT_OFF

KEY0 EQU h'40'
KEY1 EQU h'41'
MODE EQU h'42'
I    EQU h'43'
J    EQU h'44'

RES_VECT CODE 0x0000
    GOTO START

MAIN_PROG CODE

START
    clrf LATA
    clrf ANSELA

    movlw b'11111111'
    movwf PR2
    clrf PWM2DCL
    clrf PWM2DCH
    clrf TMR2
    movlw b'11000000'
    movwf PWM2CON
    movlw b'00000101'
    movwf TRISA

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
    movlw h'AB'
    subwf KEY0,W
    btfss STATUS,Z
    goto INIT

    movlw h'CD'
    subwf KEY1,W
    btfss STATUS,Z
    goto INIT

    goto SWITCH

INIT
    movlw h'AB'
    movwf KEY0
    movlw h'CD'
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
    GOTO LOOP

    END
