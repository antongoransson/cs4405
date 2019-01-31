class Box {
  int minValue, maxValue;
  int count;
  int range;
  int unique;

  Box(int m0, int m1, int [] h) {
    minValue = m0;
    maxValue = m1;
    range = maxValue - minValue + 1;
    count = count(h);
    unique = unique(h);
  }

  int count(int [] h) {
    int c = 0;
    for (int i = minValue; i <= maxValue; i += 1) {
      c += h[i];
    }

    return c;
  }

  int unique(int [] h) {
    int c = 0;
    for (int i = minValue; i <= maxValue; i += 1) {
      if (h[i] != 0) {
        c += 1;
      }
    }
    
    return c;
  }
  
  void describe() {
    println("[" + minValue +" .. " + maxValue + "] count = " + count + ", unique = " + unique);
  }
}
