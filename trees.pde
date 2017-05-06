Turtle turtle;

void setup() {
  size(400, 300, P3D);
  turtle = new Turtle(";(0)#F;(4)F;;;;F,,,F;\\![F/FF+F/FF[\\F&F];[+F]-F]-;;[-/F&,F+F+F]");
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
  int stroke;
  int strokeDelt = 1;
  int colour;
  int[] colourMap = {255, 240, 225, 210, 195, 180};
  
  Turtle(String s) {
    todraw = s;
    len = 20;
    theta = - PI/4;
    stroke = 1;
    colour = 0;
  }
  
  void render() {
    stroke(colourMap[colour]);
    strokeWeight(stroke);
    
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
      else if (c == '#') {    // Set line width or increase by strokeDelt
        char d = todraw.charAt(i+1);
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          stroke = int(todraw.substring(i+2, end));
          i += end - i;
        } else {
          stroke += strokeDelt;
        }
        stroke = constrain(stroke, 1, 10);
        strokeWeight(stroke);
      }
      else if (c == '!') {    // Set line width or decrease by strokeDelt
        char d = todraw.charAt(i+1);
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          stroke = int(todraw.substring(i+2, end));
          i += end - i;
        } else {
          stroke -= strokeDelt;
        }
        stroke = constrain(stroke, 1, 10);
        strokeWeight(stroke);
      }
      else if (c == ';') {    // Set ind of colour map or increase ind
        char d = todraw.charAt(i+1);
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          colour = int(todraw.substring(i+2, end));
          i += end - i;
        } else {
          colour += 1;
        }
        colour = constrain(colour, 0, colourMap.length-1);
        stroke(colourMap[colour]);
      }
      else if (c == ',') {    // Set ind of colour map or increase ind
        char d = todraw.charAt(i+1);
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          colour = int(todraw.substring(i+2, end));
          i += end - i;
        } else {
          colour -= 1;
        }
        colour = constrain(colour, 0, colourMap.length-1);
        stroke(colourMap[colour]);
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