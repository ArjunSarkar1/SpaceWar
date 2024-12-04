// Main File

// Colors
final color BLACK = color(0);
final color WHITE = color(255);
final color RED = color(255,0,0);
final color GREEN = color(0,255,0);
final color BLUE = color(0,0,255);
final color ORANGE = color(255, 165, 0);

// Camera parameters
final float eyeX = 0;
final float eyeY = 0;
final float eyeZ = 550;
final float centerX = 0;
final float centerY = 0;
final float centerZ = 0;
final float upX = 0;
final float upY = 1;
final float upZ = 0;

// Perspective parameters
final float fieldOfView = PI/3;
final float aspect = 1;
final float zNear = 1;
final float zFar = 900;

// Canvas Dimensions
final int CANVAS_HEIGHT = 600;
final int CANVAS_WIDTH = 600;

// We have a total 5 Enemy Frames
final int NUM_ENEMY_FRAMES = 5;

// Variables to store images
PImage ship;
PImage shipAmmo;
PImage enemyAmmo;

// Global variables to track the user's score and current index for enemy frame
int currentEnemyIndex = 0;
int trackScore = 0;

ArrayList<PImage> enemyAnimations = new ArrayList<PImage> ();
ArrayList<MyExplosion> allExplosions = new ArrayList<MyExplosion> ();

void setup() {
  size(600, 600, P3D); // change the dimensions if desired
  textureMode(NORMAL); // use normalized 0..1 texture coords
  textureWrap(REPEAT); // change if desired
  
  // Setting a slower framerate
  frameRate(45);
  
  // Loading all the frames for our world objects
  loadingShipFrame();
  loadingAmmoFrames();
  loadingEnemyFrames();
  
  // Black Background
  background(BLACK);
  
  // Initializing spaceship position
  startingShipPosition();
  
  // Generating alien enemies and storing them on the enemies list
  addEnemies();
  
  // Setting the camera
  setCameraFocus();
}

void draw() {
  background(BLACK);
  
  // Star Space
  drawSpaceBackground();
  
  // Enabling Ship Movement
  moveShip();
  
  // Allowing shooting
  shootingEnabled();
  
  // Generating Enemies
  createEnemies();
  
  // Enabling Collisions
  collisionCheck();
  
  // Explosions allowed 
  explosionsEnabled();
}

// The game's camera view is configured using the `setCameraFocus` function. 
// A field of vision angle (60 degrees), an aspect ratio (1), 
// and a range of view distances from the near clipping plane (1) 
// to the far clipping plane (900) are defined by the perspective projection. 
// With the upward direction defined along the positive y-axis (0, 1, 0), 
// the camera function places the camera at (0, 0, 550) and faces the origin (0, 0, 0). 
// With the camera aimed in the center of the game, this gives a nice 3D perspective.
void setCameraFocus() {
  perspective(fieldOfView,aspect, zNear, zFar);
  camera(eyeX,eyeY,eyeZ,centerX,centerY,centerZ,upX,upY,upZ); 
} 

// Storing all enemy frames in a list
void loadingEnemyFrames() {
  for (int i = 0; i < NUM_ENEMY_FRAMES; i++) {
    PImage getCurrFrame = loadImage("enemy"+i+".png");
    enemyAnimations.add(getCurrFrame);
  }
}

// Storing Ammunition Images for later use
void loadingAmmoFrames() {
  shipAmmo = loadImage("shipAmmo.png");
  enemyAmmo = loadImage("enemyAmmo.png");
}

// Storing the Spaceship Image for later use
void loadingShipFrame() {
  ship = loadImage("ship.png");
}

// A simple end game function that outputs the phrase
// "GAME OVER" in WHITE color at the center of the screen if the spaceship is hit.
void endGame() {
  background(BLACK);
  fill(WHITE);
  textSize(50);
  text("GAME OVER!", -125, 0); 
}
