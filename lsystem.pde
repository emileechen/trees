class Rule {
  char pre;
  String suc;
  
  Rule(char a, String b) {
    pre = a;
    suc = b;
  }
  
  char getPre() {
    return pre;
  }
  String getSuc() {
    return suc;
  }
}


class LSystem {
  String sentence;
  Rule[] rules;
  int gen;
  int genCap = 4;
  
  LSystem(String axiom, Rule[] r) {
    sentence = axiom;
    rules = r;
    gen = 0;
  }
  
  void reset(String axiom) {
    sentence = axiom;
    gen = 0;
  }
  
  void grow() {
    if (gen != genCap) {
      StringBuffer nextGen = new StringBuffer();
      for (int i = 0; i < sentence.length(); i++) {
        
        char c = sentence.charAt(i);
        
        String replace = "" + c;
        for (int j = 0; j < rules.length; j++) {
          char pre = rules[j].getPre();
          if (c == pre) {
            replace = rules[j].getSuc();
          }
        }
        nextGen.append(replace);
        
      }
      sentence = nextGen.toString();
      insertRandom();
      gen++;
    }
  }
  
  String getSentence() {
    return sentence;
  }
  
  void insertRandom() {
    int[] rotations = {'+', '-', '&', '^', '\\', '/'};
    
    for (int i = 0; i < rotations.length; i++) {
      int j = sentence.indexOf(rotations[i]);
      
      if (j != -1) {
        char c = sentence.charAt(j);
        char d = ' ';
        
        // Only check next char if not last char in string
        if (j != sentence.length() -1) {
          d = sentence.charAt(j+1);
        }
        
        if (c == '+' || c == '-' || c == '&' || c == '^' || c == '\\' || c == '/') {
          if (d != '(') {
            sentence = sentence.substring(0,j+1) + '(' + str(random(PI/20, PI/4)) + ')' + sentence.substring(j+1);
          }
        }
      }
    }
  }
  
  
}