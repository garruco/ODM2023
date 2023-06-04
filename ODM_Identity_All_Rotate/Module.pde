// Class to define the behavior of a single module in the grid
class Module {
  // Variables to hold the grid position, color, rotation, and type of the module, as well as the size of the grid
  int gridX, gridY;
  color c;
  int nRotations;
  int module;
  int gridSize;

  // Constructor to initialize the Module object
  Module(int gridX, int gridY, color c, int nRotations, int module, int gridSize) {
    this.gridX = gridX; // X position in the grid
    this.gridY = gridY; // Y position in the grid
    this.c = c; // Color of the module
    this.nRotations = nRotations; // Number of 90 degree rotations
    this.module = module; // Type of module (determines which SVG shape to use)
    this.gridSize = gridSize; // Size of the grid
  }

  // Method to update the module (currently just increments the number of rotations)
  void update() {
    nRotations = (nRotations + 1) % 4; // Increment the rotation, wrapping around to 0 after 3
  }

  // Method to draw the module on the screen
  void display() {
    // Calculate the size of each cell in the grid
    int cellSize = width / gridSize;

    // Begin a new transformation matrix
    pushMatrix();

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
    shape(svgShapes[module], 0, 0, cellSize, cellSize); // Note: svgShapes is not defined in this class, but in the global scope

    // End the transformation matrix
    popMatrix();
  }
}
