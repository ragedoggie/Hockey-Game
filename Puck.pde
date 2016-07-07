class Puck {

  float x, y, xspd, yspd, ballwid, ballhit;
  PImage puck;

  Puck() {
    //loads the puck, gives dimensions, speed, and spawning point
    puck = loadImage("puck.png");
    ballwid = ballhit = 50;
    xspd =5;
    yspd =5; 
    x = (int)random(ballwid/2, width-ballwid/2);
    y = (int)random(height-100, height-ballwid/2);
  }
  
  void show(){
    image(puck, x, y,ballwid, ballhit);
  }
}