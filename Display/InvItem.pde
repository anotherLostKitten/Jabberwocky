public class InvItem{
     //item id:
    //101: Knife (default item with infinite durability)
    //102: Sword
    //103: Spear
    //104: Axe
    //105: Potion
    //106: Spell
  int durability;
  int restoreHealth;
  int restoreMagic;
  int damage;
  
  public InvItem(int level, int ID){
    if (ID == 101){
       durability = -100;//infinite use
       damage = 10 + 10*level;}
    if (ID == 102){
       durability = 5 + 3*level;
       damage = 50 + 5*level;}
    if (ID == 103){
       durability = 10 + 2*level;
       damage = 30 + 20*level;}
    if (ID == 104){
       durability = 15 + level;
       damage = 20 + 25*level ;}    
    if (ID == 105){
       durability = 1;
       restoreHealth = 150 + 10*level;
      damage =0;}
    if (ID == 106){
       durability = 1;
       restoreMagic = 25 + 10*level;
      damage =0;}  
       }
       
  Boolean reduceDurability(){ //returns false if the weapon/potion/spell is used up.
    durability -= 1;
    if (durability == -1){
      return false;
    }
    return true;
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