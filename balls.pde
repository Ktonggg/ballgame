import processing.video.*;
Capture video;
color targetColor;
float targetColorR, targetColorG, targetColorB;
float targetX = 0;

void setup() {
  size(640, 480);
  video = new Capture(this, width, height, 30);//set the game screen
  smooth();
  targetColor = color(0, 255, 0);
  targetColorR = red(targetColor);
  targetColorG = green(targetColor);
  targetColorB = blue(targetColor);
  video.start();
  setblock();
}
  float targetY = 350;
void draw() {
  if (video.available()) {
    video.read();
  }

  image(video, 0, 0);
  video.loadPixels();
  float colorDistance  = 1;
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      int loc = x + y * video.width;
      color videoColor = video.pixels[loc];
      float r1 = red(videoColor);
      float g1 = green(videoColor);
      float b1 = blue(videoColor);

      float d = dist(r1, g1, b1, targetColorR, targetColorG, targetColorB);
      //enables more accurate color recognition in different light conditions
      if (d < colorDistance && abs(colorDistance-d)>0
      ) {
        print(colorDistance-d,"\n");
        colorDistance = d;
        targetX = x;
      }
    }
  }

  if (colorDistance < 30) {
    drawTargetColorShape(targetX, targetY);
  }

  drawblock();
}

//Make the color of the paddle into the color of recognition
void drawTargetColorShape(float targetX, float targetY) {
  fill(targetColor);
  strokeWeight(2.0);
  stroke(255);
  rectMode(CENTER);
  rect(targetX, targetY, paddleWidth, paddleHeight);
}

//Mouse click on the color user want to get
void mousePressed() {
  int loc = mouseX + mouseY * video.width;
  targetColor = video.pixels[loc];
  targetColorR = red(targetColor);
  targetColorG = green(targetColor);
  targetColorB = blue(targetColor);
}

void keyPressed() {
  //Trigger to start the game
  if(key == 's'){
    start = true;
  }
  //Trigger to restart the game
  if(key == 'r' && restart == true){
    ballX = 200;
    ballY = 350;
    speedX = 3;
    speedY = -3;
    for(int i = 0; i<28; i++){
      brick[i].a = true;
    }
    restart = false;
    score = 0;
  }
}
