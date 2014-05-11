/*************************************************************
project: Exemplo de uso da biblioteca Mallandro
author: Alex Porto
description: 
*************************************************************/

#include "example.h"
#include <Mallandro.h>

// Cria um objeto Mallandro, usando os seguintes pinos:
// 	11 - Saida de audio: Pode ser qualquer pino com suporte a PWM (3,5,6,9,10 ou 11)
//	12 - Saida que sera ativada somente quando o som estiver tocando. No exemplo, usamos
//       a porta 13, para ativar o led embutido na placa Arduino
Mallandro mallandro(11, 13);

void setup()
{
	// Inicializa a classe Mallandro
	mallandro.Initialize();
	
	pinMode(2, INPUT);	
}

void loop()
{
	// Lendo um push-button ligado a porta 2 do arduino. 
	// Recomenda-se usar um resistor pull-down para evitar leituras erroneas
	bool button2 = (digitalRead(2) == HIGH);
	
	// Mallandro.Play(boolean playNow) pode ser chamada a qualquer momento. 
	// Mas so ira reproduzir o audio se
	// a) playNow for true
	// b) Ja tiver terminado de reproduzir o audio da ultima vez
	// 
	// Para parar uma reproducao no meio, use Mallandro.Stop();
	mallandro.Play(button2);
}


