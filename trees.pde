
LSystem lsystem;
Turtle turtle;

PFont f;

boolean spin = true;

float spinTime = 0;
float going = 7;

float a = 0.0;


void setup() {
  size(600, 400, P3D);
  //turtle = new Turtle(";(0)#F;(4)F;;;;F,,,F;\\![F/FF+[F\\F][F/-FFF\\[F&F]];-F]-;;[-/F&,F+[F/FF]F+F]");
  //turtle = new Turtle("F[+F]F[-F]F[+F[+F]F[-F]F]F[+F]F[-F]F[-F[+F]F[-F]F]F[+F]F[-F]F");
  
  Rule[] ruleset = new Rule[1];
  ruleset[0] = new Rule('F', ",F;[+F]&F[\\F]");
  lsystem = new LSystem("F", ruleset);
  turtle = new Turtle(lsystem.getSentence());
  
  // Create font
  f = createFont("FiraMono.tff", 16);
  textFont(f);
}

void draw() {
  background(40);
  
  // Write tree generation
  fill(200);
  textAlign(LEFT, BOTTOM);
  text("GEN: " + lsystem.gen, 10, height - 10);
  
  // Write spinning status
  if (spinTime >= 40) {
    spinTime -= going;
    fill(spinTime);
    textAlign(RIGHT, BOTTOM);
    String status = spin ? "ON" : "OFF";
    text("SPINNING " + status, width - 10, height - 10);
  }
  
  translate(width/2, height - 10, 0);
  //rotateZ(-PI/2);
  
  fill(200);
  stroke(255);
  translate(-100, -150, -100);
  cylinder(90, 0, 200, 6);
  translate(200, 0, 0);
  cylinder(90, 90, 200, 6);
  
  
  rotateX(a);    // Rotates the tree
  //turtle.render();
  
  if (spin) {
    a += 0.01;
  }
  
}

void mousePressed() {
  lsystem.grow();
  println(lsystem.getSentence());
  turtle.setSentence(lsystem.getSentence());
}

void keyPressed() {
  if (key == 's') {
    spin = !spin;
    spinTime = 255;
  }
}