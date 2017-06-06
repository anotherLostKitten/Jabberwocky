public class Monster extends Item {

  private int health;
  private int attack;

  public Monster(int x, int y) {
    super(x, y, "monster.png");
    health = 50 +  (int) random(20);
    attack = 10 +  (int) random(16);
  }


  public boolean setHealth(int damage) {
    health -= damage;
    return health < 0;
  }
    public void move(int r, int c) {
      arrayX+=r;
      arrayY+=c;
  }
}