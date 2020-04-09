import netP5.*; //this is a dependancy of OSC.
import oscP5.*;

//Send OSC Messages to SuperCollider.
//import the oscP5 lib for OSC protocol.


//Dependancies of a Library is some other Lib that the one
//you are using requires in order to run.

int keyValue = 100;
float m;
char letter = 'A';

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(200, 200);
  frameRate(25);
  
  oscP5 = new OscP5(this, 12000); //12000 is Proc's Port.
  
  /* my remote location is the SC address and port which is listening, since we working in the 
  same machine the address will be localhost.*/
  
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);
  println(oscP5);
};

void draw() {
  background(155);
  textSize(32);
  textSize(20);
  text("You pressed: ", 42, 80);
  text(letter, 170, 80);
  text("Value: ", 52, 100);
  text(keyValue, 110, 100); 
};

void keyPressed() {
  keyValue = int(key);
  letter = char(key);
  OscMessage msg = new OscMessage("/key/value");
  if( keyValue == 65535 ) { //press SHIFT and see what happens.
    background(255); //background changes if SHIFT pressed.
    text("you pressed SHIFT", 10, 90);
  } {
    msg.add(keyValue);
    msg.add(str(letter));
  }
  oscP5.send(msg, myRemoteLocation);
}

/*Receive OSC from outside using the oscEvent method*/
void oscEvent(OscMessage msg) { 
  println(" Received an OSC message: " + msg.get(0));
};

/* For Non ascii keys, such as SHIFT, BACKSPACE etc. 
Check here:https://processing.org/reference/keyCode.html*/
