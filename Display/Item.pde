class Item {
  int size;
  int x;
  int y;
  color col;
  boolean explored;
  int arrayX;
  int arrayY;
  Item(int hori, int vert, color whatever){
    size = 40;
    x = hori;
    y = vert;
    col = whatever;
    explored = false;
  }
  void display(){
    if (explored){
      fill(col);
    }
    else {
      fill(color(0,0,0));
    }
    rect(x, y, size, size);
  }
  void placeTo(Item thing){
    this.x = arrayX + 7 - thing.arrayX;
    this.y = arrayY + 7 - thing.arrayY;
  }
}