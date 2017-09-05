
final int width = 50;
final int height = 50;
final int draw_size = 10;
final int delay_ms = 100;
int[][] grid;
int odd;
boolean paused;

void setup() {
  size(1, 1);
  surface.setResizable(true);
  surface.setSize(width*draw_size, height*draw_size);
  grid = new int[width][height];
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < width; y++) {
      grid[x][y] = 0;
    }
  }
  odd = 0;
  paused = true;
}

void rotate4(int x, int y) {
  int new_x = x+1;
  int new_y = y+1;
  int saved = grid[x][y];
  if (new_x == width) {
    new_x = 0;
  }
  if (new_y == height) {
    new_y = 0;
  }
  if (grid[x][y] + grid[x][new_y] + grid[new_x][new_y] + grid[new_x][y] == 1) {
    grid[x][y] = grid[x][new_y];
    grid[x][new_y] = grid[new_x][new_y];
    grid[new_x][new_y] = grid[new_x][y];
    grid[new_x][y] = saved;
  }
}

void update_grid() {
  for (int i = 0; i < width-1; i+=2) {
    for (int j = 0; j < height-1; j+=2) {
      rotate4(i+odd, j+odd);
    }
  }
  if (odd == 1) {
    odd = 0;
  } else {
    odd = 1;
  }
}

void draw() {
  background(0);
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < width; y++) {
      if (grid[x][y] == 1) {
        rect(x*draw_size, y*draw_size, draw_size, draw_size); 
      }      
    }
  }
  if (!paused) { 
    update_grid();
    delay(delay_ms);
  }
}

void mousePressed() {
  int x = mouseX/draw_size;
  int y = mouseY/draw_size;
  if (grid[x][y] == 1) grid[x][y] = 0;
  else grid[x][y] = 1;
}

void keyPressed() {
  paused = !paused;
}