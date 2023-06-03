int fps = 30;
int[] clicksX = new int[100];  // array to store x-coordinates of blobs
int[] clicksY = new int[100];  // array to store y-coordinates of blobs
float[] radius = new float[100];
float[] noiseOffset = new float[100]; // offset for noise function
int[] alphaValues = new int[100]; // alpha values for each blob
int numBlobs = 0;
float noiseFactor = 0.05;

void setup() {
  frameRate(fps);
  size(750, 750);
  smooth();
  noiseSeed(1234);
  for (int i = 0; i < 100; i++) {
    radius[i] = 0; // Initialize radius to 0 for all blobs
    noiseOffset[i] = random(100); // Initialize noise offset
    alphaValues[i] = 0; // Initialize alpha values to 0
  }
}

void draw() {
  background(255);

  // Update and draw existing blobs
  for (int i = 0; i < numBlobs; i++) {
    noiseOffset[i] += 0.02;
    if (radius[i] <200) {
      radius[i] += 0.5; // Increase the radius slowly
    }
    blob(clicksX[i], clicksY[i], radius[i], alphaValues[i], noiseOffset[i]);



    noiseOffset[i] += 0.01; // increment noise offset
    if (alphaValues[i] < 255) alphaValues[i] += 2; // increase the alpha value
  }

  // If there are fewer than 100 blobs, create a new one at the mouse position
  if (numBlobs < 100) {
    clicksX[numBlobs] = mouseX;
    clicksY[numBlobs] = mouseY;
    numBlobs++;
  } else { // Else replace the oldest blob with a new one at the mouse position
    for (int i = 0; i < 99; i++) {
      clicksX[i] = clicksX[i + 1];
      clicksY[i] = clicksY[i + 1];
      radius[i] = radius[i + 1];
      noiseOffset[i] = noiseOffset[i + 1];
      alphaValues[i] = alphaValues[i + 1]; // Move the alpha values along the array
    }
    clicksX[99] = mouseX;
    clicksY[99] = mouseY;
    radius[99] = 0; // Reset the radius of the new blob
    noiseOffset[99] = random(100); // Initialize noise offset for the new blob
    alphaValues[99] = 0; // Reset the alpha value for the new blob
  }
}

void blob(float x, float y, float r, int alphaValue, float noiseOffset) {
  beginShape();
  noStroke();
  fill(33, 33, 33, alphaValue);
  for (float angle = 0; angle < TWO_PI; angle += PI/50.0) {
    float r2 = r;
    float px = x + r2 * cos(angle) + noise(noiseOffset) * 10; // add noise to x-coordinate
    float py = y + r2 * sin(angle) + noise(noiseOffset + 100) * 10; // add noise to y-coordinate, offset is added to create different noise
    curveVertex(px, py);
    noiseOffset += 0.1; // increment the offset
  }
  endShape(CLOSE);
}
