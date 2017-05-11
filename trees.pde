
LSystem lsystem;
Turtle turtle;

PFont f;

String seed;
Rule[] ruleset;
LSystem[] lsystems = new LSystem[5];
int lsysInd = 0;

boolean spin = true;
boolean circular = true;
boolean leaves = true;
float spinTime = 0;
float circularTime = 0;
float leavesTime = 0;
float resetTime = 0;
float going = 7;

float a = 0.0;



void setup() {
  size(800, 600, P3D);

  // Configuration A
  String seed_a = "F";
  float theta_a = PI/6;
  Rule[] ruleset_a = new Rule[1];
  ruleset_a[0] = new Rule('F', ",F;[+FL]&F[\\FL]");
  LSystem lsystem_a = new LSystem(seed_a, ruleset_a, theta_a);
  
  // Configuration B
  String seed_b = "F";
  float theta_b = PI/12;
  Rule[] ruleset_b = new Rule[1];
  ruleset_b[0] = new Rule('F', "FF+&[&\\FL]");
  LSystem lsystem_b = new LSystem(seed_b, ruleset_b, theta_b);
  
  lsystems[0] = lsystem_a;
  lsystems[1] = lsystem_b;
  
  lsystem = lsystems[lsysInd];
  turtle = new Turtle(lsystem.getSentence(), lsystem.getTheta());
  
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
  
  // Write seed
  fill(200);
  textAlign(LEFT, TOP);
  text("SEED:", 10, 10);
  text(lsystem.getSeed(), 80, 10);
  
  // Write rules
  fill(200);
  textAlign(LEFT, TOP);
  text("RULES: ", 10, 35);
  for (int i = 0; i < lsystem.rules.length; i++) {
    text(lsystem.rules[i].getPre() + " -> " + lsystem.rules[i].getSuc(), 80, 35 + 20 * i); 
  }
  
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
  // Write reset
  if (resetTime >= 40) {
    resetTime -= going;
    fill(resetTime);
    textAlign(RIGHT, BOTTOM);
    text("RESET", width - 10, height - 10);
  }
  
  translate(width/2, height, -50);
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
    lsysInd = lsysInd + 1;
    if (lsystems[lsysInd] == null) {
      lsysInd = 0;
    }
    setLSystem(lsysInd);
  }
  if (key == '2') {
    spin = !spin;
    spinTime = 255;
  }
  else if (key == '3') {
    circular = !circular;
    turtle.circular = circular;
    circularTime = 255;
  }
  else if (key == '4') {
    leaves = !leaves;
    turtle.leaves = leaves;
    leavesTime = 255;
  }
  else if (key == '0') {
    lsystem.reset();
    turtle.setSentence(lsystem.getSentence());
    resetTime = 255;
  }
}

void setLSystem(int i) {
  lsystem = lsystems[i];
  turtle.setSentence(lsystem.getSentence());
}