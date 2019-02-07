void keyPressed() {

    switch (key) {
    case 'l':
        getNewImage();
        break;
    // Y channel, cb channel, cr channel
    case 'c':
        channel = (channel + 1) % 3;
        calculateSingleChannel(target, singleChannel, channel);
        break;

    case 's': 
        target.save("subsampled.png");
        break;

    case 'h': 
        println("Image Source contains " + countRGB(source) + " RGB colours");
        println("Image Target contains " + countRGB(target) + " RGB colours");
        break;

    case 'q':
        QUANTIZATION *= 2;
        break;

    case 'r':
        QUANTIZATION = 1.0;
        break;
    }
}


void getNewImage() {
  source = loadImage(sourceImageNames[currentImageIndex]);
  currentImageIndex = (currentImageIndex + 1) % sourceImageNames.length;

  target = source.copy();
  chromaSubSampleImage(target);
  
  singleChannel = createImage(source.width, source.height, RGB);
  channel = 0;
  calculateSingleChannel(target, singleChannel, channel);
}


void calculateSingleChannel(PImage s, PImage t, int c) {
    s.loadPixels();
    t.loadPixels();

    float scale = 1.0;
    if (c > 0) {
        scale = QUANTIZATION;
    }

    for (int i = 0; i < s.pixels.length; i += 1) {
        int [] p = rgb2YCbCr(red(s.pixels[i]), green(s.pixels[i]), blue(s.pixels[i]));
        t.pixels[i] = color(p[c] * scale, p[c] * scale, p[c] * scale); // Luminance channel
    }
    t.updatePixels();
}
