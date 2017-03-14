#include "p10F322.inc"

    __CONFIG _FOSC_INTOSC & _BOREN_OFF & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _LVP_ON & _LPBOR_OFF & _BORV_LO & _WRT_OFF

VARS UDATA 0x40
TEST RES 1
MODE RES 1
ADCAN2 RES 1

RESET CODE 0x0000
    goto START

MAIN CODE

START
    clrf LATA
    clrf PORTA
    bcf ANSELA,1
    bcf TRISA,1

    ; 500 kHz clock
    movlw b'00100000'
    movwf OSCCON

    ; 1:32 prescaler
    movlw b'11010100'
    movwf OPTION_REG
    clrf TMR0
    bcf INTCON,TMR0IF

DEBOUNCE
    ; wait 65 ms
    btfss INTCON,TMR0IF
    goto DEBOUNCE
    bcf INTCON,TMR0IF

    ; select mode
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
    bsf ANSELA,1
    goto LOOP

MODE2
    btfss MODE,1
    goto MODE1
    movlw b'11000000'
    movwf PWM2DCL
    movlw b'00011111'
    movwf PWM2DCH
    goto PWM

MODE1
    movlw b'01000000'
    movwf PWM2DCL
    clrf PWM2DCH

PWM
    ; start PWM
    movlw b'11000000'
    movwf PWM2CON
    bsf T2CON,TMR2ON

LOOP
    ; wait 65 ms
    btfss INTCON,TMR0IF
    goto LOOP
    bcf INTCON,TMR0IF

    ; 1.024 V FVR
    bsf FVRCON,FVREN
    bsf FVRCON,ADFVR0

    ; measure AN2
    movlw b'00001001'
    movwf ADCON
    call MEASUREMENT
    movwf ADCAN2

    ; measure FVR
    movlw b'00011101'
    movwf ADCON
    call MEASUREMENT

    clrf ADCON
    bcf FVRCON,ADFVR0
    bcf FVRCON,FVREN

    ; sleep if AN2 is less than FVR
    subwf ADCAN2,F
    btfsc STATUS,C
    goto LOOP
    bcf T2CON,TMR2ON
    clrf PWM2CON
    bcf ANSELA,1
    bcf TRISA,1
    bsf VREGCON,VREGPM1
    sleep

MEASUREMENT
    bsf ADCON,GO_NOT_DONE
CONVERSION
    btfsc ADCON,GO_NOT_DONE
    goto CONVERSION
    movf ADRES,W
    return

    END
