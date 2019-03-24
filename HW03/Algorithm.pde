PImage forwardMC(PImage codedReferenceY, PImage originalTargetY) {
    PImage bestMB = null;
    PImage codedTargetY = new PImage(originalTargetY.height, originalTargetY.width);
    int min = Integer.MAX_VALUE;
    for (int i = 0; i < codedReferenceY.height; i += MACROBLOCK_SIZE) {
        for (int j = 0; j < codedReferenceY.width; j += 1) {
            PImage mcOrg = originalTargetY.get(i, j, MACROBLOCK_SIZE, MACROBLOCK_SIZE);
            for (int k = Math.max(i - DISPLACEMENT, 0); k < Math.min(i + DISPLACEMENT, codedReferenceY.width); k += 1) {
                for (int n = Math.max(j - DISPLACEMENT, 0); n < Math.min(j + DISPLACEMENT, codedReferenceY.width); n += 1) {
                    PImage tempMB = codedReferenceY.get(k, n, MACROBLOCK_SIZE, MACROBLOCK_SIZE);
                    if (bestMB == null || SSD(tempMB, bestMB) < min) {
                        bestMB = tempMB;
                    }
                }

            }
        codedTargetY.set(i, j, bestMB);
        }
    }
    return codedTargetY;
}


double SAD(PImage p1, PImage p2) {
    double s = 0;
    for (int i = 0; i < p1.height; i += 1) {
        for (int j = 0; j < p1.width; j += 1) {
            s += Math.abs(p1.get(i, j) - p2.get(i, j));
        }
    }
    return s;
}

double SSD(PImage p1, PImage p2) {
  double s = 0;
    for (int i = 0; i < p1.height; i += 1) {
        for (int j = 0; j < p1.width; j += 1) {
            s += Math.pow(p1.get(i, j) - p2.get(i, j), 2);
        }
    }
    return s;
}