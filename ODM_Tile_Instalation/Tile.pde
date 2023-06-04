class Tile {

  int genotype_length = 10;
  ArrayList <Float> genes = new ArrayList<Float>();
  float fitness = 0;
  boolean hovered = false;

  Tile() {
    randomize();
  }

  Tile(ArrayList <Float> genes_init) {
    for (int i = 0; i < genotype_length; i++) {
      genes.add(genes_init.get(i));
    }
  }

  void randomize() {
    for (int i = 0; i < genotype_length; i++) {
      float value = random(1);
      genes.add(value);
    }
  }

  Tile getCopy() {
    Tile copy = new Tile(genes);
    copy.fitness = fitness;
    return copy;
  }

  void mutate() {
    if (random(1) <= mutation_rate) {
        float mutated_gene = constrain(genes.get(0) + random(-0.3, 0.3), 0, 0.9999);
        genes.set(0, mutated_gene);
      }
    for (int i = 1; i < genes.size(); i++) {
      if (random(1) <= mutation_rate) {
        float mutated_gene = constrain(genes.get(i) + random(-0.01, 0.01), 0, 0.9999);
        genes.set(i, mutated_gene);
      }
    }
  }

  PImage getPhenotype(int resolution) {
    PGraphics canvas = createGraphics(resolution, resolution);
    canvas.beginDraw();
    canvas.background(255);
    color currentColor = colors[floor(map(genes.get(0), 0, 1, 0, colors.length))];
    canvas.fill(currentColor);
    canvas.noStroke();
    render(canvas);
    canvas.endDraw();
    return canvas;
  }

  void render(PGraphics canvas) {
    float cell_side = tile_grid[0].z;

    for (int col = 0; col < tile_grid.length; col++) {
      for (int row = 0; row < tile_grid.length; row++) {

        int gene_n = 1 + col * tile_grid.length + row;
        int current_module_index = floor(map(genes.get(gene_n), 0, 1, 0, n_modules));

        if (current_module_index == 0) {
          continue;
        }

        PShape current_module = modules[current_module_index];

        current_module.disableStyle();


        float rotation_value_f = map(genes.get(gene_n), 0, 1, 0, n_modules) - current_module_index;

        int rotation_value = floor(rotation_value_f/0.25);

        float angle = rotation_value * HALF_PI;

        canvas.pushMatrix();
        switch (rotation_value) {
        case 0:
          break;
        case 1:
          canvas.translate(cell_side, 0);
          break;
        case 2:
          canvas.translate(cell_side, cell_side);
          break;
        case 3:
          canvas.translate(0, cell_side);
          break;
        }


        float current_x = tile_grid[col].x;
        float current_y = tile_grid[row].x;

        canvas.translate(current_x, current_y);

        canvas.rotate(angle);

        canvas.shape(current_module, 0, 0, cell_side, cell_side);
        canvas.popMatrix();
      }
    }
  }

  void setHovered(boolean state) {
    hovered = state;
  }

  boolean getHovered() {
    return hovered;
  }

  void wasClicked(int button) {
    if (button == LEFT) fitness += 0.1;
    else fitness = 0;
  }

  float getFitness() {
    return fitness;
  }
}
