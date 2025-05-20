void setup() {
  size(600, 800);
  surface.setResizable(true);
  noSmooth();
  frameRate(30);
  imageMode(CENTER);
  
  squareW = width / 28.0;
  squareH = height / 32.0;
  
  mario = new Mario();
  dKong = new DonkeyKong();
  
  loadImmagini();
  setupScale();
}


void draw() {
  background(0);
  drawMap();
  drawGrid();
  mario.draw();
  dKong.draw();
  
  if (onMenu)
    drawMenu();
  else if (!mario.morto) {
    update();
    // Disegno barili
    for (Barile barile : barili) {
      barile.draw();
    }
  }
}

void update() {
   
  mario.update();
  
  // Spawn barili
  if (tempoSpawn > barrelTimeSpawn) {
    barili.add(new Barile());
    
    tempoSpawn = 0;
  }
  
  // Update dei barili
  for (Barile barile : barili) {
    barile.update();
  }
  barili.removeIf(barile -> barile.daRimuovere());
  
  tempoSpawn += 1;
  
  if (mario.y < squareH * 8)
    vittoria();
}
