public class Monster extends Item{
    
    private int level;
    private int health;
    private int attack;
    private int arrayX;
    private int arrayY;
    private int state;
    
    public Monster(int lvl, int x, int y){
      super(x, y, #FFFFFF);
	state = 1;
	level = lvl;
	health = 50 + level * (int)(Math.random()*20);
	attack = 20 + level * (int)(Math.random()*20);
	arrayX = x;
	arrayY = y;
    }

    public void die(){
	//dropCoin();
	state = 0;//monster disappears and drops a coin
    }
    
    public void setHealth(int damage){
	health = health - damage;
	if (health < 0){
	    die();
	}
    }
    
}