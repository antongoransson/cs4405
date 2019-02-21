void keyPressed() {
  switch (key) {
  case 'l':
    currentFile = (currentFile + 1) % audioFilenames.length;
    loadAndAnalyseAudio(audioFilenames[currentFile]);
    playReconstructedAudio();
    break;
  case CODED:
    setNumberOfContributions();
    break;
  }
}

void setNumberOfContributions() {
  switch (keyCode) {
  case UP:
    numberOfContributions += 1;
    break;
  case DOWN:
    numberOfContributions = max(1, numberOfContributions - 1);
    break;
  }

  playReconstructedAudio();
}

void loadAndAnalyseAudio(String filename) {
  audioTest = minim.loadSample(filename);

  spectra = analyzeUsingAudioSample(audioTest);
  strongest = strongestAcrossAllSpectra(spectra);
  
  frameDuration = FFT_SIZE / audioTest.sampleRate() * 1000;
  currentFrame = 0;
  previousTime = 0;
}

void playReconstructedAudio() {
  unpatchOutput(oscillators, sum);

  oscillators = setupOscillators(numberOfContributions);
  sum = patchOutput(oscillators);
  sum.patch(out);
}
