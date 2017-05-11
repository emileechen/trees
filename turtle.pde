
class Turtle {
  String todraw;
  float len;
  float theta;
  float currTheta;
  int stroke;
  float strokeDelt = .5;
  int colour;
  int[] colourMap = {255, 240, 225, 210, 195, 180, 165};
  color green = #6A7F4E;
  PImage leavesTex = loadImage("leaves.png");
  
  boolean leaves = true;
  boolean circular = true;
  int cir_sides = 6;
  
  Turtle(String s, float t) {
    todraw = s;
    theta = t;
  }
  
  void reset() {
    len = 20;
    currTheta = - theta;
    stroke = 6;
    colour = 0;
  }
  
  void setSentence(String sentence) {
    todraw = sentence;
  }
  
  void render() {
    reset();
    
    int i = 0;
    while (i < todraw.length()) {
      
      char c = todraw.charAt(i);
      char d = ' ';
      
      // Only check next char if not last char in string
      if (i != todraw.length() -1) {
        d = todraw.charAt(i+1);
      }
      
      // Symbols for movement and drawing
      if (c == 'F') {       // Move one step forward and draw
      
        fill(colourMap[colour+1]);
        stroke(colourMap[colour]);
        strokeWeight(stroke);
        
        if (circular) {
          noStroke();
          pushMatrix();
          translate(len/2, 0, 0);
          rotateZ(PI/2);
          if (d == 'L' || d == ']') {
            cylinder(stroke/2, 0, len, cir_sides);
          } else {
            cylinder(stroke/2, stroke/2, len, cir_sides);
          }
          popMatrix();
        } else {
          line(0, 0, 0, len, 0, 0);   
        }
        translate(len, 0, 0);
      }   
      else if (c == 'L') {
        if (leaves) {
          noStroke();
          fill(green);
          
          pushMatrix();
          rotateZ(PI/2);
          translate(-len, -len, 0);
          image(leavesTex, 0, 0, len*2, len*2);
          popMatrix();
          pushMatrix();
          rotateX(PI/2);
          rotateZ(PI/2);
          translate(-len, -len, 0);
          image(leavesTex, 0, 0, len*2, len*2);
          popMatrix();
          
          //fill(green);
          //rect(-len/2, -len, len*2, len*2);
          //rotateX(PI/2);
          //rect(-len/2, -len, len*2, len*2);
        }
      }
      
      // Symbols for orientation control
      else if (c == '+') {  // Rotate left around U (y) axis 
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          float t = float(todraw.substring(i+2, end));
          rotateY(t);
          i += end - i;
        } else {
          rotateY(currTheta);
        }
      }
      else if (c == '-') {  // Rotate right around U axis
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          float t = float(todraw.substring(i+2, end));
          rotateY(-t);
          i += end - i;
        } else {
          rotateY(-currTheta);
        }
      }
      else if (c == '&') {  // Pitch down around L (x) axis 
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          float t = float(todraw.substring(i+2, end));
          rotateX(t);
          i += end - i;
        } else {
          rotateX(currTheta);
        }
        rotateX(currTheta);
      }
      else if (c == '^') {  // Rotate right around L axis
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          float t = float(todraw.substring(i+2, end));
          rotateX(-t);
          i += end - i;
        } else {
          rotateX(-currTheta);
        }
        rotateX(-currTheta);
      }
      else if (c == '/') {  // Roll left around H (z) axis 
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          float t = float(todraw.substring(i+2, end));
          rotateZ(t);
          i += end - i;
        } else {
          rotateZ(currTheta);
        }
        rotateZ(currTheta);
      }
      else if (c == '\\') {  // Rotate right around H axis
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          float t = float(todraw.substring(i+2, end));
          rotateZ(-t);
          i += end - i;
        } else {
          rotateZ(-currTheta);
        }
        rotateZ(-currTheta);
      }
      else if (c == '|') {  // Turn 180 around U axis
        rotateZ(PI);
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
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          stroke = int(todraw.substring(i+2, end));
          i += end - i;
        } else {
          stroke += strokeDelt;
        }
        stroke = constrain(stroke, 2, 10);
        strokeWeight(stroke);
      }
      else if (c == '!') {    // Set line width or decrease by strokeDelt
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          stroke = int(todraw.substring(i+2, end));
          i += end - i;
        } else {
          stroke -= strokeDelt;
        }
        stroke = constrain(stroke, 2, 10);
        strokeWeight(stroke);
      }
      else if (c == ';') {    // Set ind of colour map or increase ind
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          colour = int(todraw.substring(i+2, end));
          i += end - i;
        } else {
          colour += 1;
        }
        colour = constrain(colour, 0, colourMap.length-2);
        stroke(colourMap[colour]);
      }
      else if (c == ',') {    // Set ind of colour map or increase ind
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          colour = int(todraw.substring(i+2, end));
          i += end - i;
        } else {
          colour -= 1;
        }
        colour = constrain(colour, 0, colourMap.length-2);
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


void cylinder(float r_bottom, float r_top, float h, int sides) {  
  float theta = TWO_PI / sides;

  // Draw bottom circle
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos(i * theta) * r_bottom;
    float y = sin(i * theta) * r_bottom;
    vertex(x, h/2, y);
  }
  endShape(CLOSE);
  
  // Draw top circle
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos(i * theta) * r_top;
    float y = sin(i * theta) * r_top;
    vertex(x, -h/2, y);
  }
  endShape(CLOSE);
  
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides+1; i++) {
    float x_1 = cos(i * theta) * r_bottom;
    float y_1 = sin(i * theta) * r_bottom;
    float x_2 = cos(i * theta) * r_top;
    float y_2 = sin(i * theta) * r_top;
    vertex(x_1, h/2, y_1);
    vertex(x_2, -h/2, y_2);
  }
  endShape(CLOSE);
}