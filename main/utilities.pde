void loadImmagini() {
  scala = loadImage("../data/scala.png");
  trave = loadImage("../data/trave.png");
  barileVerticale = loadImage("../data/bariliSprites/barileVerticale.png");
  menu = loadImage("../data/menu.png");
  menuStart = loadImage("../data/menuStart.png");
  
  // Animazioni dKong
  for (int i = 0; i < dKong.sprites.length; i++) {
     dKong.sprites[i] = loadImage("../data/donkeyKongSprites/" + i +  ".png");
  }
  
  // Camminata Mario
  for (int i = 0; i < mario.camminata.length; i++) {
     mario.camminata[i] = loadImage("../data/marioSprites/walk" + i +  ".png");
  }
  // Scalata Mario
  for (int i = 0; i < mario.scalata.length; i++) {
     mario.scalata[i] = loadImage("../data/marioSprites/climb" + i +  ".png");
  }
  
  // Salto mario
  mario.salto = loadImage("../data/marioSprites/walk3.png");
  
  // Rotolamento barili
  for (int i = 0; i < rotolamentoBarili.length; i++) {
     rotolamentoBarili[i] = loadImage("../data/bariliSprites/" + i +  ".png");
  }
  
  // Discesa barili
  for (int i = 0; i < discesaBarili.length; i++) {
     discesaBarili[i] = loadImage("../data/bariliSprites/discesa" + i +  ".png");
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
  // Sesta trave
  scale.add(new Scala(squareH * 0.0, squareH * 11.2, squareW * 8.5));
  scale.add(new Scala(squareH * 0.0, squareH * 11.2, squareW * 10.5));
  scale.add(new Scala(squareH * 7.6, squareH * 11.2, squareW * 16.5));
}

void vittoria() {
  println("Hai vinto!"); 
  
}
