class Enemy {
  int x;
  int y;
  int dir;  //0right 1left
  boolean alive;
  int index;
  
  Bullet b = new Bullet(0, 0, 0, false, index);
  
  Enemy(int tempX, int tempY, int tempI) {  //again some values
    x = tempX;
    y = tempY;
    dir = 0;
    alive = true;
    index = tempI;
  }
  
  void move() {  //moving left and right
    if (dir == 0) {
      x += 5;
    } else {
      x -= 5;
    }
  }
  
  void turn() {  //moving downwards when it's supposed to do so
    dir = (dir+1)%2;
    y += 20;
    move();
  }
  
  void bullet() {
    if (!b.active) {
      if (random(10)<0.002) {  //shoot once every 100 frames(=3.3333333sec)
        b = new Bullet(x, y+20, 5, true, index);
      }
    } else {
      b.move();  //move the bullet
    }
  }
  
  void show() {  //displaying on screen
    noStroke();
    fill(255, 255, 255, 20);
    rect(x, y, 20, 20);
    if (b.active) {
      stroke(255, 255, 255, 20);
      line(b.x, b.y+5, b.x, b.y-5);
    }
  }
}