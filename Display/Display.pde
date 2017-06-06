int[][] room;
String[] textureNames = { 
  "missing", "floor", "floorTorch", "floorPuddle", "floorShrubbery", "door", "bedTop", "bedBottom", "toilet", "carpetEdge", "carpetCentre", "table", "tableTools", "rackLeft", "rackRight", "wineCaskRight", "wineCaskLeft", "wineCaskUpright", "altar", "roseTop", "roseLeft", "roseRight", "roseBottom", "roseCentre", "furnace", "cupboard", "bathNE", "bathSE", "bathSW", "bathNW", "throne", "steps", "tableFood", "fancyTable", "fancyFood" };
PImage[] textures = new PImage[textureNames.length];
PImage floor;
Player automaton;
PFont f;
int olCount = 0;//movement purposes
int gameState = 0;
Monster[] enemy = new Monster[32];
FloorItem[] friend = new FloorItem[64];
void setup() {
  room = (new Dungeon(79, 79, 5, 11, sketchPath(""))).getDungeon();
  automaton = new Player();
  size(900, 600);
  imageMode(CENTER);
  f = createFont("Monospaced.bold", 20, true);
  for (int i = 0; i < textureNames.length; i++ ) {
    textures[i] = loadImage("../data/" + textureNames[i] + ".png");
  }
  for (int monmon = 0; monmon < enemy.length; monmon += 1) {
    int xmon = (int) random(room[0].length);
    int ymon = (int) random(room.length);
    while (room[ymon][xmon] == 0 || (xmon == automaton.arrayX && ymon == automaton.arrayY)) {
      xmon = (int) random(room[0].length);
      ymon = (int) random(room.length);
    }
    enemy[monmon] = new Monster(xmon, ymon);
  }
  for (int monmon = 0; monmon <  friend.length; monmon += 1) {
    int xmon = (int) random(room[0].length);
    int ymon = (int) random(room.length);
    while (room[ymon][xmon] == 0 || (xmon == automaton.arrayX && ymon == automaton.arrayY)) {
      xmon = (int) random(room[0].length);
      ymon = (int) random(room.length);
    }
    friend[monmon] = new FloorItem(xmon, ymon);
  }
  frameRate(5);
}
void draw() {
  if (gameState == 0) {
    background(0, 0, 0);
    noStroke();
    for (int y = automaton.arrayY - 7; y <= automaton.arrayY + 7; y += 1) {
      for (int x = automaton.arrayX - 7; x <= automaton.arrayX + 7; x += 1) {
        if (y > -1 && y < room.length && x > -1 && x < room[0].length &&
          room[y][x] != 0) { 
          int horhor = (x + 7 - automaton.arrayX) * 40 + 20;
          int hihi = (y + 7 - automaton.arrayY) * 40 + 20;
          if ( room[y][x] < 0 ) {
            pushMatrix();
            rotate(HALF_PI);
            translate(hihi - horhor, -hihi - horhor);
            image(textures[-1 * room[y][x]], horhor, hihi, 40, 40);
            popMatrix();
          } else {
            image(textures[room[y][x]], horhor, hihi, 40, 40);
          }
        }
      }
    }
    for (FloorItem flr : friend) {
      if (! flr.pickedUp) {
        if (automaton.arrayX == flr.arrayX && automaton.arrayY == flr.arrayY) {
          automaton.pickUp(flr);
          flr.pickedUp = true;
        } else {
          flr.placeTo(automaton);
          flr.display();
        }
      }
    }
    int monCount = 0;
    for (Monster mon : enemy) {
      if (mon.alive) {
        monCount++;
        if (mon.arrayX == automaton.arrayX && mon.arrayY == automaton.arrayY) {
          if (mon.setHealth(automaton.attack))
            mon.alive = false;
        }
        int[][] mov = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
        int q = 4;
        while ( q > 0 ) {
          int m = (int) random(q);
          if (room[mon.arrayY + mov[m][1]][mon.arrayX + mov[m][0]] != 0) {
            mon.move(mov[m]);
            break;
          }
          int[] temp = mov[m];
          mov[m] = mov[q - 1];
          mov[q - 1] = temp;
          q--;
        }
        if (mon.arrayX == automaton.arrayX && mon.arrayY == automaton.arrayY) {
          automaton.health-=mon.getAttack();
          if (automaton.health <= 0) {
            automaton.health=0;
            gameState = -1;
          }
        }
        mon.placeTo(automaton);
        mon.display();
      }
    }
    if ( monCount == 0 ) {
       gameState = 1; 
    }
    fill(#5A5757);
    rect(600, 0, 400, 600);
    automaton.display();
    //health
    fill(255, 128, 128);
    rect(635, 120, 225, 20);
    fill(255, 0, 0);
    rect(635, 120, automaton.health * 3 / 4, 20);
    //attack
    fill(128, 255, 128);
    rect(635, 200, 225, 20);
    fill(0, 255, 0);
    rect(635, 200, automaton.attack * 3 / 4, 20);
    //magic
    //fill(128, 128, 255);
    //rect(635, 280, 225, 20);
    //fill(0, 0, 255);
    //rect(635, 280, 225, 20);
    //words
    textFont(f, 20);
    fill(255, 255, 255);
    textAlign(CENTER);
    text("Health", 750, 100);
    text(automaton.health + " / 300", 750, 137);
    text("Attack", 750, 180);
    text(automaton.attack + " / 300", 750, 217);
    //text("Magic", 750, 260);
    //text(automaton.magic + " / 50", 750, 297);
    //inventory
    text("Inventory", 750, 260);
  } else if (gameState == 1) {
    textFont(f, 40);
    text("YOU WON", 450, 300);
  } else {
   textFont(f, 40);
   text("YOU LOST :(", 450, 300); 
  }
}

void keyPressed() {
  if (key == CODED && olCount != frameCount) {
    if (keyCode == DOWN && room[automaton.arrayY + 1][automaton.arrayX] != 0) {
      automaton.moveY(1);
    } else if (keyCode == UP && room[automaton.arrayY - 1][automaton.arrayX] != 0) {
      automaton.moveY(-1);
    } else if (keyCode == LEFT && room[automaton.arrayY][automaton.arrayX - 1] != 0) {
      automaton.moveX(-1);
    } else if (keyCode == RIGHT && room[automaton.arrayY][automaton.arrayX + 1] != 0) {
      automaton.moveX(1);
    }
  }
  olCount = frameCount;
}