float [][] analyzeUsingAudioSample(AudioSample audioSample)
{   
  float[] leftChannel = audioSample.getChannel(AudioSample.LEFT);

  float[] fftSamples = new float[FFT_SIZE];
  FFT fft = new FFT( FFT_SIZE, audioSample.sampleRate() );

  int totalChunks = (leftChannel.length / FFT_SIZE) + 1;

  float [][] spectra = new float[totalChunks][FFT_SIZE/2];

  for (int chunkIdx = 0; chunkIdx < totalChunks; chunkIdx += 1) {
    int chunkStartIndex = chunkIdx * FFT_SIZE;

    int chunkSize = min( leftChannel.length - chunkStartIndex, FFT_SIZE );

    arrayCopy( leftChannel, chunkStartIndex, fftSamples, 0, chunkSize);

    if ( chunkSize < FFT_SIZE ) {
      Arrays.fill( fftSamples, chunkSize, fftSamples.length - 1, 0.0 );
    }

    fft.forward( fftSamples );

    for (int i = 0; i < FFT_SIZE / 2; i += 1) {
      spectra[chunkIdx][i] = fft.getBand(i);
    }
  }

  audioSample.close();
  
  return spectra;
}