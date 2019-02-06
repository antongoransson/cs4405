static final int COLOUR_CHANNELS = 3;

void chromaSubSampleImage(PImage s) {

}

void subSampleBlock(PImage s) {
  s.loadPixels();

  int [] c0 = new int [COLOUR_CHANNELS];
  int [] c1 = new int [COLOUR_CHANNELS];

  for (int i = 0; i < s.pixels.length; i += 1) {
 
  }

  s.updatePixels();
}
