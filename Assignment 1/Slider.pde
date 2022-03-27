class Slider {

  //Variables for slider which alters # of lines
  float slideWidth = 20;
  float slideHeight = 10;
  float posX = 750;
  float posY = 20;
  boolean over = false;
  boolean locked = false;

  //Booleans for the RGB sliders

  boolean over2 = false;
  boolean locked2 = false;
  boolean over3 = false;
  boolean locked3 = false;
  boolean over4 = false;
  boolean locked4 = false;

  //Position values for the RGB sliders

  float posY2 = 25;
  float posX2 = 100;
  float posY3 = 25;
  float posX3 = 175;
  float posY4 = 25;
  float posX4 = 250;

  //RGB starting values
  float r=255, g=255, b=255;


  //------------------------------------------------------------------------------------------------------

  //Main slider which controls # of lines seen
  void slider1() {
    stroke(255);
    strokeWeight(2);
    line (750, 20, 750, 675); // Position for sliders line
    if (dist(mouseX, mouseY, posX, posY) < slideHeight) { /* Calculates if mouse cursor  
     is over the slider box*/

      fill(200);                                       
      over = true; // If cursor is over box, "over" becomes true
    } else {
      fill(255);
      over = false; // If it is not "over" stays false
    }
    if (posY < 20 && posX == 750) { // Makes sure the slider stays within constraints
      posY = 20;                     // When PosY goes below 20, it sets is back to 20
    } else if (posY > 675) { 
      posY = 675;// Makes sure the slider does not cross 675
    }
    rect(posX, posY, slideWidth, slideHeight); // Where the rectangle box is drawn

    lines=posY/16; //Controls number of lines generated by the slider
    // Increasing the value means less lines are drawn
  }

  // Mouse commands for the slider controlling # of lines
  void pressed1() { 
    if (over) { // If statement works when mouse is over slider
      locked = true; // Makes locked true which controls the dragging
    }
  }
  void dragged1() {
    if (locked && mouseX>670 && mouseX<800) { // Makes slider slidable within those 
      // X-value constraints; activates when mouse is pressed
      posY = mouseY; // Value of posY = the mouses y-value; allows slider to slide on the y-axis
    }
  }
  void released1() { // Controls what happens when the mouse press is released
    locked = false; // Changes boolean of "locked" making the slider undraggable when released
  }

  //--------------------------------------------------------------------------------------------

  //RED SLIDER
  void slider2() {
    stroke(255);
    strokeWeight(2);
    line (100, 25, 100, 175);

    if (dist(mouseX, mouseY, posX2, posY2) < slideHeight) {
      fill(200);
      over2 = true;
    } else {
      fill(255);
      over2 = false;
    }
    if (posY2 < 25 && posX2 == 100) {
      posY2 = 25;
    } else if (posY2 > 175) {
      posY2 = 175;
    }
    fill(255);
    rect(posX2, posY2, slideWidth, slideHeight);
  }

  void pressed2() {
    if (over2) {
      locked2 = true;
    }
  }
  void dragged2() {
    if (locked2 && mouseX>75 && mouseX<125) {
      posY2 = mouseY;
    }
  }  
  void released2() {
    locked2 = false;
  }

  //-------------------------------------------------------------------------------------------------------

  //GREEN SLIDER

  void slider3() {
    stroke(255);
    strokeWeight(2);
    line (175, 25, 175, 175);
    if (dist(mouseX, mouseY, posX3, posY3) < slideHeight) {
      fill(200);
      over3 = true;
    } else {
      fill(255);
      over3 = false;
    }
    if (posY3 < 25 && posX3 == 175) {
      posY3 = 25;
    } else if (posY3 > 175) {
      posY3 = 175;
    }
    rect(posX3, posY3, slideWidth, slideHeight);
  }
  void pressed3() {
    if (over3) {
      locked3 = true;
    }
  }
  void dragged3() {
    if (locked3 && mouseX>150 && mouseX<200) {
      posY3 = mouseY;
    }
  }
  void released3() {
    locked = false;
  }

  //------------------------------------------------------------------------------------------------------------

  //BLUE SLIDER
  void slider4() {
    stroke(255);
    strokeWeight(2);
    line (250, 25, 250, 175);
    if (dist(mouseX, mouseY, posX4, posY4) < slideHeight) {
      fill(200);
      over4 = true;
    } else {
      fill(255);
      over4 = false;
    }
    if (posY4 < 25 && posX4 == 250) {
      posY4 = 25;
    } else if (posY4 > 175) {
      posY4 = 175;
    }
    rect(posX4, posY4, slideWidth, slideHeight);
  }
  void pressed4() {
    if (over4) {
      locked4 = true;
    }
  }
  void dragged4() {
    if (locked4 && mouseX>225 && mouseX<275) {
      posY4 = mouseY;
    }
  }
  void released4() {
    locked4 = false;
  }

  //--------------------------------------------------------------------------------------------------------------

  // How the colours are changed
  void changeColour() { // Controls how the sliders change the colours

    r=posY2/0.57; // Red value depends on position of Y2 divided by appropriate factor
    g=posY3/0.57;// Green "                           Y3                            "
    b=posY4/0.57;// Blue                              Y4                            "
    fill(r, g, b); // Fill colour for the ellipses
    stroke(r, g, b); // Stroke colour for the line
  }
}
