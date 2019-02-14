
void keyPressed() {

  switch (key) {
  case 'l' :
    getNewImage();
    break;

  case 'c':
    channel = (channel + 1) % 3;
    singleChannel = calculateSingleChannel(target, channel);
    break;

  case 's': 
    target.save("reconstructed.png");
    break;

  case 'h': 
    originalCount = "Source = " + countRGB(source);  
    reconstructedCount = "Reconstructed = " + countRGB(target);
    break;

  case 'b':
    target.filter(BLUR, 2);
    break;

  case CODED:
    setCurrentQuality();
    break;
  }
}

void getNewImage() {
  source = loadImage(sourceImageNames[currentImageIndex]);
  currentImageIndex = (currentImageIndex + 1) % sourceImageNames.length;
  target = source.copy();
  
  currentQuality = MAX_QUALITY;
  reconstructImage();
}

void reconstructImage() {
  currentLumaQuantization = scaledQuantizationMatrix(DQT_L, currentQuality);
  currentChromaQuantization = scaledQuantizationMatrix(DQT_C, currentQuality);


  target = dctImage(source);

  channel = 0;
  singleChannel = calculateSingleChannel(target, channel);

  originalCount = "Source = " + countRGB(source);  
  reconstructedCount = "Reconstructed = " + countRGB(target);
}

void setCurrentQuality() {
  int oldQuality = currentQuality;

  switch (keyCode) {
  case UP:
    currentQuality = min(currentQuality + 1, 100);
    break;
  case DOWN:
    currentQuality = max(currentQuality - 1, 1);
    break;
  }

  if (currentQuality != oldQuality) {
    currentLumaQuantization = scaledQuantizationMatrix(DQT_L, currentQuality);
    currentChromaQuantization = scaledQuantizationMatrix(DQT_C, currentQuality);
    reconstructImage();
  }
}
