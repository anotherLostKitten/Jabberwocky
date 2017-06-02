public class Monster extends Item{
    
    private int level;
    private int health;
    private int attack;
    private int state;
    private int[] directions;
    
    
    public Monster(int lvl, int x, int y){
      super(x, y, #FFFFFF);
	state = 1;
	level = lvl;
	health = 50 + level * (int)(Math.random()*20);
	attack = 20 + level * (int)(Math.random()*20);
	arrayX = x;
	arrayY = y;
  directions = new int[4];
for(int X = 0; X < 3; X++){
   directions[X] = X; 
}
    }

    public void die(){
	state = 0;//monster disappears and player gains a coin
    }
    
    public void setHealth(int damage){
	health = health - damage;
	if (health < 0){
	    die();
	}
    }
    
    public void navigate(){
      for(int x : directions){
          swap( (int)(random(3)) , (int)(random(3))); 
      }
      
      //once you find space that is not a wall, go to that space
      
    }
    
  public void swap(int a , int b  ){
      int temp = directions[a];
      directions[a] = directions[b];
      directions[b] = temp; 
  }
       
    
}