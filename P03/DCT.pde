final int BLOCK_SIZE = 8;

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


void dctBlock(PImage s) {

}
