class Bullet {
  float x;
  float y;
  float yv;
  boolean active;
  int index;
  
  Bullet(int tempX, int tempY, int tempYV, boolean tempACTIVE, int tempI) {
    x = tempX;
    y = tempY;
    yv = tempYV;
    active = tempACTIVE;
    index = tempI;
  }
  
  void move() {
    if (active) {
      y += yv;
    } else {
      x = 1000;
      y = 1000;
    }
    if (y>50 || y<-690) {
      active = false;
    }
    for (int a=0; a<4; a++) {
      if (players[index].pro[a].alive) {
        if (dist(x, y, players[index].pro[a].x, players[index].pro[a].y) < 40) {
          players[index].pro[a].lives --;
          active = false;
          if (players[index].pro[a].lives == 0) {
            players[index].pro[a].alive = false;
          }
        }
      }
    }
  }
}