// count the number of times each grey level occurs
// grey means R = G = B (so count any channel)

int [] greyScaleHistogram(PImage s) {
  int [] h = new int [256];

  s.loadPixels();

  for (int i = 0; i < s.pixels.length; i += 1) {
    int idx = (int) red(s.pixels[i]);
    h[idx] += 1;
  }

  return h;
}

// visualise the parts of the algorithm

void drawTheListOf(ArrayList<Box> b, int [] hist, int x, int y, int w, int h) {
  drawHistogram(hist, x, y, w, h);

  noFill();
  stroke(color(255, 0, 0));
  float barWidth = ((1.0 * w) / hist.length);
  
  for (Box p : b) {
    float boxWidth = barWidth * (p.maxValue - p.minValue + 1);
    rect(x + (p.minValue * barWidth), y, boxWidth, h);
  }
}

void drawHistogram(int [] hist, int x, int y, int w, int h) {
  int minValue = min(hist);
  int maxValue = max(hist);
  float barWidth = (1.0 * w) / hist.length;
  
  fill(0);
  rect(x, y, width - x, 10);
  fill(255);
  stroke(0);
  text("Number of levels " + currentLevels, x, y + 10);
  for (int i = 0; i < hist.length; i += 1) {
    float barHeight = map(hist[i], minValue, maxValue, 0, h);
    rect(x + i * barWidth, y + h - barHeight, barWidth, barHeight);
  }
}

void drawSpectrumOf(int [] l, int x, int y) {
  int w = (width - x) / l.length;
  
  for (int i = 0; i < l.length; i += 1) {
    noStroke();
    fill(l[i]);
    rect(x + i * w, y, w, height - y);
  }
}

void printAllBoxes(ArrayList<Box> boxes) {
  for (Box b: boxes) {
    b.describe();
  }
}
