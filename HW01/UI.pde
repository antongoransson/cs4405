void keyPressed() {
  switch (key) {
  case 'l':
    getNewImage();
    break;
  }
}

void getNewImage() {
  currentImageIndex = (currentImageIndex + 1) % testImageNames.length;
  currentImage = loadImage(testImageNames[currentImageIndex]);
  
  yImage = extractAsImageFromComponent(currentImage, 0);
  cbImage = extractAsImageFromComponent(currentImage, 1);
  crImage = extractAsImageFromComponent(currentImage, 2);
  
  reconstructedImage = createRGBImageFrom(yImage, cbImage, crImage);
  
  imageDifference = ycbcrPSNR(currentImage, reconstructedImage);
}
