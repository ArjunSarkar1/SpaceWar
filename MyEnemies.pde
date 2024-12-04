// This file handles describes the AlienEnemy Class.

// The following are constant values mainly for the Enemy Class attributes 
final int ENEMY_COLOR = BLUE; 
final int ENEMY_SPEED = 5; 
final int ENEMY_SIZE = 50;
final int NUM_ENEMIES = 3;
final float ENEMY_LERP_AMT = 0.02;
final int ENEMY_SPAWN_Y = -100;
final int ENEMY_SIZE_OFFSET = 10;

// This helps to control the flow of shooting
// Enemy alien should wait before shooting again!
final int activateShooting = 200;

// These are arraylists to store Enemies and their Ammos
ArrayList<Ammunition> myAmmoEnemies = new ArrayList<Ammunition>();
ArrayList<AlienEnemy> myEnemies = new ArrayList<AlienEnemy>();

class AlienEnemy {

  // AlienEnemy Class Variables for position, speed, 
  // random target to follow and their shooting time
  PVector enemyPosition;
  PVector enemySpeed;
  PVector randomTarget;
  float shootTimer;
  
  // Constructor getting a random position
  AlienEnemy (PVector randomPosition) {
    // The starting and random target is set to random position along with an empty
    // speed vector and a random shooting duration
    enemyPosition = randomTarget = randomPosition.copy();
    enemySpeed = new PVector();
    shootTimer = random(activateShooting);
  }
  
  void updateEnemy() {
    enemyMove();
    enemyShoots();
  }
  
  // Enemy only shoots after a while 
  // Below we calculate the direction of the ship through normalization
  // as well as giving it a specified speed
  // and setting a new shooting timer
  void enemyShoots() {
    shootTimer = shootTimer - 1;
    if ( shootTimer < 1 ) {
      PVector direction = PVector.sub(shipPosition, enemyPosition);
      direction = direction.normalize();
      PVector ammoPosition = enemyPosition.copy();
      PVector ammoSpeed = direction.mult(AMMO_SPEED); 
      myAmmoEnemies.add(new Ammunition(ammoPosition, ammoSpeed));
      shootTimer = int(random(60, 120));
    }

  }
  
  void enemyMove() {
    // As Enemy approaches the target position, we give it another location to head towards
    if (enemyPosition.dist(randomTarget) <= 15) {
      randomTarget = new PVector(random(-START_Y, START_Y), random(-START_Y, 100), 0);
    }
    // The enemy lerps towards the new random target position smoothly
    enemyPosition.lerp(randomTarget, ENEMY_LERP_AMT);
  }

  void drawEnemy() {
    // Draw enemy
    pushMatrix();
    translate(enemyPosition.x, enemyPosition.y, enemyPosition.z);
    noStroke();
    
    // Applying the textures based on the `doTextures` flag
    if (doTextures) {
      beginShape(QUADS);
      
      // We will be animating the ENEMY with 5 different frames
      // `currentEnemyIndex` assists in getting the correct index to display
      PImage currEnemy = enemyAnimations.get(currentEnemyIndex);
      texture(currEnemy);
      
      // This if branch is because the first enemy frame is super big
      // and we want to adjust the other ones by rotating them 90 degrees
      if ( currentEnemyIndex != 0) { 
        rotate(HALF_PI);
        
        // Note: we are applying with proper texturing coordinates
        // 0,0 : top left
        // 0,1 : top right
        // 1,1 : bottom right
        // 1,0 : bottom left
        vertex(-ENEMY_SIZE - ENEMY_SIZE_OFFSET, -ENEMY_SIZE - ENEMY_SIZE_OFFSET, 0, 0, 0);
        vertex(ENEMY_SIZE + ENEMY_SIZE_OFFSET, -ENEMY_SIZE - ENEMY_SIZE_OFFSET, 0, 0, 1);
        vertex(ENEMY_SIZE + ENEMY_SIZE_OFFSET, ENEMY_SIZE + ENEMY_SIZE_OFFSET, 0, 1, 1);
        vertex(-ENEMY_SIZE - ENEMY_SIZE_OFFSET, ENEMY_SIZE + ENEMY_SIZE_OFFSET, 0, 1, 0);

      } else {
      
        vertex(-ENEMY_SIZE - ENEMY_SIZE_OFFSET, -ENEMY_SIZE, 0, 0, 0);
        vertex(ENEMY_SIZE + ENEMY_SIZE_OFFSET, -ENEMY_SIZE, 0, 0, 1);
        vertex(ENEMY_SIZE + ENEMY_SIZE_OFFSET, ENEMY_SIZE, 0, 1, 1);
        vertex(-ENEMY_SIZE - ENEMY_SIZE_OFFSET, ENEMY_SIZE, 0, 1, 0);
      }
      
      endShape(CLOSE);
      
    } else {
      // Otehrwise, display normally as Squares
      fill(ENEMY_COLOR);
      beginShape(QUADS);
      vertex(-ENEMY_SIZE - ENEMY_SIZE_OFFSET, -ENEMY_SIZE - ENEMY_SIZE_OFFSET, 0);
      vertex(ENEMY_SIZE + ENEMY_SIZE_OFFSET, -ENEMY_SIZE - ENEMY_SIZE_OFFSET, 0);
      vertex(ENEMY_SIZE + ENEMY_SIZE_OFFSET, ENEMY_SIZE + ENEMY_SIZE_OFFSET, 0);
      vertex(-ENEMY_SIZE - ENEMY_SIZE_OFFSET, ENEMY_SIZE + ENEMY_SIZE_OFFSET, 0);
      endShape(CLOSE);
    }
    popMatrix();
    
    updateEnemyFrameIndex();
  }
}

// This small function iterates over our Enemy Animations Array List
// by using modulo and updating the current enemy index for the frame
void updateEnemyFrameIndex() {
  if ( frameCount % 200 == 0 ) {
    currentEnemyIndex = currentEnemyIndex + 1;
    currentEnemyIndex = currentEnemyIndex % NUM_ENEMY_FRAMES;
  } 
}

// Adding enemies to the Enemies array list as well as with their random positions
// bounded by our view port
void addEnemies() {
  for (int i = 0; i < NUM_ENEMIES; i++) {
    PVector randomPosition = new PVector(random(-200,250),random(-300,-100),0);
    AlienEnemy enemy = new AlienEnemy(randomPosition);
    myEnemies.add(enemy);
  }
}

void createEnemies() {   
  // Updating and displaying Enemies
  for (int i = 0; i < NUM_ENEMIES; i++) {
    AlienEnemy enemy = myEnemies.get(i);
    enemy.updateEnemy();
    enemy.drawEnemy();
  }
  
  // Updating and displaying Enemy Ammunitions
  for (int i = 0; i < myAmmoEnemies.size(); i++) {
    Ammunition enemyAmmo = myAmmoEnemies.get(i);
    enemyAmmo.updateAmmo();
    enemyAmmo.drawEnemyAmmo();
    if (enemyAmmo.offGridEnemy()) {
      myAmmoEnemies.remove(i);
    }
  }
}

// A small function to generate new enemies and adding them to the list of enemies
void makeNewEnemy() {
  PVector randomPosition = new PVector(random(-200,250),random(-300,-100),0);
  myEnemies.add(new AlienEnemy(randomPosition));
}
