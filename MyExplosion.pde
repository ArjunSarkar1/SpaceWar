// This file handles describes the MyExplosion Class. 
// This will help in managing a group of particles.

// A strict number of particles
final int NUM_PARTICLES = 100;

class MyExplosion {
  
  // Each explosion consists of an array of particles and the 
  // the original position of its occurence
  ArrayList<Particle> myParticles;
  PVector explosionPosition;
  
  // In the MyExplosion Constructor, we are accepting the given coordinates
  // of position as well as the specified particle size. Then, we proceed
  // to fill our particles list by the function `fillParticles`.
  MyExplosion(float x, float y, float z, int particleSize) {
    myParticles = new ArrayList<Particle>();
    explosionPosition = new PVector(x,y,z);
    fillParticles(x,y,z, particleSize);
  }
  
  // Returns current particles list size
  int getSize() {
    return myParticles.size();
  }
  
  // The game's particle system for explosions is controlled by the `updateExplosion` function. 
  // By using updateParticle() on the current particle, it iteratively updates each of 
  // the active particles in the myParticles list. After updating, `checkParticleOpacity()` is 
  // used to determine whether the particle has faded to the point of being invisible. 
  // The particle gets deleted from the myParticles list if its opacity has sufficiently 
  // dropped to make it invisible. In this way, we have dynamic explosion effects and 
  // the removal of particles when they are no longer needed.
  void updateExplosion() {
    for (int i = 0; i < myParticles.size(); i++) {
      Particle currParticle = myParticles.get(i);
      currParticle.updateParticle();
      if (currParticle.checkParticleOpacity()) {
        myParticles.remove(currParticle);
      }
    }    
  }
  
  // In this function,  we are displaying our explosion by 
  // drawing every single particle from the list.
  void drawExplosion() {
    for (int i = 0; i < myParticles.size(); i++) {
      Particle currParticle = myParticles.get(i);
      currParticle.drawParticle();
    }
  }
  
  // Filling our particles list up to `NUM_PARTICLES` number of particles
  void fillParticles(float x, float y, float z, int particleSize) {
    for (int i = 0; i < NUM_PARTICLES; i++) {
      myParticles.add(new Particle(x,y,z, particleSize));
    }
  }
  
}

// The game's explosions are controlled and updated by the `explosionsEnabled` function.
// It calls updateExplosion() on the current explosion to update each explosion as it 
// iterates through the allExplosions list, which includes all active explosions. 
// It uses the drawExplosion() function to draw the explosion after updating. 
// To maintain the smooth operation of our game, an explosion is eliminated 
// from the allExplosions list if its size has reached 0
void explosionsEnabled() {
  for (int i = 0; i < allExplosions.size(); i++) {
    MyExplosion currExplosion = allExplosions.get(i);
    currExplosion.updateExplosion();
    currExplosion.drawExplosion();
    if ( currExplosion.getSize() == 0 ) {
      allExplosions.remove(currExplosion);
    }
  }  
}

// The following function below handle the explosion of ship and alien ship
// where the main difference is the magnitude of the explosion which is 
// distinguised by the size of the particles. Last but not least, we add this new
// explosion to our explosion list.

// This function handles the a MINI EXPLOSION when the ship hits the Alien Enemy
void enemyExplosion(float x, float y, float z) {
  MyExplosion newExplosion = new MyExplosion(x,y,z, ENEMY_SIZE/15);
  allExplosions.add(newExplosion);
}

// This function handles the a BIG EXPLOSION when the Alien Enemy hits the Spaceship
// Then, we proceed to call the end game function.
void spaceshipExplosion(float x, float y, float z) {
  MyExplosion newExplosion = new MyExplosion(x,y,z, SHIP_SIZE/10);
  allExplosions.add(newExplosion);
  endGame();
}
