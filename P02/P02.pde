final String [] channelNames = { "Y", "Cb", "Cr" }; //<>//
String [] sourceImageNames = { "spectrum.png", "flower-close.png", "farmhouse.png", "finetexture.png" };
int currentImageIndex = 0;

PImage source, target, singleChannel;
int channel = 0;


void setup() {
  size(1535, 512);

  getNewImage();
}

void draw() {
  background(0);

  image(source, 0, 0);
  image(target, source.width, 0);
  image(singleChannel, source.width * 2, 0);
  fill(255);
  text(channelNames[channel], source.width * 3 - 30, 30);
}
