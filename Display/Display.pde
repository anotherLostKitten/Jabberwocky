int[][] room = (new Dungeon(79, 79, 5, 11)).getDungeon();
PImage floor;
Player automaton = new Player();
PFont f;

void setup(){
  size(900, 600);
  f = createFont("Monospaced.bold", 20, true);
  floor = loadImage("../data/floor.png");
}
  void draw(){
  background(0,0,0);
    for(int y = automaton.arrayY - 7; y <= automaton.arrayY + 7; y += 1){
      for (int x = automaton.arrayX - 7; x <= automaton.arrayX + 7; x += 1){
        if (y > -1 && y < room.length && x > -1 && x < room[0].length &&
          room[y][x] >= 1){
            noStroke();
            fill(#5D0000);
            image(floor, (x + 7 - automaton.arrayX) * 40, (y + 7 - automaton.arrayY) * 40, 40, 40);
        }
      }
    }
    automaton.display();
    textFont(f, 20);
    fill(255,255,255);
    textAlign(CENTER);
    text("Health", 750, 100);
  }
  
  void keyPressed(){
    if (key == CODED){
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
  }