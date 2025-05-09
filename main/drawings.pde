void drawMap() {
  drawScale(28,30,20);
  
  drawTravi(11, 17, 8, 32, true, 1);
  drawTravi(0, 26, 11, 15, true, 1);
  drawTravi(2, 27, 14, 0, false, 1);
  drawTravi(0, 26, 18, 0, true, 1);
  drawTravi(2, 27, 22, 0, false, 1);
  drawTravi(0, 26, 26, 0, true, 1);
  drawTravi(0, 28, 31, 10, true, -1);
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


void drawScale(int inizio, int fine, int x) { // Inizio e fine con direzione dall'alto verso il basso
  for (int i = inizio; i <= fine; i++) {
    image(scala, ((x * squareW) + squareW/2), ((i * squareH) + squareH/2), squareW, squareH); 
    if (primoFrame) {
      PVector posizioneScalaGrid = new PVector(x,i);
      gridPosScale.add(posizioneScalaGrid);
    }
  }
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
