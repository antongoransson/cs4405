float [] strongestNBins(float [] a, int n) {
  float [] r = new float[a.length];
  float [] top = new float[n];

  arrayCopy(a, r);
  Arrays.sort(r); 
  arrayCopy(r, r.length - n, top, 0, n);
  
  return reverse(top);
}

int [] indicesOfStrongestBins(float [] a, float [] top) {
  int [] topIndices = new int [top.length];

  for ( int i = 0; i < top.length; i += 1 ) {
    int k = 0;
    while (a[k] != top[i]) {
      k += 1;
    }
    topIndices[i] = k;
  }

  return topIndices;
}


float indexToFrequency(int i, float samples, int nFFT) {
  return i * (samples / (nFFT));
}

float [] frequenciesOfStrongestBins(int [] idx, float samples, int nFFT) {
  float [] r = new float[idx.length];
  
  for (int i = 0; i < idx.length; i += 1) {
    r[i] = indexToFrequency(idx[i], samples, nFFT);
  }
  
  return r;
}

float strongestAcrossAllSpectra(float [][]s) {
  float strongest = 0;
  
  for (int i = 0; i < s.length; i += 1) {
    for (int j = 0; j < s[i].length; j += 1) {
      if (strongest < s[i][j]) {
        strongest = s[i][j];
      }
    }
  }
  
  return strongest;
}
