void resize() {
  if (lastWidth != width || lastHeight != height) {
    squareW = width / 28.0;
    squareH = height / 32.0;
  }
  
  
  lastWidth = width;
  lastHeight = height;
}


void offsetMappa(int i, int j) {
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
}
