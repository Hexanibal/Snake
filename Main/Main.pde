Snake s;
PVector v;

void setup() {
  s = new Snake(31, 31);
  v = new PVector();
  
  size(800, 800);
  frameRate(10);
}

void draw() {
  background(40);
  s.death();
  s.eat();
  s.move();
  s.display();
}

void keyPressed() {
      
      if(key == 'f') {
         s.addCorps();
         return;
      }
  
      if(key == 'z') v.set(0, -1);
      if(key == 's') v.set(0, 1);
      if(key == 'q') v.set(-1, 0);
      if(key == 'd') v.set(1, 0);
      
      if(keyCode == UP) v.set(0, -1);
      if(keyCode == DOWN) v.set(0, 1);
      if(keyCode == LEFT) v.set(-1, 0);
      if(keyCode == RIGHT) v.set(1, 0);
      
      if(s.corps.size() == 1) {
          s.setDirection(v);
          return;
      }
      
      v.add(s.getDirection());
      
      if(v.x == 0 && v.y == 0) return;
      else s.setDirection(v.sub(s.getDirection()));
}