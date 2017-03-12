#include "p10F322.inc"

    __CONFIG _FOSC_INTOSC & _BOREN_OFF & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _LVP_ON & _LPBOR_OFF & _BORV_LO & _WRT_OFF

GPR_VARS UDATA 0x40
TEST RES 1
MODE RES 1
ADCFVR RES 1
ADCAN2 RES 1

RES_VECT CODE 0x0000
    goto START

MAIN_PROG CODE

START
    clrf LATA
    movlw b'00000100'
    movwf ANSELA

    ; 1 MHz clock
    movlw b'00110000'
    movwf OSCCON

    ; 1:32 prescaler
    movlw b'10000100'
    movwf OPTION_REG

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
    btfss INTCON,2
    goto DEBOUNCE
    bcf INTCON,2

    movlw b'10101010'
    subwf TEST,F
    btfss STATUS,Z
    clrf MODE
    movwf TEST

    bsf STATUS,C
    rlf MODE,F

MODE3
    btfss MODE,2
    goto MODE2
    clrf MODE
    bsf TRISA,1
    goto LOOP

MODE2
    btfss MODE,1
    goto MODE1
    movlw b'11000000'
    movwf PWM2DCL
    movlw b'00000011'
    movwf PWM2DCH
    goto PWM

MODE1
    movlw b'01000000'
    movwf PWM2DCL
    clrf PWM2DCH

PWM
    movlw b'00000100'
    movwf T2CON

LOOP
    btfss INTCON,2
    goto LOOP
    bcf INTCON,2

    movlw b'10011101'
    movwf ADCON
    call MEASUREMENT
    movwf ADCFVR

    movlw b'10001001'
    movwf ADCON
    call MEASUREMENT
    movwf ADCAN2

    call COMPARISON
    call COMPARISON

    goto LOOP

MEASUREMENT
    bsf ADCON,GO_NOT_DONE
CONVERSION
    btfsc ADCON,GO_NOT_DONE
    goto CONVERSION
    movf ADRES,W
    return

COMPARISON
    bcf STATUS,C
    rrf ADCFVR,F
    movf ADCFVR,W
    subwf ADCAN2,F
    btfsc STATUS,C
    return
    clrf T2CON
    clrf PWM2CON
    bcf TRISA,1
    bcf PORTA,1
    sleep

    END
