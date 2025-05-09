class Mario {
  float x, y;
  float startX, startY;
  int dir;
  final float SPEED = 5;
  float frameIndex = 0;
  PImage[] frames = new PImage[4];
  int gridPosX, gridPosY;
  boolean idleDestra = true;

  
  void move() {
    x += SPEED * width/800 * dir; // Muove sull'asse x aggiungendo velocità e normalizzandola per la larghezza    
    
    if (suScala()) {
      mario.x = (gridPosX+1) * (width / 28) - startX;
      mario.y -= height / 256;
    }
  }
  
  void draw() {    
    // Calcolo della posizione sulla griglia
    gridPosX = round((x + startX) / (width / 28));
    gridPosY = round((y + startY) / (height / 32));
    
    // Calcolo dell'offset 
    if (gridPosY == 30 && gridPosX >= 12)
      offset = -height*0.002 * (gridPosX - 13);
    
    // In base allo stato in cui è mario, le animazioni si attivano o disattivano di conseguenza
    pushMatrix();
    translate(x + startX, 0);
    if (dir == -1 || !idleDestra)
      scale(-1, 1);
      
    if (dir != 0) {
      if (int(frameIndex) == 4)
        frameIndex = 0;
      
      image(frames[int(frameIndex)], 0, y + startY + offset, squareW * 2, squareH * 2);
      frameIndex += 0.3;
    }
    else
      image(frames[0], 0, y + startY + offset, squareW * 2, squareH * 2);
    popMatrix();
  }

  void updatePosition() {
    // Posizione iniziale del player
    startX = width*5/28 - squareW;
    startY = height*31/32 - squareH;

    x *= width / lastWidth;
    y *= height / lastHeight;
  }
  
  
  boolean suScala() {
    for (PVector gridPos : gridPosScale) {
      if (gridPosX >= gridPos.x && gridPosX <= gridPos.x+2 && upPremuto) {
        gridPosX = int(gridPos.x);
        return true;
      }
    }
    return false;
  }
} Mario mario;








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
