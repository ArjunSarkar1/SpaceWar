// This file handles different Modes Logic.

// player character
final char KEY_LEFT = 'a';
final char KEY_RIGHT = 'd';
final char KEY_UP = 'w';
final char KEY_DOWN = 's';
final char KEY_SHOOT = ' ';

// turn textures or collisions on/off - useful for testing and debugging
final char KEY_TEXTURE = 't';
final char KEY_COLLISION = 'c';

boolean doTextures = false;
boolean doCollision = false;

// Global Movement flags
boolean travelUp = false;
boolean travelDown = false;
boolean travelRight = false;
boolean travelLeft = false;

// When key is pressed, we allow  
// movement to made in all (up, down, left, right) directions
// as well as for enabling textures and collision.
void keyPressed() {
  if (key == KEY_TEXTURE) {
    doTextures = !doTextures;
    if (doTextures) {
      System.out.println("Texture is on!");
    } else {
      System.out.println("Texture is off!");
    }
  }
  if (key == KEY_COLLISION) {
    doCollision = !doCollision;
    if (doCollision) {
      System.out.println("Collision is on!");
    } else {
      System.out.println("Collision is off!");
    }
  }
  if (key == KEY_SHOOT) {
    PVector currShipPos = shipPosition.copy();
    PVector direction = new PVector(0,-AMMO_SPEED,0);
    myAmmo.add(new Ammunition(currShipPos.add(0,-SHIP_SIZE,0), direction));
  }
  if (key == KEY_LEFT) {
    travelLeft = true;
  }
  if (key == KEY_RIGHT) {
    travelRight = true;
  }
  if (key == KEY_UP) {
    travelUp = true;
  }  
  if (key == KEY_DOWN) {
    travelDown = true;
  }
}

// Setting movement flags to be `false` 
// when key is released.
void keyReleased() {
  if (key == KEY_LEFT) {
    travelLeft = false;
  }
  if (key == KEY_RIGHT) {
    travelRight = false;
  }
  if (key == KEY_UP) {
    travelUp = false;
  }  
  if (key == KEY_DOWN) {
    travelDown = false;
  }
}
