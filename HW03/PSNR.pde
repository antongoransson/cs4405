double log10(double x) {
  return Math.log(x) / Math.log(10);
}

// PSNR of the Y component to 3 places of decimals
double yPSNR(PImage a, PImage b){
  double diff = 0, sum = 0;
  
  for(int  i = 0; i< a.pixels.length; i += 1){
    diff = red(a.pixels[i]) - red(b.pixels[i]);
    sum += (diff * diff);
  }
  double mse = sum / (a.width * a.height); 
  
  double full = (10.0 * log10(255.0 * 255.0 / mse));
  
  return Math.round(full * 1000d) / 1000d;
}
