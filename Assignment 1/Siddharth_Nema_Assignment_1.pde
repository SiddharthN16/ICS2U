/* 
 Description: Processing Assignment 1
 Author: Siddharth Nema
 Last Modified: October 25, 2019
 
 Reference: https://www.vectorstock.com/royalty-free-vector/neon-dna-spiral-abstract-background-medical-vector-24462792
 */

Slider s;
PImage DNA;

float x(float t) { // x is a function which accepts a parameter of float type and returns float type values
  return sin(t/5)*110; // Returns sine waves for parameter "t"; allows for more curve options with parametrics
}
float y(float t) {
  return cos(t/20)*675;// Returns cosine waves for parameter "t"
}
float x2(float t) {
  return -sin(t/5)*110;
}
float y2(float t) {
  return cos(t/20)*675;
  // modifying number in brackets(divisor) changes frequency of the wave; lower value increases frequency, higher value lowers frequency
  // changing the number outside brackets changes scale; higher number increases the length or height of product depeding to which variable it assigned to
}
float t; // parameter variable
float cordX = 400; //X coordinate for drawing
float cordY = 350;//Y coordinate for drawing
int i; // Looping variable
float lines; // # of lines drawn
float yRote;


void setup() {
  size (800, 700,P3D);
  rectMode(CENTER); // Alligns rectangles in the center rather than a corner
  s = new Slider();
  DNA=loadImage("DNA.png");
  frameRate(60);
  smooth(8); // Anti-aliasing level
}

void draw() {

  background(0);
  

  s.slider1(); 
  s.slider2();
  s.slider3();
  s.slider4();
  text("R", 95, 205);
  text("G", 170, 205);
  text("B", 245, 205);
  text("Less Lines", 670, 25); 
  text("More Lines", 670, 675);

  strokeWeight(2);
  translate(cordX, cordY); // Move drawing to desired position
  s.changeColour();

  t+=0.5; // Speed of the parametric equations

  for (i=0; i < lines; i+=2) { // Loop to contantly draw the specified number of lines 
    pushMatrix();
    rotateY(radians(yRote+=0.05));
    //rotateZ(radians(-60)); // Use to fully recreate image

    if (mousePressed && mouseX<700 && mouseX>200) { // When mouse is pressed the parametrics rotate in the given constraint
      rotateY(radians(mouseX/1.1)); // Rotates around the y-axis depending on the position of the mouse
    } 
    if (mousePressed && mouseX<500 && mouseX>300) {
      yRote = 0;
    }
    line(x(t+i), y(t+i), x2(t+i), y2(t+i)); // Adding"i" allows for all lines not to be drawn at one place; separates them
    ellipse(x(t+i), y(t+i), 10, 10);
    ellipse(x2(t+i), y2(t+i), 10, 10);
    popMatrix();
  }

//Reference Image
  if (keyPressed) {
    if (key=='i' || key=='I') { // Press 'i' to show reference image
      clear();
      image(DNA, -400, -350);
    }
  }
}
void mousePressed() {
  s.pressed1();
  s.pressed2();
  s.pressed3();
  s.pressed4();
}
void mouseDragged() {
  s.dragged1();
  s.dragged2();
  s.dragged3();
  s.dragged4();
}
void mouseReleased() {
  s.released1();
  s.released2();
  s.released3();
  s.released4();
}
