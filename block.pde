float ballX = 200;
float ballY = 350;
float ballWidth = 7;
float ballHeight = 7;
float speedX = 3;
float speedY = -3;
float paddleX = 200;
float paddleY = 500;
float paddleWidth = 100;
float paddleHeight = 20;
float clr = 30;
int score = 0;
boolean start = false;
boolean restart = false;
boolean a = false;
boolean b = false;
boolean c = false;


class track{
  float bright;
  float X;
  float Y;
}

class Brick{
  boolean a = true;
  float X;
  float Y;
}

track[] balltrack = new track[15];
Brick[] brick = new Brick[400];

void setblock(){
  noStroke();
  colorMode(HSB, 100, 100, 100);
  textSize(20);
  rectMode(CENTER);
  
  for(int i = 0; i < 15; i++){
    balltrack[i] = new track();
    balltrack[i].bright = 94-6*i;
    balltrack[i].X = 200;
    balltrack[i].Y = 350;
  }
  
  for(int j = 0; j < 4; j++){ //create the bricks
    for(int i = 0; i<11; i++){
      brick[i+(j*11)] = new Brick();
    }
  }

}

void drawblock(){
  if(start){
    ballMove();
  }
  
  clr = clr +0.2;
  
  if(clr > 100){
    clr -= 100;
  }

  ballDisp();
  trackDisp();
  playerMove();
  playerDisp();
  check();
  scoreDisp();
  brickCheck();
}

void check(){ //Identify if the ball is still in the interface
  if(ballY > 601){ //The ball flies off the interface
    start = false;
    text("press 'r' to restart", 120, 550);
    restart = true;
  }
}

void scoreDisp(){
  fill(0);
  textSize(40);
  text("score: " + str(score), 460, 447);
}



void ballMove(){
  if (ballY < 0){
    speedY = -speedY;
  }
  
  collision2(paddleX, paddleY);
  
  a = false;
  b = false;
  c = false;
  
  if(ballX < 0 ||ballX > 400){
    speedX = -speedX;
  }
  ballX += speedX;
  ballY += speedY;
}

void ballDisp(){
  fill(0, 0, 100);
  rect(ballX, ballY, ballWidth, ballHeight);
}

void trackDisp(){
  fill(0, 0 ,balltrack[1].bright);
  rect(balltrack[1].X, balltrack[0].Y, ballWidth, ballHeight);
  balltrack[0].X = ballX;
  balltrack[0].Y = ballY;
  for(int i = 14; i > 0; i--){
    fill(0, 0 ,balltrack[i].bright);
    rect(balltrack[i].X, balltrack[i-1].Y, ballWidth, ballHeight);
    balltrack[i].X = ballX;
    balltrack[i].Y = ballY;
  }
}

void playerMove(){
  if(targetX + paddleWidth/2 > width){
    paddleX = width - paddleWidth/2;
  }else if(targetX < paddleWidth/2){
    paddleX = paddleWidth/2;
  }else{
    paddleX = targetX;
  }
}

void playerDisp(){
   //fill(clr, 78, 100);
   fill(targetColor);
   paddleY = 350;
   rect(paddleX, paddleY, 100, 20);
}

void brickCheck(){
  int t = 0;
  for(int j = 0; j < 4; j++){
    for(int i = 0; i<11; i++){
      if(brick[t].a){
        
        brick[t].X = 35 + 55*i;
        brick[t].Y = 25 + 35 *j;
        collision(brick[t].X, brick[t].Y);
        brickDisp(t);
        brick[t].a = !a;
        
      }
      
     t++;
     a = false;
     b = false;
     c = false;
    }
  }
}

void brickDisp(int n){
  stroke(clr, 100, 100);
  fill(0, 0, 0);
  rect(brick[n].X, brick[n].Y, 40, 20);
  noStroke();
}

void collision(float px, float py){
  if(ballX < (px+20) && ballX > (px-20) && ballY < (py+10) && ballY > (py-10)){
    a = true;
  }
  
  if((ballX > px - 20 && ballX < px - 16) || (ballX < px+20 && ballX > px + 16)){
    b = true;
  }
  
  if((ballY > py -10 && ballY < py -6 ) || (ballY < py +10 && ballY > py +6)){
    c = true;
  }
  
  if(a){
    if(b){
      speedX = -speedX;
    }
    if(c){
      speedY = -speedY;
    }
    if(ballY<300){
      score += 1;
    }
  }
}

void collision2(float px, float py){
  if(ballX < (px+50) && ballX > (px-50) && ballY < (py+10) && ballY > (py-10)){
    a = true;
  }
  
  if((ballX > px - 50 && ballX < px - 16) || (ballX < px+50 && ballX > px + 16)){
    b = true;
  }
  
  if((ballY > py -10 && ballY < py -6 ) || (ballY < py +10 && ballY > py +6)){
    c = true;
  }
  
  if(a){
    if(b){
      speedX = -speedX;
    }
    if(c){
      speedY = -speedY;
    }
    if(ballY<300){
      score += 1;
    }
  }
}
