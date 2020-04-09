
void setup() {
  size(600, 400);
  background(0);
  smooth();
  noFill();
  stroke(200);
  strokeWeight(2);
}

void draw() {
  float xr = random(20);
  float yr = random(20);
  background(0);
  //fill(255, 255, 255);
  ellipse(100, 100, 100+xr, 100+yr);
  ellipse(100, 100, 105+yr, 105+xr);
}