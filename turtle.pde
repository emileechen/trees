
class Turtle {
  LSystem lsys;

  String todraw;
  float theta;
  float balance;
  float currTheta;
  int stroke;
  float strokeDelt = .5;
  int colour;
  int[] colourMap = {255, 240, 225, 210, 195, 180, 165};
  color green = #6A7F4E;
  PImage leavesTex = loadImage("leaves.png");
  
  boolean leaves = true;
  boolean simple = false;
  int cir_sides = 6;

  Turtle() {

  }
  
  void reset() {
    currTheta = - theta;
    stroke = 3;
    colour = 0;
  }
  
  void setSentence(String sentence) {
    todraw = sentence;
  }

  void setLSystem(LSystem ls) {
    lsys = ls;
    todraw = ls.getSentence();
  }

  void drawTrunk() {
    fill(colourMap[colour+1]);
    stroke(colourMap[colour]);
    strokeWeight(stroke);
    
    float tlen = min(150.0, lsys.getLength() * 3.0);
    if (!simple) {
      noStroke();
      pushMatrix();
      translate(tlen/2, 0, 0);
      rotateZ(PI/2);
      cylinder(stroke/2, stroke/2, tlen, cir_sides);
      popMatrix();
    } else {
      line(0, 0, 0, tlen, 0, 0);   
    }
    translate(tlen, 0, 0);
  }

  void drawLeaves(float clen) {
    noStroke();
    fill(green);
    
    if (simple) {
      rect(-clen/2, -clen, clen*2, clen*2);
      rotateX(PI/2);
      rect(-clen/2, -clen, clen*2, clen*2);
    } else {
      pushMatrix();
      rotateZ(PI/2);
      translate(-clen, -clen, 0);
      image(leavesTex, 0, 0, clen*2, clen*2);
      popMatrix();
      
      pushMatrix();
      rotateX(PI/2);
      rotateZ(PI/2);
      translate(-clen, -clen, 0);
      image(leavesTex, 0, 0, clen*2, clen*2);
      popMatrix();
    }
  }
  
  void render() {
    reset();
    
    float currTheta = -lsys.getTheta();
    int i = 0;
    int g = 0;
    float clen = lsys.getLength();

    drawTrunk();

    while (i < todraw.length()) {
      
      char c = todraw.charAt(i);
      char d = ' ';
      float b = lsys.getBalance() * max(0, (lsystem.gen - 1));

      // Only check next char if not last char in string
      if (i != todraw.length() -1) {
        d = todraw.charAt(i+1);
      }
      
      // Symbols for movement and drawing
      if (c == 'F') {       // Move one step forward and draw
        fill(colourMap[colour+1]);
        stroke(colourMap[colour]);
        strokeWeight(stroke);
        
        if (!simple) {
          noStroke();
          pushMatrix();
          translate(clen/2, 0, 0);
          rotateZ(PI/2);
          if (d == 'L' || d == ']') {
            cylinder(stroke/2, 0, clen, cir_sides);
          } else {
            cylinder(stroke/2, stroke/2, clen, cir_sides);
          }
          popMatrix();
        } else {
          line(0, 0, 0, clen, 0, 0);   
        }

        translate(clen, 0, 0);
        if (g == lsys.gen && leaves) {
          if (leaves) {
            drawLeaves(clen);
          }
        }
      }
      else if (c == 'L') {
        if (leaves) {
          drawLeaves(clen);
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
          if (!lsystem.random) {
            rotateY(max(-45, (currTheta / 2.0) * b));
          } else {
            rotateY(currTheta);
          }
        }
      }
      else if (c == '-') {  // Rotate right around U axis
        if (d == '(') {
          int end = findClosingParen(todraw, i+1);
          float t = float(todraw.substring(i+2, end));
          rotateY(-t);
          i += end - i;
        } else {
          if (!lsystem.random) {
            rotateY(-min(-45, currTheta * (1.0 - b)));
          } else {
            rotateY(-currTheta);
          }
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
        clen *= lsys.getReduction();
        g++;
      }
      else if (c == ']') {
        popMatrix();
        clen *= 1.0 / lsys.getReduction();
        g--;
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