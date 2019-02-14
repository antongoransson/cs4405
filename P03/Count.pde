int countRGB(PImage s) {
  HashMap<Integer,Integer> countColours = new HashMap<Integer, Integer>();

  s.loadPixels();
  for (int i = 0; i < s.pixels.length; i += 1) {
    Integer c = countColours.get(s.pixels[i]);
    if (c == null) {
      countColours.put(s.pixels[i], 1);
    }
    else {
      countColours.put(s.pixels[i], c + 1);
    }
  }
 
  return countColours.size();
}

String countQuantizedDCTCoefficients() {
  return "DCT # " + (source.width * source.height * 3) + 
    "  Zero before: " + dctCoefficientZeroBeforeQuantization + "   " + nf(100.0 * dctCoefficientZeroBeforeQuantization / (source.width * source.height * 3), 0, 1) + "%" +
    "   after: " + dctCoefficientZeroAfterQuantization + "   " + nf(100.0 * dctCoefficientZeroAfterQuantization / (source.width * source.height * 3), 0, 1) + "%";
}
