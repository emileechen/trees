
class Turtle {
  String todraw;
  float len;
  float theta;
  int stroke;
  int strokeDelt = 1;
  int colour;
  int[] colourMap = {255, 240, 225, 210, 195, 180, 165};
  
  boolean circular = true;
  
  Turtle(String s) {
    todraw = s;
    len = 20;
    theta = - PI/6;
    stroke = 1;
    colour = 0;
  }
  
  void setSentence(String sentence) {
    todraw = sentence;
  }
  
  void render() {
    fill(colourMap[colour+1]);
    stroke(colourMap[colour]);
    strokeWeight(stroke);
    
    int i = 0;
    while (i < todraw.length()) {
    //for (int i = 0; i < todraw.length(); i++) {
      
      char c = todraw.charAt(i);
      
      // Symbols for movement and drawing
      if (c == 'F') {       // Move one step forward and draw
        if (circular) {
          pushMatrix();
          translate(len/2, 0, 0);
          rotateZ(PI/2);
          cylinder(stroke, stroke, len, 6);
          popMatrix();
        } else {
          line(0, 0, 0, len, 0, 0);   
        }
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
        colour = constrain(colour, 0, colourMap.length-2);
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
  
  beginShape(QUAD_STRIP);
  for (int i = 0; i < sides+1; i++) {
    float x_1 = cos(i * theta) * r_top;
    float y_1 = sin(i * theta) * r_top;
    float x_2 = cos(i * theta) * r_top;
    float y_2 = sin(i * theta) * r_top;
    vertex(x_1, h/2, y_1);
    vertex(x_2, -h/2, y_2);
  }
  endShape(CLOSE);
}