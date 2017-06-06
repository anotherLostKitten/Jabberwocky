class Item {
  int size;
  int x;
  int y;
  PImage imag;
  int arrayX;
  int arrayY;
  Item(int row, int coll, String whatever){
    size = 40;
    arrayX = row;
    arrayY = coll;
    imag = loadImage(whatever);
  }
  void display(){
    image(imag, x + 20, y + 20, size, size);
  }
  void placeTo(Item thing){
    this.x = (arrayX + 7 - thing.arrayX)* 40;
    this.y = (arrayY + 7 - thing.arrayY) * 40;
  }
}