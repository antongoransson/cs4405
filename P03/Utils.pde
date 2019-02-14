int [][] copy2DArray(int [][] m) {

  int [][] r = new int[m.length][];

  for (int i = 0; i < m.length; i += 1) {
    r[i] = new int[m[i].length];
    arrayCopy(m[i], 0, r[i], 0, m[i].length);
  }

  return r;
}


PImage calculateSingleChannel(PImage s, int c) {
  PImage t = createImage(s.width, s.height, RGB);

  s.loadPixels();
  t.loadPixels();

  for (int i = 0; i < s.pixels.length; i += 1) {
    int [] p = rgb2YCbCr(red(s.pixels[i]), green(s.pixels[i]), blue(s.pixels[i]));
    t.pixels[i] = color(p[c], p[c], p[c]);
  }
  t.updatePixels();

  return t;
}


void printTable(int [][] t) {
  println("-----------------------------------");
  for (int i = 0; i < t.length; i += 1) {
    for (int j = 0; j < t[i].length; j += 1) {
      print(t[i][j] + ", ");
    }
    println();
  }
  println("-----------------------------------");
}
