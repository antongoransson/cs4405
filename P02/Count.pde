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