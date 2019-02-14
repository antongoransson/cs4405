final int [][] DQT_L = {
  {16, 11, 10, 16, 12, 12, 14, 19}, 
  {14, 13, 16, 24, 14, 17, 22, 29}, 
  {18, 22, 37, 56, 24, 35, 55, 64}, 
  {49, 64, 78, 87, 72, 92, 95, 98}, 
  {24, 40, 51, 61, 26, 58, 60, 55}, 
  {40, 57, 69, 56, 51, 87, 80, 62}, 
  {68, 109, 103, 77, 81, 104, 113, 92}, 
  {103, 121, 120, 101, 112, 100, 103, 99 }
};


final int[][] DQT_C = {
  {17, 18, 24, 47, 99, 99, 99, 99}, 
  {18, 21, 26, 66, 99, 99, 99, 99}, 
  {24, 26, 56, 99, 99, 99, 99, 99}, 
  {47, 66, 99, 99, 99, 99, 99, 99}, 
  {99, 99, 99, 99, 99, 99, 99, 99}, 
  {99, 99, 99, 99, 99, 99, 99, 99}, 
  {99, 99, 99, 99, 99, 99, 99, 99}, 
  {99, 99, 99, 99, 99, 99, 99, 99}
};



int [][] scaledQuantizationMatrix(int [][] q, int quality) {
  int [][] sQ = copy2DArray(q);
  float s = 0;
  
  if (quality < 50) {
    s = 5000.0 / quality;
  }
  else {
    s = 200.0 - 2 * quality;
  }
  
  for (int i = 0; i < q.length; i += 1) {
    for (int j = 0; j < q[i].length; j += 1) {

      long temp = (long) (floor(q[i][j] * s + 50)) / 100L;
      /* limit the values to the valid range for Baseline JPEG (1..255) */
      temp = int(max(temp, 1L));
      temp = int(min(temp, 255L));
      sQ[i][j] = int(temp);
    }
  }
  
  return sQ;
}

void quantize(double [][] d, int [][] q) {  
  for (int i = 0; i < d.length; i += 1) {
    for (int j = 0; j < d[i].length; j += 1) {
      if (d[i][j] == 0) {
        dctCoefficientZeroBeforeQuantization += 1;
      }

      d[i][j] = Math.round(d[i][j] / q[i][j]); 

      if (d[i][j] == 0) {
        dctCoefficientZeroAfterQuantization += 1;
      }
    }
  }
}

void deQuantize(double [][] d, int [][] q) {
  for (int i = 0; i < d.length; i += 1) {
    for (int j = 0; j < d[i].length; j += 1) {
      d[i][j] *= q[i][j];
    }
  }
}
