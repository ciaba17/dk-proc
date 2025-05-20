void drawMap() {
  // Disegna le scale, ma senza aggiungerle all'array scale
  for (Scala s : scale) {
    float yUp = s.yUp;
    float yDown = s.yDown;
    float x = s.x;

    x += squareW * 0;
    int nScale = int((yDown - yUp) / squareH);

    // Disegna le scale (ma non aggiunge nuove scale)
    for (int i = 1; i <= nScale; i++) {
      image(scala, x, squareH * i + yUp, squareW, squareH);
    }
  }

  // Disegna le travi
  drawTravi(11, 17, 8, 32, true, 1);
  drawTravi(0, 26, 11, 15, true, 1);
  drawTravi(2, 27, 14, 0, false, 1);
  drawTravi(0, 26, 18, 0, true, 1);
  drawTravi(2, 27, 22, 0, false, 1);
  drawTravi(0, 26, 26, 0, true, 1);
  drawTravi(0, 28, 31, 12, true, -1);
  
  // Disegna i barili accanto a dKong
  image(barileVerticale, squareW * 0.7, squareH  * 8, squareW * 2, squareH * 1.8);
  image(barileVerticale, squareW * 2, squareH  * 8, squareW * 2, squareH * 1.8);
  image(barileVerticale, squareW * 2, squareH  * 10, squareW * 2, squareH * 1.8);
  image(barileVerticale, squareW * 0.7, squareH  * 10, squareW * 2, squareH * 1.8);
  
  // Disegna peach
  image(peach, squareW * 12.2, squareH  * 6.3, squareW * 2, squareH * 4);
  
  // Disegna barile OIL
  image(oil, squareW * 3, squareH  * 30, squareW * 2, squareH * 2);
}


void drawTravi(int inizio, int fine, int y, int inizioOffset, boolean direzioneX, int direzioneY) {
  float offset = 0;
  // Da sinistra verso destra
  if (direzioneX) { 
    int iSuccessivo = inizio + 1;
    for (int i = inizio; i < fine; i++) {
      image(trave, ((i * squareW) + squareW/2), ((y * squareH) + squareH/2) + offset, squareW, squareH);    
      if (iSuccessivo == i) {
        iSuccessivo += 2;
        if (i > inizioOffset) {
          offset += height / 260 * direzioneY;
        }
      }
    }
  }
  // Da destra verso sinistra
  else {
    int iSuccessivo = fine - 1;
    for (int i = fine; i >= inizio; i--) {
      image(trave, ((i * squareW) + squareW/2), ((y * squareH) + squareH/2) + offset, squareW, squareH);    
      if (iSuccessivo == i) {
        iSuccessivo -= 2;
        if (i > inizioOffset) {
          offset += height / 260 * direzioneY;
        }
      }
    }
  }
}


void drawScale(float yUp, float yDown, float x) {
  x += squareW/2;
  int nScale = int((yDown - yUp) / squareH);
  
  for (int i = 1; i <= nScale; i++) {
    image(scala, x, squareH * i + yUp, squareW, squareH);
  }
  scale.add(new Scala(yUp, yDown, x));
}


void drawMenu() {
  image(menu, width/2, height/2, width, height);  
  
  if (menuStartIndex > 30) {
    image(menuStart, width/2, height/1.7, width/2, height/24);
  }
  if (menuStartIndex > 60) {
    menuStartIndex = 0;
  }
  
  menuStartIndex += 1;
}


void drawGrid() {
  for (int i = 0; i < 32; i++) {
    for (int j = 0; j < 28; j++) {
      stroke(150);
      strokeWeight(0.5);
      fill(0, 0, 0, 70);
      rect(squareW * j, squareH * i, squareW, squareH);
    }
  }
}
