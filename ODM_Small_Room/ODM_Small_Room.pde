int fps = 60;
int[] clicksX = new int[100];  // array to store x-coordinates of blobs
int[] clicksY = new int[100];  // array to store y-coordinates of blobs
float[] radius = new float[100];
float[] noiseOffset = new float[100]; // offset for noise function
int[] alphaValues = new int[100]; // alpha values for each blob
boolean[] decrease = new boolean[100]; // decrease flags for each blob
int numBlobs = 0;
float noiseFactor = 0.05;
PImage bg;

void setup() {
  frameRate(fps);
  size(750, 900);
  smooth();
  noiseSeed(1234);
  for (int i = 0; i < 100; i++) {
    radius[i] = 0; // Initialize radius to 0 for all blobs
    noiseOffset[i] = random(100); // Initialize noise offset
    alphaValues[i] = 0; // Initialize alpha values to 0
  }

  bg = loadImage("image.png"); // replace "image.png" with the name of your image
}

void draw() {
  background(255);
  image(bg, 0, 0, width, height); // scales the image to fit the size of the window
  // Update and draw existing blobs
  for (int i = 0; i < numBlobs; i++) {
    noiseOffset[i] += 0.02;
    if (radius[i] < 250) {
      radius[i] += random(0.3,0.8); // Increase the radius slowly
    }
    blob(clicksX[i], clicksY[i], radius[i], alphaValues[i], noiseOffset[i]);

    noiseOffset[i] += 0.01; // increment noise offset
    if (alphaValues[i] > 70) decrease[i]=true;
    else if (alphaValues[i] <= 0) decrease[i]=false;

    if (decrease[i] == false) alphaValues[i] += 2;
    else if (decrease[i] == true) alphaValues[i] -= 1;
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
      decrease[i] = decrease[i + 1]; // Move the decrease flags along the array
    }
    clicksX[99] = mouseX;
    clicksY[99] = mouseY;
    radius[99] = 0; // Reset the radius of the new blob
    noiseOffset[99] = random(100); // Initialize noise offset for the new blob
    alphaValues[99] = 0; // Reset the alpha value for the new blob
    decrease[99] = false; // Reset the decrease flag for the new blob
  }
}

void blob(float x, float y, float r, int alphaValue, float noiseOffset) {
  beginShape();
  noStroke();
  fill(#0F1214, alphaValue);
  for (float angle = 0; angle < TWO_PI; angle += PI/50.0) {
    float r2 = r;
    float px = x + r2 * cos(angle) + noise(noiseOffset) * 30; // add noise to x-coordinate
    float py = y + r2 * sin(angle) + noise(noiseOffset + 100) * 30; // add noise to y-coordinate, offset is added to create different noise
    curveVertex(px, py);
    noiseOffset += 0.3; // increment the offset
  }
  endShape(CLOSE);
}
