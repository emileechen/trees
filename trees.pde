
LSystem lsystem;
Turtle turtle;

float a = 0.0;


void setup() {
  size(600, 400, P3D);
  //turtle = new Turtle(";(0)#F;(4)F;;;;F,,,F;\\![F/FF+[F\\F][F/-FFF\\[F&F]];-F]-;;[-/F&,F+[F/FF]F+F]");
  //turtle = new Turtle("F[+F]F[-F]F[+F[+F]F[-F]F]F[+F]F[-F]F[-F[+F]F[-F]F]F[+F]F[-F]F");
  
  Rule[] ruleset = new Rule[1];
  ruleset[0] = new Rule('F', "F[+F]&F[\\F]");
  lsystem = new LSystem("F", ruleset);
  turtle = new Turtle(lsystem.getSentence());
}

void draw() {
  background(40);
  translate(width/2, height - 10, 0);
  rotateZ(-PI/2);
  rotateX(a);    // Rotates the tree
  turtle.render();
  a += 0.01;
}

void mousePressed() {
  lsystem.grow();
  println(lsystem.getSentence());
  turtle.setSentence(lsystem.getSentence());
}