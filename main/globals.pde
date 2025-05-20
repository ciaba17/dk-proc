PImage scala, trave, barileVerticale, menu;
PImage rotolamentoBarili[] = new PImage[4];
PImage discesaBarili[] = new PImage[2];

float lastWidth = 1, lastHeight = 1;
float squareW, squareH;

boolean onMenu = true;

int rand;

ArrayList<Scala> scale = new ArrayList<Scala>();
ArrayList<Barile> barili = new ArrayList<Barile>();

float tempoSpawn = 0;

boolean upPremuto = false;
boolean downPremuto = false;


int i = 0;

final int barrelTimeSpawn = 90;
