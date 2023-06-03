int fps = 30;
int[] clicksX = new int[100];  // array to store x-coordinates of blobs
int[] clicksY = new int[100];  // array to store y-coordinates of blobs
float[] radius = new float[100];
float[] noiseOffset = new float[100]; // offset for noise function
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
  }
}

void draw() {
  background(255);

  // Update and draw existing blobs
  for (int i = 0; i < numBlobs; i++) {
    if (radius[i] <200) {
      radius[i] += 0.5; // Increase the radius slowly
    }
    blob(clicksX[i], clicksY[i], radius[i]); // add noise to radius
    noiseOffset[i] += 0.01; // increment noise offset
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
    }
    clicksX[99] = mouseX;
    clicksY[99] = mouseY;
    radius[99] = 0; // Reset the radius of the new blob
    noiseOffset[99] = random(100); // Initialize noise offset for the new blob
  }
}

void blob(float x, float y, float r) {
  beginShape();
  noStroke();
  fill(33, 33, 33);
  for (float angle = 0; angle < TWO_PI; angle += PI/50.0) {
    float noiseVal = noise((x + r * cos(angle)) * noiseFactor, (y + r * sin(angle)) * noiseFactor);
    float r2 = r + noiseVal * 10; // Increase radius based on noise value
    float px = x + r2 * cos(angle);
    float py = y + r2 * sin(angle);
    vertex(px, py);
  }
  endShape(CLOSE);
}
