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
  String seed;
  String sentence;
  Rule[] rules;
  float theta;
  int gen;
  int genCap;
  boolean random;
  float reduction;
  float balance;
  float length;
  
  LSystem(String axiom, Rule[] r, float t, int cap, boolean rand, float p, float l, float b) {
    seed = axiom;
    sentence = axiom;
    theta = t;
    rules = r;
    genCap = cap;
    random = rand;
    reduction = p;
    length = l;
    balance = b;
    gen = 0;
  }
  
  void reset() {
    sentence = seed;
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
      if (random) {
        insertRandom();
      }
      gen++;
    }
  }
  
  String getSeed() {
    return seed;
  }

  String getSentence() {
    return sentence;
  }

  float getTheta() {
    return theta;
  }

  float getReduction() {
    return reduction;
  }  

  float getLength() {
    return length;
  }

  float getBalance() {
    return balance;
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
            sentence = sentence.substring(0,j+1) + '(' + str(random(-theta/2, theta/2) + theta) + ')' + sentence.substring(j+1);
          }
        }
      }
    }
  }
  
  
}