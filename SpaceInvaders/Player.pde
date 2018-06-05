class Player {
  int x;
  int y;
  boolean shoot;
  boolean finish;
  boolean l;
  boolean r;
  boolean s;
  boolean turn;
  boolean good;
  float inputs [] = new float [258];
  int index;
  
  Protection pro [] = new Protection [4];  //each player spawns protections. enemies, a bullet and a neural network
  Enemy enemies [] = new Enemy [50];
  Bullet b = new Bullet(0, 0, 0, false, index);
  NeuralNetwork nn = new NeuralNetwork();
  
  Player(int tempI) {
    x = 0;
    y = 0;
    shoot = false;
    finish = false;
    l = false;
    r = false;
    s = false;
    turn = false;
    good = false;
    index = tempI;
    
    for (int a=0; a<50; a++) {
      if (a<4) {
        pro[a] = new Protection(int((a-1.5)*250), -80);  //assigning coordinates to protections and enemies
      }
      enemies[a] = new Enemy(int((a%10)-4.5)*50, floor(a/10)*50-640, index);
    }
  }
  
  void play() {
    turn = false;
    for (int b=0; b<enemies.length; b++) {
      if (abs(enemies[b].x) >= width/2-30) {  //eventually the enemies need to turn
        turn = true;
      }
      enemies[b].bullet();  //their bullets are updated
    }
    if (turn) {
      for (int c=0; c<enemies.length; c++) {
        enemies[c].turn();
      }
    }
    
    for (int f=0; f<50; f++) {  //all of the inputs for the neural network
      inputs[f*5] = int(enemies[f].alive);                             //Its late at night now (in germany) and I'll stop now. I will continue with this right after school tomorrow
      inputs[f*5+1] = enemies[f].x/720+0.5;
      inputs[f*5+2] = enemies[f].y/680;
      inputs[f*5+3] = enemies[f].b.x/720+0.5;
      inputs[f*5+4] = enemies[f].b.y/680;
    }
    inputs[250] = x/720+0.5;
    inputs[251] = b.x/720+0.5;
    inputs[252] = b.y/680;
    for (int g=0; g<4; g++) {
      inputs[253+g] = pro[g].lives/16;
    }
    inputs[257] = enemies[0].dir;
    
    nn.update(inputs);
    
    if (nn.n0[3][0].activation > 0.5) {
      s = true;
    } else {
      s = false;
    }
    if (nn.n0[3][1].activation > 0.5) {
      r = true;
    } else {
      r = false;
    }
    if (nn.n0[3][2].activation > 0.5) {
      l = true;
    } else {
      l = false;
    }
    
    if (abs(x)<width/2-30) {
      if (l && !r) {
        x -= 3;
      }
      if (r && !l) {
        x += 3;
      }
    }
    if (s) {
      if (!b.active) {
        b = new Bullet(x, y+20, -5, true, index);
      }
    }
    b.move();
    
    for (int d=0; d<enemies.length; d++) {
      if (enemies[d].b.active) {
        if (dist(x, y ,enemies[d].b.x, enemies[d].b.y) < 25) {
          finish = true;
        }
      }
      if (b.active) {
        if (enemies[d].alive) {
          if (dist(b.x, b.y, enemies[d].x, enemies[d].y) < 25) {
            enemies[d].alive = false;
            b.active = false;
          }
        }
      }
    }
  }
  
  void show() {
    noStroke();
    fill(255, 255, 255, 20);
    if (!finish) {
      ellipse(x, y, 10, 10);
    }
    if (b.active) {
      stroke(255, 255, 255, 20);
      line(b.x, b.y+5, b.x, b.y-5);
    }
    for (int h=0; h<50; h++) {
      if (enemies[h].alive) {
        enemies[h].show();
      }
      if (h<4) {
        noStroke();
        fill(255, 255, 255, 20);
        rect(pro[h].x, pro[h].y, 50, 50);
      }
    }
  }
}