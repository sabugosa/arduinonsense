//-------------------------------------------------------------------

/*
	a573h libary
	Controls a triple 7-segment display
	
	Author: Alex Porto
	Date: 27-May-2014
	License: GPL v3
*/

//-------------------------------------------------------------------
#ifndef DISPLAY_TRIPLE_H__
#define DISPLAY_TRIPLE_H__

//-------------------------------------------------------------------

#include <arduino.h>

//-------------------------------------------------------------------

class Display3Segs {
public:
	Display3Segs (int p1,int p2,int p3,int p4,int p5,int p6,int p7, int p8,int  p9,int  p10);
	void Update(void);
	void Update(int number);
	void SetNumber(int number);
  
private:
	void DisplayDigit(int d);
	int pa, pb, pc, pd, pe, pf, pg, sel[3];
	int value;
};

//-------------------------------------------------------------------
#endif
//-------------------------------------------------------------------