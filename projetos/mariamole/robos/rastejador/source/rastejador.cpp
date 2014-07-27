#include "mariamole_auto_generated.h"
// Sweep
// by BARRAGAN <http://barraganstudio.com> 
// This example code is in the public domain.


#include <Servo.h> 
 
Servo yaw, roll;

#define MAX_ROLL		15
#define MAX_YAW			30
#define CENTER_ROLL		130
#define CENTER_YAW		50
                

void setup() 
{ 
	yaw.attach(9);  
	roll.attach(11);
} 
  
void loop() 
{ 
	int delayServo = 15;
	for (int i = 0; i < MAX_ROLL; i++) {
		roll.write(CENTER_ROLL + i);
		delay(delayServo);      
	} 
	for (int i = 0; i < MAX_YAW; i++) {
		yaw.write(CENTER_YAW - i);
		delay(delayServo);      
	} 
	
	for (int i = 0; i < MAX_ROLL; i++) {
		roll.write(CENTER_ROLL - i);
		delay(delayServo);      
	} 
	for (int i = 0; i < MAX_YAW; i++) {
		yaw.write(CENTER_YAW + i);
		delay(delayServo);      
	}   
} 
