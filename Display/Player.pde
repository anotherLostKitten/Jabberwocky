class Player extends Item {
  int attack;
  int health; 
  int usingSlot = 0;
  //int magic;     
  InvItem[] inventory;
  Player() {
    super(0, 0, "player.png");
    attack = 10;
    health = 300;
    //magic = 50;
    x = 280;
    y = 280;
    inventory = new InvItem[4];
    inventory[0] = new InvItem(0);  //sets the first slot as knife
    arrayX = (int) random(room[0].length);
    arrayY = (int) random(room.length);
    while (room[arrayY][arrayX] < 1) {
      arrayX = (int) random(room[0].length);
      arrayY = (int) random(room.length);
    }
    //arrayX = 1;
    //arrayY = 1;
  }
  void moveX(int thing) {
    arrayX += thing;
  }
  void moveY(int thing) {
    arrayY += thing;
  }

  
  
  
  
  void pickUp(FloorItem q) {
      getItem(q.id);
  }




  Boolean getItem(int itemID) {
    //item id:
    //101: Knife (default item with infinite durability)
    //102: Sword
    //103: Spear
    //104: Axe
    //105: Potion
    //106: Spell
    InvItem bloop = new InvItem(itemID); //creates inventory item
    int x = 0; 
    while (inventory[x] != null) {
      if (x < inventory.length - 1) {
        x++;
      } else {
        System.out.println("inventory is full.");
        return false;
      }
    }
    inventory[x] = bloop; //adds inventory item to an open inventory slot
    return true;
  }

  void useItem(int slot) {//returns damage, if no damage returns 0;
    if (inventory[slot].reduceDurability()) {//if it doesnt break
      if (inventory[slot].getID() == 4) {//if its a potion, restore health
        health+= 150;
        if (health > 300){
         health = 300; 
        }
      }
      /*if (inventory[slot].getID() == 106){// if its a spell, restore magic
       magic+= inventory[slot].getRestMagic();
       }*/
      attack = inventory[slot].getDamage(); //all invItems return damage (even 0)
    }
    else {
      inventory[slot] = null;
    }
  }
}