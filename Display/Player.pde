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
    super(140, 140, #FFFFFF);
    explored = true;
    coin = 0;
    attack = 50;
    health = 300;
    level = 1;
    magic = 50;
    weapon = 0;
    arrayX = (room[0].length + 1) / 2;
    arrayY = (room.length + 1) / 2;
  }
  void moveX(int thing){
    arrayX += thing;
  }
  void moveY(int thing){
    arrayY += thing;
  }
}