void drawMap() {
  // Prima linea
  drawScale(squareH * 26.1, squareH * 32, squareW * 10);
  drawScale(squareH * 26.9, squareH * 30.5, squareW * 23);
  // Seconda trave
  drawScale(squareH * 22.85, squareH * 26, squareW * 4);
  drawScale(squareH * 22.4, squareH * 27, squareW * 12);
  // Terza trave
  drawScale(squareH * 18.4, squareH * 23.2, squareW * 14);
  drawScale(squareH * 18.8, squareH * 22.5, squareW * 23);
  // Quarta trave
  drawScale(squareH * 14.85, squareH * 18.5, squareW * 4);
  drawScale(squareH * 14.65, squareH * 18.65, squareW * 9);
  // Quinta trave
  drawScale(squareH * 10.9, squareH * 14.65, squareW * 23);
  
  drawTravi(11, 17, 8, 32, true, 1);
  drawTravi(0, 26, 11, 15, true, 1);
  drawTravi(2, 27, 14, 0, false, 1);
  drawTravi(0, 26, 18, 0, true, 1);
  drawTravi(2, 27, 22, 0, false, 1);
  drawTravi(0, 26, 26, 0, true, 1);
  drawTravi(0, 28, 31, 12, true, -1);
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
