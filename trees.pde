
LSystem lsystem;
Turtle turtle;

PFont f;

String seed;
Rule[] ruleset;

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
  Rule[] ruleset_a = new Rule[1];
  ruleset_a[0] = new Rule('F', ",F;[+FL]&F[\\FL]");
  lsystem = new LSystem(seed_a, ruleset_a);
    
  //Rule[] ruleset = new Rule[1];
  //ruleset[0] = new Rule('F', ",F;![+FL]&F[\\FL]");
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
  else if (key == '0') {
    lsystem.reset("F");
    turtle.setSentence(lsystem.getSentence());
    resetTime = 255;
  }
}