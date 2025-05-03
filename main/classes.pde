class Mario {
  float x, y;
  float speed = 5;
  int dir;
  PImage sprite;
  int gridPosX, gridPosY;

  
  void move() {
    x += speed * width/800 * dir; // Muove sull'asse x aggiungendo velocità e normalizzandola per la larghezza    
  }
  
  void draw() {
    float startX = width*5/28 - squareW/2, startY = height*31/32 - squareH/2; // Posizione iniziale del player
    
    
    gridPosX = round((x + startX) / (width / 28));
    gridPosY = round((y + startY) / (height / 32));
    

    
    if (gridPosY == 30 && gridPosX >= 14)
      offset -= height*0.002 * (gridPosX - 13);
      
    println(gridPosY, gridPosX);
      
    image(sprite, x + startX, y + startY + offset, squareW, squareH);
  }

  void updatePosition() {
    x *= width / lastWidth;
    y *= height / lastHeight;
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


Mario mario;
