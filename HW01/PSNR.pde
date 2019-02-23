double log10(double x) {
  return Math.log(x) / Math.log(10);
}

double psnr(PImage a, PImage b) {
  double diff = 0, sum = 0;

  for (int  i = 0; i< a.pixels.length; i += 1) {
    diff = red(a.pixels[i]) - red(b.pixels[i]);
    sum += (diff * diff);
  }
  double mse = sum / (a.width * a.height); 

  return (10.0 * log10(255.0 * 255.0 / mse));
}

// report the overall PSNR of the image as the average of the PSNR in each component

double ycbcrPSNR(PImage r, PImage t) {
  PImage rY, rCb, rCr;
  PImage tY, tCb, tCr;

  rY = extractAsImageFromComponent(r, 0);
  rCb = extractAsImageFromComponent(r, 1);
  rCr = extractAsImageFromComponent(r, 2);

  tY = extractAsImageFromComponent(t, 0);
  tCb = extractAsImageFromComponent(t, 1);
  tCr = extractAsImageFromComponent(t, 2);
  
  double yPSNR = psnr(rY, tY);
  double cbPSNR = psnr(rCb, tCb);
  double crPSNR = psnr(rCr, tCr);
  
  return (yPSNR + cbPSNR + crPSNR) / 3.0; 
}

// should you use the RGB channels?
// would it make a difference?
