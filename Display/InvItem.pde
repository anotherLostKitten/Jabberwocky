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
    if (ID == 101){
      idNum = 101;
       durability = -100;//infinite use
       damage = 10;}
    if (ID == 102){
      idNum = 102;
       durability = 5;
       damage = 50;}
    if (ID == 103){
      idNum = 103;
       durability = 10;
       damage = 30;}
    if (ID == 104){
      idNum = 104;
       durability = 15;
       damage = 20;}    
    if (ID == 105){
      idNum = 105;
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