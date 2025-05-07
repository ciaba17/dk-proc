void drawMap() {
  lineaTravi(0, 26, 11, 15, true, 1);
  lineaTravi(1, 26, 14, 0, false, 1);

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
