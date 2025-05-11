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
  // Disegno barili
  for (Barile barile : barili) {
    barile.draw();
    barile.rotola();
  }
  
  
  primoFrame = false;

}


void update() {
  resize();  
  mario.move();
  println(mario.gridPosX, mario.gridPosY);
  if (barili.size() > 0) {
    println(barili.get(0).gridPosX);
  }


  
  /// Spawn barili
  if (tempoSpawn > 30) {
    barili.add(new Barile());
    tempoSpawn = 0;
  }
  tempoSpawn += 0.5;
}
