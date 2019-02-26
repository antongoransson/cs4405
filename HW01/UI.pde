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
  }
}

void getNewImage() {
  currentImageIndex = (currentImageIndex + 1) % testImageNames.length;
  currentImage = loadImage(testImageNames[currentImageIndex]);
  
  yImage = extractAsImageFromComponent(currentImage, 0);
  cbImage = extractAsImageFromComponent(currentImage, 1);
  crImage = extractAsImageFromComponent(currentImage, 2);
  // int [] 
  reconstructedImage = createRGBImageFrom(yImage, cbImage, crImage);
  
  imageDifference = ycbcrPSNR(currentImage, reconstructedImage);
}

void getImage() {
  currentImage = loadImage(testImageNames[currentImageIndex]);
  
  yImage = extractAsImageFromComponent(currentImage, 0);
  cbImage = extractAsImageFromComponent(currentImage, 1);
  crImage = extractAsImageFromComponent(currentImage, 2);
  
  reconstructedImage = createRGBImageFrom(yImage, cbImage, crImage);
  
  imageDifference = ycbcrPSNR(currentImage, reconstructedImage);
}
