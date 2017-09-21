class Snake {
  
  int columns, rows;
  int tx, ty;
  PVector[][] matrice;
  ArrayList<PVector> corps;
  PVector direction;
  HashMap<Integer, PVector> map;
  PVector food;
  
  public Snake(int columns, int rows) {
      this.tx = width / columns;
      this.ty = height / rows;
      this.columns = columns - 1;
      this.rows = rows - 1;
      this.matrice = new PVector[columns][rows];
      
      this.corps = new ArrayList();
      this.direction = new PVector(0, 0);
      this.map = new HashMap();
      this.food = new PVector();
      
      for(int i = 0; i < columns; i++) {
        for(int j = 0; j < rows; j++) {
             matrice[i][j] = new PVector(i, j);
         }
      }
      
      firstCorp(matrice[(columns % 2 == 0) ? columns / 2 : columns / 2 - 1][(rows % 2 == 0) ? rows / 2 : rows / 2 - 1]);
      sumonFood();
  }
  
  public void move() {
    
      if(direction.x == 0 && direction.y == 0) return;   //<>//
      
      PVector v = new PVector(direction.x + map.get(0).x, direction.y + map.get(0).y); //<>//
      HashMap<Integer, PVector> p = new HashMap();
      
      p.put(0, matrice[(int) v.x][(int) v.y]);
      corps.add(matrice[(int) v.x][(int) v.y]);
      corps.remove(map.get(map.size() - 1));
      
      for (int i = 0; i < map.size() - 1; i++) {
         p.put(i+1, map.get(i));
      }
      
      map = p;
  }

  public void death() {
      PVector v = new PVector(map.get(0).x + direction.x, map.get(0).y + direction.y);  
      if(corps.contains(v) || v.x > columns || v.x < 0 || v.y > rows ||v.y < 0) {
          map = new HashMap();
          corps = new ArrayList();
          firstCorp(matrice[(columns % 2 == 0) ? columns / 2 : columns / 2 - 1][(rows % 2 == 0) ? rows / 2 : rows / 2 - 1]);
          setDirection(0, 0);
      }
  }
  
  public void display() {
      noStroke();
      fill(188, 107, 229);
      rect(getPixX(food), getPixY(food), tx, ty);
   
      stroke(40);
      fill(255);
      for(PVector v : corps) {
          rect(getPixX(v), getPixY(v), tx, ty);
      }
      
  }
  
   public void addCorps() {
    PVector v = food;
    
    this.corps.add(matrice[(int) v.x][(int) v.y]);
    map.put(corps.size() - 1, matrice[(int) v.x][(int) v.y]);
  }
  
  public void firstCorp(PVector v) {
    this.corps.add(matrice[(int) v.x][(int) v.y]);
    map.put(0, matrice[(int) v.x][(int) v.y]);
  }
  
  public void eat() { 
      if(map.get(0).x == food.x && map.get(0).y == food.y) {
         addCorps();
         sumonFood();
      }
  }
  
  public void sumonFood() {
      int x;
      int y;
      
      do {
        x = (int) random(0, columns);
        y = (int) random(0, rows);
      } while (corps.contains(matrice[x][y]));
      
      food.set(x, y);
}
  
  public void setDirection(int x, int y) {
      direction.set(x, y);
  }
  
  public void setDirection(PVector v) {
      direction.set(v.x, v.y);
  }
  
  public PVector getDirection() {
     return direction; 
  }
  
  private float getPixX(PVector v) {
    return v.x * tx; 
  }

  private float getPixY(PVector v) {
     return v.y * ty; 
  }

}