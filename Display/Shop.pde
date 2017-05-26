class Shop extends Item{
                private int potionStock;
                private int spellStock;
                private int weaponStock;

              
                
                public Shop(){
                   potionStock = (int)(Math.random()*5); 
                   spellStock = (int)(Math.random()*5); 
                   weaponStock = (int)(Math.random()*5); 
                }
                public Boolean sellPotion(){
                  if (potionStock > 0){
                  potionStock --;
             return true;
            }
              return false;
                  }
                
                  public Boolean sellSpell(){
                    if (spellStock > 0){
                     spellStock --;
                     return true;
              }
                return false;
                  }
                
                  public Boolean sellWeapon(){
                    if (weaponStock > 0){
                    weaponStock --;
                  return true;  
                }
                    return false;
                  }
                
                  public Boolean outOfStock(){
                    if (potionStock == 0 && weaponStock == 0 && spellStock ==0){
                    return true;}
                    else {
                       return false; 
                    }
                  }
                
                
  }