float [] data;
float sampleRate;

void setup() {
  size(1280, 720);
  
  data = loadAudio("96kHz.wav");
  
  float x = minimisesMSEOf(data);

  println("value that minimises MSE is " + x);
  println("Reported sample rate " + sampleRate);
}
