// This file manages the Background.

// Number of Stars in background
final int NUM_STARS = 210;

// A function for plotting random white dots on the canvas representing the deep space
void drawSpaceBackground() {
    loadPixels();
    for (int i = 0; i < NUM_STARS; i++) {
        int x = (int) random(CANVAS_WIDTH);
        int y = (int) random(CANVAS_HEIGHT);
        if ( pointInCanvas(x,y) ) {
          drawPixel(x,y,WHITE);
        }
    }
    updatePixels();
}

// Plotting the pixel on canvas with specified white color for stars
private void drawPixel(int x, int y, color c) {
  int index =  x + (y * CANVAS_WIDTH);
  pixels[index] = color(c);
}

// Checking the boundary of our points
private boolean pointInCanvas(int x, int y) {
  if (x >= 0 && y >= 0 && x < CANVAS_WIDTH && y < CANVAS_HEIGHT) {
    return true;
  }
  return false;
}
