int currentLevelsY = 16;
int currentLevelsCb = 16;
int currentLevelsCr = 16;

String [] testImageNames = { "baboon.png", "farmhouse.png", "flowers.png", "gif.png", "lena_flipped.png" };
int currentImageIndex = 0;

PImage currentImage, reconstructedImage;
PImage yImage, cbImage, crImage;

double imageDifference;

void setup() {
  size(2560, 612);


  getNewImage();
}

void draw() {
  background(0);

  image(currentImage, 0, 0);
  image(yImage, 512 * 1, 0);
  image(cbImage, 512 * 2, 0);
  image(crImage, 512 * 3, 0);
  image(reconstructedImage, 512 * 4, 0);

  showLabels();
}

void showLabels() {
  textAlign(CENTER);
  fill(255);

  text("Original", 512 * 0.5, currentImage.height + 20);
  text("Y", 512 * 1.5, currentImage.height + 20);
  text("Levels " + currentLevelsY, 512 * 1.5, currentImage.height + 40);
  
  text("Cb", 512 * 2.5, currentImage.height + 20);
  text("Levels " + currentLevelsCb, 512 * 2.5, currentImage.height + 40);
  
  text("Cr", 512 * 3.5, currentImage.height + 20);
  text("Levels " + currentLevelsCr, 512 * 3.5, currentImage.height + 40);
  text("Reconstructed", 512 * 4.5, currentImage.height + 20);
  text("PSNR (Original/Reconstructed) " + imageDifference, 512 * 4.5, currentImage.height + 50);
}
