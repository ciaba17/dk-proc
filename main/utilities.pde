void resize() {
  if (lastWidth != width || lastHeight != height) {
    squareW = width / 28.0;
    squareH = height / 32.0;
  }
  
  
  lastWidth = width;
  lastHeight = height;
}
