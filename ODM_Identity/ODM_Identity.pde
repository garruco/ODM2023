import processing.svg.*;

int gridSize = 5; // number of rows and columns in the grid
int shapeSize; // size of each shape
color[] colors = {#0F1523, #EC2626, #2A258A, #2F5247}; // random colors to choose from

PShape[] svgShapes; // array to store the SVG shapes
Module[][] modules; // 2D array to store the Module objects

void setup() {
  size(800, 800);
  shapeSize = width/gridSize;
  svgShapes = new PShape[14];

  // Load SVG files
  for (int i = 0; i <= 13; i++) {
    svgShapes[i] = loadShape("modules/" + nf(i) + ".svg");
    svgShapes[i].disableStyle();
  }
  
  modules = new Module[gridSize][gridSize];

  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      int moduleIndex = int(random(14));
      color c = colors[int(random(4))];
      int nRotations = int(random(4));
      modules[i][j] = new Module(i, j, c, nRotations, moduleIndex, gridSize);
    }
  }

  beginRecord(SVG, "padrao.svg");
  background(255);
  noStroke();
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      modules[i][j].display();
    }
  }
  endRecord();
}
