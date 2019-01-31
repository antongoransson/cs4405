ArrayList<Box> medianCut(int [] h, int n) {
    ArrayList<Box> p = initialBox(h);

    while (n > 1) {
        n -= 1;
        int idxBiggestBox = biggestBoxIn(p);
        splitBoxesAt(idxBiggestBox, p, h);
    }

    return p;
}

// biggest mean greatest number of pixels
int biggestBoxIn(ArrayList<Box> p) {
    int idx = 0;
    int biggestMeasure = 0;

    for (int i = 0; i < p.size(); i++) {
        Box b = p.get(i);
        if (b.count > biggestMeasure && b.unique > 1) {
        idx = i;
        biggestMeasure = b.count;
        }
    }
    return idx;
}


void splitBoxesAt(int idx, ArrayList<Box> p, int [] h) {
    Box b = p.get(idx);
    int s = b.minValue;
    int e = b.maxValue;
    int total = b.count;

    int i = s;
    int c = 0;
    // Find middle of the box
    while ((c < total / 2) && i < e) {
        c += h[i];
        i += 1;
    }
    // Lower box
    Box b1 = new Box(s, i - 1, h);
    // Upper box
    Box b2 = new Box(i, e, h);
    p.remove(idx);
    p.add(b1);
    p.add(b2);
}

int [] representativeLevelForEach(ArrayList<Box> b, int [] h) {
    int [] levels = new int [b.size()];
    int idx = 0;
    for(Box p: b) {
        levels[idx] = int (weightedSum(p, h) / p.count);
        idx += 1;
    }

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
