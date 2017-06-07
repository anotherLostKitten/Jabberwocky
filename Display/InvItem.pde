public class InvItem{
     //item id:
    //101: Knife (default item with infinite durability)
    //102: Sword
    //103: Spear
    //104: Morningstar
    //105: Potion
  int durability;
  int restoreHealth;
  int restoreMagic;
  int damage;
  int idNum;
  
  public InvItem(int ID){
    if (ID == 0){
      idNum = 0;
       durability = -100;//infinite use
       damage = 10;}
    if (ID == 1){
      idNum = 1;
       durability = 3;
       damage = 50;}
    if (ID == 2){
      idNum = 2;
       durability = 5;
       damage = 30;}
    if (ID == 3){
      idNum = 3;
       durability = 7;
       damage = 25;}    
    if (ID == 4){
      idNum = 4;
       durability = 1;
       restoreHealth = 150;
      damage =0;}
/*    if (ID == 106){
      idNum = 106;
       durability = 1;
       restoreMagic = 25;
      damage =0;}  
   */    }
       
  Boolean reduceDurability(){ //returns false if the weapon/potion/spell is used up.
    durability -= 1;
    if (durability == -1){
      return false;
    }
    return true;
  }
  
  int getID(){
     return idNum; 
  }
  
  int getRestHealth(){
     return restoreHealth; 
  }
  
  int getRestMagic(){
     return restoreMagic; 
  }
  
  int getDamage(){
     return damage; 
  }
  
}