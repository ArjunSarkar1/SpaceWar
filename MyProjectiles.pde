// This file handles describes the Ammunition Class.

// Gloabl Constands describing the characteristics of the ammunition
final int AMMO_SPEED = 4;
final int SHIP_AMMO_COLOR = ORANGE; 
final int ENEMY_AMMO_COLOR = GREEN; 
final int AMMO_SIZE = 15;

// A list to store all ammunitions
ArrayList<Ammunition> myAmmo = new ArrayList<Ammunition>();

class Ammunition {
  
  // Ammos hold position and speed
  PVector ammoPosition;
  PVector ammoSpeed;
  
  // Ammunition constructor to get the position and speed
  Ammunition(PVector objPos, PVector objSpeed) {
    PVector copyObjPos = objPos.copy();
    ammoPosition = copyObjPos;
    ammoSpeed = objSpeed.copy();
  }
  
  // Making sure the ammos move with given speed
  void updateAmmo() {
    ammoPosition.add(ammoSpeed);
  }

  // Primarily manages the ammo for the Spaceship
  void drawAmmo() {
    pushMatrix();
    translate(ammoPosition.x, ammoPosition.y, ammoPosition.z);
    ammoShape();
    popMatrix();
  } 
  
  // Handles the Enemy Ammo 
  void drawEnemyAmmo() {
    pushMatrix();
    translate(ammoPosition.x, ammoPosition.y, ammoPosition.z);
    enemyAmmoShape();
    popMatrix();
  }
  
  void enemyAmmoShape() {
    noStroke();
    if (doTextures) {
      beginShape(QUAD);
      
      // Applying the `enemyAmmo.png` texture here
      texture(enemyAmmo);
      
      // Adding a cool animation allowing the ammunition to rotate
      // giving a nice look for the game experience.
      rotate(frameCount * 0.5);
      
      // Applying texturing coordinates
      vertex(-AMMO_SIZE, -AMMO_SIZE, 0, 0, 0);
      vertex(AMMO_SIZE, -AMMO_SIZE, 0, 0, 1);
      vertex(AMMO_SIZE, AMMO_SIZE, 0, 1, 1);
      vertex(-AMMO_SIZE, AMMO_SIZE, 0, 1, 0);
      endShape(CLOSE);
      
    } else {
      // Otherwise, display the normal square shape
      fill(ENEMY_AMMO_COLOR);
      beginShape(QUAD);
      vertex(-AMMO_SIZE, -AMMO_SIZE, 0);
      vertex(AMMO_SIZE, -AMMO_SIZE, 0);
      vertex(AMMO_SIZE, AMMO_SIZE, 0);
      vertex(-AMMO_SIZE, AMMO_SIZE, 0);
      endShape(CLOSE);
    }
  } 
  
  // The functions below both ensure the ammos disappear once they are beyond 
  // a certain boundary
  
  // Ship's Ammo Boundary Check
  boolean offGridShip() {
    return ammoPosition.y < -START_Y + SHIP_SIZE/8;
  }
  
  // ALien Ship's Ammo Boundary Check
  boolean offGridEnemy() {
    return ammoPosition.y > START_Y || ammoPosition.y < -START_Y || ammoPosition.x < -START_Y + SHIP_SIZE/2 || ammoPosition.x > START_Y - SHIP_SIZE/2; // Off Grid
  }
  
  // This function is mainly for the ammo for the spaceship
  void ammoShape() {
    noStroke();
    if (doTextures) {
      beginShape(QUADS);
      
      // Applying the `shipAmmo.png` texture here
      texture(shipAmmo);
      
      vertex(-AMMO_SIZE, -AMMO_SIZE, 0, 0, 0);
      vertex(AMMO_SIZE, -AMMO_SIZE-10, 0, 1, 0);
      vertex(AMMO_SIZE, AMMO_SIZE+10, 0, 1, 1);
      vertex(-AMMO_SIZE, AMMO_SIZE, 0, 0, 1);
      endShape(CLOSE);
      
    } else {
      // Otherwise, display the normal square shape as orange in color
      fill(SHIP_AMMO_COLOR);
      beginShape(QUADS);
      vertex(-AMMO_SIZE, -AMMO_SIZE, 0);
      vertex(AMMO_SIZE, -AMMO_SIZE, 0);
      vertex(AMMO_SIZE, AMMO_SIZE, 0);
      vertex(-AMMO_SIZE, AMMO_SIZE, 0);
      endShape(CLOSE);
    }
  }
}


// The myAmmo list is iterated over by the `shootingEnabled` function, 
// which updates and draws each ammo item on the screen to control the ship's 
// ammunition in the game. drawAmmo() is used to render the ammunition graphically, 
// and the updateAmmo() method is called to update the ammunition's position or other 
// properties. By calling offGridShip(), the method also determines whether any ammo 
// has left the screen. If it has, it deletes that ammunition from the list.
void shootingEnabled() {
  for (int i = 0 ; i < myAmmo.size(); i++) {
    Ammunition currAmmo = myAmmo.get(i);
    currAmmo.updateAmmo();
    currAmmo.drawAmmo();
    if (currAmmo.offGridShip() ) {
      myAmmo.remove(i);
    }
  }
}
