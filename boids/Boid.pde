class Boid {
  PVector pos;
  PVector vel;
  
  Boid(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;    
  }
  
  void update() {
    this.pos.add(this.vel);
    
    if (this.pos.x < 0 || this.pos.x > width) this.vel.x *= -1;
    if (this.pos.y < 0 || this.pos.y > height) this.vel.y *= -1;
    
    this.vel.limit(10);
  }
  
  void show() {
    point(this.pos.x, this.pos.y);
  }
}
