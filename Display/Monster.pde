public class Monster extends Item {

  private int health;
  private int attack;

  public Monster(int x, int y) {
    super(x, y, #FFFFFF);
    health = 50 +  random(20);
    attack = 10 +  random(16);
  }


  public boolean setHealth(int damage) {
    health -= damage;
    return health < 0;
  }
  public  
    public void move(int r, int c) {
      arrayX+=r;
      arrayY+=c;
  }
}