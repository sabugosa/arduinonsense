//-------------------------------------------------------------------
#ifndef __mallandro_H__
#define __mallandro_H__
//-------------------------------------------------------------------

#include <arduino.h>
#include <pcm.h>

//-------------------------------------------------------------------

class Mallandro {	
	public: 
		Mallandro(char soundPin, char ledPin);
		void Initialize(void);
		void Play(bool playNow);
		void Stop(void);
	
	private:
		bool playing;
		char ledPort;
		char soundPort;
		unsigned long lastTime;
		unsigned long delayTime;
};

//-------------------------------------------------------------------
#endif
//-------------------------------------------------------------------
