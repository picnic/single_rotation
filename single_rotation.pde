
final int width = 50;
final int height = 50;
final int draw_size = 10;
final int delay_ms = 100;
final int colors_count = 4;
final color[] colors = {
  color(255, 0, 0), 
  color(255, 255, 0), 
  color(255, 0, 255), 
  color(0, 255, 0)
};
int[][] grid;
int odd;
boolean paused;
int particule_counter;


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
  particule_counter = 1;
}

int is_particule(int cell) {
  if (cell > 0) return 1;
  return 0;
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
  if (is_particule(grid[x][y]) + is_particule(grid[x][new_y]) + is_particule(grid[new_x][new_y]) + is_particule(grid[new_x][y]) == 1) {
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
      if (grid[x][y] > 0) {
        fill(colors[grid[x][y] % colors_count]);
        rect(x*draw_size, y*draw_size, draw_size, draw_size); 
      }      
    }
  }
  if (!paused) { 
    update_grid();
    delay(delay_ms);
  }
}

void mousePressed() {
  int x = mouseX/draw_size;
  int y = mouseY/draw_size;
  if (grid[x][y] > 0) grid[x][y] = 0;
  else grid[x][y] = particule_counter;
  particule_counter++;
}

void keyPressed() {
  paused = !paused;
}