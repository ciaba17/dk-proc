void resize() {
  if (lastWidth != width || lastHeight != height) {
    squareW = width / 28.0;
    squareH = height / 32.0;
    mario.updatePosition();
  }
  
  lastWidth = width;
  lastHeight = height;
}


void lineaTravi(int inizio, int fine, int j, int inizioOffset, boolean direzioneX, int direzioneY) {
  float offset = 0;
  // Da sinistra verso destra
  if (direzioneX) { 
    int iSuccessivo = inizio + 1;
    for (int i = inizio; i < fine; i++) {
      image(trave, ((i * squareW) + squareW/2), ((j * squareH) + squareH/2) + offset, squareW, squareH);    
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
      image(trave, ((i * squareW) + squareW/2), ((j * squareH) + squareH/2) + offset, squareW, squareH);    
      if (iSuccessivo == i) {
        iSuccessivo -= 2;
        if (i > inizioOffset) {
          offset += height / 260 * direzioneY;
        }
      }
    }
  }
}
