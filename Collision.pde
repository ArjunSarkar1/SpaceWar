// This file handles Collision Logic.

void collisionCheck() {
  if (doCollision) {
    
    // Spaceship and Alien Collision
    shipAndShipCollision();
    
    // Spaceship Ammo Hits Alien Spaceship
    shipAmmoHitsEnemy();
    
    // Spaceship Ammo Hits Alien Ammo
    shipAmmoHitsEnemyAmmo();
    
    // Alien Ammo Hits Spaceship
    alienAmmoHitsSpaceship();
  }

}

/////////////////////////////////////////
// Spaceship Ammo Hits Alien Spaceship //
/////////////////////////////////////////
// Using nested for loop, we check for
// collisions between the player's bullets and enemy ships are 
// detected and resolved by the `shipAmmoHitsEnemy` function. Using bounding circles, 
// it calculates the distance between each pair of enemies and bullets as it iterates 
// through them to look for overlaps. The player's score rises, the alien enemy and the
// bullet disappear and a particle explosion effect is activated at the impact point for 
// visual feedback whenever a collision takes place. The challenge is then maintained by the spawning of a new enemy.
void shipAmmoHitsEnemy() {
  for (int s = 0; s < myAmmo.size(); s++) {
    Ammunition currAmmo = myAmmo.get(s);
    for (int a = 0; a < myEnemies.size(); a++) {
      AlienEnemy currEnemy = myEnemies.get(a);
      float calculateDist = dist(currAmmo.ammoPosition.x, currAmmo.ammoPosition.y, currEnemy.enemyPosition.x, currEnemy.enemyPosition.y);
      int boundingCircle = ENEMY_SIZE + AMMO_SIZE;
      if ( calculateDist < boundingCircle ) {
        myEnemies.remove(currEnemy);
        myAmmo.remove(currAmmo);
        trackScore = trackScore + 1;
        System.out.println("Current Score: " + trackScore);
        
        // Call particle system here
        enemyExplosion(currEnemy.enemyPosition.x, currEnemy.enemyPosition.y, currEnemy.enemyPosition.z);
        
        makeNewEnemy();
        //System.out.println("Enemy Alien Spaceship is hit!");
      }
    }
  }
}

/////////////////////////////////////////
// Spaceship and Alien Collision ////////
/////////////////////////////////////////
// The player's spacecraft and enemy ships are checked 
// for collisions by the shipAndShipCollision function. 
// In order to find overlap, it iterates through every enemy ship,
// measures the distance between the player's ship and each one, 
// then compares that distance to the total of the enemies' bounding circle radii. 
// The game terminates, the score is reset to zero, and a "Game Over" state 
// is activated if a collision is detected.
void shipAndShipCollision() {
  for (int i = 0; i < myEnemies.size(); i++) {
    AlienEnemy enemy = myEnemies.get(i);
    float calculateDist = dist(shipPosition.x, shipPosition.y,enemy.enemyPosition.x, enemy.enemyPosition.y);
    int boundingCircle = ENEMY_SIZE + SHIP_SIZE;
    if ( calculateDist < boundingCircle ) {
      //System.out.println("Our Spaceship got hit with Alien Ship!");
      trackScore = 0;
      System.out.println("Resetting Score:" + trackScore);
      endGame();
    }
  }
}

/////////////////////////////////////////
//  Alien Ammo Hits Spaceship ///////////
/////////////////////////////////////////
// When enemy ammo and the user's spaceship collide, 
// the `alienAmmoHitsSpaceship` function detects it. 
// It goes through all of the enemy's ammunition, figures out how far 
// away each one is from the ship's spaceship, and determines whether or 
// not it is less than the total of their bounding circle radii. A particle 
// explosion effect is activated at the spaceship's position to graphically 
// depict the hit, and the ship's score is reset to zero if a collision is detected.
// When the ship is struck by enemy fire, this feature cautions them.
void alienAmmoHitsSpaceship() {
  for (int a = 0; a < myAmmoEnemies.size(); a++) {
    Ammunition currEnemyAmmo = myAmmoEnemies.get(a);
    float calculateDist = dist(currEnemyAmmo.ammoPosition.x, currEnemyAmmo.ammoPosition.y, shipPosition.x, shipPosition.y);
    int boundingCircle = SHIP_SIZE + AMMO_SIZE;    
    if (calculateDist < boundingCircle) {
      //System.out.println("Our Spaceship is hit with Enemy Ammo!");
      trackScore = 0;
      System.out.println("Resetting Score: " + trackScore);
      
      // Calling explosion
      spaceshipExplosion(shipPosition.x, shipPosition.y, shipPosition.z);
    }
        
  }
}
/////////////////////////////////////////
// Spaceship Ammo Hits Alien Ammo //////
/////////////////////////////////////////
// Collisions between the ship's and enemy 
// ammunition are handled by the `shipAmmoHitsEnemyAmmo` function. 
// Iterating through both projectile lists, it determines the distance 
// between each pair of enemy and ship ammunition and determines whether 
// it is less than the total of their bounding circle radii. Both the ship's 
// and the enemy's ammunition are eliminated from their lists upon detection of a collision, so killing them!
void shipAmmoHitsEnemyAmmo() {
  for (int s = 0; s < myAmmo.size(); s++) {
    Ammunition currAmmo = myAmmo.get(s);
    for (int a = 0; a < myAmmoEnemies.size(); a++) {
      Ammunition currEnemyAmmo = myAmmoEnemies.get(a);
      float calculateDist = dist(currAmmo.ammoPosition.x, currAmmo.ammoPosition.y, currEnemyAmmo.ammoPosition.x, currEnemyAmmo.ammoPosition.y);
      int boundingCircle = AMMO_SIZE + AMMO_SIZE;      
      if ( calculateDist < boundingCircle ) {
        myAmmoEnemies.remove(currEnemyAmmo);
        myAmmo.remove(currAmmo);
        //System.out.println("Ship's Ammos collided with Enemy Ship's Ammos!");
      }
    }
  }  
}
