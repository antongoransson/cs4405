import java.util.Arrays;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

String [] audioFilenames = { "440Hz_44100Hz_16bit_05sec.wav", "you_got_it_1.wav", "guess-what-1.wav", "alarm_clock_1.wav", "brass.wav" };
int currentFile = 0;

Minim       minim;
AudioSample audioTest;

final int FFT_SIZE = 1024;
FFT fft;

float[][] spectra;
float strongest;

int currentFrame = 0;
int previousTime = 0;
float frameDuration;

AudioOutput out;
Oscil [] oscillators;
Summer sum;

int numberOfContributions = 1;

void setup()
{
  size(2000, 1200);

  minim = new Minim(this);
  out = minim.getLineOut();

  loadAndAnalyseAudio(audioFilenames[currentFile]);
  playReconstructedAudio();
}

void draw()
{
  background(0);

  text(audioFilenames[currentFile], 10, 20);
  text("Number of Freqencies " + numberOfContributions, 10, 40);

  if (millis() - previousTime >= frameDuration) {
    synthesiseAudio(spectra, strongest, audioTest.sampleRate());
    previousTime = millis();
  }
}
