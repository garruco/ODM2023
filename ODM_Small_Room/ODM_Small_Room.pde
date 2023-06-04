// Define the frames per second
int fps = 60;

// Create arrays to store x-coordinates, y-coordinates, radius, noiseOffset, alphaValues of blobs
// And a decrease flag for each blob
int[] clicksX = new int[100];  
int[] clicksY = new int[100];
float[] radius = new float[100];
float[] noiseOffset = new float[100];
int[] alphaValues = new int[100]; 
boolean[] decrease = new boolean[100]; 

// Set initial number of blobs
int numBlobs = 0;

// Define noise factor
float noiseFactor = 0.05;

// Variable to hold the background image
PImage bg;

void setup() {
  // Set frame rate and canvas size
  frameRate(fps);
  size(534, 896);

  // Enable smoothing
  smooth();

  // Set a seed value for noise generation
  noiseSeed(1234);

  // Initialize radius, noiseOffset, alphaValues of blobs
  for (int i = 0; i < 100; i++) {
    radius[i] = 0;
    noiseOffset[i] = random(100);
    alphaValues[i] = 0;
  }

  // Load background image
  bg = loadImage("image.png");
}

void draw() {
  // Set background color and place the background image
  background(255);
  image(bg, 0, 0, width, height);

  // Update and draw existing blobs
  for (int i = 0; i < numBlobs; i++) {
    // Adjust the noiseOffset and radius of each blob
    noiseOffset[i] += 0.02;
    if (radius[i] < 250) {
      radius[i] += random(0.3,0.8);
    }

    // Draw the blob
    blob(clicksX[i], clicksY[i], radius[i], alphaValues[i], noiseOffset[i]);

    // Adjust the noiseOffset and alphaValues
    noiseOffset[i] += 0.01;
    if (alphaValues[i] > 70) decrease[i]=true;

    // Conditionally increase or decrease the alphaValue based on the decrease flag
    if (decrease[i] == false) alphaValues[i] += 2;
    else if (decrease[i] == true) alphaValues[i] -= 1;
  }

  // If there are fewer than 100 blobs, create a new one at the mouse position
  if (numBlobs < 100) {
    clicksX[numBlobs] = mouseX;
    clicksY[numBlobs] = mouseY;
    numBlobs++;
  } else { 
    // If there are 100 blobs, replace the oldest blob with a new one at the mouse position
    for (int i = 0; i < 99; i++) {
      clicksX[i] = clicksX[i + 1];
      clicksY[i] = clicksY[i + 1];
      radius[i] = radius[i + 1];
      noiseOffset[i] = noiseOffset[i + 1];
      alphaValues[i] = alphaValues[i + 1];
      decrease[i] = decrease[i + 1];
    }
    // Initialize the new blob
    clicksX[99] = mouseX;
    clicksY[99] = mouseY;
    radius[99] = 0;
    noiseOffset[99] = random(100);
    alphaValues[99] = 0;
    decrease[99] = false;
  }
}

void blob(float x, float y, float r, int alphaValue, float noiseOffset) {
  // Begin drawing a shape
  beginShape();

  // Don't draw an outline
  noStroke();

  // Fill with a color and transparency defined by alphaValue
  fill(#0F1214, alphaValue);

  // Draw a noisy circle
  for (float angle = 0; angle < TWO_PI; angle += PI/50.0) {
    float r2 = r;
    float px = x + r2 * cos(angle) + noise(noiseOffset) * 30;
    float py = y + r2 * sin(angle) + noise(noiseOffset + 100) * 30; // Offset is added to create a different noise
    curveVertex(px, py);
    noiseOffset += 0.3;
  }

  // End drawing a shape
  endShape(CLOSE);
}
