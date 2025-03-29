void keyPressed() {
  
  switch(key) {
    case 'a':
      mario.dir = -1;
      break;
    
    case 'd':
      mario.dir = 1;
      break;
    
  }
}


void keyReleased() {
  mario.dir = 0;
}
