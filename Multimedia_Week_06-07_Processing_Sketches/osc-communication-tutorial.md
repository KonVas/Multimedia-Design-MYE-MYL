# OSC Interaction Tutorial
OSC protocol is used for communicating with local or remote computers while working on interactive media. 
A standard scenario is to connect two applications, which create audio <> visuals, for example Processing and SuperCollider.
Below we will create a reciprocal interaction between these two. To establish this, first we need to know in which address and port
the two apps are listening too. 

Assuming we are working in our computers, the address of the remote application is the local host, or `127.0.0.1`.
In case we wanted to send to another computer we would need to know its IP address. 
The other thing we need to know is the port, that the application is listening to for incoming messages. In SuperCollider, this is by default `57120`.

## Sending OSC Messages
Now, providing we have these information at hand, let's create map some values from Processing and send them in SC.
Open a new file on a newly created Processing sketch. In the file, import the OSC library which we will use for the OSC communication.

Add this: 
``js 
import netP5.*; //this is a dependancy of OSC.
import oscP5.*;
```

Or, go to Processing Menu, Sketch, and Import and choose the library oscP5 (you must have already installed it on your computer).
This two lines will create two things, it will load the oscP5 lib and its necessary dependancies that are required by the library to make it work. Dependancies of a Library is some other Lib that the one you are using requires in order to run.

Then declare the variables which will be used inside your program. We will attempt to use the keyboards keys of the computer in order to trigger some sound in SC.

Add this:
```java 
int keyValue = 100;
float m;
char letter = 'A';

OscP5 oscP5;
NetAddress myRemoteLocation;
```

Then we will create a standard function in Processing, which will set up the necessary elements for our sketch building.
```java 
void setup() {
  size(200, 200);
  frameRate(25);
  
  oscP5 = new OscP5(this, 12000); //12000 is Proc's Port.
  
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);
  println(oscP5);
};
```
The setup function add the following, as normal: size of your sketch, the frame rate but also the OSC object of the library communication. Comment provides an additional information about the port of Processing, or in which port is listening for incoming messages.
Next is the address information of the remote location, which we are targeting. It is the SC address and port which is listening, since we working in the same machine the address will be localhost.

Furthermore, there is a function which adds the settings for the sketch box, including background color text size etc.
```java
void draw() {
  background(155);
  textSize(32);
  textSize(20);
  text("You pressed: ", 42, 80);
  text(letter, 170, 80);
  text("Value: ", 52, 100);
  text(keyValue, 110, 100); 
};
```

In order to be able to detect which key was pressed on the keyboard, we will use a given function from Processing named `keyPressed` and as the name suggests, everytime we will press a key it will tap out the information of the key that was pressed.
```java
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
```
Inside this function, there are couple of things that we must take a look. First thing is the key value, we will be able to assign this to a variable and then pass its value to the OSC message.
Accordingly we will do the same with the letter of the key and pass it on. For non-acii[1] keys you must use another function named `keyCode`.
In addition to this, I will create a conditional pass of the information based in their characters, for example SHIFT key will be treated as a special button in my sketch.
After that I will wrap everything I added in my message using the `msg.add` method and send it using `oscP5.send(msg, myRemoteLocation);` this is SC in this case.

Finally, I am making a function with which I will be able to receive the messages from SC.
```java
/*Receive OSC from outside using the oscEvent method*/
void oscEvent(OscMessage msg) { 
  println(" Received an OSC message: " + msg.get(0));
};
```

Now we are done in Processing configuration let's take a look on SC how to receive the OSC data.

First we will create an OSC function which serves as the receiver of the messages from Processing:
```java
OSCdef(\playNotes, {|msg|
		var note, ascii;
		note = msg[1];
		ascii = msg[2];
		Synth(\playNotes, [ \note, note.midicps ]);
	}, '/key/value');
  ```
  This above, is listening for the same exact string path of the sender: `'/key/value` (check in Processing to make sure). If these don't match then there won't be any connection.
  Inside our OSC function we are parsing the incoming messages since they arrive as an array format, that is `[msg1, msg2]` and assigning them to variables respectively. Next is the synth that we are mapping the messages.

References
<http://www.sojamo.de/libraries/oscP5/>
<https://www.google.com/search?client=firefox-b-d&q=OSC+communication>
[^1] For Non ascii keys, such as SHIFT, BACKSPACE etc. Check here: <https://processing.org/reference/keyCode.html>
