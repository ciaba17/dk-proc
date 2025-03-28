void drawMap() {
  float offset = 0;
  
  for (int i = 0; i < 32; i++) {
    for (int j = 0; j < 28; j++) {

      
      if (mappa[i][0] == 2){
        offset += 1.5; 
      }
      else if (mappa[i][27] == 2) {
        offset -= 1.5; 
      }
      if (i == 31 || i == 7) {
        offset = 0; 
      }
      
      switch (mappa[i][j]) {
      case 1: // Disegna le scale
        image(scala, squareW * j + squareW/2, squareH* i + squareH/2 + offset, squareW, squareH);
        break;
      case 2:
        image(trave, squareW * j + squareW/2, squareH* i + squareH/2 + offset, squareW, squareH);
        break;
      }
    }
  }
}


void drawGrid() {
  for (int i = 0; i < 32; i++) {
    for (int j = 0; j < 28; j++) {
      stroke(150);
      strokeWeight(0.5);
      fill(0, 0, 0, 100);
      rect(squareW * j, squareH * i, squareW, squareH);
    }
  }
}
