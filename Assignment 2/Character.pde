class character {

  String characterName;

  float charSizeX, charSizeY, charPosX, charPosY, velocityX, velocityY, currentVelX, currentVelY, jumpAmount;

  float attackPosX, attackPosY, attackX, attackY;

  boolean leftLedge, rightLedge, canJump, direction;
  
  boolean crouch = true;

  int jumpCounter = 0;

  PImage defaultImage;


//constructor for actions
  public character(boolean startingDir, String charName) {
    this.jumpCounter = 0;
    this.leftLedge = false;
    this.rightLedge = false;
    this.canJump = true;
    this.direction = startingDir;
    this.characterName = charName;
  }
  //constructor for movement
  public void characterSettings(float cX, float cY, float cPosX, float cPosY, float velX, float velY, float jump) {
    this.charSizeX = cX;
    this.charSizeY = cY;
    this.charPosX = cPosX;
    this.charPosY= cPosY;
    this.velocityX = velX;
    this.velocityY = velY;
    this.jumpAmount = jump;
  }
//contructor for attack
  public void attackSettings(float aX, float aY) {
    this.attackX = aX;
    this.attackY = aY;
  } 

  void loadAssets() {

    defaultImage = loadImage(characterName + ".png");

    //remember to use load assets in gameRun() and find a way to initialize multiple picture instances(for different animations);
  }


  void drawCharacter() {
    currentVelY += velocityY;
    charPosY += currentVelY;
    if (direction) {
      pushMatrix();
      scale(-1, 1);
      tint(255, 255);
      image(defaultImage, -charPosX, charPosY, charSizeX, charSizeY);
      popMatrix();
    } else {
      image(defaultImage, charPosX, charPosY, charSizeX, charSizeY);
    }
  }

  void moveLeft() {
    if (!rightLedge) {
      direction = true;
      leftLedge = false;
      velocityY = 0.2;
      currentVelX = constrain(currentVelX - velocityX, -22, 0);
      charPosX += currentVelX/4;
    }
  }

  void moveRight() {
    if (!leftLedge) {
      direction = false;
      rightLedge = false;
      velocityY = 0.2;
      currentVelX = constrain(currentVelX + velocityX, 0, 22);
      charPosX += currentVelX/4;
    }
  }

  void ledge() {
    if (leftLedge == true) {
      jumpCounter = 0;
      canJump = true;
      velocityY = 0;
      currentVelY = 0;
      charPosY = stageY+10;
      charPosX = stageX-stageSizeX/2-charSizeX/2-1;
    }
    if (rightLedge == true) {
      jumpCounter = 0;
      canJump = true;
      velocityY = 0;
      currentVelY = 0;
      charPosY = stageY+10;
      charPosX = stageX+stageSizeX/2+charSizeX/2+1;
    }
  }

  void jump() {
    if (jumpCounter<jumpAmount) {
      leftLedge = false;
      rightLedge = false;
      velocityY = 0.2;
      if (canJump) {
        currentVelY = -7;
        up = false;
        jumpCounter+=1;
      }
    }
  }

  void crouch() {
    
    velocityY = 0.2;
    leftLedge = false;
    rightLedge = false;
    charSizeY = 60;
    if(crouch){
      charPosY += 15;
      crouch = false;
    }
    currentVelY += velocityY * 1;
  }


  void stageCol() {
    int colValue;  
    colValue = col(charPosX, charPosY, charSizeX, charSizeY, stageX, stageY, stageSizeX, stageSizeY);
    if (colValue == 1) {
      charPosY = stageY - stageSizeY/2 - charSizeY/2;
      currentVelY = 0;
      canJump = true;
      jumpCounter = 0;
    } else if (colValue == 2) {
      currentVelY = +4;
    } else if (colValue == 3) {
      leftLedge = true;
    } else if (colValue == 4) {
      rightLedge = true;
    }
  }

  void attackCol(float x, float y, float sizeX, float sizeY) {
    int colValue;
    if (direction) {
      colValue = col(attackPosX, attackPosY, attackX, attackY, x, y, sizeX, sizeY);
    } else {
      colValue = col(attackPosX, attackPosY, attackX, attackY, x, y, sizeX, sizeY);
    }

    if (colValue == 3 || colValue == 4) {
      knockBack = true;
    }
  }


  void attack() {
    //attackAnimation
    attackPosY = charPosY-10;
    fill(255, 0, 0, 100);
    if (direction) {
      attackPosX = charPosX - charSizeX/2 - attackX/2;
      rect(attackPosX, attackPosY, attackX, attackY);
    } else {
      attackPosX = charPosX + charSizeX/2+attackX/2;
      rect(attackPosX, attackPosY, attackX, attackY);
    }
  }

  void charCol(float x, float y, float sizeX, float sizeY) {
    int colValue;
    colValue = col(charPosX, charPosY, charSizeX, charSizeY, x, y, sizeX, sizeY);
    if (colValue == 3) {
      charPosX = charPosX2-charSizeX2/2-charSizeX/2;
    } else if (colValue == 4) {
      charPosX = charPosX2+charSizeX2/2+charSizeX/2;
    }
  }
}