class Player extends Item{
  int coin;
  int attack;
  int health;
  int level;
  int magic;
  int weapon;
  int arrayX;
  int arrayY;
  Player(){
    super(280, 280, #FFFFFF);
    explored = true;
    coin = 0;
    attack = 50;
    health = 300;
    level = 1;
    magic = 50;
    weapon = 0;
    arrayX = (int) random(room[0].length);
    arrayY = (int) random(room.length);
    while (room[arrayY][arrayY] < 1){
      arrayX = (int) random(room[0].length);
      arrayY = (int) random(room.length);
    }
    //arrayX = 1;
    //arrayY = 1;
  }
  void moveX(int thing){
    arrayX += thing;
  }
  void moveY(int thing){
    arrayY += thing;
  }
}