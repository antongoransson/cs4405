static final int COLOUR_CHANNELS = 3;

void chromaSubSampleImage(PImage s) {
    for (int y = 0; y < s.height; y += 2) {
        for (int x = 0; x < s.width; x += 4) {
            PImage blk = s.get(x, y, 4, 2);
            subSampleBlock(blk);
            s.set(x, y, blk);
        }
    }
}

void subSampleBlock(PImage s) {
    s.loadPixels();

    int [] c0 = new int [COLOUR_CHANNELS];
    int [] c1 = new int [COLOUR_CHANNELS];
    int [] luma = new int[s.pixels.length];
    // Image: 4x2 = 8 pixels
    for (int i = 0; i < s.pixels.length; i += 1) {
        int [] p = rgb2YCbCr(red(s.pixels[i]), green(s.pixels[i]), blue(s.pixels[i]));
        luma[i] = p[0];
        // Combine the 4 pixels in the left to one value and the 4 values on the right to one
        if (i % 4 < 2) {
            c0[1] += p[1];
            c0[2] += p[2];
        } else {
            c1[1] += p[1];
            c1[2] += p[2];
        }
    }

    for (int i = 1; i < COLOUR_CHANNELS; i += 1) {
        c0[i] /= 4;
        c1[i] /= 4;
    }

    for (int i = 0; i < s.pixels.length; i +=1 ) {
        int [] p = rgb2YCbCr(red(s.pixels[i]), green(s.pixels[i]), blue(s.pixels[i]));
        float cb;
        float cr;
        if (i % 4 < 2) {
            cb = c0[1];
            cr = c0[2];
        } else {
            cb = c1[1];
            cr = c1[2];
        }
        int [] c = ycbcr2RGB(luma[i], cb, cr);
        s.pixels[i] = color(c[0], c[1], c[2]);
    }
    s.updatePixels();
}
