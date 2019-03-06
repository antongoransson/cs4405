void keyPressed() {
  switch (key) {
  case 'l':
    getNewImage();
    break;
  case 'a':
    currentLevelsY -= 1;
    getImage();
    break;
  case 's':
    currentLevelsCb -= 1;
    getImage();
    break;
  case 'd':
    currentLevelsCr -= 1;
    getImage();
    break;
  case 'c':
    getImageMedianCut();
    break;
  }
}

void getNewImage() {
  currentImageIndex = (currentImageIndex + 1) % testImageNames.length;
  currentImage = loadImage(testImageNames[currentImageIndex]);
  
  yImage = extractAsImageFromComponent(currentImage, 0);
  cbImage = extractAsImageFromComponent(currentImage, 1);
  crImage = extractAsImageFromComponent(currentImage, 2);
  
  currentLevelsY = defaultLevel;
  currentLevelsCb = defaultLevel;
  currentLevelsCr = defaultLevel;
  
  getImageMedianCut();
}

void getImage() {
  currentImage = loadImage(testImageNames[currentImageIndex]);
  
  reconstructedImage = createRGBImageFrom(yImage, cbImage, crImage);
  imageDifference = ycbcrPSNR(currentImage, reconstructedImage);
}

void getImageMedianCut() {
  currentImage = loadImage(testImageNames[currentImageIndex]);
  yImage.loadPixels();
  cbImage.loadPixels();
  crImage.loadPixels();
  yR = makeReducedLevelImage(yImage, currentLevelsY);
  cbR = makeReducedLevelImage(cbImage, currentLevelsCb);
  crR = makeReducedLevelImage(crImage, currentLevelsCr);
  
  yRR = makeReducedLevelImage(yImage, currentLevelsY- 1);
  cbRR = makeReducedLevelImage(cbImage, currentLevelsCb -1);
  crRR = makeReducedLevelImage(crImage, currentLevelsCr- 1);
  
  PImage reconstructedImage1 = createRGBImageFrom(yRR, cbR, crR);
  double imageDifference1 = ycbcrPSNR(currentImage, reconstructedImage1);
  
  PImage reconstructedImage2 = createRGBImageFrom(yR, cbRR, crR);
  double imageDifference2 = ycbcrPSNR(currentImage, reconstructedImage2);
  
  PImage reconstructedImage3 = createRGBImageFrom(yR, cbR, crRR);
  double imageDifference3 = ycbcrPSNR(currentImage, reconstructedImage3);
  
  imageDifference = Math.max(Math.max(imageDifference1, imageDifference2), imageDifference3);
  if (imageDifference == imageDifference1) {
    reconstructedImage = reconstructedImage1;
    currentLevelsY -= 1;
  } else if (imageDifference == imageDifference2) {
    reconstructedImage = reconstructedImage2;
    currentLevelsCb -= 1;
  } else if (imageDifference == imageDifference3) {
    currentLevelsCr -= 1;
    reconstructedImage = reconstructedImage3;

  }
  if(imageDifference > LIMIT) {
    getImageMedianCut();
  }
}
