Turtle turtle;

void setup() {
  size(400, 300, P3D);
  turtle = new Turtle("!(2)FFFF\\![F/F-F]-[-F&F+F+F]");
}

void draw() {
  background(40);
  translate(width/2, height, 0);
  rotate(-PI/2);
  turtle.render();
}




class Turtle {
  String todraw;
  float len;
  float theta;
  
  Turtle(String s) {
    todraw = s;
    len = 20;
    theta = - PI/4;
  }
  
  void render() {
    stroke(255);
    //strokeWeight(2);
    
    int i = 0;
    while (i < todraw.length()) {
    //for (int i = 0; i < todraw.length(); i++) {
      
      char c = todraw.charAt(i);
      
      // Symbols for movement and drawing
      if (c == 'F') {       // Move one step forward and draw
        line(0, 0, 0, len, 0, 0);
        translate(len, 0, 0);
      }
      
      // Symbols for orientation control
      else if (c == '+') {  // Rotate left around U (y) axis 
        rotateY(theta);
      }
      else if (c == '-') {  // Rotate right around U axis
        rotateY(-theta);
      }
      else if (c == '&') {  // Pitch down around L (x) axis 
        rotateX(theta);
      }
      else if (c == '^') {  // Rotate right around L axis
        rotateX(-theta);
      }
      else if (c == '/') {  // Roll left around H (z) axis 
        rotateZ(theta);
      }
      else if (c == '\\') {  // Rotate right around H axis
        rotateZ(-theta);
      }
      
      // Symbols for modeling structures
      else if (c == '[') {
        pushMatrix();
      }
      else if (c == ']') {
        popMatrix();
      }
      
      // Symbols for changing drawing attributes
      else if (c == '!') {
        char d = todraw.charAt(i+1);
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          println(int(todraw.substring(i+2, end-1)));
          strokeWeight(int(todraw.substring(i+2, end-1)));
        } else {
          strokeWeight(1);
        }
      }
      
      i++;
    }
  }
  
}

// Given string and index of opening paren, return index of closing paren
// Does not handle nesting
int findClosingParen(String str, int ind) {
  int i = ind;
  while (i < str.length()) {
    char c = str.charAt(i);
    if (c == ')') {
      return i;
    }
    i++;
  }
  return -1;
}