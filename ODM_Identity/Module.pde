class Module {
  int gridX, gridY;
  color c;
  int nRotations;
  int module;
  int gridSize;

  Module(int gridX, int gridY, color c, int nRotations, int module, int gridSize) {
    this.gridX = gridX;
    this.gridY = gridY;
    this.c = c;
    this.nRotations = nRotations;
    this.module = module;
    this.gridSize = gridSize;
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
    shape(svgShapes[module], 0, 0, cellSize, cellSize); // Display the chosen module
    popMatrix();
  }
}
