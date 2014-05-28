//-------------------------------------------------------------------
#include <a573.h>
//-------------------------------------------------------------------
 
Display3Segs::Display3Segs (int p1,int p2,int p3,int p4,int p5,
							int p6,int p7, int p8,int  p9,int  p10)
{
	pa = p7; pb = p6; pc = p3; pd = p2; pe = p1; pf = p5; pg = p4;
	sel[0] = p8; sel[1] = p9; sel[2] = p10;
	
	value = 0;
	 
	pinMode(pa, OUTPUT);
	pinMode(pb, OUTPUT);
	pinMode(pc, OUTPUT);
	pinMode(pd, OUTPUT);
	pinMode(pe, OUTPUT);
	pinMode(pf, OUTPUT);
	pinMode(pg, OUTPUT);
	 
	for (int i=0; i<3; i++) {
		pinMode(sel[i], OUTPUT);
	}	 
}

//-------------------------------------------------------------------

void Display3Segs::SetNumber(int number)
{
	value = number;
	if (value < 0) { value = 0; }
	if (value > 999) { value = 999; }
	Update();
}

//-------------------------------------------------------------------

void Display3Segs::Update(int number)
{
	SetNumber(number);
	Update();
}

//-------------------------------------------------------------------

void Display3Segs::Update(void)
{
	// calcula os 3 digitos (unidade, dezena e centana)
	int digit[3];
	digit[0] = value / 100;
	digit[1] = (value - digit[0] * 100) / 10;
	digit[2] = (value - digit[0] * 100 - digit[1] * 10);
	 
	// varre os 3 digitos do display
	for (int d=0; d<3; d++) {
		// Liga o display 'd', 
		// ao mesmo tempo em que desliga os outros 2
		for (int i=0; i<3; i++) {
			digitalWrite(sel[i], d == i);
		}
		// exibe o caracter correspondente ao display 'd' 
		// (unidade, dezena ou centena)
		DisplayDigit(digit[d]);
		delay(10);
	}
}
 
//-------------------------------------------------------------------
 
void Display3Segs::DisplayDigit(int d)
{
	switch (d) {
		case 0:
			digitalWrite(pa, 0);
			digitalWrite(pb, 0);
			digitalWrite(pc, 0);
			digitalWrite(pd, 0);
			digitalWrite(pe, 0);
			digitalWrite(pf, 0);
			digitalWrite(pg, 1);
		break;
		 
		case 1:
			digitalWrite(pa, 1);
			digitalWrite(pb, 0);
			digitalWrite(pc, 0);
			digitalWrite(pd, 1);
			digitalWrite(pe, 1);
			digitalWrite(pf, 1);
			digitalWrite(pg, 1);
		break;
		 
		case 2: 
			digitalWrite(pa, 0);
			digitalWrite(pb, 0);
			digitalWrite(pc, 1);
			digitalWrite(pd, 0);
			digitalWrite(pe, 0);
			digitalWrite(pf, 1);
			digitalWrite(pg, 0);
		break;
		 
		case 3: 
			digitalWrite(pa, 0);
			digitalWrite(pb, 0);
			digitalWrite(pc, 0);
			digitalWrite(pd, 0);
			digitalWrite(pe, 1);
			digitalWrite(pf, 1);
			digitalWrite(pg, 0);
		break;
		 
		case 4: 
			digitalWrite(pa, 1);
			digitalWrite(pb, 0);
			digitalWrite(pc, 0);
			digitalWrite(pd, 1);
			digitalWrite(pe, 1);
			digitalWrite(pf, 0);
			digitalWrite(pg, 0);
		break;
		 
		case 5:
			digitalWrite(pa, 0);
			digitalWrite(pb, 1);
			digitalWrite(pc, 0);
			digitalWrite(pd, 0);
			digitalWrite(pe, 1);
			digitalWrite(pf, 0);
			digitalWrite(pg, 0);
		break;
		 
		case 6:
			digitalWrite(pa, 0);
			digitalWrite(pb, 1);
			digitalWrite(pc, 0);
			digitalWrite(pd, 0);
			digitalWrite(pe, 0);
			digitalWrite(pf, 0);
			digitalWrite(pg, 0);
		break;
		 
		case 7:
			digitalWrite(pa, 0);
			digitalWrite(pb, 0);
			digitalWrite(pc, 0);
			digitalWrite(pd, 1);
			digitalWrite(pe, 1);
			digitalWrite(pf, 1);
			digitalWrite(pg, 1);
		break;
		 
		case 8:
			digitalWrite(pa, 0);
			digitalWrite(pb, 0);
			digitalWrite(pc, 0);
			digitalWrite(pd, 0);
			digitalWrite(pe, 0);
			digitalWrite(pf, 0);
			digitalWrite(pg, 0);
		break;
		 
		case 9:
			digitalWrite(pa, 0);
			digitalWrite(pb, 0);
			digitalWrite(pc, 0);
			digitalWrite(pd, 0);
			digitalWrite(pe, 1);
			digitalWrite(pf, 0);
			digitalWrite(pg, 0);
		break;
		 
		default:
			digitalWrite(pa, 1);
			digitalWrite(pb, 1);
			digitalWrite(pc, 1);
			digitalWrite(pd, 1);
			digitalWrite(pe, 1);
			digitalWrite(pf, 1);
			digitalWrite(pg, 1);
	}
}
 
//------------------------------------------------------------------- 

 
