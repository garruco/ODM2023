// Define the Module class
class Module {
  int gridX, gridY;
  color c;
  int nRotations;
  int module;
  int gridSize;

  // Constructor
  Module(int gridX, int gridY, color c, int nRotations, int module, int gridSize) {
    this.gridX = gridX;
    this.gridY = gridY;
    this.c = c;
    this.nRotations = nRotations;
    this.module = module;
    this.gridSize = gridSize;
  }

  // Display the module
  void display() {
    int cellSize = width / gridSize;
    shapeMode(CORNER);
    pushMatrix();

    // Perform the necessary translations based on the number of rotations
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

    // Translate to the appropriate grid position
    translate(gridX * cellSize, gridY * cellSize);

    // Rotate the module
    rotate(nRotations * HALF_PI);

    // Set the fill color and display the module
    fill(c);
    shape(svgShapes[module], 0, 0, cellSize, cellSize);
    
    // Return to the original matrix state
    popMatrix();
  }
}
