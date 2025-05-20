PImage scala, trave, barileVerticale, martello, peach, oil, menu, menuStart;
PImage rotolamentoBarili[] = new PImage[4];
PImage discesaBarili[] = new PImage[2];

int menuStartIndex = 0;

float lastWidth = 1, lastHeight = 1;
float squareW, squareH;

boolean onMenu = true;

int rand;

ArrayList<Scala> scale = new ArrayList<Scala>();
ArrayList<Barile> barili = new ArrayList<Barile>();
ArrayList<Martello> martelli = new ArrayList<Martello>();


float tempoSpawn = 0;

boolean upPremuto = false;
boolean downPremuto = false;


int i = 0;

final int barrelTimeSpawn = 90;

import processing.sound.*;

SoundFile levelMusic;
SoundFile deathMusic;

Movie intro, vittoria;
boolean showIntro = true;
