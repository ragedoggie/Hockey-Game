class Goalie {

  float x, y, xSpeed, ySpeed,width,height;
  PImage goalie;
  
  Goalie() {
    //goalies pic and speed
      goalie = loadImage("goalie.png");
      x = 180;
      y = 141;
      xSpeed = 50;
      ySpeed = 50;
      width = goalie.width;
      height = goalie.height;
      
      
  }
  
  void move() {
    //move goalie
  }

  void show() {
    if (mouseX <= 130)  mouseX = 130;//left side
    if (mouseX >= 180 + 141) mouseX = 180 + 140;//right side of box
    if (mouseY <= 80) mouseY = 80;  //top of box
    if (mouseY >= 140 + 140) mouseY = 110 +170;//bottom of box
     image(goalie, mouseX, mouseY);
    //draw
    
  }
}