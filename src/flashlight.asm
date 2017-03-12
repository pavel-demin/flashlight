#include "p10F322.inc"

    __CONFIG _FOSC_INTOSC & _BOREN_OFF & _WDTE_SWDTEN & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _LVP_ON & _LPBOR_OFF & _BORV_LO & _WRT_OFF

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
    clrf PORTA
    clrf TRISA
    clrf ANSELA
    bsf ANSELA,2

    ; 500 kHz clock
    movlw b'00100000'
    movwf OSCCON

    ; 1 V FVR
    bsf FVRCON,FVREN
    bsf FVRCON,ADFVR0

    ; enable ADC interrupt
    bsf PIE1,ADIE

    ; sleep 64 ms
    movlw b'00001101'
    movwf WDTCON
    sleep

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
    movlw b'00111111'
    movwf NCO1INCL
    goto PFM

MODE1
    movlw b'00000111'
    movwf NCO1INCL

PFM
    ; connect NCO to gate 2
    movlw b'01010000'
    movwf CLC1SEL0
    clrf CLC1SEL1
    clrf CLC1GLS0
    clrf CLC1GLS1
    clrf CLC1GLS2
    clrf CLC1GLS3
    bsf CLC1GLS1,3
    ; invert gate 1
    clrf CLC1POL
    bsf CLC1POL,0
    ; enable CLC output
    movlw b'11000000'
    movwf CLC1CON

    clrf NCO1INCH
    clrf NCO1ACCU
    ; 8 us pulse
    movlw b'11100010'
    movwf NCO1CLK
    ; enable PFM
    movlw b'10000001'
    movwf NCO1CON

LOOP
    ; sleep 64 ms
    sleep

    ; measure FVR
    movlw b'11111101'
    movwf ADCON
    call MEASUREMENT
    movwf ADCFVR

    ; measure AN2
    movlw b'11101001'
    movwf ADCON
    call MEASUREMENT
    movwf ADCAN2

    ; stop if AN2 is less than 0.75*FVR
    call COMPARISON
    call COMPARISON

    goto LOOP

MEASUREMENT
    bsf ADCON,GO_NOT_DONE
    sleep
    movf ADRES,W
    return

COMPARISON
    bcf STATUS,C
    rrf ADCFVR,F
    movf ADCFVR,W
    subwf ADCAN2,F
    btfsc STATUS,C
    return
    clrf ADCON
    bcf FVRCON,ADFVR0
    bcf FVRCON,FVREN
    clrf NCO1CON
    clrf CLC1CON
    clrf PORTA
    clrf TRISA
    bcf WDTCON,SWDTEN
    sleep

    END
