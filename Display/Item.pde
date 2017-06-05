class Item {
  int size;
  int x;
  int y;
  color col;
  int arrayX;
  int arrayY;
  Item(int row, int col, color whatever){
    size = 40;
    arrayX = row;
    arrayY = col;
    col = whatever;
  }
  void display(){
      fill(col);
    rect(x, y, size, size);
  }
  void placeTo(Item thing){
    this.x = (arrayX + 7 - thing.arrayX)* 40;
    this.y = (arrayY + 7 - thing.arrayY) * 40;
  }
}