import processing.sound.*;

SoundFile levelMusic;
SoundFile deathMusic;

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

  levelMusic = new SoundFile(this, "../data/sounds/levelMusic.mp3");
  deathMusic = new SoundFile(this, "../data/sounds/deathMusic.mp3");
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
  
  if (onMenu) {
    drawMenu();
    // Se la musica del livello è in riproduzione mentre sei nel menu, fermala
    if (levelMusic.isPlaying()) {
      levelMusic.stop();
    }
  } else if (!mario.morto) {
    // Avvia la musica del livello solo se non è già in riproduzione
    // e se non siamo nel menu
    if (!levelMusic.isPlaying()) {
      levelMusic.loop();
    }
    update();
    // Disegno barili
    for (Barile barile : barili) {
      barile.draw();
    }
  } else { // Mario è morto
    // Qui potresti voler fermare levelMusic e avviare deathMusic
    if (levelMusic.isPlaying()) {
      levelMusic.stop();
    }
    if (!deathMusic.isPlaying()) {
      deathMusic.play(); // O loop() se è un loop di morte
    }
    // Mostra schermata di game over o riavvia
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
