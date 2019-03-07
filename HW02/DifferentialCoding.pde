// generate a predicted value from the signal in [s, e]

float linearPredictedFrom(float [] d, int s, int e) {
  float value = 0;
  float N = e - s + 1;
  float [] w = PREDICTOR_COEFFICIENTS; 

  for (int i = 0; i < N; i += 1) {
    value += (d[s + i] * w[i]);
  }

  return value;
}

// the output of the encoding process for DPCM coding is
// first (N) values are signal
// next (signal length - N) values are quantised differences

void dpcmEncoding(float [] s, float [] p, float [] e) {
  int N = DIFFERENTIAL_ENCODING_SIZE;
  float [] qp = new float[s.length];

  for (int i = 0; i < N; i += 1) {
    p[i] = s[i];
    e[i] = 0.0;
    qp[i] = p[i] + e[i]; 
  }

  for (int i = N; i < s.length; i += 1) {
    p[i] = linearPredictedFrom(qp, i - N, i - 1);
    e[i] = quantize(s[i] - p[i], quantisationScale);
    qp[i] = p[i] + e[i]; 
  } 

}

void reconstructFromDPCMEncoding(float [] s, float [] p, float [] e) {
  int N = DIFFERENTIAL_ENCODING_SIZE;

  // depending on the number of terms in the linear predictor 
  // set predicted to signal value and as a result to error is zero
  for (int i = 0; i < N; i += 1) {
    s[i] = p[i];
  }

  for (int i = N; i < s.length; i += 1) {
    s[i] = linearPredictedFrom(s, i - N, i - 1) + e[i];
  }
}


// quantisation scale and mutiplier (fractional accuracy)
// using 1000 preserves 3 places of decimals
final float MULTIPLIER = 1000.0;

float quantize(float v, float scale) {
  v *= MULTIPLIER;
  return round(v / scale) / MULTIPLIER;
}

float dequantize(float v, float scale) {
  v *= MULTIPLIER;
  return (v * scale) / MULTIPLIER;
}
