import org.jtransforms.dct.DoubleDCT_2D; //<>//

final String [] channelName = { "Y", "Cb", "Cr" };
String [] sourceImageNames = { "spectrum.png", "flower-close.png", "farmhouse.png", "finetexture.png" };
int currentImageIndex = 0;

final int MAX_QUALITY = 100;

int currentQuality = MAX_QUALITY;

int [][] currentLumaQuantization;
int [][] currentChromaQuantization;

int dctCoefficientZeroBeforeQuantization = 0;
int dctCoefficientZeroAfterQuantization = 0;

PImage source = null, target = null, singleChannel = null;
int channel = 0;


String originalCount, reconstructedCount;

void setup() {
  size(1535, 540);
 
  getNewImage();
}

void draw() {
  background(0);

  image(source, 0, 0);
  image(target, source.width, 0);
  if (singleChannel != null) {
    image(singleChannel, source.width * 2, 0);
  }

  fill(255);
  text(originalCount, 10, source.height + 20);
  text(reconstructedCount, source.width / 4 + 10, source.height + 20);

  text(countQuantizedDCTCoefficients(), source.width / 1.5, source.height + 20);

  text("Q = " + currentQuality, source.width * 1.5, source.height + 20);
  text("PSNR = " + brightnessPSNR(source, target), source.width * 2, source.height + 20);
  text(channelName[channel], source.width * 2.5, source.height + 20);
}
