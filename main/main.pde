void setup() {
  size(600, 800, P2D);
  surface.setResizable(true);
  
  imageMode(CENTER);
  
  scala = loadImage("../data/scala.png");
  trave = loadImage("../data/trave.png");
}


void draw() {
  update();
  background(0);
  
  
  drawMap();
  drawGrid();
}


void update() {
  resize();
  
}
