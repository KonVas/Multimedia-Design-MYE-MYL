// Draw a fading ball where the mouse clicks
ball b1;
// int alpha = 0;
int x, y, size = 10, alpha = 0;

void setup() {
  size(600, 400);
  background(0);
  smooth();
  noStroke();
  fill(0);
  b1 = new ball(100, 100);
}

void draw() {
  background(0);
  b1.drop();
  b1.display();
  if (y > 399) {
    b1.explode();
  }
}


void mouseClicked() {
  size = 10;
  alpha = 100;
  x = mouseX;
  y = mouseY;
}