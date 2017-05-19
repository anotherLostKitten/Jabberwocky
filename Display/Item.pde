class Item {
  int size;
  int x;
  int y;
  color col;
  boolean explored;
  Item(int hori, int vert, color whatever){
    size = 20;
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
}