void setup() {
  size(600, 800);
  //surface.setResizable(true);
  noSmooth();
  frameRate(30);
  imageMode(CENTER);
  resize();
  mario = new Mario(); // Crea l'oggetto mario
  loadImmagini();
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
  println(mario.gridPosX, mario.gridPosY);
}
