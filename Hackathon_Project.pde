import processing.sound.*; //<>// //<>//
Goalie player;
Puck puck;

int score;
int timeStart, totalTime, timeEnd, timeLeft;
int gamestate;
PImage backImg;
SoundFile Hockeysound;
boolean musicCheck;
SoundFile rejected;
SoundFile Ding;

void setup() {
  size(500, 500);
  backImg = loadImage("hockeynet.jpg");
  score = 0;
  player = new Goalie();
  gamestate = 0;
  Hockeysound = new SoundFile (this, "Hockey.wav");
  timeStart = millis() ;
  totalTime = 20000;
  timeEnd = timeStart + totalTime;
  score = 0;
  rejected = new SoundFile (this, "PunchCut.wav");
  Ding = new SoundFile (this, "Ding.mp3");
  //no cursor all the time
  noCursor();
  puck = new Puck();
  Hockeysound.loop(1);
}

void draw() {

  image(backImg, 0, 0, width, height);
  //load the first page that has some instructions
  if (gamestate == 0) {
    fill(random(255), random(255), random(255));
    textSize(40);
    text("click space to start", 0, 75);
    text("use pad to move goalie", 0, 125);
    //214 is middle
  }

  if (gamestate == 1) {
    timeLeft = timeEnd - millis();
    puck.show();
    //collision with the net subtracts one point
    if (puck.x + puck.ballwid> 180 
      && puck.x < 180+ 141
      && puck.y + puck.ballhit > 140
      && puck.y <140 + 175) {
      puck.x = (int)random(puck.ballwid/2, width-puck.ballwid/2);
      puck.y = (int)random(height-100, height-puck.ballwid/2);
      print("net");
      score = score - 1;
      Ding.play();
    }

    if (timeLeft <= 0) {
      gamestate = 2;
    }

    //these show the score and the time left on the top of the screen
    textSize(40);
    fill(255);
    text("score "+ score, 0, 70);
    text("timer:" + timeLeft/1000, 300, 70);

    //collision with the goalie gives you a point
    if (puck.x + puck.ballwid> mouseX 
      && puck.x < mouseX + player.width
      && puck.y + puck.ballhit > mouseY
      && puck.y < mouseY + player.height
      && mouseX >= 130 && mouseX <= 180 + 141 && mouseY >= 80 && mouseY <= 140 + 140) {
      print("goalie");
      rejected.play();
      puck.x = (int)random(puck.ballwid/2, width-puck.ballwid/2);
      puck.y = (int)random(height-100, height-puck.ballwid/2);
      score = score + 1;
    }
    player.show();
    player.move();
    puck.x = puck.x + puck.xspd;
    puck.y = puck.y + puck.yspd;
    //we used a rectangle to find the coordinates of the goal in the background
    noStroke();
    fill(255, 0);
    rect(180, 140, 141, 175, 30);

    //this is the puck speed after it bounces of each wall
    if (puck.x >= width) {
      puck.xspd = -7;
    }
    if (puck.x <= 0) {
      puck.xspd = 8;
    }
    if (puck.y <= 0) {
      puck.yspd = 4;
    }
    if (puck.y >= height) {
      puck.yspd = -3;
    }
  }

  //if you lose it pops up texts
  if (gamestate == 2) {
    textSize(40);
    text("score "+ score, 0, 70);
    textSize(30);
    fill(255);
    text("Play Again", 200, 250);
    text("click space to play again", 50, 200);
  }
}

//loop back to the start screen if you lose and press space
void keyPressed() {
  if (key == ' ' && gamestate == 0) {
    gamestate = 1;
  }

  //we changed the movement of the goalie by the pad instead of arrow keys
  /*if (gamestate == 1) {
   if (key == CODED) {
   if (keyCode == UP) {
   player.y = player.y - player.ySpeed;
   }
   if (keyCode == DOWN) {
   player.y = player.y + player.ySpeed;
   }
   if (keyCode == LEFT) {
   player.x = player.x - player.xSpeed;
   }
   if (keyCode == RIGHT) {
   player.x = player.x + player.xSpeed;
   }
   }
   }
   */
  if (gamestate == 2) {
    if (key == ' ') {
      gamestate = 0;   

      score = 0;
      player = new Goalie();
      timeStart = millis() ;
      timeEnd = timeStart + totalTime;
      score = 0;
      puck = new Puck();
    }
  }
}