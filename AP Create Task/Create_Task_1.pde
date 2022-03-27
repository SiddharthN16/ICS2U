/*
Description: AP Create Task - Capture The Flag
 Author: N/A
 Last Modified: Tuesday, January 21, 2020
 */

float rectX, rectY, rectWidth, rectHeight;
int speedX = 8;
int speedY = 8;
boolean up, down, right, left;

int score = 0;
float flagX = 50, flagY = 300, flagW = 80, flagH = 80;
boolean locked = false;
float chase = 0.15;

float velocity = 0.5;

int pLife = 3;

float aiX, aiY, aiW, aiH, angle;
int respawnX = 1000;
int respawnY = 300;
float accel = 7.5;

PImage heart, flag;

void setup() {
  size(1200, 600);
  rectX = 900 ;
  rectY = 300;
  rectWidth = 50;
  rectHeight = 50;
  aiX = 120;
  aiY = height/2;
  aiW = 50;
  aiH = 50;
  flag = loadImage("flag.png");
  heart = loadImage("heart.png");
}

void draw() {
  rectMode(CENTER);
  imageMode(CENTER);
  gameRun();
}

void gameRun() {
  //---------------------------------------------------------
  //BACKGROUND
  fill(255, 0, 0);
  noStroke();
  quad(0, 0, 800, 0, 800, height, 0, height);
  fill(70, 150, 255);
  quad(800, 0, width, 0, width, height, 800, height);

  //---------------------------------------------------------
  bound(width/2, height/2, 100, 250);
  move();
  charAI();
  flagMech();

  fill(70, 150, 255);
  strokeWeight(5);
  stroke(0);
  rect(rectX, rectY, rectWidth, rectHeight);
  //Max & Min speed
  speedX = constrain(speedX, 1, 15); 
  speedY = constrain(speedY, 1, 15);
  //Max & Min Lives
  pLife = constrain(pLife, 0, 3);
  lose();
  //------------------------------------------------------ 
  //DISPLAY SCORE
  textSize(20);
  fill(0);
  text("Current Score:" + score, 525, height-50);
  //DISPLAY LIVES
  for (int i = 0; i<pLife; i++) {
    fill(255, 150, 50);
    strokeWeight(5);
    stroke(0);
    image(heart, width/2+i*70, 30, 50, 50);
  }
  //--------------------------------------------------------
}
void bound(int obsX, int obsY, int obsW, int obsH) {
  //OBSTACLE
  fill(0);
  strokeWeight(0);
  rect(obsX, obsY, obsW, obsH);

  //bounce off left and right edges of screen
  if (rectX + rectWidth/2 > width) {
    rectX = width - rectWidth/2;
  } else if (rectX-rectWidth/2 < 0) {
    rectX = 0+rectWidth/2;
  }

  //bounce off top and bottom edges of screen
  if (rectY + rectHeight/2 > height) {
    rectY = height - rectHeight/2;
  } else if (rectY - rectHeight/2 < 0) {
    rectY =0+rectHeight/2;
  }
  //Right & Left side collision for player against obstacle
  if (rectY<=obsY+obsH/2 && rectY>=obsY-obsH/2) {
    if (dist(rectX, rectY, obsX, rectY)<=obsW/2+rectWidth/2) {
      if (rectX>=obsX) {
        rectX = obsX+obsW/2+rectWidth/2;
      } else {
        rectX = obsX-obsW/2-rectWidth/2;
      }
    }
  }
  //Top & Bottom side collision for player against obstacle
  if (rectX<=obsX+obsW/2 && rectX>=obsX-obsW/2) {
    if (dist(rectX, rectY, rectX, obsY)<=obsH/2+rectHeight/2) {
      if (rectY<=obsY) {
        rectY = obsY-obsH/2-rectHeight/2;
      } 
      if (rectY>=obsY) {
        rectY = obsY+obsH/2+rectHeight/2;
      }
    }
  }
  //Top and Bottom side collision for Opponent against obstacle
  if (aiX<=obsX+obsW/2 && aiX>=obsX-obsW/2) {
    if (dist(aiX, aiY, aiX, obsY)<=obsH/2+aiH/2) {
      if (aiY<=obsY) {
        aiY = obsY-obsH/2-aiH/2;
      } 
      if (aiY>=obsY) {
        aiY = obsY+obsH/2+aiH/2;
      }
    }
  }
  //Right & Left side collision for Opponent against obstacle
  if (aiY<=obsY+obsH/2 && aiY>=obsY-obsH/2) {
    if (dist(aiX, aiY, obsX, aiY)<=obsW/2+aiW/2) {
      if (aiX>=obsX) {
        aiX = obsX+obsW/2+aiW/2;
      } else {
        aiX = obsX-obsW/2-aiW/2;
      }
    }
  }
}
void keyPressed() {
  if (key == 'w') {
    up = true;
  }
  if (key == 's') {
    down = true;
  }
  if (key == 'a') {
    left = true;
  }
  if (key == 'd') {
    right =true;
  }

  if (pLife == 0) {
    if (key == ' ') {
      pLife = 3;
      score = 0;
    }
  }
}


void charAI() {
  stroke(0);
  strokeWeight(5);
  fill(255, 0, 0);
  rect(aiX, aiY, aiW, aiH);


  if (rectX<=800) {
    if (abs(aiX - rectX) > 1 || abs(aiY - rectY) > 2) {
      angle = atan2(rectY - aiY, rectX - aiX);
      aiX = aiX + round(accel * cos(angle));
      aiY = aiY + round( accel* sin(angle));
    }
  }
  if (rectX>=800) {
    aiX = lerp(aiX, 120, 0.05); 
    aiY = lerp(aiY, height/2, 0.05);
  }

  if (dist(aiX, aiY, rectX, rectY)<=50) {
    rectX = respawnX; 
    rectY = respawnY;
    locked = false;
    pLife -=1;
  }
  if (locked) {
accel = 8.5;
    flagX = lerp(flagX, rectX+50, 1);
    flagY = lerp(flagY, rectY-30, 1);
  } else if (!locked) {
    flagX = 50;
    flagY = height/2;
accel = 7.5;
  }
}


void flagMech() {
  fill(0, 128, 129);
  rect(1150, height/2, 95, 500);
  if (flagX>=1115 && flagX<=width && flagY>=50 && flagY <=550) {
    locked = false;
    score +=1;
  }
  fill(0, 150, 0);
  image(flag, flagX, flagY, flagW, flagH);
  if (dist(flagX, flagY, rectX, rectY)<=60 && flagX<=1115) {
    locked = true;
  }
}


void lose() { 
  if (pLife == 0) {
    //fill(0, 220);
    //quad(0, 0, width, 0, width, height, 0, height);
    clear();
    textSize(50);
    fill(120, 255, 50);
    text("Score:" + score, 500, height/2);
  }
}




void move() {
  if (up && pLife >0) {
    rectY-=speedY;
    speedY+=velocity;
  }
  if (down && pLife >0) {
    rectY+=speedY;
    speedY+=velocity;
  }
  if (left && pLife >0) {
    rectX-=speedX;
    speedX+=velocity;
  }
  if (right && pLife >0) {
    rectX+=speedX;
    speedX+=velocity;
  }
}
void keyReleased() {
  if (key == 'w') {
    up = false;
    speedY = 7;
  }
  if (key == 's') {
    down = false;
    speedY = 7;
  }
  if (key == 'a') {
    left = false;
    speedX = 7;
  }
  if (key == 'd') {
    right =false;
    speedX = 7;
  }
}
