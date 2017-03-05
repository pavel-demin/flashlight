#include <xc.h>

#pragma config FOSC = INTOSC // Oscillator Selection bits (INTOSC oscillator: CLKIN function disabled)
#pragma config BOREN = OFF // Brown-out Reset Enable (Brown-out Reset disabled)
#pragma config WDTE = OFF // Watchdog Timer Enable (WDT disabled)
#pragma config PWRTE = OFF // Power-up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = ON // MCLR Pin Function Select bit (MCLR pin function is MCLR)
#pragma config CP = OFF // Code Protection bit (Program memory code protection is disabled)
#pragma config LVP = ON // Low-Voltage Programming Enable (Low-voltage programming enabled)
#pragma config LPBOR = OFF // Brown-out Reset Selection bits (BOR disabled)
#pragma config BORV = LO // Brown-out Reset Voltage Selection (Brown-out Reset Voltage (Vbor), low trip point selected.)
#pragma config WRT = OFF // Flash Memory Self-Write Protection (Write protection off)

#define _XTAL_FREQ 8000000

persistent unsigned int key;
persistent unsigned char mode;

unsigned char pwmh[3] = {0, 3, 255};
unsigned char pwml[3] = {1, 192, 192};

void main()
{
  LATA = 0;
  ANSELA = 0;

  PR2 = 255;
  PWM2DCL = 0;
  PWM2DCH = 0;
  TMR2 = 0;

  PWM2CON = 0b11000000;
  TRISA = 0b00000101;

  __delay_ms(50);

  mode = (key != 12345 || mode >= 2) ? 0 : mode + 1;
  key = 12345;

  PWM2DCL = pwml[mode];
  PWM2DCH = pwmh[mode];

  T2CON = 0b00000100;

  while(1);
}
