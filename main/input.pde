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
  if (key == ' ' && !mario.salendo && !mario.salitaSalto && !mario.discesaSalto && !mario.conMartello) {
    mario.salitaSalto = true;
    mario.yBeforeSalto = mario.y;
  }
  if (keyCode == ENTER && onMenu) {
    onMenu = false;
    intro.play();
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
