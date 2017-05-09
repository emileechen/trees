
LSystem lsystem;
Turtle turtle;

PFont f;

boolean spin = true;
boolean circular = true;
boolean leaves = true;
float spinTime = 0;
float circularTime = 0;
float leavesTime = 0;
float going = 7;

float a = 0.0;


void setup() {
  size(600, 400, P3D);
  //turtle = new Turtle(";(0)#F;(4)F;;;;F,,,F;\\![F/FF+[F\\F][F/-FFF\\[F&F]];-F]-;;[-/F&,F+[F/FF]F+F]");
  //turtle = new Turtle("F[+F]F[-F]F[+F[+F]F[-F]F]F[+F]F[-F]F[-F[+F]F[-F]F]F[+F]F[-F]F");
    
  Rule[] ruleset = new Rule[1];
  ruleset[0] = new Rule('F', ",F;![+FL]&F[\\FL]");
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
  // Write 3D status
  if (circularTime >= 40) {
    circularTime -= going;
    fill(circularTime);
    textAlign(RIGHT, BOTTOM);
    String status = circular ? "ON" : "OFF";
    text("3D " + status, width - 10, height - 10);
  }
  // Write leaves status
  if (leavesTime >= 40) {
    leavesTime -= going;
    fill(leavesTime);
    textAlign(RIGHT, BOTTOM);
    String status = leaves ? "ON" : "OFF";
    text("LEAVES " + status, width - 10, height - 10);
  }
  
  translate(width/2, height - 10, 0);
  rotateZ(-PI/2);  // Rotate to tree points upwards
  rotateX(a);      // Rotates the tree
  turtle.render();
  
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
  if (key == '1') {
    spin = !spin;
    spinTime = 255;
  }
  else if (key == '2') {
    circular = !circular;
    turtle.circular = circular;
    circularTime = 255;
  }
  else if (key == '3') {
    leaves = !leaves;
    turtle.leaves = leaves;
    leavesTime = 255;
  }
}