class Mario {
  float x = squareW * 5, y = squareH * 30.15;
  float larghezza = squareW * 2, altezza = squareH * 1.85;
  
  float hitboxL, hitboxR, hitboxU, hitboxD;
  float martHitboxL, martHitboxR, martHitboxU, martHitboxD;
  float hammerW = larghezza * 0.5; 
  float hammerH = altezza * 0.6;
  float hammerOffsetY = altezza * 0.2;
  
  float durataMartello = 0;
  
  int gridPosX, gridPosY;
  int dir; // 0 = fermo, 1 = destra, -1 = sinistra
  final float SPEED = width / 120;
  float frameIndex = 0;
  float frameIndexMorte = 0;
  PImage[] camminata = new PImage[4];
  PImage[] scalata = new PImage[2];
  PImage[] morte = new PImage[5];
  PImage[] martellate = new PImage[4];
  PImage salto;
  boolean idleDestra = true;
  
  boolean salendo = false;
  float yInizioScala;
  float xScala;
  
  float yBeforeSalto;
  boolean salitaSalto = false;
  boolean discesaSalto = false;
  float altezzaSalto = squareH * 1.65;
  float contDiscesa = altezzaSalto;
  
  boolean morto = false;
  boolean conMartello = false;

  void draw() {
    pushMatrix();
    translate(x, 0); // Trasla solo sull'asse x per lo scaling
    if (morto) {
      frameIndex += 0.23;
      if (frameIndexMorte == 3)
        image(morte[int(4)], 0, y, larghezza, altezza);
      else {
        if (frameIndex >= morte.length - 1) {
          frameIndexMorte++;
          frameIndex = 0;
        }
        image(morte[int(frameIndex)], 0, y, larghezza, altezza);
      }
    }
    else if (conMartello) {
      float offsetX = (dir == -1 || (!idleDestra && dir == 0)) ? +larghezza : 0;
      float offsetY = y - squareH * 0.7;
      if (dir == -1 || (!idleDestra && dir == 0)) {
        scale(-1, 1);
      }

      if (dir != 0) {
        frameIndex += 0.4;
        if (frameIndex >= martellate.length)
          frameIndex = 0;
        image(martellate[int(frameIndex)], offsetX, offsetY - squareH * 0.3, larghezza * 2, altezza * 2);
        idleDestra = (dir == 1);
      }
      else {
        image(martellate[0], offsetX, offsetY - squareH * 0.3, larghezza * 2, altezza * 2);
      }  
    }
    else if (salendo) {
      if (upPremuto || downPremuto) { // Animazione solo se si muove sulla scala
        frameIndex += 0.2;
        if (frameIndex >= scalata.length)
          frameIndex = 0;
      }

      image(scalata[int(frameIndex)], 0, y, larghezza, altezza);
    } 
    else if (salitaSalto || discesaSalto) {
        if (dir == -1 || (!idleDestra && dir == 0)) { // Se va a sinistra o era a sinistra ed è fermo
          scale(-1, 1); // Specchia l'immagine
        }
        image (salto, 0, y, larghezza, altezza);
    }
    else {
      if (dir == -1 || (!idleDestra && dir == 0)) { 
        scale(-1, 1);
      }

      if (dir != 0) { 
        frameIndex += 0.5;
        if (frameIndex >= camminata.length)
          frameIndex = 0;
        image(camminata[int(frameIndex)], 0, y, larghezza, altezza);
        idleDestra = (dir == 1); 
      } 
      else { // Se è fermo (idle)
        image(camminata[0], 0, y, larghezza, altezza);
      }
    }
    popMatrix();

  }
  
  void update() {
    // Camminata
    if (!salendo) {
      x += SPEED * width / 800 * dir;
    }

    if (conMartello && (!salitaSalto && !discesaSalto)) {
      durataMartello += 0.1;
      if (durataMartello >= 18) {
        durataMartello = 0;
        conMartello = false;
      }
    }
    else if (salitaSalto) {
      if (yBeforeSalto - y < altezzaSalto) {
        y -= squareH * 0.135;
      }
      else {
        discesaSalto = true;
        salitaSalto = false;
      }
    }
    else if (discesaSalto) {
      if (contDiscesa > 0) {
        y += squareH * 0.135;
        contDiscesa -= squareH * 0.135;
      }
      else {
        discesaSalto = false;
        contDiscesa = altezzaSalto;
      }
    }
    // Salita scale
    else if (suScala()) {
      if (!salendo) {
        yInizioScala = y;
      }
      if (upPremuto) {
        salendo = true;
        mario.x = xScala; 
        mario.y -= height / 256;
      }
      if (downPremuto && salendo) { 
        if (y < yInizioScala) { 
          mario.y += height / 256; 
        } else {
          salendo = false;
          y = yInizioScala;
        }
      }
      // Se non preme su o giu mentre è su una scala e in modalità salendo, rimane fermo
    } 

    else {
      salendo = false; // Assicura che non sia in modalità salita
    }

    if (!salendo)
      offset(); // Applica l'offset della piattaforma
      
    gridPosX = round(x / (width / 28));
    gridPosY = round(y / (height / 32));
    
    hitboxL = x - larghezza / 2;
    hitboxR = x + larghezza / 2;
    hitboxU = y - altezza / 2;
    hitboxD = y + altezza / 2;
    
    if (dir == 1) {
      martHitboxL = x + larghezza * 0.5;
      martHitboxR = martHitboxL + hammerW;
    }
    else if (dir == -1){
      martHitboxR = x - larghezza * 0.5;
      martHitboxL = martHitboxR - hammerW;
    }
    martHitboxU = y + hammerOffsetY;
    martHitboxD = martHitboxU + hammerH;
    
    collisioni();
  }

  boolean suScala() {
    for (Scala scala : scale) {
      if (x > scala.x - squareW / 2 && x < scala.x + squareW / 2) {
        if (y > scala.yUp - squareH * 0.45 && y < scala.yDown + squareH * 0.5) {
          xScala = scala.x; // Salva la x della scala per allineare Mario
          return true;
        }
      }
    }
    return false;
  }

  void offset() {
    if (gridPosY >= 28) {
      if (gridPosX >= 14)
        y -= altezza/190 * dir;
    } else if (gridPosY >= 23) {
      y += altezza/190 * dir;
    } else if (gridPosY >= 20) {
      y -= altezza/190 * dir;
    } else if (gridPosY >= 16) {
      y += altezza/190 * dir;
    } else if (gridPosY >= 12) {
      y -= altezza/190 * dir;
    } else if (gridPosY >= 9) {
      if (gridPosX >= 18) {
        y += altezza/190 * dir;
      }
    }
  }
  
  void collisioni() {
    for (Barile barile : barili) {
      boolean collisioneBarile = 
        hitboxR > barile.hitboxL &&
        hitboxL < barile.hitboxR &&
        hitboxD > barile.hitboxU &&
        hitboxU < barile.hitboxD;
        
      if (collisioneBarile)
        morto = true;
      
      boolean collisioneMartelloBarile = 
        martHitboxR > barile.hitboxL &&
        martHitboxL < barile.hitboxR &&
        martHitboxD > barile.hitboxU &&
        martHitboxU < barile.hitboxD;
        
      if (collisioneMartelloBarile && conMartello)
        barile.daRimuovere = true;
    }
    barili.removeIf(barile -> barile.daRimuovere);

    
    for (Martello martello : martelli) {
      boolean collisione = 
        hitboxR > martello.hitboxL &&
        hitboxL < martello.hitboxR &&
        hitboxD > martello.hitboxU &&
        hitboxU < martello.hitboxD;
        
      if (collisione) {
        conMartello = true;
        martello.daRimuovere = true;
      }
    }
    martelli.removeIf(martello -> martello.daRimuovere);
  }
} Mario mario;


class Scala {
  float yUp, yDown;
  float x;      

  Scala(float yUp_, float yDown_, float x_) {
    yUp = yUp_;
    yDown = yDown_;
    x = x_;
  }
}


class Barile {
  float x = squareW * 9, y = squareH * 11;
  float larghezza = squareW * 1.7, altezza = squareH * 1.7;
  float hitboxL, hitboxR, hitboxU, hitboxD;
  int gridPosX = 9, gridPosY = 10;
  float speed = width/150;
  int dir = 1;
  float distanzaCaduta = 0; 
  boolean destra = true;
  float frameIndex = 0;
  boolean daRimuovere = false;

  boolean scendendo = false; 
  Scala scalaCorrente = null; // Riferimento alla scala che sta scendendo

  int randDecisioneScala = -1; // Risultato della decisione casuale (0 non scende, 1 scende)
  boolean decisionePresaPerScala = false; // Flag per assicurare che la decisione di scendere venga presa una sola volta per "incontro" con una zona scala

  void draw() {
    int i = 0;
    
    if (scendendo) {
      if (frameIndex > 90) frameIndex = 0;
      else if (frameIndex > 70) i = 1;
      
      image(discesaBarili[i], x - squareW / 2, y - squareH / 2, larghezza, altezza);
    }
    else {
      if (frameIndex > 90) frameIndex = 0;
      else if (frameIndex > 70) i = 3;
      else if (frameIndex > 50) i = 2;
      else if (frameIndex > 30) i = 1;
    
      image(rotolamentoBarili[i], x - squareW / 2, y - squareH / 2, larghezza, altezza);
    }
      frameIndex += 10;
    
  
  }

  void update() {
    if (scendendo) {
      // Sta scendendo una scala
      y += squareH * 0.1; // Velocità di discesa sulla scala
      if (scalaCorrente != null && y >= scalaCorrente.yDown - squareH * 0.1) { 
        scendendo = false;
        y = scalaCorrente.yDown;
        scalaCorrente = null;
        decisionePresaPerScala = false; // Resetta per future scale
        randDecisioneScala = -1;
        if (destra) dir = 1;
        else dir = -1;
      }
    } else if (distanzaCaduta > 0) {
      y += squareH * 0.1; // Velocità di caduta
      distanzaCaduta -= squareH * 0.1;
      if (distanzaCaduta <= 0) {
        distanzaCaduta = 0;
        if (destra) dir = 1;
        else dir = -1;
      }
    } else {
      x += speed * dir;
      offset();
      scendiScale();
    }


    if (!scendendo && distanzaCaduta <= 0) {
      gridPosX = round(x / (width / 28.0));

      if (gridPosX >= 28 && dir == 1) {
        distanzaCaduta = squareH * 2.4; 
        destra = false; 
        dir = 0; 
        x = (28 * (width / 28.0)) - squareW / 2; 
      } else if (gridPosX <= 1 && dir == -1) { 
        distanzaCaduta = squareH * 2.4;
        destra = true;
        dir = 0; 
        x = (1 * (width / 28.0)) + squareW / 2; // Correggi posizione
      }
    }
    
    // Aggiorna sempre le posizioni grid alla fine del movimento
    gridPosX = round(x / (width / 28.0));
    gridPosY = round(y / (height / 32.0));
    
    hitboxL = x - larghezza / 2 + squareW * 0.7;
    hitboxR = x + larghezza / 2 - squareW * 0.7;
    hitboxU = y - altezza / 2 + squareH * 0.7;
    hitboxD = y + altezza / 2 - squareH * 0.7;
  }
  
  boolean daRimuovere() {
    if (x - larghezza/2 > width && x + larghezza < 0 && y - altezza > height)
      return true;
      
    return false;
  }

  void scendiScale() {
    if (scendendo || distanzaCaduta > 0) return; 

    boolean sopraUnaScalaAttualmente = false;

    for (Scala s : scale) {
      boolean inX = x > s.x - squareW * 0.6 && x < s.x + squareW * 0.6; 

      boolean inYDecisionZone = (y > s.yUp - squareH * 0.6) && (y < s.yUp + squareH * 0.6);


      if (inX && inYDecisionZone) {
        sopraUnaScalaAttualmente = true;
        if (!decisionePresaPerScala) {
          randDecisioneScala = int(random(100));
          decisionePresaPerScala = true;
        }

        if (decisionePresaPerScala && randDecisioneScala >= 65) {
          scendendo = true;
          scalaCorrente = s;
          x = s.x + squareW * 0.5; 
          destra = !destra; 
          dir = 0;
          break;
        }
      }
    }

   if (!sopraUnaScalaAttualmente) {
      decisionePresaPerScala = false;
      randDecisioneScala = -1;
    }
  }

  void offset() {
    if (dir != 0 && !scendendo && distanzaCaduta <= 0) {
      if (gridPosY >= 28) {
        if (gridPosX >= 14)
          y -= speed/15 * dir;
      } else if (gridPosY >= 24) {
        y += speed/15 * dir;
      } else if (gridPosY >= 20) {
        y -= speed/15 * dir;
      } else if (gridPosY >= 16) {
        y += speed/15 * dir;
      } else if (gridPosY >= 12) {
        y -= speed/15 * dir;
      } else if (gridPosY >= 9) {
        if (gridPosX >= 18) {
          y += speed/15 * dir;
        }
      }
    }
  }
}


class DonkeyKong {
  float x = squareW * 5.3, y = squareH * 9;
  PImage[] sprites = new PImage [4];
  float frameIndex = 0;

  
  
  void draw() {
    int i = 0;
    
    if (frameIndex > 90) frameIndex = 0;
    else if (frameIndex > 70) i = 3;
    else if (frameIndex > 50) i = 2;
    else if (frameIndex > 30) i = 1;
    
    if (!vittoria)
      image(sprites[i], x, y, squareW * 6, squareH * 4); 
    
    if (!mario.morto && !onMenu && !vittoria)
      frameIndex += 1;
    
    if (vittoria)
    {
    image(dkongAngry, x, y, squareW * 6, squareH * 4); 
    }
  }
} DonkeyKong dKong;


class Martello {
  float x, y;
  float larghezza = squareW, altezza = squareH;
  float hitboxL, hitboxR, hitboxU, hitboxD;
  boolean daRimuovere = false;

  
  Martello(float x_, float y_) {
    x = squareW * x_;
    y = squareH * y_;
    
    hitboxL = x - larghezza / 2 + squareW * 0.7;
    hitboxR = x + larghezza / 2 - squareW * 0.7;
    hitboxU = y - altezza / 2 + squareH * 0.7;
    hitboxD = y + altezza / 2 - squareH * 0.7;
  }
  
  void draw() {
    image(martello, x, y, squareW * 1, squareH * 1); 
  }
}
