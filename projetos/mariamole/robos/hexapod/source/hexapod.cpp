//---------------------------------------------------------------------------

#include "mariamole_auto_generated.h"

//---------------------------------------------------------------------------
int led = 1;

// ora=dat, yel=cmd, gre=att, blu=clk
#define PS2_DAT        8 //8//13  //14    
#define PS2_CMD        9 //9//11  //15
#define PS2_ATT        10 //10//10  //16
#define PS2_CLK        12 //11//12  //17	

int error, type;

PS2X ps2x;

void setup() {                
	pinMode(led, OUTPUT);
	delay(300);	
	error = ps2x.config_gamepad(PS2_CLK, PS2_CMD, PS2_ATT, PS2_DAT);
	type = ps2x.readType(); 
}

//---------------------------------------------------------------------------

void MoveMotor(unsigned char motor, int dir)
{
	unsigned char m1 = 5;
	unsigned char m2 = 6;
	
	if (motor == 1) {
		m1 = 3;
		m2 = 11;
	}

	if (dir == 255) { // brake
		digitalWrite(m1, HIGH);
		digitalWrite(m1, HIGH);
	} else {
		if (dir == 0) {
			digitalWrite(m1, LOW); // coast
			digitalWrite(m2, LOW);
		} else {
			if (dir < 0) {
				digitalWrite(m1, HIGH); // forward
				digitalWrite(m2, LOW);
			} else {
				digitalWrite(m1, LOW); // backward
				digitalWrite(m2, HIGH);
			}
		}
	}
}

void loop() 
{
	if(error == 1) {//skip loop if no controller found
		return; 
	}

	if (type != 2) {     
		ps2x.read_gamepad(false, 0); //read controller and set large motor to spin at 'vibrate' speed
		
		int side = 0;
		if (ps2x.Analog(PSS_LX) > 140) {
			side = -1;
		} else if (ps2x.Analog(PSS_LX) < 116) {
			side = 1;
		}
		int direction = 0;
		if (ps2x.Analog(PSS_LY) > 140) {
			direction = -1;
		} else if (ps2x.Analog(PSS_LY) < 116) {
			direction = 1;
		}
		
		MoveMotor (0, direction);
		MoveMotor (1, side);
	}
  
	delay(50); 
	
/*
	MoveMotor (0, 1);
	delay(1000);            	
	MoveMotor (0, -1);
	delay(1000);            	

	MoveMotor (1, 1);
	delay(1000);            	
	MoveMotor (1, -1);
	delay(1000);            	
*/
}

//---------------------------------------------------------------------------