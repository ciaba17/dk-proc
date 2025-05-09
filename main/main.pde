void setup() {
  size(600, 800);
  surface.setResizable(true);
  noSmooth();

  frameRate(30);
  
  imageMode(CENTER);
  
  mario = new Mario(); // Crea l'oggetto mario
  
  scala = loadImage("../data/scala.png");
  trave = loadImage("../data/trave.png");
  for (int i = 0; i < mario.frames.length; i++) {
     mario.frames[i] = loadImage("../data/marioSprites/" + i +  ".png");
  }
}


void draw() {
  update();
  background(0);
  
  
  drawMap();
  drawGrid();
  mario.draw();
  
  primoFrame = false;
}


void update() {
  resize();
  
  mario.move();
  
  //println(mario.gridPosX);
}
