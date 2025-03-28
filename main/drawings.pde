void drawMap() {
  float offset = 0;
  
  // Disegna le scale
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
      
      if (mappa[i][j] == 2) {
        for (int n = 1; n < 5; n++) {
          if (mappa[i-n][j] == 1)
            image(scala, squareW * j + squareW/2, squareH * (i-n) + squareH/2 + offset, squareW, squareH);
        }
      }
    }
  }
  
  offset = 0;
  
  // Disegna le travi
  for (int i = 0; i < 32; i++) {
    for (int j = 0; j < 28; j++) {

      if (i != 31) {
        if (mappaTravi[i][0] == 2){
          offset += 1.5; 
        }
        else if (mappaTravi[i][27] == 2) {
          offset -= 1.5; 
        }
      }
      else {
          if (j == 0)
            offset = 0;
          if (j > 13)
            offset -= 1.9;
      }
      
      
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
