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
    else if (gridPosY >= 9) {
      if (gridPosX >= 18) {
        y += height*0.00035 * dir;
      }
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
  float x = squareW * 9, y = squareH * 10 + squareH * 0.25;
  int gridPosX = 9, gridPosY = 10;
  final float SPEED = 2.0; 
  int dir = 1;
  float distanzaCaduta;
  boolean destra = true;
  boolean scendendo = false;
  int rand = -1;
  boolean decided = false;

  
  void rotola() {   
    if (!scendendo)
      x += SPEED * dir;
    else
      y += squareH * 0.1;
    
    
    if (gridPosX == 28) {
      distanzaCaduta = squareH * 2.2;
      x -= squareW * 0.1;
      destra = false;
    }
    else if (gridPosX == 1) {
      distanzaCaduta = squareH * 2.18;
      x += squareW * 0.1;
      destra = true;
    }
      
    if (distanzaCaduta >= 0) {
         y += squareH * 0.1;
         distanzaCaduta -= squareH * 0.1;
         dir = 0;
    }
    else {
      if (destra)
        dir = 1;
      else 
        dir = -1; 
    }
      
      
      
    gridPosX = round(x / (width / 28));
    gridPosY = round(y / (height / 32));

    offset();

    scendiScale();
  }
  
  
  void scendiScale() {
    boolean overStair = false;
    for (Scala scala : scale) {
      boolean inX = x > scala.x - squareW/2 && x < scala.x + squareW/2;
      boolean inYzone = y > scala.yUp - squareH * 0.45 && y < scala.yDown - squareH * 0.5;
    
      if (inX) {
        overStair = true;
      
        // Decido una volta sola se scendere o no
        if (inYzone && !decided) {
          rand = int(random(2));  // 0 o 1
          decided = true;
        }
      
        // Se ho deciso di scendere, e non sto già "scendendo", inizio la discesa
        if (decided && rand == 1 && inYzone && !scendendo) {
          scendendo = true;
          i++;
          x = scala.x;
          destra = !destra;
          println(i);
        }
      
        // Se sto scendendo e ho raggiunto il fondo, esco dallo stato scala
        if (scendendo && y >= scala.yDown - squareH * 0.5) {
          scendendo = false;
          decided  = false;
        }
      }
    }
  
  // Se esco orizzontalmente dalla hitbox della scala, resetto tutto
  if (!overStair) {
    scendendo = false;
    decided  = false;
    }
  }
  
  void offset() {
    if (gridPosY >= 28) {
      if (gridPosX >= 14)
        y -= height*0.00019 * dir;
    }
    else if (gridPosY >= 24) {
      y += height*0.00019 * dir;
    }
    else if (gridPosY >= 20) {
      y -= height*0.00019 * dir;
    }
    else if (gridPosY >= 16) {
      y += height*0.00019 * dir;
    }
    else if (gridPosY >= 12) {
      y -= height*0.00019 * dir;
    }
    else if (gridPosY >= 9) {
      if (gridPosX >= 18) {
        y += height*0.00019 * dir;
      }
    }
  }
  
  void draw() {
    image(barile, x, y, squareW, squareH);
  }
}
