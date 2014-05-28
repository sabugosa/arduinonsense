#include "teste_display_triplo_main.h"

Display3Segs display(11,10,9,8,7,6,5,4,3,2);
float d=0;

void setup() 
{                
}

void loop() {
	d = d + 0.1;
	display.Update(d);
}
