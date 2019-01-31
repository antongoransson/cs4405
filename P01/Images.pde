// create an image that uses fewer levels
// replace pixel with closest representative level

PImage reducedImageToLevels(PImage s, int [] l) {
  PImage r = createImage(s.width, s.height, RGB);

  s.loadPixels();
  r.loadPixels();

  for (int idx = 0; idx < s.pixels.length; idx += 1) {
    r.pixels[idx] = closestLevel(s.pixels[idx], l);
  }

  r.updatePixels();

  return r;
}


// closest using square of the difference
// magnitude not direction (+/-) is important
color closestLevel(color c, int [] l) {
  float dist = 255 * 255;
  int ci = 0;

  for (int i = 0; i < l.length; i += 1) {
    float d = (l[i] - red(c)) * (l[i] - red(c));
    if (d < dist) {
      dist = d;
      ci = i;
    }
  }
  
  return color(l[ci], l[ci], l[ci]);
}
