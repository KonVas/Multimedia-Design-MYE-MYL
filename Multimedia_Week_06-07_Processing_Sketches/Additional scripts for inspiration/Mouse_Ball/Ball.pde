class ball {
  //fields
  //int size = 100;
  //constructor
  ball (int _x, int _y) {
    x = _x;
    y = _y;
  }
  // methods
  void display() {
    fill(alpha);
    ellipse(x, y, size, size);
  }
  
  void drop() {
    if (y <400) {
    y += 5;
    }
  }
 
  void explode() {
    if (alpha > 0) {
      alpha --;
      size+=5;
    }
  }
}