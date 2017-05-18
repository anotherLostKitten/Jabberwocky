class Item {
  int size;
  int x;
  int y;
  color col;
  Item(int hori, int vert, color whatever){
    size = 10;
    x = hori;
    y = vert;
    col = whatever;
  }
  display(){
    fill(col);
    rect(x, y, size, size);
  }
}