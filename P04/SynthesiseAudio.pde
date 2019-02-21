Oscil [] setupOscillators(int n) {
  Oscil [] o = new Oscil[n];

  for (int i = 0; i < n; i += 1) {
    o[i] = new Oscil(0, 1, Waves.SINE);
  }
  return o;
}

Summer patchOutput(Oscil [] o) {
  Summer s = new Summer();
  for (int i = 0; i < o.length; i += 1) {
    o[i].patch(s);
  }

  return s;
}

void unpatchOutput(Oscil [] o, Summer s) {
  if (s != null) {
    for (int i = 0; i < o.length; i += 1) {
      o[i].unpatch(s);
    }
  }
}

void synthesiseAudio(float [][] spectra, float strongest, float sampleRate) {
  synthesiseFrame(spectra[currentFrame], strongest, sampleRate);
  currentFrame = (currentFrame + 1) % spectra.length;
}

void synthesiseFrame(float [] s, float strongest, float sR) {
  // Take out the top frequencies
  float [] strengths = strongestNBins(s, numberOfContributions);
  float [] frequencies = frequenciesOfStrongestBins(indicesOfStrongestBins(s, strengths), sR, FFT_SIZE);

  for (int i = 0; i < frequencies.length; i += 1) {
    oscillators[i].setFrequency(frequencies[i]);
    oscillators[i].setAmplitude(strengths[i] / strongest);

  }
}
