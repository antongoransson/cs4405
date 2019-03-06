import java.util.Map;
import java.util.HashSet;

import ddf.minim.*;
import ddf.minim.ugens.*;

String [] audioFilenames = { "organ.wav", "hrp-extract.wav", "piano.wav", "test-speech-female.wav", "test-speech-male.wav", "sweep.wav", "tone.wav", "you_got_it_1.wav" };
int currentFile = 0;

// Number of samples per frame
final int FRAME_SIZE = 1024;
final float [] PREDICTOR_COEFFICIENTS = { 0.8, 0.64, -0.45 };
// Current one = previous one
final float [] PREDICTOR_COEFFICIENTS = { 1 };
final int DIFFERENTIAL_ENCODING_SIZE = PREDICTOR_COEFFICIENTS.length;

float [] signal;
float [] predicted;
float [] error;

float quantisationScale = 1.0;
float [] reconstructed;

PImage sourceHistogram, codedHistogram;

Minim              minim;
MultiChannelBuffer sampleBuffer, rsampleBuffer;
AudioOutput        output;
Sampler            samplerOriginal, samplerReconstructed;
float              sampleRate;


void setup() {
  size(2048, 1040);
  textSize(30);
  minim  = new Minim(this);
  output = minim.getLineOut();
  sampleBuffer = new MultiChannelBuffer( 1, 1 );
  loadSignal(audioFilenames[currentFile]);
  sourceHistogram = makeHistogram(signal, #AFF096);
}


void draw() {
  background(0);
  drawSample(output);
  showDetails();
  showHistograms();
}


// play reconstructed audio signal

void playReconstructedData(float [] data) {
  rsampleBuffer = new MultiChannelBuffer(data.length, 1);
  rsampleBuffer.setChannel(0, data);
  samplerReconstructed = new Sampler( rsampleBuffer, sampleRate, 1 );
  samplerReconstructed.patch( output );
  samplerReconstructed.trigger();
}

// drawing

void drawSample(AudioOutput o)
{
  stroke(255);
  text(audioFilenames[currentFile], 12, 20);
  
  for (int i = 0; i < o.bufferSize() - 1; i += 1) {
    float x1 = map(i, 0, o.bufferSize(), 0, width);
    float x2 = map(i+1, 0, o.bufferSize(), 0, width);
    line(x1, 75 - o.left.get(i)*100, x2, 75 - o.left.get(i+1)*100); // only draw left channel (mono audio data is by convention in the left channel)
  }
}


void showDetails() {
  text("Q = " + quantisationScale, 20, height - 120);
  if (signal != null) {
    text("Samples (trimmed) = " + signal.length, 20, height - 60);
    text("# zero differences " + countZeroIn(signal) + " (" + nf(100.0 * countZeroIn(signal) / signal.length, 2, 1) + "%)", width * 1 / 4, height - 60);
    text("# unique " + countUniqueIn(signal) + " out of " + signal.length + " (" + nf(100.0 * countUniqueIn(signal) / signal.length, 2, 1) + "%)", width * 1 / 4, height - 30);

  }

  if ((signal != null) && (reconstructed != null)) {
    text("PSNR " + nf(PSNR(signal, reconstructed), 2, 1) + " dB", width * 4 / 7, height - 60);
  }

  if (error != null) {
    text("# zero differences " + countZeroIn(error) + " (" + nf(100.0 * countZeroIn(error) / error.length, 2, 1) + "%)", width * 3 / 4 - 80, height - 60);
    text("# unique " + countUniqueIn(error) + " out of " + error.length + " (" + nf(100.0 * countUniqueIn(error) / error.length, 2, 1) + "%)", width *3 / 4 - 80, height - 30);
  }
}

void showHistograms() {
  if (sourceHistogram != null) {
    image(sourceHistogram, 50, 200);
    // sourceHistogram.resize(200, 400);
  }
  
  if (codedHistogram != null) {
    image(codedHistogram, 50 + sourceHistogram.width + 20, 200);
  }
}
