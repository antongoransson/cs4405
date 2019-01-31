ArrayList<Box> medianCut(int [] h, int n) {
  ArrayList<Box> p = initialBox(h);

  while (n > 1) {
    n -= 1;
    int idxBiggestBox = biggestBoxIn(p);
    splitBoxesAt(idxBiggestBox, p, h);
  }

  return p;
}

int biggestBoxIn(ArrayList<Box> p) {
  int idx = 0;
  int biggestMeasure = 0;

  return idx;
}


void splitBoxesAt(int idx, ArrayList<Box> p, int [] h) {

}

int [] representativeLevelForEach(ArrayList<Box> b, int [] h) {
  int [] levels = new int [b.size()];
  int idx = 0;


  return levels;
}

float weightedSum(Box p, int [] h) {
  float total = 0;

  for (int i = p.minValue; i <= p.maxValue; i += 1) {
    total += (i * h[i]);
  }

  return total;
}


// smallest box containing all the grey levels in the image

ArrayList<Box> initialBox(int [] h) {
  ArrayList<Box> p = new ArrayList<Box>();
  int s = 0, e = h.length - 1;

  while (h[s] == 0) {
    s += 1;
  }
  while (h[e] == 0) {
    e -= 1;
  }

  p.add(new Box(s, e, h));

  return p;
}
