void setup() {
  size(400, 400);
  noFill();
  stroke(255);
  background(100);
  drawBall(width/2, height/2, width/2);
}

void drawBall (int x, int y, int s) {
  if (s > 2) {
    ellipse(x, y, s, s);
    drawBall(x-s/2, y, s/2);
    drawBall(x+s/2, y, s/2);
  }
}