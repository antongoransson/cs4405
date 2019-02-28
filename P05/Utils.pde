
int countZeroIn(float [] d) {
  int c = 0; 
  for (int i = 0; i < d.length; i += 1) {
    if (d[i] == 0) {
      c += 1;
    }
  }

  return c;
}

int countUniqueIn(float [] d) {
  HashSet s = new HashSet();

  for (int i = 0; i < d.length; i += 1) {
    s.add(d[i]);
  }

  return s.size();
}


HashMap<Float, Integer> distributionOfValues(float [] s) {
  HashMap<Float, Integer> count = new HashMap<Float, Integer>();

  for (int i = 0; i < s.length; i += 1) {
    Integer c = count.get(s[i]);
    if (c == null) {
      count.put(s[i], 1);
    } else {
      count.put(s[i], c + 1);
    }
  }

  return count;
}


// Measure differences
// Mean Squared Error

float MSE(float [] s1, float [] s2) {
  // assert s1.length == s2.length
  float total = 0.0;

  for (int i = 0; i < s1.length; i += 1) {
    total += ((s1[i] - s2[i]) * (s1[i] - s2[i]));
  }

  return total / s1.length;
}


// Peak Signal to Noise Ratio
float PSNR(float [] s1, float [] s2) {
  float p = max(abs(min(s1)), abs(max(s1)));
  float S = p * p;
  float N = MSE(s1, s2);

  return 10 * log10(S/N);
}

float log10(float x) {
  return log(x) / log(10);
}

// resize arrays
float [] trimArray(float [] d, int size) {
  float [] nd = new float[size];
  arrayCopy(d, 0, nd, 0, size);

  return nd;
}
