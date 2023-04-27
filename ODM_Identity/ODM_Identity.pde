import processing.svg.*;

int gridSize = 10; // number of rows and columns in the grid
int shapeSize; // size of each shape
int[][] shapes; // 2D array to store the shapes
color[] colors = {#0F1523, #EC2626, #2A258A, #2F5247}; //random colors to choose from

void setup() {
  size(1600, 800);
  shapeSize = width/gridSize;
  shapes = new int[gridSize][gridSize];
   beginRecord(SVG, "padrao.svg");
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      shapes[i][j] = int(random(10)); // randomly assign a shape index
    }
  }
  background(255);
  noStroke();
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      int shapeIndex = shapes[i][j];
      pushMatrix();
      translate(i * shapeSize, j * shapeSize);
      fill(colors[int(random(4))]);
      switch (shapeIndex) {
      case 0:
        ellipse(shapeSize/2, shapeSize/2, shapeSize, shapeSize); //circle
        break;
      case 1:
        rect(0, 0, shapeSize, shapeSize); //square
        break;
      case 2:
        triangle(0, shapeSize, shapeSize, shapeSize, 0, 0); // right triangle
        break;
      case 3:
        triangle(shapeSize, shapeSize, shapeSize, 0, 0, shapeSize); // rotated right triangle
        break;
      case 4:
        triangle(shapeSize, 0, 0, 0, shapeSize, shapeSize); // rotated right triangle
        break;
      case 5:
        triangle(0, 0, 0, shapeSize, shapeSize, 0); // rotated right triangle
        break;
      case 6:
        arc(shapeSize/2-shapeSize/2, shapeSize/2-shapeSize/2, shapeSize*2, shapeSize*2, 0, PI/2, PIE); // quarter-circle
        break;
      case 7:
        arc(shapeSize/2+shapeSize/2, shapeSize/2-shapeSize/2, shapeSize*2, shapeSize*2, PI/2, PI, PIE); // rotated quarter-circle
        break;
      case 8:
        arc(shapeSize/2+shapeSize/2, shapeSize/2+shapeSize/2, shapeSize*2, shapeSize*2, PI, 3*PI/2, PIE); // rotated quarter-circle
        break;
      case 9:
        arc(shapeSize/2-shapeSize/2, shapeSize/2+shapeSize/2, shapeSize*2, shapeSize*2, 3*PI/2, 2*PI, PIE); // rotated quarter-circle
        break;
      }
      popMatrix();
    }
  }
    endRecord();
}
