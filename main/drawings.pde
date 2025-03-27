void drawMap() {
  for (int i = 0; i < 28; i++) {
    for (int j = 0; j < 28; j++) {
      switch (mappa[i][j]) {
      case 1: // Disegna le scale
        image(scala, 10 * i, 10 * j);
        break;
      case 2:
        break;
      
        
      }
    }
  }
}
