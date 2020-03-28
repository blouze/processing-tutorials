// BOIDS
// algorithm created by Craig W. Reynolds
// https://fr.wikipedia.org/wiki/Boids

int population = 600;
Boid[] flock = new Boid[population];
int maxForce = 2;

void setup() {
  size(900, 900);
  
  for (int i = 0; i < population; i++) {
    PVector pos = new PVector(random(width), random(height));
    PVector vel = new PVector(random(-2, 2), random(-2, 2));
    flock[i] = new Boid(pos, vel);
  }
}

PVector cohesion(int index) {
  Boid boid = flock[index];
  PVector f = new PVector();
  
  for (int i = 0; i < population; i++) {
    if (i == index) continue;
    Boid otherBoid = flock[i];
    f.add(otherBoid.pos);
  }
  f.div(population - 1).sub(boid.pos).div(100);
  
  return f; 
}

PVector separation(int index) {
  Boid boid = flock[index];
  PVector f = new PVector();
  int proximity = 10;

  for (int i = 0; i < population; i++) {
    if (i == index) continue;
    Boid otherBoid = flock[i];
    if (otherBoid.pos.dist(boid.pos) > proximity) continue;
    f.sub(otherBoid.pos.copy().sub(boid.pos));
  }
  
  return f;
}

PVector alignment(int index) {
  Boid boid = flock[index];
  PVector f = new PVector();
  
  for (int i = 0; i < population; i++) {
    if (i == index) continue;
    Boid otherBoid = flock[i];
    f.add(otherBoid.vel);
  }
  f.div(population - 1).sub(boid.vel).div(8);
  
  return f; 
}

void draw () {
  background(22, 22, 29);
  stroke(255);

  for (int i = 0; i < population; i++) {
    Boid boid = flock[i];
    
    PVector c = cohesion(i).limit(maxForce);
    PVector s = separation(i).limit(maxForce);
    PVector a = alignment(i).limit(maxForce);

    PVector av = avoidance(i).limit(maxForce);
    
    boid.vel.add(c).add(s).add(a).add(av);
    
    boid.update();
    boid.show();
  }
}

// extra

PVector avoidance(int index) {
  Boid boid = flock[index];
  PVector f = new PVector();
  PVector mousePos = new PVector(mouseX, mouseY);
  int proximity = 50;
  
  if (mousePos.dist(boid.pos) < proximity) {
    f.sub(mousePos.sub(boid.pos));
  }
  return f;
}
