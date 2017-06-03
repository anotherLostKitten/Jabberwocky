class Player extends Item{
  int coin;
  int attack; // attack that increases based on level
  int health;  // current health
  int healthBar; // total health (determined by the level)
  int level;
  int experience; // current experience 
  int experienceBar;  //total experience necessary to level up
  int magic;      // current magic  
  int magicBar;    // total magic (determined by the level)
  InvItem[] inventory;
  Player(){
    super(280, 280, #FFFFFF);
    coin = 0;
    attack = 50;
    health = 300;
    healthBar = 300;
    level = 1;
    magic = 50;
    magicBar = 50;
    inventory = new InvItem[7];
    inventory[0] = new InvItem(1, 101);  //sets the first slot as knife
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
  
  void addExperience( int x){
     experience += x;
     if (experience == experienceBar){
       int temp = experienceBar - experience; 
       levelUp();
       experience = temp;
     }
  }
  
  void levelUp(){
   level += 1;
   healthBar += 20;
   magicBar += 20;
   attack += 20;
  }
  
  void setCoin(int i){
      coin += i;
      if (coin <0){ //if you're in debt
         coin -= i;  //take back your money 
         System.out.println("oops. can't buy that. you're broke");
      }
  }
 
  
  Boolean buyItem(int level, int itemID){
    //item id:
    //101: Knife (default item with infinite durability)
    //102: Sword
    //103: Spear
    //104: Axe
    //105: Potion
    //106: Spell
    InvItem bloop = new InvItem(level, itemID); //creates inventory item
    int x = 0; 
    while (inventory[x] == null){
      if (x < 7){
      x++;
      }
      else{
        System.out.println("inventory is full.");
        return false;
      }
    }
    inventory[x] = bloop; //adds inventory item to an open inventory slot
    return true;
  }
  
  int useItem(int slot){//returns damage, if no damage returns 0;
      if (inventory[slot].reduceDurability()){//if it doesnt break
        if (inventory[slot].getID() == 105){//if its a potion, restore health
            health+= inventory[slot].getRestHealth();
        }
        if (inventory[slot].getID() == 106){// if its a spell, restore magic
            magic+= inventory[slot].getRestMagic();
        }
        return inventory[slot].getDamage(); //all invItems return damage (even 0) 
      }
      else{
        inventory[slot] = null;
        return 0;
      }
      
  }
  
}