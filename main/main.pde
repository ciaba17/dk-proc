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

  intro = new Movie(this, "intro.mp4");
  levelMusic = new SoundFile(this, "../data/sounds/levelMusic.mp3");
  deathMusic = new SoundFile(this, "../data/sounds/deathMusic.mp3");
  
  martelli.add(new Martello(20, 20));
}


void draw() {
  background(0);
  drawMap();
  drawGrid();
  mario.draw();
  dKong.draw();
  
  if (onMenu) {
    drawMenu();
  }
  else if (!mario.morto) {
    update();
    
    // Disegno barili
    for (Barile barile : barili) {
      barile.draw();
    }
    // Disegno martelli
    for (Martello martello : martelli) {
      martello.draw();
    }
  }
}

void update() {
  gestisciAudio();
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


void movieEvent(Movie m) {
  m.read();
}

void movieFinished(Movie m) {
  showIntro = false;
  intro.stop();
}
