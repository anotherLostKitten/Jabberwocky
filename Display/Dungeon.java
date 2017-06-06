import java.util.Random;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

public class Dungeon {
  private int[][] d;
  private String dataPath;
  public Dungeon(int rows, int coll, int rmin, int rmax, String dp) {
    dataPath = dp;
    d = new int[rows][coll];
    List<int[]> rooms = new LinkedList<int[]>();
    int placeNumber = 1;
    // generate rooms
    for ( int i = 0; i < 200; i++ ) {
      int rowC = rOdd(1, rows), colC = rOdd(1, coll), rRow = rOdd(rmin, rmax), rCol = rOdd(rmin, rmax);
      if ( roomify(rowC, colC, rRow, rCol, placeNumber) ) {
        placeNumber++;
        rooms.add(new int[]{rowC, colC, rRow, rCol});
      }
    }
    // generate maze inbetween
    for ( int i = 1; i < rows; i += 2 ) 
      for ( int j = 1; j < coll; j += 2 ) 
        if ( d[i][j] == 0 )
          mazeify(i, j, placeNumber++);
    // connect rooms & maze
    // -- find all possible connections
    List<int[]> con = new ArrayList<int[]>();
    for ( int i = 1; i < rows - 1; i++ )
      for ( int j = 1; j < coll - 1; j++ ) {
        int[] temp = conn(i, j);
        if ( temp != null )
          con.add(temp);
      }
    // -- connect all reigons w/ different number ( not 0 )
    List<Integer> visit = new ArrayList<Integer>(placeNumber - 1);
    visit.add(1);
    Random r = new Random();
    while ( visit.size() < placeNumber - 1 ) {
      int q = r.nextInt(con.size());
      int[] tcon = con.get(q);
      if ( visit.contains(tcon[2]) ^ visit.contains(tcon[3]) ) {
        d[tcon[0]][tcon[1]] = 5; // door at 5
        if ( visit.contains(tcon[2]) )
          visit.add(tcon[3]);
        else
          visit.add(tcon[2]);
      }
      con.remove(q);
    }
    // -- add some extra connections
    for ( int i = 0; i < con.size() / 50; i++ ) {
      int q = r.nextInt(con.size());
      d[con.get(q)[0]][con.get(q)[1]] = 2; // door at 5
      con.remove(q);
    }
    // remove dead ends
    for ( int i = 1; i < rows - 1; i++ )
      for ( int j = 1; j < coll - 1; j++ )
        rde(i, j);
    // floorify maze
    for ( int i = 1; i < rows - 1; i++ )
      for ( int j = 1; j < coll - 1; j++ )
        if ( d[i][j] > 0 )
          if ( r.nextInt(5) == 4 ) {
            d[i][j] = r.nextInt(3) + 2;
          } else
            d[i][j] = 1;
    // room templates
    while ( ! rooms.isEmpty() ) {
      templify(rooms.get(0));

      rooms.remove(0);
    }
  }
  private boolean roomify( int rs, int cs, int rl, int cl, int rn) {
    if ( rs + rl >= d.length || cs + cl >= d[0].length )
      return false;
    for ( int j = rs; j < rl + rs; j++ ) 
      for ( int k = cs; k < cs + cl; k++ )
        if ( d[j][k] > 0 )
          return false;
    for ( int j = rs; j < rs + rl; j++ ) 
      for ( int k = cs; k < cs + cl; k++ )
        d[j][k] = rn;
    return true;
  }
  private void mazeify( int rowStart, int colStart, int mn ) {
    Stack<int[]> cur = new Stack<int[]>();
    d[rowStart][colStart] = mn;
    cur.push(new int[]{rowStart, colStart});
    while ( ! cur.isEmpty() ) {
      int[] z = nayber(cur.peek(), mn);
      if ( z == null )
        cur.pop();
      else
        cur.push(z);
    }
  }
  private int[] conn ( int r, int c ) { // returns [ row coord, collumn coord, 1st reigon, 2nd reigon ]
    if ( d[r + 1][c] != 0 && d[r - 1][c] != 0 && d[r + 1][c] != d[r - 1][c] ) // horizontal
      return new int[]{r, c, d[r + 1][c], d[r - 1][c]};
    if ( d[r][c + 1] != 0 && d[r][c - 1] != 0 && d[r][c + 1] != d[r][c - 1] ) // vertical
      return new int[]{r, c, d[r][c + 1], d[r][c - 1]};
    return null;
  }
  private int[] nayber ( int[] pos, int mn ) {
    List<int[]> nei = new ArrayList<int[]>(4);
    nei.add(new int[]{pos[0] + 2, pos[1]});
    nei.add(new int[]{pos[0] - 2, pos[1]});
    nei.add(new int[]{pos[0], pos[1] + 2});
    nei.add(new int[]{pos[0], pos[1] - 2});
    List<int[]> mid = new ArrayList<int[]>(4);
    mid.add(new int[]{pos[0] + 1, pos[1]});
    mid.add(new int[]{pos[0] - 1, pos[1]});
    mid.add(new int[]{pos[0], pos[1] + 1});
    mid.add(new int[]{pos[0], pos[1] - 1});

    for ( int i = 3; i >= 0; i-- ) 
      if ( ! vMaze(nei.get(i), 0) ) { 
        nei.remove(i);
        mid.remove(i);
      }
    if ( nei.isEmpty() )
      return null;

    Random r = new Random();
    int q = r.nextInt(nei.size());
    d[nei.get(q)[0]][nei.get(q)[1]] = mn;
    d[mid.get(q)[0]][mid.get(q)[1]] = mn;

    return nei.get(q);
  }
  private boolean vMaze ( int[] pos, int eq ) {
    return pos[0] >= 0 && pos[0] < d.length && pos[1] >= 0 && pos[1] < d[0].length && d[pos[0]][pos[1]] == eq;
  }
  private int rOdd(int low, int upp) {
    Random r = new Random();
    return r.nextInt((upp - low) / 2 + 1) * 2 + low;
  }
  private void rde ( int r, int c ) {
    if ( r < 0 || r > d.length - 1 || c < 0 || c > d[0].length - 1 || d[r][c] == 0 )
      return;
    int pc = 0;
    int rNext = -1, cNext = -1;
    if ( d[r + 1][c] > 0 ) {
      pc++;
      rNext = r + 1;
      cNext = c;
    }
    if ( d[r - 1][c] > 0 ) {
      pc++;
      rNext = r - 1;
      cNext = c;
    }
    if ( d[r][c + 1] > 0 ) {
      pc++;
      rNext = r;
      cNext = c + 1;
    }
    if ( d[r][c - 1] > 0 ) {
      pc++;
      rNext = r;
      cNext = c - 1;
    }
    if ( pc < 2 ) {
      d[r][c] = 0;
      rde(rNext, cNext);
    }
  }
  private void templify( int[] r ) {
    if ( r[2] > r[3] ) { // transpose
      int[][] room = template(r[3], r[2]);
      for ( int i = 0; i < r[3]; i++ )
        for ( int j = 0; j < r[2]; j++ )
          d[r[0] + j][r[1] + i] = -1 * room[i][j];
    } else { // no transpose
      int[][] room = template(r[2], r[3]);
      for ( int i = 0; i < r[2]; i++ )
        for ( int j = 0; j < r[3]; j++ )
          d[r[0] + i][r[1] + j] = room[i][j];
    }
  } 
  public int[][] template( int r, int c ) {
    try {
      int[][] room = new int[r][c];
      Scanner sc = new Scanner(new File( dataPath + "data" + File.separator + r + "x" + c + ".txt"));
      int i = 0;
      while ( sc.hasNextLine() ) {
        String[] row = sc.nextLine().split(" ");
        for ( int j = 0; j < c; j++ ) {
          room[i][j] = Integer.parseInt(row[j]);
        }
        i++;
      }
      return room;
    } 
    catch( FileNotFoundException e ) {
      e.printStackTrace();
      return null;
    }
  }


  public String toString() {
    String k = "";
    for ( int[] q : d ) {
      for ( int z : q )
        k += z + " "; 
      k += "\n";
    }
    return k;
  }
  public int[][] getDungeon() {  
    //System.out.println(this);
    return d;
  }
  public static void main(String args[]) {

    //Dungeon dung = new Dungeon(79,79,5,11);
    //System.out.println(dung);
  }
}
/*
  5x5   | Dungeon cell 
 5x7   | Carpet room
 5x9   | Torture room
 5x11  | Wine room
 7x7   | church room
 7x9   | Kitchen
 7x11  | Barracks
 9x9   | Bath room
 9x11  | Throne room
 11x11 | Feasting hall
 
 1 floor 
 2 torch floor 
 3 puddle floor 
 4 shrubbery floor 
 5 door 
 6 bedTop 
 7 bedBottom 
 8 toilet
 9 carpetEdge
 10 carpetCentre
 11 table
 12 tableTools
 13 rackLeft
 14 rackRight
 15 wineCaskRight
 16 wineCaskLeft
 17 wineCaskUpright
 18 altar
 19 roseTop
 20 roseLeft
 21 roseRight
 22 roseBottom
 23 roseCentre
 24 furnace
 25 cupboard
 26 bathNE
 27 bathSE
 28 bathSW
 29 bathNW
 30 throne
 31 steps
 32 tableFood
 33 fancyTable
 34 fancyFood
 
 
 "floor floorTorch floorPuddle floorShrubbery door bedTop bedBottom toilet carpetEdge carpetCentre table tableTools rackLeft rackRight wineCaskRight wineCaskLeft wineCaskUpright altar roseTop roseLeft roseRight roseBottom roseCentre furnace cupboard bathNE bathSE bathSW bathNW throne steps tableFood fancyTable fancyFood"
 */