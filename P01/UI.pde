void keyPressed() {
  switch (key) {
  case 'l':
    getNewImage();
    reducedImage = makeReducedLevelImage();
    break;

  case 's':
    addLevel();
    reducedImage = makeReducedLevelImage();
    break;

  case 'f':
    if (reducedImage != null) {
      reducedImage.save("image-" + nf(currentLevels,3) + ".png");
    }
    break;

  case 'd':
    printAllBoxes(boxes);
    break;
  }
}

void getNewImage() {
  currentImageIndex = (currentImageIndex + 1) % testImageNames.length;
  currentImage = loadImage(testImageNames[currentImageIndex]);
  currentLevels = 1;

  histogram = greyScaleHistogram(currentImage);
}

PImage makeReducedLevelImage() {
  boxes = medianCut(histogram, currentLevels);

  representativeLevels = representativeLevelForEach(boxes, histogram);

  return reducedImageToLevels(currentImage, representativeLevels);
}

void addLevel() {
  currentLevels += 1;
}
