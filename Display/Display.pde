int[][] room = (new Dungeon(79, 79, 5, 11)).getDungeon();
PImage floor;
Player automaton = new Player();
PFont f;
int olCount = 0;//movement purposes

void setup(){
  size(900, 600);
  imageMode(CENTER);
  f = createFont("Monospaced.bold", 20, true);
  floor = loadImage("../data/floor.png");
  frameRate(5);
}
  void draw(){
  background(0,0,0);
  noStroke();
    for(int y = automaton.arrayY - 7; y <= automaton.arrayY + 7; y += 1){
      for (int x = automaton.arrayX - 7; x <= automaton.arrayX + 7; x += 1){
        if (y > -1 && y < room.length && x > -1 && x < room[0].length &&
          room[y][x] >= 1){ 
            int horhor = (x + 7 - automaton.arrayX) * 40 + 20;
            int hihi = (y + 7 - automaton.arrayY) * 40 + 20;
            //pushMatrix();
            //rotate(HALF_PI);
            //translate(hihi - horhor, -hihi - horhor);
            image(floor, horhor, hihi, 40, 40);
            //popMatrix();
        }
      }
    }
    fill(#5A5757);
    rect(600, 0, 400, 600);
    automaton.display();
    //health
    fill(255, 128, 128);
    rect(635, 120, 225, 20);
    fill(255,0,0);
    rect(635, 120, automaton.health * 3 / 4, 20);
    //attack
    fill(128, 255, 128);
    rect(635, 200, 225, 20);
    fill(0, 255, 0);
    rect(635, 200, 225, 20);
    //magic
    fill(128, 128, 255);
    rect(635, 280, 225, 20);
    fill(0, 0, 255);
    rect(635, 280, 225, 20);
    //words
    textFont(f, 20);
    fill(255,255,255);
    textAlign(CENTER);
    text("Health", 750, 100);
    text(automaton.health + " / 300", 750, 137);
    text("Attack", 750, 180);
    text(automaton.attack + " / 50", 750, 217);
    text("Magic", 750, 260);
    text(automaton.magic + " / 50", 750, 297);
  }
  
  void keyPressed(){
    if (key == CODED && olCount != frameCount){
      if (keyCode == DOWN && room[automaton.arrayY + 1][automaton.arrayX] >= 1){
        automaton.moveY(1);
      }
      else if (keyCode == UP && room[automaton.arrayY - 1][automaton.arrayX] >= 1){
        automaton.moveY(-1);
      }
      else if (keyCode == LEFT && room[automaton.arrayY][automaton.arrayX - 1] >= 1){
        automaton.moveX(-1);
      }
      else if (keyCode == RIGHT && room[automaton.arrayY][automaton.arrayX + 1] >= 1){
        automaton.moveX(1);
      }
    }
    olCount = frameCount;
  }