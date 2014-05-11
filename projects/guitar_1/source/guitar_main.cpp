/*************************************************************
project: <type project name here>
author: <type your name here>
description: <type what this file does>
*************************************************************/
 
#include "guitar_main.h"
 
PS2X ps2x;
//byte pin[MAX_LEDS] = {PIN_LED_1, PIN_LED_2, PIN_LED_3, PIN_LED_4};
//int play_tones[MAX_LEDS] = {10, 30, 75, 110};
//byte sequence[MAX_SEQUENCE];
//byte stage;
//int wait;

int melody[] = {
  NOTE_C4, NOTE_G3,NOTE_G3, NOTE_A3, NOTE_G3,0, NOTE_B3, NOTE_C4};
  
int note[6] = {0, NOTE_G4, NOTE_F4, NOTE_E4, NOTE_D4, NOTE_C4};

 
void setup() 
{
	Serial.begin(9600);
	 
	pinMode(PIN_SPEAKER, OUTPUT);
	 
	int error = ps2x.config_gamepad(GAMEPAD_CLK, GAMEPAD_CMD, GAMEPAD_ATT, GAMEPAD_DAT);	
}

int ReadController(void)
{
	ps2x.read_gamepad();	 
	
	int b = -1;
	
	if(ps2x.ButtonPressed(UP_STRUM) || ps2x.ButtonPressed(DOWN_STRUM)) {	
		b = 0;		
		if (ps2x.Button(GREEN_FRET)) {
			b = 1;
		} else if (ps2x.Button(RED_FRET)) {
			if (ps2x.Button(YELLOW_FRET)) {
				b = 3;
			}
			else {
				b = 2;
			}
		} else if (ps2x.Button(BLUE_FRET)) {
			b = 4;
		} else if (ps2x.Button(ORANGE_FRET)) {
			b = 5;
		}
		Serial.println(b);
	}
	
	return b;
}
 
void loop() 
{
	int key = ReadController();
	if (key != -1) {
		if (key == 0 ) {
			noTone(PIN_SPEAKER);
		} else {
			tone(PIN_SPEAKER, note[key], 500);
		}		
	}

}
