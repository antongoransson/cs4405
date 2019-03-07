float [] data, reconstructed, predicted, error;
float sampleRate;
// Number of samples per frame
final int FRAME_SIZE = 1024;
final float [] PREDICTOR_COEFFICIENTS = { 0.8, 0.64, -0.45 };
// Current one = previous one
// final float [] PREDICTOR_COEFFICIENTS = { 1 };
final int DIFFERENTIAL_ENCODING_SIZE = PREDICTOR_COEFFICIENTS.length;

float quantisationScale = 1.0;

void setup() {
  size(1280, 720);
  
  data = loadAudio("96kHz.wav");
  
  predicted = new float[data.length];
  error = new float[data.length];
  dpcmEncoding(data, predicted, error);
  reconstructed = new float[data.length];
  reconstructFromDPCMEncoding(reconstructed, predicted, error);
  
  float x = minimisesMSEOf(data);
  float y = minimisesMSEOf(reconstructed);
    
  println("value that minimises MSE is " + x);
  println("value that minimises MSE is " + y);
  println("Reported sample rate " + sampleRate);
  println("Diff " + PSNR(data, reconstructed));
}
