public class Monster extends Item{
    
    private int level;
    private int health;
    private int attack;
    private int arrayX;
    private int arrayY;
    private int state;

    public Monster(){
	
    }

    public void die(){
	dropCoin();
    }
    
    public void setHealth(int damage){
	health = health - damage;
	if (health < 0){
	    die();
	}
    }
    
}
