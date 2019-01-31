int currentLevels = 0;

String [] testImageNames = { "gradient.png", "mountain-01.jpg", "lena.png", "snow.png", "gif.png" };
int currentImageIndex = 0;

PImage currentImage, reducedImage;
int [] histogram;
int [] representativeLevels = null;

ArrayList<Box> boxes;

void setup() {
  size(1280, 612);

  getNewImage();
  reducedImage = makeReducedLevelImage();
}

void draw() {
  background(127);

  image(currentImage, 0, 0);
  image(reducedImage, 0, currentImage.height);
  drawTheListOf(boxes, histogram, currentImage.width + 10, 0, width - 20 - currentImage.width, currentImage.height * 2);
  drawSpectrumOf(representativeLevels, currentImage.width + 10, currentImage.height * 2);
}
