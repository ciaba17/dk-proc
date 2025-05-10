class Mario {
  float x, y;
  int gridPosX = 5, gridPosY = 30;
  int dir;
  final float SPEED = 5;
  float frameIndex = 0;
  PImage[] frames = new PImage[4];
  boolean idleDestra = true;
  boolean salendo = false;
  float yInizioScala;
  float xScala;


  
  void move() {
    // Camminata
    if (!salendo) {
      x += SPEED * width / 800 * dir; // Muove sull'asse x aggiungendo velocità e normalizzandola per la larghezza    
    }
    
    // Salita scale
    if (suScala()) {
      if (!salendo) {
        yInizioScala = y;
      }
      if (upPremuto) {
        salendo = true;
        mario.x = xScala;
        mario.y -= height / 256;
      }
      if (downPremuto) {
        if (y < yInizioScala)
          mario.y += height / 256;
        else
          salendo = false;
      }
    }
    else
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
    x = gridPosX * squareW;
    y = gridPosY * squareH;
    
  }

  boolean suScala() {
    for (Scala scala : scale) {
      if (x > scala.x - squareW/2 && x < scala.x + squareW/2) {
        if (y > scala.yUp && y < scala.yDown) {
          xScala = scala.x;
          return true;
        }
      }
    }
    salendo = false;
    return false;
  }

  void offset() {
    // Calcolo dell'offset 
    if (gridPosY >= 28) {
      if (gridPosX >= 12)
        offset = -height*0.002 * (gridPosX - 13);
    }
    else if (gridPosY >= 23) {
       offset = height*0.002 * (gridPosX - 13);
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
