// Import SVG functionality from Processing
import processing.svg.*;

// Declare global variables
boolean record; // Flag to indicate whether to record frames to an SVG file
int gridSize = 5; // Size of the grid (in number of cells)
int shapeSize; // Size of each cell in the grid (in pixels)
// Set of colors to use for the modules
color[] colors = {#0F1523, #EC2626, #2A258A, #2F5247};
PShape[] svgShapes; // Array of shapes loaded from SVG files
Module[][] modules; // 2D array of module objects

void setup() {
  size(800, 800); // Set the size of the window
  shapeSize = width/gridSize; // Calculate the size of each cell
  svgShapes = new PShape[14]; // Initialize the array of shapes

  // Load the shapes from SVG files
  for (int i = 0; i <= 13; i++) {
    svgShapes[i] = loadShape("modules/" + nf(i) + ".svg");
    svgShapes[i].disableStyle(); // Disable the default styles of the shapes
  }

  modules = new Module[gridSize][gridSize]; // Initialize the 2D array of modules

  // Populate the grid with modules
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      int moduleIndex = int(random(14)); // Select a random shape
      color c = colors[int(random(4))]; // Select a random color
      int nRotations = int(random(4)); // Select a random number of rotations
      boolean shouldRotate = random(1) < 0.5; // 50% chance for the module to be rotatable
      // Create a new module and add it to the grid
      modules[i][j] = new Module(i, j, c, nRotations, moduleIndex, gridSize, shouldRotate);
    }
  }
}

void draw() {
  // For the first 4 frames...
  if (frameCount <= 4) {
    // If not currently recording...
    if (!record) {
      // Start recording to an SVG file
      beginRecord(SVG, "frame-" + frameCount + ".svg");
      record = true; // Set the flag to indicate that recording is in progress
    }
  }
  background(255); // Clear the screen
  noStroke(); // Disable outlines

  // Update and draw all modules
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      modules[i][j].update(); // Update the module
      modules[i][j].display(); // Draw the module
    }
  }
  delay(1000); // Wait for a second

  // If currently recording...
  if (record) {
    endRecord(); // Stop recording
    record = false; // Reset the flag
  }
}
