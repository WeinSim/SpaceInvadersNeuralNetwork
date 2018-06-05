float speed;  //how many frames until the enemies move
float etimer;
int mode;  //0play 1selectioncorssovermutation
int layers [] = {258, 15, 15, 3};  //258=50(enemyalive)+50(enemyx)+50(enemyy)+50(bulletex)+50(bulletey)+1(playerx)+2(bulletpx&y)+4(protectionlives)+1(enemydir), 2 hidden layers with 15 neurons each, 3=2(move left/right)+1(shoot)
int generation;

Player players [] = new Player [10];

void setup() {
  size(1080, 720);
  speed = 20;
  for (int d=0; d<10; d++) {
    players[d] = new Player(d);
  }
  ellipseMode(CENTER);
  rectMode(CENTER);
  etimer = speed;
  generation = 0;
}

void draw() {
  background(0);
  translate(width/2, 680);
  etimer --;
  if (etimer <= 0) {
    speed -= 0.02;
    etimer = speed;
    for (int a=0; a<players.length; a++) {
      for (int b=0; b<players[a].enemies.length; b++) {
        players[a].enemies[b].move();
      }
    }
  }
  
  if (mode == 0) {
    for (int c=0; c<players.length; c++) {
      players[c].play();
      players[c].show();
    }
  }
  if (mode == 1) {
    selection();
    crossoverm();
    mode = 0;
    generation ++;
  }
}

void selection() {
  
}

void crossoverm() {
  
}