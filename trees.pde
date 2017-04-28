Turtle turtle;

void setup() {
  size(400, 300);
  turtle = new Turtle("FF+[+F-F-F]-[-F+F+F]");
}

void draw() {
  background(40);
  translate(width/2, height);
  rotate(-PI/2);
  turtle.render();
}




class Turtle {
  String todraw;
  float len;
  float theta;
  
  Turtle(String s) {
    todraw = s;
    len = 10;
    theta = - PI/4;
  }
  
  void render() {
    stroke(255);
    
    int i = 0;
    while (i < todraw.length()) {
    //for (int i = 0; i < todraw.length(); i++) {
      
      char c = todraw.charAt(i);
      
      // Symbols for movement and drawing
      if (c == 'F') {
        line(0,0,len,0);
        translate(len,0);
      }
      
      // Symbols for orientation control
      else if (c == '+') {
        rotate(theta);
      }
      else if (c == '-') {
        rotate(-theta);
      }
      
      // Symbols for modeling structures
      else if (c == '[') {
        pushMatrix();
      }
      else if (c == ']') {
        popMatrix();
      }
      
      // Symbols for changing drawing attributes
      
      i++;
    }
  }
  
}