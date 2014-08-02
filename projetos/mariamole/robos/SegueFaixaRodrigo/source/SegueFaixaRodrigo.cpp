#include "mariamole_auto_generated.h"
#include <EEPROM.h>
#include <seguefaixa.h>


//#define velFrente 0.4

//#define velCorrige 0.2

float velFrente;

float velCorrige;

const int en1 = 7;
const int m1a = 6;
const int m1b = 5;
const int m2a = 4;
const int m2b = 3;
const int en2 = 2;

int led = 8;
int limiarDireita, limiarEsquerda, limiarMeio;
int liga;
int num = 10;
int i, j;
int mDireita, mMeio, mEsquerda;
float bateria, monitora;

int ldr1 = A1;
int ldr2 = A2;
int ldr3 = A3;
int direita, meio, esquerda;

void leSensores()
{
  direita = analogRead(ldr1);
  meio = analogRead(ldr2);
  esquerda = analogRead(ldr3);
  direita = map(direita, 0, 1023, 0, 255);
  meio = map(meio, 0, 1023, 0, 255);
  esquerda = map(esquerda, 0, 1023, 0, 255);
}
void aviso()
{
  digitalWrite(led, HIGH);
  delay(1000);
  digitalWrite(led, LOW);
  delay(2000);
}
void confAutomatica()
{
  aviso(); 
  medianaSensores(); //Direita
  int d1 = mDireita;//Preto
  int m1 = mMeio;
  int e1 = mEsquerda;//Branco
  aviso(); 
  medianaSensores(); //Esquerda
  int d2 = mDireita;//Branco
  int m2 = mMeio;
  int e2 = mEsquerda;//Preto
  aviso();
  
  limiarDireita = (d1 + d2) / 2;
  limiarMeio = (m1 + m2) / 2;
  limiarEsquerda = (e1 + e2) / 2;
  /*
  Serial.print("BRANCO - d1: ");
  Serial.print(d1);
  Serial.print(" m1: ");
  Serial.print(d1);
  Serial.print(" e1: ");
  Serial.println(e1);
  Serial.print("PRETO - d2: ");
  Serial.print(d2);
  Serial.print(" m2: ");
  Serial.print(m2);
  Serial.print(" e2: ");
  Serial.println(e2);
  
  Serial.print("Limiar Direita: ");
  Serial.println(limiarDireita);
  Serial.print("Limiar Meio: ");
  Serial.println(limiarMeio);
  Serial.print("Limiar Esquerda: ");
  Serial.println(limiarEsquerda);*/
  
  EEPROM.write(0, limiarDireita);
  EEPROM.write(4, limiarMeio);
  EEPROM.write(8, limiarEsquerda);
}

void frente()
{
  analogWrite(m1a,0);  
  analogWrite(m1b,255*velFrente);  
  analogWrite(m2a,0);  
  analogWrite(m2b,255*velFrente*0.9);  
}

void viraDireita()
{
  analogWrite(m1a,0);  
  analogWrite(m1b,255*velCorrige);  
  analogWrite(m2a,0);  
  analogWrite(m2b,255*velFrente*0.9);  
}

void viraEsquerda()
{
  analogWrite(m1a,0);  
  analogWrite(m1b,255*velFrente);  
  analogWrite(m2a,0);  
  analogWrite(m2b,255*velCorrige*0.9);  
}
void mensagem()
{
  Serial.print("Limiar Esquerda: ");
  Serial.println(limiarEsquerda);
  Serial.print("Limiar Direita: ");
  Serial.println(limiarDireita);
  Serial.print(esquerda);
  Serial.print(" ");
  Serial.print(meio);
  Serial.print(" ");
  Serial.println(direita);
  Serial.println(" ");
}
void medianaSensores()
{
  int vD[num], vM[num], vE[num],aux, j;
  for (i = 0; i < num; i++)
  {
    leSensores();    
    vD[i] = direita;
    vM[i] = meio;
    vE[i] = esquerda;
    delay(100);
  }
 
  for (i = 0; i < (num - 1); i++)
  {
      for (j = i + 1; j < num; j++)
      {
        if (vD[i] > vD[j])
        {
          aux = vD[i];
          vD[i] = vD[j];
          vD[j] = aux;
        }
      }
  }
  for (i = 0; i < (num - 1); i++)
  {
      for (j = i + 1; j < num; j++)
      {
        if (vM[i] > vM[j])
        {
          aux = vM[i];
          vM[i] = vM[j];
          vM[j] = aux;
        }
      }
  }
  for (i = 0; i < (num - 1); i++)
  {
      for (j = i + 1; j < num; j++)
      {
        if (vE[i] > vE[j])
        {
          aux = vE[i];
          vE[i] = vE[j];
          vE[j] = aux;
        }
      }
  }
  mDireita = vD[num/ (num/2)];
  mMeio = vM[num/(num/2)];
  mEsquerda = vE[num/(num/2)];
}
void setup() {                
  // initialize the digital pin as an output.
  pinMode(en1, OUTPUT);     
  pinMode(m1a, OUTPUT);     
  pinMode(m1b, OUTPUT);     
  pinMode(en2, OUTPUT);     
  pinMode(m2a, OUTPUT);     
  pinMode(m2b, OUTPUT);
  
  pinMode(led, OUTPUT);
  
  // 2 - direita
  // 1 - esquerda
  digitalWrite(en1,HIGH);
  digitalWrite(en2,HIGH);

  
  Serial.begin(9600);
  leSensores();
  liga = digitalRead(9);
  if(liga == 1){
    confAutomatica();
  }else{
    digitalWrite(led, HIGH);
    delay(200);
    digitalWrite(led, LOW);
    delay(200);
    digitalWrite(led, HIGH);
    delay(200);
    digitalWrite(led, LOW);
    delay(200);
    limiarDireita = EEPROM.read(0);
    limiarMeio = EEPROM.read(4);
    limiarEsquerda = EEPROM.read(8);
  }
}

void loop()
{
  if(liga == 0)
  {
  //bateria = analogRead(A5);
  //monitora = (bateria*9)/1023;
  //Serial.println(monitora); 
  velFrente = 0.4;
  velCorrige = 0;
  
  leSensores();
  if(direita>limiarDireita){
    viraDireita();
  }else if(esquerda>limiarEsquerda){
    viraEsquerda();
  }else{
    frente();
  }
  }
  
  
}



