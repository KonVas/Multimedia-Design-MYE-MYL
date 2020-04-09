// Use random timing to call function at specific times

int nextDrop = 5; // when will the first drop fall

void setup() {
  background(50);
  noFill();
  stroke(200);
  size(400, 400);
}

void draw() {
  // int time = millis(); // get the current time each frame
  if (frameCount > nextDrop) {
    drop();
    nextDrop = frameCount + (1 + int(random(60)));
    println(frameCount);
    // println(time);
  }
}

// function that draws a circle
void drop() {
  int xpos = int(random(width));
  int ypos = int(random(height));
  int big = int(random(height/3));
  ellipse(xpos, ypos, big, big);
}