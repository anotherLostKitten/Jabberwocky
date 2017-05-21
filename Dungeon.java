import java.util.Random;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

public class Dungeon {
    private int[][] d;
    public Dungeon(int rows, int coll, int rmin, int rmax) {
	d = new int[rows][coll];
	int placeNumber = 1;
	// generate rooms
	for ( int i = 0; i < 200; i++ ) {
	    int rowC = rOdd(1, rows), colC = rOdd(1, coll), rRow = rOdd(rmin, rmax), rCol = rOdd(rmin, rmax);
	    placeNumber += roomify(rowC, colC, rRow, rCol, placeNumber);
	    
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
		d[tcon[0]][tcon[1]] = placeNumber;
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
	    d[con.get(q)[0]][con.get(q)[1]] = placeNumber;
	    con.remove(q);
	}
	// remove dead ends
	for ( int i = 1; i < rows - 1; i++ )
	    for ( int j = 1; j < coll - 1; j++ )
		rde(i,j);
    }
    private int roomify( int rs, int cs, int rl, int cl, int rn) {
	if ( rs + rl >= d.length || cs + cl >= d[0].length )
	    return 0;
	for ( int j = rs; j < rl + rs; j++ ) 
	    for ( int k = cs; k < cs + cl; k++ )
		if ( d[j][k] > 0 )
		    return 0;
	for ( int j = rs; j < rs + rl; j++ ) 
	    for ( int k = cs; k < cs + cl; k++ )
		d[j][k] = rn;
	return 1;
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
    public String toString() {
	String k = "";
	for ( int[] q : d ) {
	    for ( int z : q )
		 if ( z <= 0 )
		     k += "#";
		 else
		     k += " "; 
	    k += "\n";
	}
	return k;
    }
    public static void main(String args[]) {
	Dungeon dung = new Dungeon( 79, 79, 7, 13 );
	System.out.println(dung);
    }
}
