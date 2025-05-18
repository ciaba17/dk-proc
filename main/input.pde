void keyPressed() {
  
  if (key == 'a') {
    mario.dir = -1;
    mario.idleDestra = false;
  }
  if (key == 'd') {
    mario.dir = 1;
    mario.idleDestra = true;
  }
  if (key == 'w') {
    upPremuto = true;
  }
  if (key == 's') {
    downPremuto = true;
  }
  if (key == ' ') {
    mario.salitaSalto = true;
    mario.yBeforeSalto = mario.y;
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
    upPremuto = false;
  }
  if (key == 's') {
    downPremuto = false;
  }
}
