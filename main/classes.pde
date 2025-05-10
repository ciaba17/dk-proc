class Mario {
  float x, y;
  float logicX, logicY;
  float startX, startY;
  int gridPosX, gridPosY;
  int dir;
  final float SPEED = 5;
  float frameIndex = 0;
  PImage[] frames = new PImage[4];
  boolean idleDestra = true;

  
  void move() {
    x += SPEED * width/800 * dir; // Muove sull'asse x aggiungendo velocità e normalizzandola per la larghezza    
    
    if (suScala()) {
      if (upPremuto)
        mario.y -= height / 256;
    }
    offset();
    
    // Calcolo della posizione sulla griglia
    gridPosX = round(x / (width / 28));
    gridPosY = round(y / (height / 32));
  }
  
  void draw() {    
    // Animazioni
    pushMatrix();
    translate(x, 0);
    if (dir == -1 || !idleDestra)
      scale(-1, 1);
      
    if (dir != 0) {
      if (int(frameIndex) == 4)
        frameIndex = 0;
        
      image(frames[int(frameIndex)], 0, y + offset, squareW * 2, squareH * 2);
      frameIndex += 0.6;
    }
    else
      image(frames[0], 0, y + offset, squareW * 2, squareH * 2);
    popMatrix();
  }

  void updatePosition() {
    // Posizione iniziale del player
    startX = width*5/28 - squareW;
    startY = height*31/32 - squareH;

    logicX *= width / lastWidth;
    logicY *= height / lastHeight;
    
    x = startX + logicX;
    y = startY + logicY;
  }

  boolean suScala() {
    for (Scala scala : scale) {
      if (x >= scala.x - squareW/2 && x <= scala.x + squareW/2 && y >= scala.yUp && y <= scala.yDown)
        return true;
    }
    return false;
  }

  void offset() {
    // Calcolo dell'offset 
    if (gridPosY >= 28) {
      if (gridPosX >= 12)
        offset = -height*0.002 * (gridPosX - 13);
    }
    
  }
} Mario mario;


class Scala {
  float yUp, yDown;
  float x;
  
  Scala(float yUp_, float yDown_, float x_) {
    yUp = yUp_;
    yDown = yDown_;
    x = x_;
  }
}


class Barile {
  int speed = 5;
  int x, y;
  PImage sprite;
  
  void rotola(int dir) {   
    x += speed * dir;
  }
  
  void draw() {
    image(sprite, x, y, squareW, squareH);
  }
}
