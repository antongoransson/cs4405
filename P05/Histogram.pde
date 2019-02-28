void showDistribution(float [] s) {
  Map<Float, Integer> count = distributionOfValues(s);
  int topCount = 0;

  for (Integer v : count.values()) {
    if (v > topCount) {
      topCount = v;
    }
  }

  rectMode(CORNERS);
  fill(color(0, 255, 0));
  noStroke();
  for (Float k : count.keySet()) {
    float x = map(k, -1, 1, 0, width);
    if (k == 0) {
      text("0.0", x, height - 80);
    }
    int c = count.get(k);
    float y = map(c, 0, topCount, 0, height - 200);
    rect(x, height - 100 - y, x + 3, height - 100);
  }
  fill(255);
}

Float keyWithMaximumValue(Map<Float, Integer> h) {
  Map.Entry<Float, Integer> maxEntry = null;
  
  for (Map.Entry<Float, Integer> entry : h.entrySet()) {
    if (maxEntry == null || entry.getValue().compareTo(maxEntry.getValue()) > 0) {
      maxEntry = entry;
    }
  }
  
  return maxEntry.getKey();
}


PImage makeHistogram(float [] s, color clr) {
  PGraphics canvas = createGraphics(450, 400);
  
  Map<Float, Integer> count = distributionOfValues(s);
  int topCount = 0;

  for (Integer v : count.values()) {
    if (v > topCount) {
      topCount = v;
    }
  }
  
  canvas.beginDraw();
  canvas.background(125);
  canvas.rectMode(CORNERS);
  canvas.fill(clr);
  
  float modalValue = keyWithMaximumValue(count);
  canvas.text(nf(modalValue, 1, 7), 50, 50);
  
  for (Float k : count.keySet()) {
    float x = map(k, -1, 1, 0, canvas.width);
    if (k == 0) {
      canvas.text("0.0", x, canvas.height - 20);
      canvas.stroke(255);
      canvas.line(x, 0, x, canvas.height - 30);
      canvas.line(0, canvas.height - 50, canvas.width, canvas.height -50);
    }
    canvas.noStroke();
    int c = count.get(k);
    float y = map(c, 0, topCount, 0, canvas.height - 100);
    canvas.rect(x, canvas.height - 50 - y, x + 3, canvas.height - 50);
  }
  canvas.endDraw();
  
  return canvas;
}
