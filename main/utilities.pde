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
  // Prima trave
  scale.add(new Scala(squareH * 26.1, squareH * 31.1, squareW * 10.5));
  scale.add(new Scala(squareH * 26.8, squareH * 30.4, squareW * 23.5));
  // Seconda trave
  scale.add(new Scala(squareH * 22.9, squareH * 26.2, squareW * 4.5));
  scale.add(new Scala(squareH * 22.4, squareH * 26.7, squareW * 12.5));
  // Terza trave
  scale.add(new Scala(squareH * 18.4, squareH * 22.8, squareW * 14.5));
  scale.add(new Scala(squareH * 18.8, squareH * 22.15, squareW * 23.5));
  // Quarta trave
  scale.add(new Scala(squareH * 14.85, squareH * 18.2, squareW * 4.5));
  scale.add(new Scala(squareH * 14.55, squareH * 18.56, squareW * 9.5));
  // Quinta trave
  scale.add(new Scala(squareH * 10.9, squareH * 14.2, squareW * 23.5));
}
