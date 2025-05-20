class Mario {
  float x = squareW * 5, y = squareH * 30.15;
  float larghezza = squareW * 2, altezza = squareH * 1.85;
  float hitboxL, hitboxR, hitboxU, hitboxD;
  int gridPosX, gridPosY;
  int dir; // 0 = fermo, 1 = destra, -1 = sinistra
  final float SPEED = 5;
  float frameIndex = 0;
  PImage[] camminata = new PImage[4];
  PImage[] scalata = new PImage[2];
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


  void move() {
    // Camminata
    if (!salendo) {
      x += SPEED * width / 800 * dir; // Muove sull'asse x aggiungendo velocità e normalizzandola per la larghezza
    }

    // Salto
    if (salitaSalto) {
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
      if (!salendo) { // Appena arriva su una scala
        yInizioScala = y; // Salva la y di partenza sulla piattaforma
      }
      if (upPremuto) {
        salendo = true;
        mario.x = xScala; // Allinea Mario alla x della scala
        mario.y -= height / 256; // Sale
      }
      if (downPremuto && salendo) { // Può scendere solo se è già in modalità 'salendo'
        if (y < yInizioScala) { // Se è più in alto del punto in cui ha iniziato a salire dalla piattaforma
          mario.y += height / 256; // Scende
        } else { // Se torna alla y della piattaforma o sotto
          salendo = false; // Esce dalla modalità scala
          y = yInizioScala; // Si riposiziona precisamente sulla piattaforma
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
    collisioni();
  }

  void draw() {
    pushMatrix();
    translate(x, 0); // Trasla solo sull'asse x per lo scaling
    if (salendo) {
      if (upPremuto || downPremuto) { // Animazione solo se si muove sulla scala
        frameIndex += 0.2;
        if (frameIndex >= scalata.length)
          frameIndex = 0;
      }
      // Disegna sempre l'immagine della scalata se 'salendo' è true
      // Se non si muove, mostra l'ultimo frame dell'animazione
      image(scalata[int(frameIndex)], 0, y, larghezza, altezza);
    } 
    else if (salitaSalto || discesaSalto) {
        if (dir == -1 || (!idleDestra && dir == 0)) { // Se va a sinistra o era a sinistra ed è fermo
          scale(-1, 1); // Specchia l'immagine
        }
        image (salto, 0, y, larghezza, altezza);
    }
    else { // Non sta salendo scale
      if (dir == -1 || (!idleDestra && dir == 0)) { // Se va a sinistra o era a sinistra ed è fermo
        scale(-1, 1); // Specchia l'immagine
      }

      if (dir != 0) { // Se si sta muovendo orizzontalmente
        frameIndex += 0.5; // Velocità animazione camminata
        if (frameIndex >= camminata.length)
          frameIndex = 0;
        image(camminata[int(frameIndex)], 0, y, larghezza, altezza);
        idleDestra = (dir == 1); // Aggiorna l'ultimo stato di direzione per l'idle
      } 
      else { // Se è fermo (idle)
        image(camminata[0], 0, y, larghezza, altezza); // Mostra il primo frame come idle
      }
    }
    popMatrix();

  }


  boolean suScala() {
    for (Scala scala : scale) {
      // Controlla se Mario è all'interno della larghezza della scala
      if (x > scala.x - squareW / 2 && x < scala.x + squareW / 2) {
        // Controlla se Mario è verticalmente sulla scala
        // y è la base di Mario, quindi deve essere tra yUp e yDown della scala
        // Aggiustamento per permettere a Mario di "agganciarsi" un po' prima
        if (y > scala.yUp - squareH * 0.45 && y < scala.yDown + squareH * 0.5) {
          xScala = scala.x; // Salva la x della scala per allineare Mario
          return true;
        }
      }
    }
    // Se esce dal loop senza aver trovato una scala, non è su una scala
    // salendo = false; // Viene gestito meglio in move()
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
        mario.hitboxR > barile.hitboxL &&
        mario.hitboxL < barile.hitboxR &&
        mario.hitboxD > barile.hitboxU &&
        mario.hitboxU < barile.hitboxD;
      if (collisioneBarile)
        println("coll");
    }
  }
} Mario mario;


class Scala {
  float yUp, yDown; // Coordinate y della parte superiore e inferiore della scala
  float x;          // Coordinata x (centro della scala)

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
  int dir = 1; // Direzione di rotolamento: 1 per destra, -1 per sinistra, 0 per fermo/caduta
  float distanzaCaduta = 0; // Distanza rimanente da cadere quando cade da un bordo
  boolean destra = true;
  float frameIndex = 0;

  boolean scendendo = false; // True se il barile sta attualmente scendendo una scala
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

  void rotola() {
    if (scendendo) {
      // Sta scendendo una scala
      y += squareH * 0.1; // Velocità di discesa sulla scala
      if (scalaCorrente != null && y >= scalaCorrente.yDown - squareH * 0.1) { // Arrivato in fondo alla scala (o quasi)
        scendendo = false;
        y = scalaCorrente.yDown; // Allinea precisamente alla fine della scala
        scalaCorrente = null;
        decisionePresaPerScala = false; // Resetta per future scale
        randDecisioneScala = -1;
        // Imposta la direzione di rotolamento per la nuova piattaforma
        if (destra) dir = 1;
        else dir = -1;
      }
    } else if (distanzaCaduta > 0) {
      // Sta cadendo da un bordo (non scendendo una scala)
      y += squareH * 0.1; // Velocità di caduta
      distanzaCaduta -= squareH * 0.1;
      if (distanzaCaduta <= 0) {
        distanzaCaduta = 0;
        // Imposta la direzione di rotolamento per la nuova piattaforma
        if (destra) dir = 1;
        else dir = -1;
        // Aggiustamento y per allinearsi alla piattaforma sottostante potrebbe essere necessario qui,
        // a seconda di come sono definite le altezze delle piattaforme.
        // Per ora, si assume che l'offset gestisca le altezze corrette.
      }
    } else {
      // Non sta scendendo scale e non sta cadendo da un bordo -> rotola orizzontalmente
      x += speed * dir;
      offset(); // Applica l'inclinazione della piattaforma (se presente)
      scendiScale(); // Controlla se incontra una scala e deve iniziare a scendere
    }

    // Logica di caduta ai bordi della piattaforma (solo se non sta già scendendo una scala)
    // e non sta già cadendo
    if (!scendendo && distanzaCaduta <= 0) {
      gridPosX = round(x / (width / 28.0)); // Aggiorna gridPosX prima del controllo bordi

      if (gridPosX >= 28 && dir == 1) { // Bordo destro (originale: gridPosX == 28)
        distanzaCaduta = squareH * 2.4; // Imposta l'altezza della caduta
        destra = false; // Cambia direzione per la prossima piattaforma
        dir = 0; // Ferma il movimento orizzontale durante la caduta
        x = (28 * (width / 28.0)) - squareW / 2; // Correggi posizione per evitare di superare troppo
      } else if (gridPosX <= 1 && dir == -1) { // Bordo sinistro (originale: gridPosX == 1)
        distanzaCaduta = squareH * 2.4;
        destra = true; // Cambia direzione per la prossima piattaforma
        dir = 0; // Ferma il movimento orizzontale durante la caduta
        x = (1 * (width / 28.0)) + squareW / 2; // Correggi posizione
      }
    }
    
    // Aggiorna sempre le posizioni grid alla fine del movimento
    gridPosX = round(x / (width / 28.0));
    gridPosY = round(y / (height / 32.0));
    
    hitboxL = x - larghezza / 2;
    hitboxR = x + larghezza / 2;
    hitboxU = y - altezza / 2;
    hitboxD = y + altezza / 2;
  }

  void scendiScale() {
    if (scendendo || distanzaCaduta > 0) return; // Già impegnato in discesa o caduta

    boolean sopraUnaScalaAttualmente = false;

    for (Scala s : scale) {
      // Il barile è orizzontalmente allineato con la scala?
      boolean inX = x > s.x - squareW * 0.6 && x < s.x + squareW * 0.6; // Tolleranza leggermente aumentata

      // Il barile è verticalmente posizionato per poter scendere questa scala?
      // La y del barile (centro) deve essere vicina alla yUp della scala.
      // Consideriamo un intervallo piccolo sopra s.yUp.
      boolean inYDecisionZone = (y > s.yUp - squareH * 0.6) && (y < s.yUp + squareH * 0.6);


      if (inX && inYDecisionZone) {
        sopraUnaScalaAttualmente = true;
        if (!decisionePresaPerScala) {
          randDecisioneScala = int(random(100)); // Es. 0-39 non scende (40%), 40-99 scende (60%)
          decisionePresaPerScala = true;
          // println("Barile (" + nf(x,0,1) + "," + nf(y,0,1) + ") sopra scala (" + s.x + "," + s.yUp + "). Decisione: " + randDecisioneScala);
        }

        // Se ha deciso di scendere (es. random > 39) e la decisione è stata presa
        if (decisionePresaPerScala && randDecisioneScala >= 65) {
          scendendo = true;
          scalaCorrente = s;
          x = s.x + squareW * 0.5; // Allinea il barile al centro della scala
          destra = !destra; // Inverti la direzione di rotolamento per la prossima piattaforma
          dir = 0; // Ferma movimento orizzontale mentre scende la scala
          // println("Barile inizia a scendere scala a x:" + x);
          break; // Inizia a scendere questa scala, esce dal loop
        }
      }
    }

    // Se il barile non è più orizzontalmente sopra nessuna scala con cui potrebbe interagire,
    // resetta il flag della decisione. Questo permette una nuova decisione al prossimo incontro.
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
    
    image(sprites[i], x, y, squareW * 6, squareH * 4); 
    
    frameIndex += 1;
  }
} DonkeyKong dKong;
