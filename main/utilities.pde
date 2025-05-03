void resize() {
  if (lastWidth != width || lastHeight != height) {
    squareW = width / 28.0;
    squareH = height / 32.0;
    mario.updatePosition();

  }
  
  
  lastWidth = width;
  lastHeight = height;
}


void lineaTravi(int inizio, int fine, int j, int inizioOffset, int direzione) {
  int iSuccessivo = 2;
  float offset = 0;
  for(int i = inizio; i < fine; i++) {
    image(trave, ((i * squareW) + squareW/2), ((j * squareH) + squareH/2) + offset, squareW, squareH);    
    if (iSuccessivo == i) {
      iSuccessivo += 2 * direzione;
      if (i > inizioOffset) {
        offset += height/300;
      }
    }
  }
}
