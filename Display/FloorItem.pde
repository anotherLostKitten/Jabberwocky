public class FloorItem extends Item {
  private int id;
  public boolean pickedUp;
  public FloorItem(int r, int c) {
    super(r, c, "monster.png");  
    id = (int) random(4) + 1;
    pickedUp = false;
    String[] tex = {"dagger.png", "sword.png", "spear.png", "morningstar.png", "potion.png"};
    imag = loadImage(tex[id]);
  }
  int getId(){return id;}
}