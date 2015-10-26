import processing.serial.*;
import ddf.minim.*;

Serial myPort;
Minim minim;
AudioPlayer player;
AudioInput input;

boolean firstContact = false;
float normalized_inByte;
int sensorVal;
int vol;
int inByte;

void setup() {
  size(500, 500);
  printArray(Serial.list());

  // initialize the serial port and set the baud rate to 9600 
  myPort = new Serial(this, Serial.list()[5], 9600);

  // Load a soundfile from the /data folder of the sketch and play it back
  minim = new Minim(this);
  player = minim.loadFile("angry_sound.mp3");
  
  // play sound
  player.loop();   
}

void draw() {
  
  // draw ellipse changing the size
  background(0);
  ellipse(width/2, height/2, sensorVal, sensorVal);
  
  // change the volume
  player.setGain(normalized_inByte);
}

void serialEvent(Serial myPort) {
  int inByte = myPort.read();
  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear();
      firstContact = true;
      myPort.write('A');
    }
  } else {
    println("inByte: " + inByte);
    sensorVal = inByte;
    myPort.write('A');
  }
  normalized_inByte = inByte / 2.5  - 80;
  println("normalized_inByte: " + normalized_inByte);    


}