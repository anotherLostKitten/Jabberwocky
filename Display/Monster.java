public class Monster extends Item{
    
    private int level;
    private int health;
    private int attack;
    private int arrayX;
    private int arrayY;
    private int state;

    public Monster(){
	state = 1;
	level = 1;
	health = 50;
	attack = 20;
	arrayX = 
	arrayY = 
    }

    public void die(){
	dropCoin();
    }
    
    public void setHealth(int damage){
	health = health - damage;
	if (health < 0){
	    state = 0;
	}
    }
    
}
