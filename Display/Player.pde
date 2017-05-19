class Player extends Item{
  int coin;
  int attack;
  int health;
  int level;
  int magic;
  int weapon;
  Player(){
    super(300, 300, #FFFFFF);
    explored = true;
    coin = 0;
    attack = 50;
    health = 300;
    level = 1;
    magic = 50;
    weapon = 0;
  }
}