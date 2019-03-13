PImage originalReferenceY;
PImage codedReferenceY;
PImage originalTargetY;
PImage codedTargetY;    // (more correctly) the motion compensated coded reference

final int MACROBLOCK_SIZE = 16;

TimeIt timer = new TimeIt();

void setup() {
  size(1280, 750);

  timer.start();
  originalReferenceY = toY(loadImage("Original-00.png"));
  timer.stop();
  
  println("load + convert took " + timer.duration() + "ms");
  
  codedReferenceY = toY(loadImage("MPEG-00.png"));

  originalTargetY = toY(loadImage("Original-03.png"));
  
  // MPEG-03.png is for completeness only
  // it is coded as a P-picture using the codedReference (an MPEG-1 I-picture) as its reference
  // it is the result of motion compensation on the coded reference, followed by 
  // coding of the (possibly) difference macroblocks
  // it should be a better representation than your result (why?)
  
  codedTargetY = createImage(originalTargetY.width, originalTargetY.height, RGB);
  // needs to be replaced by something like
  // codedTargetY = forwardMC(codedReferenceY, originalTargetY);
}

void draw() {
  background(0);

  //left-hand side of display show the reference
  // right-hand side shows the target
  // top of the display is the source content (only available to the encoder)
  // bottom of the display is the coded content (available to encoder & decoder)
  
  image(originalReferenceY, 0, 0);
  image(codedReferenceY, 0, originalReferenceY.height);

  image(originalTargetY, originalReferenceY.width, 0);
  image(codedTargetY, originalReferenceY.width, originalReferenceY.height);

  showLabels();
  showPSNR();
}

void showLabels() {
  text("Source Reference", 10, 20);
  text("Coded Reference", 10, originalReferenceY.height + 20);

  text("Source Target", originalReferenceY.width + 10, 20);
  text("Coded Target", originalReferenceY.width + 10, originalReferenceY.height + 20);
}

void showPSNR() {
  double psnrOriginalCodedReference = yPSNR(originalReferenceY, codedReferenceY);
  double psnrCodedReferenceTarget = yPSNR(codedReferenceY, originalTargetY);
  double psnrMCReferenceTarget = yPSNR(codedTargetY, originalTargetY);
  
  text("PSNR (src ref, coded ref) " + psnrOriginalCodedReference, 10, height - 10);
  text("PSNR (coded ref, src target) " + psnrCodedReferenceTarget, 300, height - 10);
  text("PSNR (mc ref, src target) " + psnrMCReferenceTarget, 700, height - 10);
}
