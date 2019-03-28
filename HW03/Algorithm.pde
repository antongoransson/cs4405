PImage forwardMCExhaustive(PImage codedReferenceY, PImage originalTargetY, String match) {
    PImage codedTargetY = createImage(originalTargetY.width, originalTargetY.height, RGB);
    for (int i = 0; i < originalTargetY.width; i += MACROBLOCK_SIZE) {
        for (int j = 0; j < originalTargetY.height ; j += MACROBLOCK_SIZE) {
            double min = Integer.MAX_VALUE;
            PImage bestMB = null;
            PImage mbTarget = originalTargetY.get(i, j, MACROBLOCK_SIZE, MACROBLOCK_SIZE);
            for (int x = i - DISPLACEMENT; x <= i + DISPLACEMENT; x += 1) {
                for (int y = j - DISPLACEMENT; y <= j + DISPLACEMENT; y += 1) {
                    PImage tempMB = codedReferenceY.get(x, y, MACROBLOCK_SIZE, MACROBLOCK_SIZE);
                    double diff = match == "SSD" ? SSD(tempMB, mbTarget) : SAD(tempMB, mbTarget);
                    if (bestMB == null || diff < min) {
                        bestMB = tempMB;
                        min = diff;
                    }
                }

            }
            codedTargetY.set(i, j, bestMB);
        }
    }
    return codedTargetY;
}

PImage forwardMCZeroMotion(PImage codedReferenceY, PImage originalTargetY) {
    PImage codedTargetY = createImage(originalTargetY.width, originalTargetY.height, RGB);
    for (int i = 0; i < originalTargetY.width; i += MACROBLOCK_SIZE) {
        for (int j = 0; j < originalTargetY.height; j += MACROBLOCK_SIZE) {
            PImage mb = codedReferenceY.get(i, j, MACROBLOCK_SIZE, MACROBLOCK_SIZE);
            codedTargetY.set(i, j, mb);
        }
    }
    return codedTargetY;
}


double SAD(PImage p1, PImage p2) {
    double s = 0;
    for (int i = 0; i < p1.width; i += 1) {
        for (int j = 0; j < p1.height; j += 1) {
            s += Math.abs(p1.get(i, j) - p2.get(i, j));
        }
    }
    return s;
}

double SSD(PImage p1, PImage p2) {
    double s = 0;
    for (int i = 0; i < p1.width; i += 1) {
        for (int j = 0; j < p1.height; j += 1) {
            s += Math.pow(p1.get(i, j) - p2.get(i, j), 2);
        }
    }
    return s;
}