void drawMap() {
  lineaTravi(11, 17, 8, 32, true, 1);
  lineaTravi(0, 26, 11, 15, true, 1);
  lineaTravi(2, 27, 14, 0, false, 1);
  lineaTravi(0, 26, 18, 0, true, 1);
  lineaTravi(2, 27, 22, 0, false, 1);
  lineaTravi(0, 26, 26, 0, true, 1);
  lineaTravi(0, 28, 31, 10, true, -1);
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
