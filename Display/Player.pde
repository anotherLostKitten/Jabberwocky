class Player extends Item{
  int coin;
  int attack;
  int health;
  int level;
  int magic;
  int[] inventory;
  Player(){
    super(280, 280, #FFFFFF);
    explored = true;
    coin = 0;
    attack = 50;
    health = 300;
    level = 1;
    magic = 50;
    inventory = new int[7];
    inventory[0] = 1;  //sets the first slot as knife
    arrayX = (int) random(room[0].length);
    arrayY = (int) random(room.length);
    while (room[arrayY][arrayX] < 1){
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
  
  void setCoin(int i){
      coin += i;
      if (coin <0){ //if you're in debt
         coin -= i;  //take back your money 
         System.out.println("oops. can't buy that. you're broke");
      }
  }
  
  Boolean buyItem(int item){
    //item id:
    //101: Knife (default item with infinite durability)
    //102: Sword
    //103: Spear
    //104: Axe
    //105: Potion
    //106: Spell
    InvItem bloop = new InvItem(item);
    int x = 0;
    while (inventory[x] == 0){
      if (x < 7){
      x++;
      }
      else{
        System.out.println("inventory is full.");
        return false;
      }
    }
    inventory[x] = bloop;
    return true;
  }
  
  int useItem(int slot){
    
  }
  
}