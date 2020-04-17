import netP5.*;
import oscP5.*;

OscP5 oscP5;
NetAddress SuperCollider;

int rgb= 255;

void setup(){
  size(600,480);
  oscP5 = new OscP5(this, 8080);
  SuperCollider = new NetAddress("127.0.0.1", 57120);
  println(oscP5);
};

void draw(){
  background(rgb);
};

void mousePressed(){
  OscMessage msg = new OscMessage("/mouse/pressed");
  
  msg.add(rgb);
  
  oscP5.send(msg, SuperCollider);                                            
}

//OSC Forwarder to SC:

void oscEvent(OscMessage message){
  /*print anything received in Proc*/
 
  OscMessage msg = new OscMessage("/rgb/freq");
  
  int msgToInt = message.get(0).intValue();
  
  float mapInt = map(msgToInt, 0, 255, 120.0, 1220.0);
  
  msg.add(mapInt); //mapping to a new range and send back to SC.
  
  oscP5.send(msg, SuperCollider);
  
  rgb = msgToInt;
  
  print( message.get(0) );
}
