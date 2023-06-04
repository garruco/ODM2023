int main_instalation = 4;
boolean isRecording = true;

int population_size = 60;
int max_elite_size = 6;
int tournament_size = 6;
float crossover_rate = 0.7;
float mutation_rate = 0.05;
int resolution = 300;

Population pop;
PVector[][] grid;
PVector[] tile_grid;

color [] colors = {color(15, 21, 35), color(236, 38, 38), color(42, 57, 138), color(47, 82, 71)};
int min_shapes = 2;
int max_shapes = 4;

int n_modules = 11;
PShape modules[] = new PShape[11];

void settings() {
  size(int(displayWidth * 0.9), int(displayHeight * 0.8));
  smooth(8);
}

void setup() {
  frameRate(8);

  tile_grid = calculateTileGrid(3, resolution, 0);
  pop = new Population();
  grid = calculateGrid(population_size, 0, 0, width, height, 30, 10, 30, true);

  for (int i = 1; i < modules.length; i++) {
    modules[i] = loadShape("module (" + i + ").svg");
  }
}

void draw() {
  background(200);
  int row = 0, col = 0;
  float highest_fitness = getHighestFitness();
  for (int i = 0; i < pop.getSize(); i++) {
    noFill();
    image(pop.getIndividual(i).getPhenotype(resolution), grid[row][col].x, grid[row][col].y, grid[row][col].z, grid[row][col].z);
    if (i >= main_instalation) {
      fill(200, 200);
      noStroke();
    } else {
      strokeWeight(map(pop.getIndividual(i).getFitness(), 0, highest_fitness, 0, 5));
      stroke(0);
      if (mouseX > grid[row][col].x && mouseX < grid[row][col].x + grid[row][col].z &&
        mouseY > grid[row][col].y && mouseY < grid[row][col].y + grid[row][col].z) {
        pop.getIndividual(i).setHovered(true);
      } else {
        pop.getIndividual(i).setHovered(false);
      }
    }
    rect(grid[row][col].x-1, grid[row][col].y-1, grid[row][col].z+2, grid[row][col].z+2);

    col += 1;
    if (col >= grid[row].length) {
      row += 1;
      col = 0;
    }
  }

  if (frameCount % 5 == 0) {
    pop.evolve();
  }

  export();
}

PVector[][] calculateGrid(int cells, float x, float y, float w, float h, float margin_min, float gutter_h, float gutter_v, boolean align_top) {
  int cols = 0, rows = 0;
  float cell_size = 0;
  while (cols * rows < cells) {
    cols += 1;
    cell_size = ((w - margin_min * 2) - (cols - 1) * gutter_h) / cols;
    rows = floor((h - margin_min * 2) / (cell_size + gutter_v));
  }
  if (cols * (rows - 1) >= cells) {
    rows -= 1;
  }
  float margin_hor_adjusted = ((w - cols * cell_size) - (cols - 1) * gutter_h) / 2;
  if (rows == 1 && cols > cells) {
    margin_hor_adjusted = ((w - cells * cell_size) - (cells - 1) * gutter_h) / 2;
  }
  float margin_ver_adjusted = ((h - rows * cell_size) - (rows - 1) * gutter_v) / 2;
  if (align_top) {
    margin_ver_adjusted = min(margin_hor_adjusted, margin_ver_adjusted);
  }
  PVector[][] positions = new PVector[rows][cols];
  for (int row = 0; row < rows; row++) {
    float row_y = y + margin_ver_adjusted + row * (cell_size + gutter_v);
    for (int col = 0; col < cols; col++) {
      float col_x = x + margin_hor_adjusted + col * (cell_size + gutter_h);
      positions[row][col] = new PVector(col_x, row_y, cell_size);
    }
  }
  return positions;
}

PVector[] calculateTileGrid(int rows, float side, float gutter_percentage) { //square shape just rows
  int n_gutters = rows - 1;  

  float gutter_size = side * gutter_percentage;

  float cell_size = (side - gutter_size * n_gutters) / rows;


  PVector[] positions = new PVector[rows];

  for (int row = 0; row < rows; row++) {
    float row_y = row * (cell_size + gutter_size);
    positions[row] = new PVector(row_y, gutter_size, cell_size);
  }
  return positions;
}

float getHighestFitness() {
  float highest_fitness = 0.01;
  for (int i = 0; i < pop.getSize(); i++) {
    float current_fitness = pop.getIndividual(i).getFitness();
    if (current_fitness > highest_fitness) highest_fitness = current_fitness;
  }
  return highest_fitness;
}

void mousePressed() {
  for (int i = 0; i < pop.getSize(); i++) {
    Tile currentTile = pop.getIndividual(i);
    if (currentTile.getHovered()) {
      currentTile.wasClicked(mouseButton);      
      return;
    }
  }
}

void export() {
  if (isRecording) saveFrame("outputs/" + "frame-######.png");
}
