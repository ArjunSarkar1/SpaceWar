// This file handles describes the user controlling the Spaceship.

// Global Constants describing the Spaceship and lerp amount for smooth movement
final int SHIP_SPEED = 5;
final int START_X = 0;
final int START_Y = 250;
final int START_Z = 0;
final int SHIP_SIZE = 40;
final int SHIP_SIZE_OFFSET = 5;
final float LERP_AMT = 0.0199999;

// Starting posituon of ship
PVector shipPosition = new PVector(START_X,START_Y,START_Z);

void startingShipPosition() {
  shipPosition.set(0,0,0);
}

void drawShip() {
  pushMatrix();
  
  // Move to the ship positions
  translate(shipPosition.x, shipPosition.y, shipPosition.z);
  
  // No outlines at all!
  noStroke();
  
  // By default, the color would be red!
  fill(RED);
  
  // Draw the ship
  drawShipBody();
  popMatrix();
}

void drawShipBody() {
   
  if (doTextures) {
    beginShape(QUADS);
    
    // Applying the `ship.png` texture
    texture(ship);
    
    // Defining the vertices properly based on the texturing coordinates
    vertex(-SHIP_SIZE/2 - SHIP_SIZE_OFFSET, -SHIP_SIZE/2 - SHIP_SIZE_OFFSET, START_Z, 0, 0);
    vertex(SHIP_SIZE/2 + SHIP_SIZE_OFFSET, -SHIP_SIZE/2 - SHIP_SIZE_OFFSET, START_Z, 1, 0);
    vertex(SHIP_SIZE/2 + SHIP_SIZE_OFFSET, SHIP_SIZE/2 + SHIP_SIZE_OFFSET, START_Z, 1, 1);
    vertex(-SHIP_SIZE/2 - SHIP_SIZE_OFFSET, SHIP_SIZE/2 + SHIP_SIZE_OFFSET, START_Z, 0, 1);
    endShape(CLOSE);
    
  } else {
    // Otherwise, just draw the square shape on screen
    beginShape(QUADS);
    vertex(-SHIP_SIZE/2, -SHIP_SIZE/2, START_Z);
    vertex(SHIP_SIZE/2, -SHIP_SIZE/2, START_Z);
    vertex(SHIP_SIZE/2, SHIP_SIZE/2, START_Z);
    vertex(-SHIP_SIZE/2, SHIP_SIZE/2, START_Z);
    endShape(CLOSE);
  }
}

// This function checks the overall ship movement, constraining ship inside a boundary,
// ship returning to home position and displaying the ship
void moveShip() {
  updateMovement();
  boundaryCheck();
  returnOriginalPosition();
  drawShip();
}

// Changing the ship's position based on key triggered by the user
void updateMovement() {
  if (travelUp) {
    shipPosition.y = shipPosition.y - SHIP_SPEED;   
  }
  if (travelDown) {
    shipPosition.y = shipPosition.y + SHIP_SPEED;   
  } 
  if (travelRight) {
    shipPosition.x = shipPosition.x + SHIP_SPEED;   
  }
  if (travelLeft) {
    shipPosition.x = shipPosition.x - SHIP_SPEED;   
  }
}

// Using the lerp function to go back to the home/original position of the ship
// when none of the movement keys are pressed.
void returnOriginalPosition() {
  PVector originalPosition = new PVector(0,START_Y,0);
  if ( !travelUp && !travelDown && !travelRight && !travelLeft ) {
    shipPosition.lerp(originalPosition, LERP_AMT);
  }
}

// Constraining the spaceship inside our screen to avoid off screen game play experience
void boundaryCheck() {
  shipPosition.x = constrain(shipPosition.x, -START_Y + SHIP_SIZE/2, START_Y - SHIP_SIZE/2);
  shipPosition.y = constrain(shipPosition.y, -START_Y + 3*SHIP_SIZE/8, START_Y);
}
