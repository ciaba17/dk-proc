void keyPressed() {
  
  if (key == 'a') {
    mario.dir = -1;
  }
  if (key == 'd') {
    mario.dir = 1;
  }
  if (key == 'w') {
    if (mappa[mario.gridPosY][mario.gridPosX] == 1 || mappa[mario.gridPosY][mario.gridPosX-1] == 1 || mappa[mario.gridPosY][mario.gridPosX+1] == 1) { // Guarda se il player si trova in prossimità di una scala
      mario.salire = true;
    }
  }
}


void keyReleased() {
  if (key == 'a'){
    mario.dir = 0;
  }
  if (key == 'd') {
    mario.dir = 0; 
  }
  if (key == 'w') {
    mario.salire = false;
  }
}
