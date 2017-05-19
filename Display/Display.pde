ArrayList<Item> room = new ArrayList<Item>();
Player automaton = new Player();

void setup(){
  size(600, 600);
  for (int x = 0; x < 620; x += 20){
    for (int y = 0; y < 620; y += 20){
      if (x == 0 || x == 600 || y == 0 || y == 600){
        room.add(new Wall(x, y));
      }
      else{
        room.add(new Floor(x, y));
      }
    }
  }
}
  void draw(){
    for (Item thing: room){
      if(thing.x - automaton.x <= 20 && thing.x - automaton.x >= -20 &&
      thing.y - automaton.y <= 20 && thing.y - automaton.y >= -20){
        thing.explored = true;
      }
      thing.display();
    }
    automaton.display();
  }