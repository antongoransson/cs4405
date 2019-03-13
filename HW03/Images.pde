// create Y component version of the picture
PImage toY(PImage s) {
  PImage r = createImage(s.width, s.height, RGB);

  s.loadPixels();
  r.loadPixels();

  for (int i = 0; i < s.pixels.length; i += 1) {
    int [] c = rgb2YCbCr(red(s.pixels[i]), green(s.pixels[i]), blue(s.pixels[i]));
    r.pixels[i] = color(c[0], c[0], c[0]);
  }

  r.updatePixels();

  return r;
}
