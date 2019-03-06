import ddf.minim.*;
import ddf.minim.ugens.*;


float [] loadAudio(String s) {
  Minim minim = new Minim(this);
  MultiChannelBuffer sampleBuffer = new MultiChannelBuffer( 1, 1 );

  sampleRate = minim.loadFileIntoBuffer( s, sampleBuffer );
  float [] signal = new float[sampleBuffer.getChannel(0).length];
  arrayCopy(sampleBuffer.getChannel(0), signal);
  
  println(min(signal) + "..." + max(signal));
  return signal;
}
