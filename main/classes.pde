class Mario {
  float x = squareW * 5, y = squareH * 30;
  int gridPosX, gridPosY;
  int dir;
  final float SPEED = 5;
  float frameIndex = 0;
  PImage[] camminata = new PImage[4];
  PImage[] scalata = new PImage[2];
  boolean idleDestra = true;
  boolean salendo = false;
  float yInizioScala;
  float xScala;
  int a = 100;

  
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
        else {
          salendo = false;
        }
      }
    }
    else
      offset();
    
      gridPosX = round(x / (width / 28));
      gridPosY = round(y / (height / 32));
  }
  
  void draw() {    
    // Animazioni
    pushMatrix();
    translate(x, 0);
    if (salendo) {
      if (upPremuto || downPremuto) {
        frameIndex += 0.2;
        if (frameIndex > scalata.length)
          frameIndex = 0;
        image(scalata[int(frameIndex)], 0, y, squareW * 2, squareH * 2);
      }
      else
        image(scalata[int(frameIndex)], 0, y, squareW * 2, squareH * 2);
    }
    else {
      if (dir == -1 || !idleDestra)
        scale(-1, 1);
      
      if (dir != 0) {
        frameIndex += 0.5;
        if (frameIndex > camminata.length-1)
          frameIndex = 0;
        image(camminata[int(frameIndex)], 0, y, squareW * 2, squareH * 2);
        
      }
      else {
        image(camminata[0], 0, y, squareW * 2, squareH * 2);
      }
    }
    popMatrix();
  }


  boolean suScala() {
    for (Scala scala : scale) {
      if (x > scala.x - squareW/2 && x < scala.x + squareW/2) {
        if (y > scala.yUp - squareH * 0.45 && y < scala.yDown) {
          xScala = scala.x;
          return true;
        }
      }
    }
    salendo = false;
    return false;
  }

  void offset() {
    if (gridPosY >= 28) {
      if (gridPosX >= 14)
        y -= height*0.00035 * dir;
    }
    else if (gridPosY >= 23) {
       y += height*0.00035 * dir;
    }
    else if (gridPosY >= 20) {
       y -= height*0.00035 * dir;
    }
    else if (gridPosY >= 16) {
       y += height*0.00035 * dir;
    }
    else if (gridPosY >= 12) {
       y -= height*0.00035 * dir;
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
