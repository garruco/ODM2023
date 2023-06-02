class Module {
  int gridX, gridY;
  color c;
  int nRotations;
  int module;
  int gridSize;
  boolean shouldRotate;

  Module(int gridX, int gridY, color c, int nRotations, int module, int gridSize, boolean shouldRotate) {
    this.gridX = gridX;
    this.gridY = gridY;
    this.c = c;
    this.nRotations = nRotations;
    this.module = module;
    this.gridSize = gridSize;
    this.shouldRotate = shouldRotate;
  }

  void update() {
    if (shouldRotate) {
      nRotations = (nRotations + 1) % 4;
    }
  }

  void display() {
    int cellSize = width / gridSize;
    shapeMode(CORNER);
    pushMatrix();

    switch (nRotations) {
    case 0:
      translate(0, 0);
      break;
    case 1:
      translate(cellSize, 0);
      break;
    case 2:
      translate(cellSize, cellSize);
      break;
    case 3:
      translate(0, cellSize);
      break;
    }

    translate(gridX * cellSize, gridY * cellSize);

    rotate(nRotations * HALF_PI);

    fill(c);
    shape(svgShapes[module], 0, 0, cellSize, cellSize);
    popMatrix();
  }
}
