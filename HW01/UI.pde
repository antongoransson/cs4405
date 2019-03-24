void keyPressed() {
  switch (key) {
  case 'l':
    getNewImage2();
    break;
  case 'k':
    getNewImage1();
    break;
  case 'r':
    getImage2();
    break;
  case 't':
    getImage1();
    break;
  }
}

void getNewImage1() {
  currentImageIndex = (currentImageIndex + 1) % testImageNames.length;
  currentImage = loadImage(testImageNames[currentImageIndex]);
  
  yImage = extractAsImageFromComponent(currentImage, 0);
  cbImage = extractAsImageFromComponent(currentImage, 1);
  crImage = extractAsImageFromComponent(currentImage, 2);
  
  currentLevelsY = defaultLevel;
  currentLevelsCb = defaultLevel;
  currentLevelsCr = defaultLevel;
  
  getImageMedianCut1();
}

void getNewImage2() {
  currentImageIndex = (currentImageIndex + 1) % testImageNames.length;
  currentImage = loadImage(testImageNames[currentImageIndex]);
  
  yImage = extractAsImageFromComponent(currentImage, 0);
  cbImage = extractAsImageFromComponent(currentImage, 1);
  crImage = extractAsImageFromComponent(currentImage, 2);
  
  currentLevelsY = defaultLevel;
  currentLevelsCb = defaultLevel;
  currentLevelsCr = defaultLevel;
  
  getImageMedianCut2();
}

void getImage2() {
  
  currentLevelsY = defaultLevel;
  currentLevelsCb = defaultLevel;
  currentLevelsCr = defaultLevel;
  getImageMedianCut2();
}

void getImage1() {
  currentLevelsY = defaultLevel;
  currentLevelsCb = defaultLevel;
  currentLevelsCr = defaultLevel;
  getImageMedianCut1();
}

void getImageMedianCut1() {
  yImage.loadPixels();
  cbImage.loadPixels();
  crImage.loadPixels();

  currentLevelsY -= 1;
  currentLevelsCb -= 1;
  currentLevelsCr -= 1;

  yRR = makeReducedLevelImage(yImage, currentLevelsY- 1);
  cbRR = makeReducedLevelImage(cbImage, currentLevelsCb -1);
  crRR = makeReducedLevelImage(crImage, currentLevelsCr- 1);
  
  reconstructedImage = createRGBImageFrom(yRR, cbRR, crRR);
  imageDifference = ycbcrPSNR(currentImage, reconstructedImage);
  
  if(imageDifference > LIMIT) {
    getImageMedianCut1();
  }
}

void getImageMedianCut2() {
  yImage.loadPixels();
  cbImage.loadPixels();
  crImage.loadPixels();
  yR = makeReducedLevelImage(yImage, currentLevelsY);
  yRR = makeReducedLevelImage(yImage, currentLevelsY- 1);
  
  cbR = makeReducedLevelImage(cbImage, currentLevelsCb);
  cbRR = makeReducedLevelImage(cbImage, currentLevelsCb -1);
  
  crR = makeReducedLevelImage(crImage, currentLevelsCr);
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
    getImageMedianCut2();
  }
}
