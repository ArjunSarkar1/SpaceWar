// This file handles describes the Particle Class. Describing a singular particle.

class Particle {

  // Each particle holds a speed, position, color, opacity and size
  // Note: the opacity helps with the shinniness of the particle as it spreads out further away
  PVector particleSpeed;
  PVector particlePosition;
  color particleColor;
  int particleOpacity;
  int pSize;
  
  // In the Partical Constructor, we are accepting the given coordinates
  // of position as well as the specified particle size.
  // Randomized color as well as a an appropriate random speed
  Particle(float x, float y, float z, int particleSize) {
    particleSpeed = new PVector( random(-10,10),random(-10,10),0 );
    particlePosition = new PVector(x,y,z);
    particleColor = color( random(1,255),random(1,255), random(1,255));
    pSize = particleSize;
    particleOpacity = 250;
  }
  
  // Changing the opacity as well as the position of our particle 
  void updateParticle() {
    particleOpacity = particleOpacity - 10;
    particlePosition.add(particleSpeed);
  }
  
  // Drawing the particle with the current opacity and color
  // as well as with no outline!
  void drawParticle() {
    noStroke();
    fill(particleColor, particleOpacity);
    displayParticle();
  }
  
  // This function is used to notify whether to remove the particle
  // from the scene once the opacity is low enough
  boolean checkParticleOpacity() {
    return particleOpacity < 20;
  }
  
  // Creating the particle with a fixed `pSize` particle size.
  void displayParticle() {
    pushMatrix();
    translate(particlePosition.x,particlePosition.y,particlePosition.z);
    beginShape(QUAD);
    vertex(-pSize,-pSize,0);
    vertex(-pSize,pSize,0);
    vertex(pSize,pSize,0);
    vertex(pSize,-pSize,0);
    endShape(CLOSE);
    popMatrix();
  }
}
