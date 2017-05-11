
LSystem lsystem;
Turtle turtle;

PFont f;

String seed;
Rule[] ruleset;
LSystem[] lsystems = new LSystem[5];
int lsysInd = 3;

boolean spin = true;
boolean simple = false;
boolean leaves = true;
float spinTime = 0;
float simpleTime = 0;
float leavesTime = 0;
float resetTime = 0;
float going = 7;

float a = 0.0;

void setup() {
  size(960, 720, P3D);

  // Configuration A
  String seed_a = "F";
  float theta_a = PI/6;
  Rule[] ruleset_a = new Rule[1];
  ruleset_a[0] = new Rule('F', ",F;[+FL]&F[\\FL]");
  LSystem lsystem_a = new LSystem(seed_a, ruleset_a, theta_a, 4, true, .60, 20, 1);
  
  // Configuration B
  String seed_b = "F";
  float theta_b = PI/12;
  Rule[] ruleset_b = new Rule[1];
  ruleset_b[0] = new Rule('F', "FF+&[&\\FL]");
  LSystem lsystem_b = new LSystem(seed_b, ruleset_b, theta_b, 4, true, .80, 20, 1);


  // Curling Tree
  String seed_c = "XF";
  float theta_c = radians(25);
  Rule[] ruleset_c = new Rule[2];
  ruleset_c[0] = new Rule('X', "F−[[XL]+X]+F[+FLX]−XL");
  ruleset_c[1] = new Rule('F', "FF");
  LSystem lsystem_c = new LSystem(seed_c, ruleset_c, theta_c, 4, true, .9, 20, 1);


  // Balanced Tree
  String seed_d = "F";
  float theta_d = radians(40);
  Rule[] ruleset_d = new Rule[1];
  ruleset_d[0] = new Rule('F', "F[+F][-F][F][/F][\\F]");
  LSystem lsystem_d = new LSystem(seed_d, ruleset_d, theta_d, 7, true, .9, 80, 1);

  // Pythagorean Tree
  String seed_e = "F";
  float theta_e = radians(90);
  Rule[] ruleset_e = new Rule[1];
  ruleset_e[0] = new Rule('F', "F[+F][-F]");
  LSystem lsystem_e = new LSystem(seed_e, ruleset_e, theta_e, 10, false, .7, 150, 1.0/9.0);
  
  lsystems[0] = lsystem_a;
  lsystems[1] = lsystem_b;
  lsystems[2] = lsystem_c;
  lsystems[3] = lsystem_d;
  lsystems[4] = lsystem_e;
  
  turtle = new Turtle();
  setLSystem(lsysInd);
  
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
  if (simpleTime >= 40) {
    simpleTime -= going;
    fill(simpleTime);
    textAlign(RIGHT, BOTTOM);
    String status = simple ? "ON" : "OFF";
    text("SIMPLE " + status, width - 10, height - 10);
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
    lsysInd = (lsysInd + 1) % 5;
    setLSystem(lsysInd);
  }
  if (key == '2') {
    spin = !spin;
    spinTime = 255;
  }
  else if (key == '3') {
    simple = !simple;
    turtle.simple = simple;
    simpleTime = 255;
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
  else if (key == '9') {
    a = PI / 2;
  }
}

void setLSystem(int i) {
  lsystem = lsystems[i];
  turtle.setLSystem(lsystem);
}