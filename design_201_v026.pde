// Design from page 201 of Islamic Geometric Designs by Eric Broug
// ISBN 978-0-500-51695-9
// Code by Rupert Russell
// 28 February 2020
// Thanks to: COLLISION DETECTION by Jeff Thompson  
// http://jeffreythompson.org/collision-detection/index.php
// Using Objects to reduce the code length
// design on redbubble at: https://www.redbubble.com/people/rupertrussell/works/45415188-design-201?asc=u

int i = 0;
float scale = 899;
int designWeight = 8;
float innerScale;
float middleScale;

float[] saveIntersectionX;
float[] saveIntersectionY;

float[] saveCircleX;
float[] saveCircleY;

boolean displayGuideLines = false;
float[] xx, yy; // used to store working intersection test lines

// use the Lineline class to create multiple myLine objects
Lineline myLineline0;
Lineline myLineline1;
Lineline myLineline2;
Lineline myLineline3;
Lineline myLineline4;
Lineline myLineline5;
Lineline myLineline6;
Lineline myLineline7;
Lineline myLineline8;
Lineline myLineline9;
Lineline myLineline10;
Lineline myLineline11;
Lineline myLineline12;
Lineline myLineline13;
Lineline myLineline14;
Lineline myLineline15;
Lineline myLineline16;
Lineline myLineline17;
Lineline myLineline18;
Lineline myLineline19;
Lineline myLineline20;
Lineline myLineline21;
Lineline myLineline22;

// use the CalculatePoints class to create multiple myCircle objects
CalculatePoints myCircle1;
CalculatePoints myCircle2;
CalculatePoints myCircle3;
import processing.pdf.*;

void setup() {
  background(255);

  noFill();
  noLoop(); 
  size(900, 900); 
  smooth();
  noFill();
  rectMode(CENTER);
  ellipseMode(CENTER);
  noFill();
  beginRecord(PDF, "design_201_v025.pdf");

  saveIntersectionX = new float[100]; // store x Points for the intersections
  saveIntersectionY = new float[100]; // store y Points for the intersections

  saveCircleX = new float[100]; // store x Points for the circles
  saveCircleY = new float[100]; // store y Points for the circles

  xx = new float[100];
  yy = new float[100];

  innerScale = 0.18163545 * 2 * scale;
  middleScale = 0.24999997 * scale;
}

void draw() {
  background(255);

  translate(width/2, height/2);
  strokeWeight(1);
  step1(displayGuideLines);
  step2(displayGuideLines);
  step3(displayGuideLines);
  step3Lower1(displayGuideLines);
  step3Upper1(displayGuideLines);
  step3Verticle(displayGuideLines);
  step3Horizontal(displayGuideLines);
  step4(displayGuideLines);

  // design lines
  stepDesign5a(true);
  stepDesign5b(true);
  stepDesign5c(true);

  stepDesign5d(true);
  stepDesign6a(true);
  stepDesign6b(true);

  stepDesign7a(true);
  stepDesign7b(true);

  // showTestPoint();
  // numberCircles();
  // numberIntersections();

  strokeWeight(designWeight);
  stroke(0, 0, 0);  // colour of final design
  save("design_201_v025.png");
  endRecord();

  // exit();
}

// Construct the Lineline object
class Lineline {
  int index;  // hold the index numbers for the intersection use to store points in array
  float x1;
  float y1;
  float x2;
  float y2;
  float x3;
  float y3;
  float x4;
  float y4;
  boolean displayLine;
  boolean displayInterection;
  char colour;
  float weight;
  float intersectionX;
  float intersectionY;

  // The Constructor is defined with arguments.
  Lineline(int tempIndex, float tempX1, float tempY1, float tempX2, float tempY2, float tempX3, float tempY3, float tempX4, float tempY4, boolean tempDisplayLine, boolean tempDisplayInterection, char tempColour, float tempWeight) {
    index =tempIndex;
    x1 = tempX1;
    y1 = tempY1;
    x2 = tempX2;
    y2 = tempY2;
    x3 = tempX3;
    y3 = tempY3;
    x4 = tempX4;
    y4 = tempY4;
    displayLine = tempDisplayLine;
    displayInterection = tempDisplayInterection;
    colour = tempColour;
    weight = tempWeight;
  }

  boolean displayIntersection() {
    // LINE/LINE 
    // Thanks to: COLLISION DETECTION by Jeff Thompson  
    // http://jeffreythompson.org/collision-detection/index.php
    // from http://jeffreythompson.org/collision-detection/line-line.php

    // calculate the distance to intersection point
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    // if uA and uB are between 0-1, lines are colliding
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

      // optionally, draw a circle where the lines meet
      intersectionX = x1 + (uA * (x2-x1));
      intersectionY = y1 + (uA * (y2-y1));
      noFill();

      switch(colour) {
      case 'r': 
        stroke(255, 0, 0);
        break;
      case 'g': 
        stroke(0, 255, 0);
        break;
      case 'b': 
        stroke(0, 0, 255);
        break;        
      case 'm': 
        stroke(255, 0, 255);
        break;    
      default:
        stroke(0, 0, 0); // black
        break;
      }

      if (displayLine) {
        strokeWeight(weight);
        line(x1, y1, x2, y2);
        line(x3, y3, x4, y4);
      }

      saveIntersectionX[index] = intersectionX;
      saveIntersectionY[index] = intersectionY;

      if (displayInterection) {
        circle(intersectionX, intersectionY, 10);
      }

      strokeWeight(designWeight);
      stroke(0, 0, 0);  // colour of final design uncomment to use 'case' to set individual design elements to different colours 

      return true ;
    }
    return false;
  }
}
//  end of constructor for Lineline class

// Start of Constructor for CalculatePoints defined with arguments
// calculate points around a circle and store n points around a circle
class CalculatePoints {
  int numPoints;
  float scale;
  float h;
  float k;
  int counterStart;
  boolean displayCrcles;

  // The Constructor is defined with arguments and sits inside the class 
  CalculatePoints(int tempCounterStart, int tempNumPoints, float tempScale, float tempH, float tempK, boolean tmpDisplayCrcles) {
    numPoints = tempNumPoints;
    scale = tempScale;
    h = tempH;
    k = tempK;
    counterStart = tempCounterStart;
    displayCrcles = tmpDisplayCrcles;

    int counter = counterStart;

    double step = radians(360/numPoints); 
    float r =  scale / 2 ;
    for (float theta=0; theta < 2 * PI; theta += step) {
      float x = h + r * cos(theta);
      float y = k - r * sin(theta); 

      // store the calculated coordinates
      saveCircleX[counter] = x;
      saveCircleY[counter] = y;
      if (displayCrcles) {
        circle(saveCircleX[counter], saveCircleY[counter], 10);  // draw small circles to show points
      }
      counter ++;
    }
  }
} // End of Constructor for CalculatePoints

void step1(boolean displayGuideLines) {
  // Guide Lines
  //              CalculatePoints(Start Saving at [index]counterStart, Number of Points to calculate, scale of circle, OffsetX to center H, OffsetY to center K, Display )  
  myCircle1 = new CalculatePoints(0, 8, scale, 0, 0, displayGuideLines);  // used for the ends of the spokes
  myCircle2 = new CalculatePoints(8, 8, scale * sqrt(2), 0, 0, false);  // used for the ends of the spokes

  //Outer Square
  if (displayGuideLines) {
    line(saveCircleX[15], saveCircleY[15], saveCircleX[9], saveCircleY[9]); // Right of outer square
    line(saveCircleX[9], saveCircleY[9], saveCircleX[11], saveCircleY[11]); // Top of outer square
    line(saveCircleX[11], saveCircleY[11], saveCircleX[13], saveCircleY[13]); // Left of outer square
    line(saveCircleX[13], saveCircleY[13], saveCircleX[15], saveCircleY[15]); // Bottom of outer square
  }

  //Spokes
  if (displayGuideLines) {
    line(saveCircleX[8], saveCircleY[8], saveCircleX[12], saveCircleY[12]); // Horozontal through center
    line(saveCircleX[9], saveCircleY[9], saveCircleX[13], saveCircleY[13]); // Diagnoal Lower West to Upper East
    line(saveCircleX[10], saveCircleY[10], saveCircleX[14], saveCircleY[14]); // Verticle through center
    line(saveCircleX[11], saveCircleY[11], saveCircleX[15], saveCircleY[15]); // Diagnoal Upper West to Lower East
  }

  // Circle Circle inside the square
  if (displayGuideLines) {
    circle(0, 0, scale);
  }
} // end step1

void step2(boolean displayGuideLines) {
  // inner diamond
  if (displayGuideLines) {
    line(saveCircleX[0], saveCircleY[0], saveCircleX[2], saveCircleY[2]); // Diagnoal North to East
    line(saveCircleX[2], saveCircleY[2], saveCircleX[4], saveCircleY[4]); // Diagnoal North to West
    line(saveCircleX[4], saveCircleY[4], saveCircleX[6], saveCircleY[6]); // Diagnoal West to South
    line(saveCircleX[6], saveCircleY[6], saveCircleX[0], saveCircleY[0]); // Diagnoal South to East
  }

  // inner square
  if (displayGuideLines) {
    line(saveCircleX[1], saveCircleY[1], saveCircleX[3], saveCircleY[3]); // Diagnoal North to East
    line(saveCircleX[3], saveCircleY[3], saveCircleX[5], saveCircleY[5]); // Diagnoal North to West
    line(saveCircleX[5], saveCircleY[5], saveCircleX[7], saveCircleY[7]); // Diagnoal West to South
    line(saveCircleX[7], saveCircleY[7], saveCircleX[1], saveCircleY[1]); // Diagnoal South to East
  }
} // end step2


void step3(boolean displayGuideLines) {

  // diagonal 1 right of inner square
  myLineline0 = new Lineline(0, saveCircleX[0], saveCircleY[0], saveCircleX[2], saveCircleY[2], saveCircleX[7], saveCircleY[7], saveCircleX[1], saveCircleY[1], false, false, 'B', 1);
  myLineline0.displayIntersection();

  // diagonal 1 top of inner square
  myLineline1 = new Lineline(1, saveCircleX[0], saveCircleY[0], saveCircleX[2], saveCircleY[2], saveCircleX[1], saveCircleY[1], saveCircleX[3], saveCircleY[3], false, false, 'B', 1);
  myLineline1.displayIntersection();

  // top of inner square diagonal 2
  myLineline2 = new Lineline(2, saveCircleX[1], saveCircleY[1], saveCircleX[3], saveCircleY[3], saveCircleX[2], saveCircleY[2], saveCircleX[4], saveCircleY[4], false, false, 'B', 1);
  myLineline2.displayIntersection();

  // top of inner square diagonal 2
  myLineline3 = new Lineline(3, saveCircleX[2], saveCircleY[2], saveCircleX[4], saveCircleY[4], saveCircleX[3], saveCircleY[3], saveCircleX[5], saveCircleY[5], false, false, 'B', 1);
  myLineline3.displayIntersection();

  // left of inner square diagonal 3
  myLineline4 = new Lineline(4, saveCircleX[3], saveCircleY[3], saveCircleX[5], saveCircleY[5], saveCircleX[4], saveCircleY[4], saveCircleX[6], saveCircleY[6], false, false, 'B', 1);
  myLineline4.displayIntersection();

  // bottom of inner square diagonal 3
  myLineline5 = new Lineline(5, saveCircleX[4], saveCircleY[4], saveCircleX[6], saveCircleY[6], saveCircleX[5], saveCircleY[5], saveCircleX[7], saveCircleY[7], false, false, 'B', 1);
  myLineline5.displayIntersection();

  // bottom of inner square diagonal 4
  myLineline6 = new Lineline(6, saveCircleX[6], saveCircleY[6], saveCircleX[0], saveCircleY[0], saveCircleX[5], saveCircleY[5], saveCircleX[7], saveCircleY[7], false, false, 'B', 1);
  myLineline6.displayIntersection();

  // bottom of inner square diagonal 4
  myLineline7 = new Lineline(7, saveCircleX[7], saveCircleY[7], saveCircleX[1], saveCircleY[1], saveCircleX[6], saveCircleY[6], saveCircleX[0], saveCircleY[0], false, false, 'B', 1);
  myLineline7.displayIntersection();

  if (displayGuideLines) {
    stroke(0);
    strokeWeight(1);
    // parallel lines
    // lower first
    line(saveIntersectionX[0], saveIntersectionY[0], saveIntersectionX[5], saveIntersectionY[5]); // diagonal pair 1 lower
    line(saveIntersectionX[1], saveIntersectionY[1], saveIntersectionX[4], saveIntersectionY[4]); // diagonal pair 1 lower

    // verticle pair
    //stroke(0, 255, 0); // green
    line(saveIntersectionX[1], saveIntersectionY[1], saveIntersectionX[6], saveIntersectionY[6]); // vertical right
    line(saveIntersectionX[2], saveIntersectionY[2], saveIntersectionX[5], saveIntersectionY[5]); // vertical left

    // diagonal  2nd pair
    //stroke(0, 0, 255); // blue
    line(saveIntersectionX[2], saveIntersectionY[2], saveIntersectionX[7], saveIntersectionY[7]); // diagonal pair 1 lower
    line(saveIntersectionX[3], saveIntersectionY[3], saveIntersectionX[6], saveIntersectionY[6]); // diagonal pair 1 lower

    // Horizontal pair
    //stroke(255, 0, 255); // magenta
    line(saveIntersectionX[0], saveIntersectionY[0], saveIntersectionX[3], saveIntersectionY[3]); // vertical right
    line(saveIntersectionX[4], saveIntersectionY[4], saveIntersectionX[7], saveIntersectionY[7]); // vertical left
  }
}

void step3Lower1(boolean displayGuideLines) {
  // Extend parallel pairs to the edge of the square

  float deltaX;
  float deltaY;
  float x1, y1, x2, y2, x3, y3, x4, y4;

  deltaX = saveIntersectionX[0] - saveIntersectionX[5];
  deltaY = saveIntersectionY[0] - saveIntersectionY[5];

  x1 = saveIntersectionX[5] - deltaX;
  y1 = saveIntersectionY[5] - deltaY;

  x2 = saveIntersectionX[0] + deltaX;
  y2 = saveIntersectionY[0] + deltaY;

  x3 = saveCircleX[15];
  y3 = saveCircleY[15];

  x4 = saveCircleX[9];
  y4 = saveCircleY[9];

  // calculate intersection points
  myLineline8 = new Lineline(8, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 2);
  myLineline8.displayIntersection();

  x3 = saveCircleX[15];
  y3 = saveCircleY[15];

  x4 = saveCircleX[13];
  y4 = saveCircleY[13];

  // calculate intersection points
  myLineline9 = new Lineline(9, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 2);
  myLineline9.displayIntersection();

  strokeWeight(1);
  // New Lower 1st Diagonal Pair
  if (displayGuideLines) {
    line(saveIntersectionX[8], saveIntersectionY[8], saveIntersectionX[9], saveIntersectionY[9]);
  }
}


void step3Upper1(boolean displayGuideLines) {
  // Extend parallel pairs to the edge of the square
  float deltaX;
  float deltaY;
  float x1, y1, x2, y2, x3, y3, x4, y4;

  deltaX = saveIntersectionX[1] - saveIntersectionX[4];
  deltaY = saveIntersectionY[1] - saveIntersectionY[4];

  x1 = saveIntersectionX[4] - deltaX;
  y1 = saveIntersectionY[4] - deltaY;

  x2 = saveIntersectionX[1] + deltaX;
  y2 = saveIntersectionY[1] + deltaY;

  x3 = saveCircleX[9];
  y3 = saveCircleY[9];

  x4 = saveCircleX[11];
  y4 = saveCircleY[11];

  // calculate intersection points
  myLineline10 = new Lineline(10, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 2);
  myLineline10.displayIntersection();

  x3 = saveCircleX[11];
  y3 = saveCircleY[11];

  x4 = saveCircleX[13];
  y4 = saveCircleY[13];

  // calculate intersection points
  myLineline11 = new Lineline(11, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 2);
  myLineline11.displayIntersection();

  strokeWeight(1);
  // New Lower 1st Diagonal Pair
  if (displayGuideLines) {
    line(saveIntersectionX[10], saveIntersectionY[10], saveIntersectionX[11], saveIntersectionY[11]);
  }

  // mirror existing points to draw the other diagnoal pair 
  saveIntersectionX[12] = - saveIntersectionX[9];
  saveIntersectionY[12] =  saveIntersectionY[9];

  saveIntersectionX[13] = - saveIntersectionX[8];
  saveIntersectionY[13] =  saveIntersectionY[8];

  strokeWeight(1);
  // New Lower 2st Diagonal Pair
  // stroke(0, 0, 255); // blue
  if (displayGuideLines) {
    line(saveIntersectionX[12], saveIntersectionY[12], saveIntersectionX[13], saveIntersectionY[13]);
  }


  // mirror existing points to draw the other diagnoal pair 
  saveIntersectionX[14] = - saveIntersectionX[11];
  saveIntersectionY[14] =  saveIntersectionY[11];

  saveIntersectionX[15] = - saveIntersectionX[10];
  saveIntersectionY[15] =  saveIntersectionY[10];

  strokeWeight(1);
  // New Upper 2st Diagonal Pair
  // stroke(0, 0, 255); // blue
  if (displayGuideLines) {
    line(saveIntersectionX[14], saveIntersectionY[14], saveIntersectionX[15], saveIntersectionY[15]);
  }
}

void step4(boolean displayGuideLines) {
  strokeWeight(1);
  stroke(0); // black
  if (displayGuideLines) {
    line(saveIntersectionX[13], saveIntersectionY[13], saveCircleX[2], saveCircleY[2]);
    line(saveIntersectionX[8], saveIntersectionY[8], saveCircleX[2], saveCircleY[2]);
    line(saveIntersectionX[14], saveIntersectionY[14], saveCircleX[6], saveCircleY[6]);
    line(saveIntersectionX[11], saveIntersectionY[11], saveCircleX[6], saveCircleY[6]);

    line(saveIntersectionX[9], saveIntersectionY[9], saveCircleX[4], saveCircleY[4]);
    line(saveIntersectionX[15], saveIntersectionY[15], saveCircleX[4], saveCircleY[4]);
    line(saveIntersectionX[12], saveIntersectionY[12], saveCircleX[0], saveCircleY[0]);
    line(saveIntersectionX[15], saveIntersectionY[15], saveCircleX[4], saveCircleY[4]);
    line(saveIntersectionX[10], saveIntersectionY[10], saveCircleX[0], saveCircleY[0]);
  }
}


void step3Verticle(boolean displayGuideLines) {
  // Extend verticle parallel lines to the top and bottom of the square
  if (displayGuideLines) {
    line(saveIntersectionX[1], saveIntersectionY[10], saveIntersectionX[1], saveIntersectionY[12]);  // right
    line(saveIntersectionX[2], saveIntersectionY[10], saveIntersectionX[2], saveIntersectionY[12]);  // left
  }
}

void step3Horizontal(boolean displayGuideLines) {
  // Extend Horizontal parallel lines to the left and right of the square
  if (displayGuideLines) {
    line(saveIntersectionX[11], saveIntersectionY[3], saveIntersectionX[8], saveIntersectionY[3]);  // top
    line(saveIntersectionX[11], saveIntersectionY[4], saveIntersectionX[8], saveIntersectionY[4]);  // bottom
  }
}

void stepDesign5a(boolean displayDesign) {
  // locate center verticle design lines

  // locate intersection point for top of line 
  // calculate intersection points

  float x1, y1, x2, y2, x3, y3, x4, y4;

  x1 = saveCircleX[2];
  y1 = saveCircleY[2];

  x2 = saveCircleX[3];
  y2 = saveCircleY[3];

  x3 = saveIntersectionX[2];
  y3 = saveIntersectionY[10];

  x4 = saveIntersectionX[2];
  y4 = saveIntersectionY[12];

  myLineline16 = new Lineline(16, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 2);  // top of line
  myLineline16.displayIntersection();

  // bottom of line
  x1 = saveIntersectionX[1];
  y1 = saveIntersectionY[1];

  x2 = saveIntersectionX[4];
  y2 = saveIntersectionY[4];

  x3 = saveIntersectionX[2];
  y3 = saveIntersectionY[10];

  x4 = saveIntersectionX[2];
  y4 = saveIntersectionY[12];

  myLineline17 = new Lineline(17, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 2);  // bottom of line
  myLineline17.displayIntersection();

  if (displayDesign) {
    // stroke(0, 0, 255); // blue
    line(  saveIntersectionX[16], saveIntersectionY[16], saveIntersectionX[17], saveIntersectionY[17]);  // top left
    line(- saveIntersectionX[16], saveIntersectionY[16], -saveIntersectionX[17], saveIntersectionY[17]);  // top right

    line(  saveIntersectionX[16], - saveIntersectionY[16], saveIntersectionX[17], - saveIntersectionY[17]);  // bottom left
    line(- saveIntersectionX[16], - saveIntersectionY[16], -saveIntersectionX[17], - saveIntersectionY[17]);  // bottom right
  }
}

void stepDesign5b(boolean displayDesign) {

  // locate center horizontal design lines

  // locate intersection point for top left of line 
  // calculate intersection points

  float x1, y1, x2, y2, x3, y3, x4, y4;

  x1 = saveCircleX[3];
  y1 = saveCircleY[3];

  x2 = saveCircleX[4];
  y2 = saveCircleY[4];

  x3 = saveIntersectionX[13];
  y3 = saveIntersectionY[3];

  x4 = saveIntersectionX[10];
  y4 = saveIntersectionY[3];

  myLineline18 = new Lineline(18, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 2);  // top of line
  myLineline18.displayIntersection();

  // bottom of line
  x1 = saveIntersectionX[1];
  y1 = saveIntersectionY[1];

  x2 = saveIntersectionX[4];
  y2 = saveIntersectionY[4];

  x3 = saveIntersectionX[3];
  y3 = saveIntersectionY[3];

  x4 = saveIntersectionX[0];
  y4 = saveIntersectionY[0];

  myLineline19 = new Lineline(19, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 2);  // bottom of line
  myLineline19.displayIntersection();

  if (displayDesign) {
    // stroke(0, 0, 255); // blue
    line(  saveIntersectionX[18], saveIntersectionY[18], saveIntersectionX[19], saveIntersectionY[19]);  // left
    line(- saveIntersectionX[18], saveIntersectionY[18], -saveIntersectionX[19], saveIntersectionY[19]);  // right

    line(  saveIntersectionX[18], - saveIntersectionY[18], saveIntersectionX[19], - saveIntersectionY[19]);  // bottom left
    line(- saveIntersectionX[18], - saveIntersectionY[18], -saveIntersectionX[19], - saveIntersectionY[19]);  // bottom right
  }
}



void stepDesign5c(boolean displayDesign) {
  float x1, y1, x2, y2, x3, y3, x4, y4;

  x1 = saveCircleX[4];
  y1 = saveCircleY[4];

  x2 = saveCircleX[5];
  y2 = saveCircleY[5];

  x3 = saveIntersectionX[17];
  y3 = saveIntersectionY[17];

  x4 = saveIntersectionX[11];
  y4 = saveIntersectionY[11];

  myLineline19 = new Lineline(19, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 2);  // top of line
  myLineline19.displayIntersection();


  if (displayDesign) {
    // stroke(0, 0, 255); // blue
    line(  saveIntersectionX[17], saveIntersectionY[17], saveIntersectionX[19], saveIntersectionY[19]);  // left
    line(- saveIntersectionX[17], saveIntersectionY[17], -saveIntersectionX[19], saveIntersectionY[19]);  // right

    line(  saveIntersectionX[17], - saveIntersectionY[17], saveIntersectionX[19], - saveIntersectionY[19]);  // bottom left
    line(- saveIntersectionX[17], - saveIntersectionY[17], -saveIntersectionX[19], - saveIntersectionY[19]);  // bottom right
  }
}

void stepDesign5d(boolean displayDesign) {
  float x1, y1, x2, y2, x3, y3, x4, y4;

  x1 = saveIntersectionX[3];
  y1 = saveIntersectionY[3];

  x2 = saveIntersectionX[0];
  y2 = saveIntersectionY[0];

  x3 = saveIntersectionX[17];
  y3 = saveIntersectionY[17];

  x4 = saveIntersectionX[1];
  y4 = saveIntersectionY[1];

  myLineline20 = new Lineline(20, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 2);  // top of line
  myLineline20.displayIntersection();

  x1 = saveIntersectionX[10];
  y1 = saveIntersectionY[10];

  x2 = saveIntersectionX[11];
  y2 = saveIntersectionY[11];

  x3 = saveCircleX[1];
  y3 = saveCircleY[1];

  x4 = saveCircleX[2];
  y4 = saveCircleY[2];

  myLineline21 = new Lineline(21, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 2);  // top of line
  myLineline21.displayIntersection();

  if (displayDesign) {
    // stroke(0, 0, 255); // blue
    //line(saveIntersectionX[17], saveIntersectionY[17], saveIntersectionX[19], saveIntersectionY[19]);

    line(  saveIntersectionX[20], saveIntersectionY[20], saveIntersectionX[21], saveIntersectionY[21]);  // left
    line(- saveIntersectionX[20], saveIntersectionY[20], -saveIntersectionX[21], saveIntersectionY[21]);  // right

    line(  saveIntersectionX[20], - saveIntersectionY[20], saveIntersectionX[21], - saveIntersectionY[21]);  // bottom left
    line(- saveIntersectionX[20], - saveIntersectionY[20], -saveIntersectionX[21], - saveIntersectionY[21]);  // bottom right
  }
}

void stepDesign6a(boolean displayDesign) {
  float x1, y1, x2, y2, x3, y3, x4, y4;

  x1 = saveIntersectionX[15];
  y1 = saveIntersectionY[15];

  x2 = saveIntersectionX[18];
  y2 = saveIntersectionY[18];

  x3 = saveIntersectionX[12];
  y3 = saveIntersectionY[12];

  x4 = saveIntersectionX[13];
  y4 = saveIntersectionY[13];

  myLineline21 = new Lineline(21, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 2);  // top of line
  myLineline21.displayIntersection();

  if (displayDesign) {
    // stroke(0, 0, 255); // blue
    //line(saveIntersectionX[17], saveIntersectionY[17], saveIntersectionX[19], saveIntersectionY[19]);

    line(  saveIntersectionX[21], saveIntersectionY[21], saveIntersectionX[15], saveIntersectionY[15]);  // 
    line(- saveIntersectionX[21], saveIntersectionY[21], -saveIntersectionX[15], saveIntersectionY[15]);  // 

    line(  saveIntersectionX[21], - saveIntersectionY[21], saveIntersectionX[15], - saveIntersectionY[15]);  //  
    line(- saveIntersectionX[21], - saveIntersectionY[21], -saveIntersectionX[15], - saveIntersectionY[15]);  //
  }
}

void stepDesign6b(boolean displayDesign) {
  float x1, y1, x2, y2, x3, y3, x4, y4;

  x1 = saveIntersectionX[13];
  y1 = saveIntersectionY[13];

  x2 = saveIntersectionX[16];
  y2 = saveIntersectionY[16];

  x3 = saveIntersectionX[15];
  y3 = saveIntersectionY[15];

  x4 = saveIntersectionX[14];
  y4 = saveIntersectionY[14];

  myLineline22 = new Lineline(22, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 2);  // top of line
  myLineline22.displayIntersection();

  if (displayDesign) {
    // stroke(0, 0, 255); // blue
    //line(saveIntersectionX[17], saveIntersectionY[17], saveIntersectionX[19], saveIntersectionY[19]);

    line(  saveIntersectionX[13], saveIntersectionY[13], saveIntersectionX[22], saveIntersectionY[22]);  // 
    line(- saveIntersectionX[13], saveIntersectionY[13], -saveIntersectionX[22], saveIntersectionY[22]);  // 

    line(  saveIntersectionX[13], - saveIntersectionY[13], saveIntersectionX[22], - saveIntersectionY[22]);  //  
    line(- saveIntersectionX[13], - saveIntersectionY[13], -saveIntersectionX[22], - saveIntersectionY[22]);  //
  }
}

void stepDesign7a(boolean displayDesign) {

  if (displayDesign) {
    // stroke(255, 0, 0); // red
    line(  saveCircleX[4], saveCircleY[4], saveIntersectionX[18], saveIntersectionY[18]);  // 
    line(- saveCircleX[4], saveCircleY[4], -saveIntersectionX[18], saveIntersectionY[18]);  // 

    line(  saveCircleX[4], - saveCircleY[4], saveIntersectionX[18], - saveIntersectionY[18]);  //  
    line(- saveCircleX[4], - saveCircleY[4], -saveIntersectionX[18], - saveIntersectionY[18]);  //
  }
}


void stepDesign7b(boolean displayDesign) {

  if (displayDesign) {
    // stroke(255, 0, 0); // red
    line(  saveCircleX[2], saveCircleY[2], saveIntersectionX[16], saveIntersectionY[16]);  // 
    line(- saveCircleX[2], saveCircleY[2], -saveIntersectionX[16], saveIntersectionY[16]);  // 

    line(  saveCircleX[2], - saveCircleY[2], saveIntersectionX[16], - saveIntersectionY[16]);  //  
    line(- saveCircleX[2], - saveCircleY[2], -saveIntersectionX[16], - saveIntersectionY[16]);  //
  }
}

void numberCircles() {
  textSize(32);
  fill(0);
  for (int i = 0; i < 17; i = i+1) {
    text(i, saveCircleX[i], saveCircleY[i]);
  }
  noFill();
}



void numberIntersections() {
  textSize(32);
  fill(255, 0, 0);
  for (int i = 0; i < 23; i = i+1) {
    text(i, saveIntersectionX[i], saveIntersectionY[i]);
  }
  noFill();
}



void showTestPoint() {

  println("i = " + i);
  circle(saveIntersectionX[i], saveIntersectionY[i], 25);
  noFill();
}


void mousePressed() {
  if (mouseButton == LEFT) {
    i = i + 1;
  }
}
