#include <xc.h>

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
