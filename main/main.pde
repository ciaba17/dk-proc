void setup() {
  size(600, 800);
  surface.setResizable(true);
  noSmooth();
  frameRate(30);
  imageMode(CENTER);
  resize();
  mario = new Mario(); // Crea l'oggetto mario
  loadImmagini();
  setupScale();
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
  if (width != lastWidth || height != lastHeight) {
    resize(); 
  }
   
  mario.move();
  
  // Spawn barili
  if (tempoSpawn > barrelTimeSpawn) {
    barili.add(new Barile());
    
    tempoSpawn = 0;
  }
  
  tempoSpawn += 2;
}
