final int BLOCK_SIZE = 8;


// Takes an image, divide it into blocks apply DCT and then reverse it
PImage dctImage(PImage s) {
  PImage t = createImage(s.width, s.height, RGB);
  t.set(0, 0, s);

  dctCoefficientZeroBeforeQuantization = 0;
  dctCoefficientZeroAfterQuantization = 0;

  for (int y = 0; y < s.height; y += BLOCK_SIZE) {
    for (int x = 0; x < s.width; x += BLOCK_SIZE) {
      PImage blk = t.get(x, y, BLOCK_SIZE, BLOCK_SIZE);
      dctBlock(blk);
      t.set(x, y, blk);
    }
  }
  
  return t;
}

// Goes through DCT process and inverse DCT process
void dctBlock(PImage s) {
  double [][] Y = new double[s.height][s.width];
  double [][] Cb = new double[s.height][s.width];
  double [][] Cr = new double[s.height][s.width];

  for (int y = 0; y < BLOCK_SIZE; y += 1) {
    for (int x = 0; x < BLOCK_SIZE; x += 1) {
      int [] p = rgb2YCbCr(red(s.get(x, y)), green(s.get(x, y)), blue(s.get(x, y)));
      Y[x][y] = p[0];
      Cb[x][y] = p[1];
      Cr[x][y] = p[2];
    }
  }

  DoubleDCT_2D dct2D = new DoubleDCT_2D(BLOCK_SIZE, BLOCK_SIZE);
  dct2D.forward(Y, true);
  dct2D.forward(Cb, true);
  dct2D.forward(Cr, true);

  quantize(Y, currentLumaQuantization);
  quantize(Cb, currentChromaQuantization);
  quantize(Cr, currentChromaQuantization);
  
  deQuantize(Y, currentLumaQuantization);
  deQuantize(Cb, currentChromaQuantization);
  deQuantize(Cr, currentChromaQuantization);
  
  dct2D.inverse(Y, true);
  dct2D.inverse(Cb, true);
  dct2D.inverse(Cr, true);

  for (int y = 0; y < BLOCK_SIZE; y += 1) {
    for (int x = 0; x < BLOCK_SIZE; x += 1) {
      int [] c = ycbcr2RGB((float) Y[x][y], (float) Cb[x][y], (float) Cr[x][y]);
      s.set(x, y, color(c[0], c[1], c[2]));
    }
  }

}

