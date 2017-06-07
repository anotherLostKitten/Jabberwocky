public class Monster extends Item {

  private int health;
  private int attack;
  private int mHP;
  public boolean alive;
  public Monster(int x, int y) {
    super(x, y, "monster.png");
    health = 50 +  (int) random(20);
    mHP = health;
    attack = 10 +  (int) random(16);
    alive = true;
  }


  public boolean setHealth(int damage) {
    health -= damage;
    return health < 0;
  }
  public int getAttack() {
    return attack;
  }
  public void move(int[] rc) {
    arrayX+=rc[0];
    arrayY+=rc[1];
  }
}
