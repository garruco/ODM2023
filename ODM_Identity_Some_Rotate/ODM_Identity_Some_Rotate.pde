import processing.svg.*;

boolean record;

int gridSize = 5;
int shapeSize;
color[] colors = {#0F1523, #EC2626, #2A258A, #2F5247};

PShape[] svgShapes;
Module[][] modules;

void setup() {
  size(800, 800);
  shapeSize = width/gridSize;
  svgShapes = new PShape[14];

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
      boolean shouldRotate = random(1) < 0.5;  // 50% chance to rotate
      modules[i][j] = new Module(i, j, c, nRotations, moduleIndex, gridSize, shouldRotate);
    }
  }
}

void draw() {
  if (frameCount <= 4) {
    if (!record) {
      beginRecord(SVG, "frame-" + frameCount + ".svg");
      record = true;
    }
  }
  background(255);
  noStroke();
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      modules[i][j].update();
      modules[i][j].display();
    }
  }
  delay(1000);
    if (record) {
    endRecord();
    record = false;
  }
}
