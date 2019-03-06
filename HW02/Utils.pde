float MSE(float [] s1, float [] s2) {
  // assert s1.length == s2.length
  float total = 0.0;

  for (int i = 0; i < s1.length; i += 1) {
    total += ((s1[i] - s2[i]) * (s1[i] - s2[i]));
  }

  return total / s1.length;
}

float MSE(float s1, float [] s2) {
  float total = 0.0;

  for (int i = 0; i < s2.length; i += 1) {
    total += ((s1 - s2[i]) * (s1 - s2[i]));
  }

  return total / s2.length;
}

// hmmm, you might want to look at this
// does it really do what it claims?
float minimisesMSEOf(float [] d) {
  final float NOT_CONVERGED = 1E-06;
  
  float a = min(d);
  float b = max(d);
  float m = (a + b) / 2.0;

  float mseA;
  float mseB;

  while (abs(b - a) > NOT_CONVERGED) {
    mseA = MSE(a, d);
    mseB = MSE(b, d);
    
    if (mseA > mseB) {
      a = m;
    } else {
      b = m;
    }
    m = (a + b) / 2.0;
  }

  return m;
}
