void setup() 
{
  Serial.begin(115200);//31250);
}

void loop() 
{
  for (int note = 0x1E; note < 0x5A; note ++) {
    noteOn(0x90, note, 0x45);
    delay(300);
    noteOn(0x80, note, 0x00);   
    delay(300);
  }
}
void noteOn(int cmd, int pitch, int velocity) 
{
  Serial.write(cmd);
  Serial.write(pitch);
  Serial.write(velocity);
}

