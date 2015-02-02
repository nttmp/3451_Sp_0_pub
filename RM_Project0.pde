//Ryan Mendes
//CS 3451 Spring 2015
//Project 1: Linear Fractals

//TODO: Fix the recursive vPowerSeries function

import java.util.List;
  
//Gloabl variables
color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);
color black = color(0, 0, 0);

Coord v;
int currPow;
ArrayList<Coord> seriesList;
//This dictates at which power to terminate calculation of the infinite series. Default = 9. Soft max at 16.
int seriesLength = 9;
//Stuff for getting output to a file
boolean seriesTest = false;
PrintWriter output;

void setup() {
  //Set the size of the window
  size(600, 600);
  if (seriesTest)
    output = createWriter("vValues.txt");
}

void draw() {
  background(255, 255, 255); //Refresh the screen
//  coordTesting(); //Testing

  if (seriesTest) {
    v = new Coord(.367f, .254f);
    output.println("Value of v is: (" + v.real +", " + v.imag + ")");
  }
  else {
    v = new Coord((mouseX/100.0f)-3, ((mouseY/100.0f)-3)*-1);
    println("v: (" + v.real + ", " + v.imag + ")");
    println("mouse: "+ mouseX + ", " + mouseY);
  }
  
  currPow = 0;
  seriesList = new ArrayList<Coord>();
  seriesList.add(new Coord(0.0f, 0.0f));
  
//  seriesList = vPowerSeries(v, seriesList, 0, 10); //Recursive
  seriesList = vPowerSeries(v, seriesList, seriesLength); //Iterative
  println(seriesList.size());
  
  drawAllPoints(seriesList);
  seriesTest = false; 
}


void drawAllPoints(ArrayList<Coord> l) {
  for (final Coord currCoord : l) {
    noStroke();
//    fill(red);
//    currCoord.drawCoordAdjust(10.0f);
    currCoord.drawCoordAdjustVarColor(10.0f);
    if (seriesTest)
      output.println("(" + currCoord.real + ", " + currCoord.imag + ")");
//    currCoord.showCoordinates();
//    noFill();
  }
  if (seriesTest) {
    output.flush();
    output.close();      
  }
}

//Compute the power series for v up to the specified limit. *Pass in 0 for pow to start the series.
//Recursive *BUGGED
ArrayList<Coord> vPowerSeries(Coord coordV, ArrayList<Coord> l, int pow, int powLimit) {
  ArrayList<Coord> tempList = new ArrayList<Coord>();
  //Get v raised to the current power, and a version with negative components
  Coord vPow = coordV.powCoord(pow);
  Coord vPowNeg = new Coord((-1*vPow.real), (-1*vPow.imag));
  for (final Coord currCoord : l) { //For every item in l...
    tempList.add(currCoord.addCoords(vPow));
    tempList.add(currCoord.addCoords(vPowNeg));
  }
  if (pow == powLimit) {
    return tempList;
  }
  else {
    l.addAll(vPowerSeries(coordV, tempList, pow + 1, powLimit));
    return l;    
  }
}

//Iterative
ArrayList<Coord> vPowerSeries(Coord coordV, ArrayList<Coord> origList, int powLimit) {
  for (int pow = 0; pow < powLimit; pow++){
    //Get v raised to the current power, and a version with negative components
    Coord vPow = coordV.powCoord(pow);
    Coord vPowNeg = new Coord((-1*vPow.real), (-1*vPow.imag));
    ArrayList<Coord> tempList = new ArrayList<Coord>();
    for(int i = (int)(Math.pow(2, pow)-1); i < origList.size(); i++) {
      tempList.add(origList.get(i).addCoords(vPow));
      tempList.add(origList.get(i).addCoords(vPowNeg));
    }
    origList.addAll(tempList);
  }
  return origList;
}

//Testing method
void coordTesting() {
  
  Coord test = new Coord(0, 0);
  Coord test2 = new Coord(300, 300);
  Coord test3 = new Coord(123, 245);
  Coord test4;
  Coord test5 = new Coord(5, 10);
  Coord test6 = new Coord(20, 40);
  Coord test7;
  Coord test8 = new Coord(3, 7);
  Coord test9;
  
  stroke(red);
  fill(red);
  test.drawCoord();
  test2.drawCoord();
  
  stroke(blue);
  fill(blue);
  test3.drawCoord();
  test4 = test2.addCoords(test3);
  test4.drawCoord();
  
  stroke(green);
  fill(green);
  test5.drawCoord();
  test6.drawCoord();
  test7 = test5.multCoords(test6);
  test7.drawCoord();
  //println("test7 coordinates: " + test7.real + ", " + test7.imag);
  
  test9 = test8.powCoord(2);
  println("(" + test9.real + ", " + test9.imag +")");
  test9 = test8.powCoord(3);
  println("(" + test9.real + ", " + test9.imag +")");
  test9 = test8.powCoord(4);
  println("(" + test9.real + ", " + test9.imag +")");  
  noStroke();
  noFill();
  
  stroke(black);
  test.showCoordinates();
  test2.showCoordinates();
  test3.showCoordinates();
  test4.showCoordinates();
  test5.showCoordinates();
  test6.showCoordinates();
  test7.showCoordinates();
  noStroke();
}
