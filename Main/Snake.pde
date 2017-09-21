class Snake {
  
  int columns, rows;
  int tx, ty;
  PVector[][] matrice;
  ArrayList<PVector> corps;
  PVector direction;
  HashMap<Integer, PVector> map;
  PVector food;
  
  public Snake(int columns, int rows) {
      this.columns = columns;
      this.rows = rows;
      this.tx = width / columns;
      this.ty = height / rows;
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
      
      addCorps(matrice[(columns % 2 == 0) ? columns / 2 : (columns - 1) / 2][(rows % 2 == 0) ? rows / 2 : (rows - 1) / 2]);
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
      
      map = p; //<>// //<>// //<>//
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
    HashMap<Integer, PVector> p = new HashMap(); 
    PVector v = new PVector(direction.x + map.get(0).x, direction.y + map.get(0).y);
    
    this.corps.add(matrice[(int) v.x][(int) v.y]);
     
     if(map.size() == 0) {  
         map.put(0, matrice[(int) v.x][(int) v.y]);
     } else {
       
       p.put(0, matrice[(int) v.x][(int) v.y]);
       
       for (int i = 0; i < map.size(); i++) {
            p.put(i+1, map.get(i));
       }
       map = p;
     }
    
  }
  
  public void addCorps(PVector v) {
    HashMap<Integer, PVector> p = new HashMap(); 
    
    this.corps.add(matrice[(int) v.x][(int) v.y]);
     
     if(map.size() == 0) {  
         map.put(0, matrice[(int) v.x][(int) v.y]);
     } else {
       
       p.put(0, matrice[(int) v.x][(int) v.y]);
       
       for (int i = 0; i < map.size(); i++) {
            p.put(i+1, map.get(i));
       }
       map = p;
     }
    
  }
  
  public void eat() {
      PVector v = new PVector(direction.x + map.get(0).x, direction.y + map.get(0).y);
      
      if(v.x == food.x && v.y == food.y) {
         addCorps();
         
         sumonFood();
      }
      
  }
  
  public void sumonFood() {
      int x;
      int y;
      
      do {
        x = (int) random(2, columns - 2);
        y = (int) random(2, rows - 2);
      } while (corps.contains(matrice[x][y]));
      
      food.set(x, y);
}
  
  public void death() {
      PVector v = new PVector(direction.x + map.get(0).x, direction.y + map.get(0).y);  
      if(corps.contains(v) || v.x >= columns || v.x < 0 || v.y >= rows ||v.y < 0) {
          map = new HashMap();
          corps = new ArrayList();
          addCorps(matrice[(columns % 2 == 0) ? columns / 2 : (columns - 1) / 2][(rows % 2 == 0) ? rows / 2 : (rows - 1) / 2]);
          setDirection(0, 0);
      }
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