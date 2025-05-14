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
  
  donkeykongStill = loadImage("../data/donkeykongStill.png");
  donkeykongLeft = loadImage("../data/donkeykongLeft.png");
  donkeykongRight = loadImage("../data/donkeykongRight.png");
  
  // Camminata Mario
  for (int i = 0; i < mario.camminata.length; i++) {
     mario.camminata[i] = loadImage("../data/marioSprites/walk" + i +  ".png");
  }
  // Scalata Mario
  for (int i = 0; i < mario.scalata.length; i++) {
     mario.scalata[i] = loadImage("../data/marioSprites/climb" + i +  ".png");
  }
  
  // Idle Donkey Kong
  /*for (int i = 0; i < donkeykong.idle.lenght; i++) {
    donkeykong.idle[i] = loadImage("../data/donkeyKongSprites/Idle" + i + ".png");
  }*/
  
}

void setupScale() {
  scale.clear();

  // Prima linea
  scale.add(new Scala(squareH * 26.1, squareH * 31.1, squareW * 10));
  scale.add(new Scala(squareH * 26.8, squareH * 30.5, squareW * 23));
  // Seconda linea
  scale.add(new Scala(squareH * 22.85, squareH * 25.85, squareW * 4));
  scale.add(new Scala(squareH * 22.4, squareH * 27, squareW * 12));
  // Terza linea
  scale.add(new Scala(squareH * 18.4, squareH * 23.2, squareW * 14));
  scale.add(new Scala(squareH * 18.8, squareH * 22.5, squareW * 23));
  // Quarta linea
  scale.add(new Scala(squareH * 14.85, squareH * 18.5, squareW * 4));
  scale.add(new Scala(squareH * 14.65, squareH * 18.65, squareW * 9));
  // Quinta linea
  scale.add(new Scala(squareH * 10.9, squareH * 14.2, squareW * 23));
}

void addScale(float y1, float y2, float x) {
  scale.add(new Scala(y1, y2, x));
}
