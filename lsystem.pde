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
  
  LSystem(String axiom, Rule[] r) {
    sentence = axiom;
    rules = r;
    gen = 0;
  }
  
  void grow() {
    StringBuffer nextGen = new StringBuffer();
    for (int i = 0; i < sentence.length(); i++) {
      char c = sentence.charAt(i);
      String replace = "" + c;
      for (int j = 0; j < rules.length; j++) {
        char pre = rules[j].getPre();
        if (c == pre) {
          replace = rules[j].getSuc();
          break;
        }
      }
      nextGen.append(replace);
    }
    sentence = nextGen.toString();
    gen++;
  }
  
  String getSentence() {
    return sentence;
  }
  
}