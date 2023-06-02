int fps = 30;
int[] clicksX = new int[100];  // array to store x-coordinates of clicks
int[] clicksY = new int[100];  // array to store y-coordinates of clicks
float[] radius = new float[100];
int numClicks = 0;             // counter for number of clicks
float bgSpeed = 5;
boolean once = true;
boolean line = false;
float random;

void setup() {
  frameRate(fps);
  size(750, 750);
  smooth();
  noiseSeed(1234);
}

void draw() {
  background(255);

  for (int i = 0; i < 100; i++) {
    x=mouseX;
    y=mouseY;

    // Increase radius based on whether mouse is inside an area < than the radius
    if (radius[i] <200) {
      radius[i] = radius[i] + 0.1;
    } else {
      radius[i] = radius[i]*exp(1/radius[i]);
    }
    r = radius[i];

    blob(clicksX[i], clicksY[i], radius[i]);

    random = random(0, 1);
    if (random < 0.1) {
      line = true;
    } else {
      line = false;
    }
  }
}


void mouseClicked() {
  if (numClicks < clicksX.length) {  // only save coordinates if there is room in the array
    clicksX[numClicks] = mouseX;    // save x-coordinate of click
    clicksY[numClicks] = mouseY;    // save y-coordinate of click
    numClicks++;                    // increment counter
  }
}

float x, y;
float r = 20;
float noiseFactor = 0.05;
float idleOffsetX, idleOffsetY;
float idleNoiseFactor = 0.2;

void blob(float x, float y, float r) {
  // blob position + noise to add some iddle movement
  x =  x + map(noise(idleOffsetX), 0, 1, -50, 50);
  y =  y + map(noise(idleOffsetY), 0, 1, -50, 50);
  idleOffsetX += 0.015;
  idleOffsetY += 0.01;

  // Draw blob
  noStroke();
  fill(33, 33, 33);
  blobShape();
}


void blobShape() {
  beginShape();
  for (float angle = 0; angle <= 380; angle +=10) {
    float noiseVal = noise((x + r * cos(radians(angle))) * noiseFactor, (y + r * sin(radians(angle))) * noiseFactor);
    float r2 = r + noiseVal * r;
    float px = x + r2 * cos(radians(angle));
    float py = y + r2 * sin(radians(angle));
    curveVertex(px, py);
  }
  endShape(CLOSE);
}
