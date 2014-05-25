//-------------------------------------------------------------------
#ifndef __main_H__
#define __main_H__
//-------------------------------------------------------------------

#include <arduino.h>
#include <PS2X_lib.h>

//-------------------------------------------------------------------


#define MAX_LEDS          4      // Maximum number of leds to play
#define DELAY_PLAY_START  1000   // Initial delay during playtime
#define DELAY_PLAY_MIN    100    // Minimum delay during playtime. Delay will decay down to this value
#define DELAY_PLAY_DECAY  50     // Delay decreasing step.
#define BUTTON_START      255
#define BUTTON_1          0
#define BUTTON_2          1 
#define BUTTON_3          2
#define BUTTON_4          3
#define NO_BUTTON         -1

#define PIN_SPEAKER      3
#define PIN_LED_1        10
#define PIN_LED_2        11
#define PIN_LED_3        12
#define PIN_LED_4        13

#define GAMEPAD_CLK      7
#define GAMEPAD_CMD      6
#define GAMEPAD_ATT      5
#define GAMEPAD_DAT      4

#define MAX_SEQUENCE     256

#define TONE_ERROR          956
//-------------------------------------------------------------------


//-------------------------------------------------------------------
#endif
//-------------------------------------------------------------------
