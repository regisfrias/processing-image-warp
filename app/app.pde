// initially based on this:
// https://processing.org/discourse/beta/num_1138567834.html

PImage source, destination;

float mX, mY;
float deltaX, deltaY;
float imgDiagonal;

void settings() {
  source = loadImage("img/IMG_20170429_214847.jpg");
  size(source.width, source.height);
  imgDiagonal = dist(0, 0, source.width, source.height);
}

void setup() {
}

void draw() {
  destination = warp(source);
  image(destination, 0, 0);
}

void mousePressed(){
  mX = mouseX;
  mY = mouseY;
}

void mouseDragged(){
  deltaX = mouseX - mX;
  deltaY = mouseY - mY;
}

PImage warp(PImage source) {
  int w = source.width, h = source.height;
  destination = new PImage(w,h);
  source.loadPixels();
  destination.loadPixels();

  for(int x = 0; x < w; x++) {
    for(int y = 0; y < h; y++) {
      int newX = x;
      int newY = y;
      
      float dist = map(dist(x, y, mX, mY), 0, imgDiagonal, 0, 1200);
      //float dist = map(dist(x, y, mouseX, mouseY), 0, imgDiagonal, 0, 1200);
      float amount = (cos(radians(dist))/2 + .5);
      
      if(dist > 180 || dist < -180) {
        amount = 0;
      }
      
      newX = int(x - deltaX * amount);
      newY = int(y - deltaY * amount);
      
      color c;
      if(newX >= w || newX < 0 ||
         newY >= h || newY < 0)
        c = color(0,0,0);
      else
        c = source.pixels[newY*w + newX];
      destination.pixels[y*w+x] = c;
    }
  }
  return destination;
}
