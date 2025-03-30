void setup() {
  size(600, 800, P2D);
  surface.setResizable(true);
  
  imageMode(CENTER);
  
  mario = new Mario(); // Crea l'oggetto mario
  
  scala = loadImage("../data/scala.png");
  trave = loadImage("../data/trave.png");
  mario.sprite = loadImage("../data/scala.png");
}


void draw() {
  update();
  background(0);
  
  
  drawMap();
  drawMario();
  
  drawGrid();
  
}


void update() {
  resize();
  println(mario.gridPosX,mario.gridPosY);
  
  mario.move();
}
