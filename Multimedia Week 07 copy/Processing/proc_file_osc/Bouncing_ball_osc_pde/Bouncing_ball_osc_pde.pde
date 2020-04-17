import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress SuperCollider;

int value = 0;
int pos = 100;
int direction = 5;
int leftright = -20;
int directionB = 5;


void setup(){
  size(720, 480);
  frameRate(25);
  smooth();
  stroke(255);
  oscP5 = new OscP5(this, 8080);
  SuperCollider = new NetAddress("127.0.0.1", 57120);
}

void draw() {
  rect(25, 25, 50, 50);
  background(value);
  
  line(0, 400, 720, 400);
  ellipse(leftright, pos, 10, 10);
  
    pos+= direction;
    
    OscMessage msg = new OscMessage("/ball/pos");
  
    if((pos > 339 || pos < 101)) {
      direction *= -1;
      
      /*sending a triggering message 
      every time ball hits down or up:*/
      msg.add(0); //sending an integer to SC
      oscP5.send(msg, SuperCollider);
    };
    
    /*sending a triggering message 
      every time ball hits left or right:*/
    if((leftright < -20) || (leftright > 720)){
      directionB *= -1;
      msg.add(1); //sending an integer to SC
      oscP5.send(msg, SuperCollider);
    };
    
    leftright += directionB;
    
}

// test you sending OSC to SC 
// everytime you press your mouse:
void mousePressed() {
 OscMessage msg = new OscMessage("/test/osc"); 
 oscP5.send(msg, SuperCollider);
}

void oscEvent(OscMessage theOscMessage) {
  
  int incomingMsg = theOscMessage.get(0).intValue();
  
  //replace white (255), same color with bouncing ball.
  if(incomingMsg > 253){
    value = 0;
  } else {
  value = incomingMsg;
  };
  println(value);
}
