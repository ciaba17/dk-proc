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
    wPressed = true;
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
    wPressed = false;
  }
}
