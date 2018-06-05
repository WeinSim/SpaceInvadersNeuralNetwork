class Bullet {
  float x;
  float y;
  float yv;
  boolean active;
  int index;
  
  Bullet(int tempX, int tempY, int tempYV, boolean tempACTIVE, int tempI) {  //it's getting a bunch of values
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
      x = 1000;  //go offscreen if not currently needed
      y = 1000;
    }
    if (y>50 || y<-690) {
      active = false;
    }
    for (int a=0; a<4; a++) {  //if it interacts with either the player or a protection, it despawns and the corresponding live values are set
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