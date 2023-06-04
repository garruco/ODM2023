// Define the class for a module
class Module {
  int gridX, gridY; // Grid position of the module
  color c; // Color of the module
  int nRotations; // Number of rotations of the module
  int module; // Index of the shape used for the module
  int gridSize; // Size of the grid
  boolean shouldRotate; // Flag to indicate whether the module should rotate

  // Constructor for the Module class
  Module(int gridX, int gridY, color c, int nRotations, int module, int gridSize, boolean shouldRotate) {
    this.gridX = gridX; // Initialize grid position
    this.gridY = gridY;
    this.c = c; // Initialize color
    this.nRotations = nRotations; // Initialize number of rotations
    this.module = module; // Initialize shape index
    this.gridSize = gridSize; // Initialize grid size
    this.shouldRotate = shouldRotate; // Initialize rotation flag
  }

  // Method to update the state of the module
  void update() {
    if (shouldRotate) { // If the module should rotate...
      nRotations = (nRotations + 1) % 4; // Increment the number of rotations, wrapping back to 0 after 3
    }
  }

  // Method to draw the module
  void display() {
    // Calculate the size of each cell in the grid
    int cellSize = width / gridSize;

    shapeMode(CORNER); // Set the mode for drawing shapes
    pushMatrix(); // Save the current transformation matrix

    // Move to the correct position in the grid, based on the number of rotations
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

    // Move to the correct grid position
    translate(gridX * cellSize, gridY * cellSize);

    // Rotate the correct amount
    rotate(nRotations * HALF_PI);

    // Set the fill color and draw the shape
    fill(c);
    shape(svgShapes[module], 0, 0, cellSize, cellSize);

    popMatrix(); // Restore the transformation matrix
  }
}
