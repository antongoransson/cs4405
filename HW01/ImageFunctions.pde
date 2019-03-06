PImage extractAsImageFromComponent(PImage s, int c) {
  s.loadPixels();
  PImage t = s.copy();

  t.loadPixels();
  for (int i = 0; i < s.pixels.length; i += 1) {
    int [] p = rgb2YCbCr(red(s.pixels[i]), green(s.pixels[i]), blue(s.pixels[i]));
    t.pixels[i] = color(p[c], p[c], p[c] ); 
  }
  t.updatePixels();
  return t;
}

// assume all images are the same size!

PImage createRGBImageFrom(PImage y, PImage cb, PImage cr) {
  PImage rgb = createImage(y.width, y.height, RGB);
  
  y.loadPixels();
  cb.loadPixels();
  cr.loadPixels();
  rgb.loadPixels();

  for (int i = 0; i < y.pixels.length; i += 1) {
    int [] c = ycbcr2RGB(red(y.pixels[i]), red(cb.pixels[i]), red(cr.pixels[i]));

    rgb.pixels[i] = color(c[0], c[1], c[2]);
  }
  
  rgb.updatePixels();
  
  return rgb;
}

PImage makeReducedLevelImage(PImage image, int currentLevels) {
  int [] histogram = greyScaleHistogram(image);
  ArrayList<Box> boxes = medianCut(histogram, currentLevels);

  int []  representativeLevels = representativeLevelForEach(boxes, histogram);

  return reducedImageToLevels(image, representativeLevels);
}
