void drawMap() {
  offset = 0;
  
  // Disegna le scale
  for (int i = 0; i < 32; i++) {
    for (int j = 0; j < 28; j++) {

      offsetMappa(i, j);
      
      if (mappa[i][j] == 2) {
        if (i == 10) {
          for (int n = 1; n < 10; n++)
            if (mappa[i-n][j] == 1)
              image(scala, squareW * j + squareW/2, squareH * (i-n) + squareH/2 + squareH, squareW, squareH);
        }
        else {
          for (int n = 1; n < 5; n++) {
            if (mappa[i-n][j] == 1) {
              image(scala, squareW * j + squareW/2, squareH * (i-n) + squareH/2 + offset, squareW, squareH);
            }
          }
        }
      }
    }
  }
  
  offset = 0;
  
  // Disegna le travi
  for (int i = 0; i < 32; i++) {
    for (int j = 0; j < 28; j++) {

      offsetMappa(i, j);
      
      if (mappaTravi[i][j] == 2) {
          if (i == 10 && j < 18) {
            image(trave, squareW * j + squareW/2, squareH * i + squareH/2 + (1.5*18), squareW, squareH); 
          }
          else
            image(trave, squareW * j + squareW/2, squareH * i + squareH/2 + offset, squareW, squareH);
      }    
    }
  }
}


void drawMario() {
  offset = 0;
  
  
  mario.draw();
  
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
