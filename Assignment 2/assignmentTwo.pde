import ddf.minim.*;

Minim minim;
AudioPlayer player;

character p = new character(false, "pewdiepie");

character b = new character(true, "borger");

PImage startingScreen, clickToContinue, pewdiepie, borger;

boolean selContinue = false, logoFlash = false;

boolean left, right, up, down, attack;

int charSizeX2 = 100, charSizeY2 = 92; 
float charPosX2 = 0, charPosY2 = 0;

float velocityX2 = 2.5, velocityY2 = 0.08;

float currentVelX2, currentVelY2;

int flashLogo;

boolean restart = false;

float stageX, stageY, stageSizeX, stageSizeY;

boolean knockBack = false;
boolean state = false;

float colour;

//----------------------------------------------------------------------------------------
void setup() {
  size(1200, 600, P2D);
  minim = new Minim(this);
  player = minim.loadFile("meleeAudio.wav");
  startingScreen = loadImage("startingScreen.png");
  clickToContinue = loadImage("clickToContinue.png");
  borger = loadImage("borger.png");
  smooth();
  noStroke();



  p.characterSettings(50, 90, width/2, height/2, 3, 0.2, 2);
  p.attackSettings(35, 20);

  b.characterSettings(100, 92, width/2 + 50, height/2, 2.5, 0.08, 4);
  b.attackSettings(25, 45);



  stageX = width/2;
  stageY = height/2 + 150;
  stageSizeX = 850;
  stageSizeY = 75;

  charPosX2 = width/2+100;
  charPosY2 = height/2+68;
}

//-------------------------------------------------------------------------------------
void draw() {
  background(0);
  scale(1);
  noStroke();
  startScreen();
  selectChar();
  //player.play();
  p.loadAssets();
  b.loadAssets();
}

void startScreen() {
  imageMode(CENTER);
  tint(255, 255);
  image(startingScreen, width/2, height/2 - 100);
  logoFlash();
}


//-------------------------------------------------------------------------------------
void gameRun() {
  clear();
  gameBackground(); // adds background

  rectMode(CENTER);
  tint(255, 255);
  fill(255);

colour = 0;
  //stage hitbox
  while (colour<stageSizeY) {
    colour++;
    stroke(100, 0+colour, 0);
    line(stageX-stageSizeX/2, stageY-stageSizeY/2+colour, stageX+stageSizeX/2, stageY-stageSizeY/2+colour);
  }
  //fill(0, 255, 0, 100);
  //rect(stageX, stageY, stageSizeX, stageSizeY);



  //characterHitbox
  fill(0, 0, 255, 100);
  rect(p.charPosX, p.charPosY, p.charSizeX, p.charSizeY);

  // detects when character is off screen to reset game
  while (p.charPosY > height || charPosY2 > height) {
    clear();
    reStart();
    startScreen();
    selContinue = false;
  }

  //draws characters and activates collision
  p.drawCharacter();
  p.stageCol();
  p.charCol(charPosX2, charPosY2, charSizeX2, charSizeY2);
  p.attackCol(charPosX2, charPosY2, charSizeX2, charSizeY2);


  //character movement
  if (left) {
    p.moveLeft();
  }
  if (right) {
    p.moveRight();
  }
  if (up) {
    p.jump();
  }
  if (down) {
    p.crouch();
  }
  p.ledge();
  if (attack) {
    p.attack();
  }
}

//------------------------------------------------------------------------------------------
void selectChar() {
  if (keyPressed == true|| mousePressed == true) {
    selContinue = true;
  }
  if (selContinue == true) {
    clear();
    gameRun();
    char2();
  }
}

//---------------------------------------------------------------------------------------------
void keyPressed() {
  pressCharOne();
  //pressCharTwo();
}

void keyReleased() {
  releaseCharOne();
  releaseCharOne();
}

//---------------------------------------------------------------------------------------------
void logoFlash() { 

  if (flashLogo >150) {
    logoFlash = true;
  }
  if (flashLogo <5) {
    logoFlash = false;
  }
  if (logoFlash == false) {
    flashLogo+=5;
  }
  if (logoFlash == true) {
    flashLogo-=5;
  }
  tint(255, flashLogo);
  image(clickToContinue, width/2, height/2 + 100);
}

//--------------------------------------------------------------------------------------------
void pressCharOne() {
  if (key == 'w' || key == 'W') {
    up = true;
  }
  if (key == 's' || key == 'S') { 
    p.crouch = true;
    down = true;
  }
  if (key == 'a' || key == 'A') {
    left = true;
  }
  if (key == 'd' || key == 'D') {
    right = true;
  }
  if (key == 'f' || key == 'F') {
    attack = true;
  }

  if (key == 'r' || key == 'R') {
    restart = true;
  }
}

//----------------------------------------------------------------------------------------
void releaseCharOne() {
  if (key == 'w' || key == 'W') {
    up = false;
  }
  if (key == 's' || key == 'S') { 
    down = false;
    p.charPosY -= 15;
    p.charSizeY = 90;
  }
  if (key == 'a' || key == 'A') {
    left = false;
    p.currentVelX = 0;
  }
  if (key == 'd' || key == 'D') {
    right = false;
    p.currentVelX = 0;
  }
  if (key == 'f' || key == 'F') {
    attack = false;
  }
  if (key == 'r' || key == 'R') {
    restart = false;
  }
}





void char2() {
  fill(255, 0, 0, 150);
  image(borger, charPosX2, charPosY2, charSizeX2, charSizeY2);
  currentVelY2 += velocityY2;
  charPosY2 += currentVelY2;
  charPosX2 += currentVelX2/4;
  velocityY2 = 0.2;

  if (charPosX2<=stageX+stageSizeX/2 && charPosX2 >= stageX-stageSizeX/2) {
    if (dist(charPosX2, charPosY2, charPosX2, stageY)<=stageSizeY/2 + charSizeY2/2) {

      if (charPosY2<stageY) {
        charPosY2 = stageY - stageSizeY/2 - charSizeY2/2;
        currentVelY2 = 0;
        currentVelX2 = 0;
        p.canJump = true;
      }
      if (charPosY2>stageY) {
        currentVelY2 = +4;
      }
    }

    if (knockBack && p.direction) {
      currentVelY2=-2;
      currentVelX2=-15;
      knockBack=false;
    } else if (knockBack) {
      currentVelY2=-2;
      currentVelX2=15;
      knockBack=false;
    }
  }
}

// collision return values (top,down,right,left)
int col(float posX, float posY, float x, float y, float posX2, float posY2, float x2, float y2) {

  if (posY <= posY2 + y2/2 && posY >= posY2 - y2/2) {
    if (dist(posX, posY, posX2, posY) <= x2/2 + x/2) {
      if (posX <= posX2) {
        return 3;
      } else {
        return 4;
      }
    }
  }
  if (posX <= posX2 + x2/2 && posX >= posX2 - x2/2) {
    if (dist(posX, posY, posX, posY2) <= y2/2 + y/2) {
      if (posY <= posY2) {
        return 1;
      } else {
        return 2;
      }
    }
  }
  return 0;
}

void gameBackground() {
  for ( int i = 0; i < height; i++) {
    stroke(0, 0, 150-i/2);
    strokeWeight(2);
    line(0, i*2, width, i*2);
  }

  for (int i = 0; i<10; i+=random(1, 2)) {
    fill(255, random(255));
    ellipse(random(i*200), random(i*20), 10, 10);
  }
}

void reStart() {
  p.charPosX = width/2;
  p.charPosY = height/2;
  stageX = width/2;
  stageY = height/2 + 150;
  restart = false;
  p.leftLedge = false;
  p.rightLedge = false;
  p.velocityY = 0.2;
  charPosX2 = width/2+100;
  charPosY2 = height/2+68;
}