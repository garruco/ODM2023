// Import the SVG library
import processing.svg.*;

// Define the grid size and shape size
int gridSize = 5; 
int shapeSize;

// Define the colors to choose from
color[] colors = {#0F1523, #EC2626, #2A258A, #2F5247}; 

// Create an array to hold the SVG shapes and a 2D array to store the Module objects
PShape[] svgShapes; 
Module[][] modules; 

void setup() {
  // Set the canvas size
  size(800, 800);
  
  // Calculate shape size
  shapeSize = width/gridSize;

  // Initialize the SVG shapes array
  svgShapes = new PShape[14];

  // Load SVG files
  for (int i = 0; i <= 13; i++) {
    svgShapes[i] = loadShape("modules/" + nf(i) + ".svg");
    svgShapes[i].disableStyle();
  }

  // Initialize the modules 2D array
  modules = new Module[gridSize][gridSize];

  // Create and store the Module objects
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      int moduleIndex = int(random(14)); // Randomly select a module index
      color c = colors[int(random(4))]; // Randomly select a color
      int nRotations = int(random(4)); // Randomly select the number of rotations
      modules[i][j] = new Module(i, j, c, nRotations, moduleIndex, gridSize); // Create the module
    }
  }

  // Start recording an SVG file
  beginRecord(SVG, "padrao.svg");

  // Set the background color and disable stroke
  background(255);
  noStroke();

  // Display all the modules
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      modules[i][j].display();
    }
  }

  // End recording the SVG file
  endRecord();
}
