
void keyPressed() 
{ 
  switch (key) {
  case 'l':
    currentFile = (currentFile + 1) % audioFilenames.length;
    loadSignal(audioFilenames[currentFile]);
    sourceHistogram = makeHistogram(signal, #AFF096);
    break;

  case 'p':
    predicted = new float[signal.length];
    error = new float[signal.length];
    differentialEncoding(signal, predicted, error);

    codedHistogram = makeHistogram(error, #FCD34A);
    
    reconstructed = new float[signal.length];
    reconstructFromDifferentialEncoding(reconstructed, predicted, error);
    playReconstructedData(reconstructed);
    break;

  case 'd':
    predicted = new float[signal.length];
    error = new float[signal.length];
    dpcmEncoding(signal, predicted, error);

    codedHistogram = makeHistogram(error, #FC834A);
    
    reconstructed = new float[signal.length];
    reconstructFromDPCMEncoding(reconstructed, predicted, error);
    playReconstructedData(reconstructed);
    break;

  case CODED:
    changeQuantisation();
    break;
  }
}

void changeQuantisation() {
  switch (keyCode) {
  case UP:
    quantisationScale += 1.0;
    break;

  case DOWN:
    if (quantisationScale > 1.0) {
      quantisationScale -= 1.0;
    }
    break;
  }
}

void loadSignal(String s) {
  quantisationScale = 1.0;

  sampleRate = minim.loadFileIntoBuffer( s, sampleBuffer );
  samplerOriginal = new Sampler( sampleBuffer, sampleRate, 1 );
  samplerOriginal.patch( output );
  samplerOriginal.trigger();

  // reference copy of the original signal
  signal = new float[sampleBuffer.getChannel(0).length];
  arrayCopy(sampleBuffer.getChannel(0), signal);
  signal = trimArray(signal, (signal.length / FRAME_SIZE) * FRAME_SIZE);

  // reset all the calculated signals
  predicted = null;
  error = null;
  reconstructed = null;
  
  // reset any images
  sourceHistogram = null;
  codedHistogram = null;
}
