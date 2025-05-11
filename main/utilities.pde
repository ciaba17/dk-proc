void resize() {
  if (lastWidth != width || lastHeight != height) {
    squareW = width / 28.0;
    squareH = height / 32.0;
  }
  
  lastWidth = width;
  lastHeight = height;
}


void loadImmagini() {
  scala = loadImage("../data/scala.png");
  trave = loadImage("../data/trave.png");
  barile = loadImage("../data/scala.png");
  
  // Camminata
  for (int i = 0; i < mario.camminata.length; i++) {
     mario.camminata[i] = loadImage("../data/marioSprites/walk" + i +  ".png");
  }
  // Scalata
  for (int i = 0; i < mario.scalata.length; i++) {
     mario.scalata[i] = loadImage("../data/marioSprites/climb" + i +  ".png");
  }
}
