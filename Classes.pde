//TO DO: make this class with double instead of float????????
//TO DO: make the powCoord method account for negative powers

//For representing complex numbers in a standard coordinate plane
class Coord {
  
  //real and imaginary components
  float real;
  float imag;
  
  Coord(float r, float i) {
    real = r;
    imag = i; 
  }
  
  //Draw a coordinate with a default size of 10
  void drawCoord() {
    ellipse(real, imag, 10, 10); 
  }
  
  //Draw a coordinate with a passed in size
  void drawCoord(float size) {
    ellipse(real, imag, size, size);
  }
  
  //Draw a coordinate with an adjust range pertaining to the screen size
  void drawCoordAdjust(float size) {
    ellipse(real*100+300, (imag*(-100)+300), size, size);
  }
  
  //Same as above with variable color
  void drawCoordAdjustVarColor(float size) {
//    fill(real*51+3, imag*51+3, (real*imag)*51+3);
//    fill(real*51-3, imag*51-3, (real*imag)*51-3);
//    fill(real*(-51)+252, imag*(-51)+252, (real*imag)*(-51)+252);
    fill(real*(-51)+175, imag*(-51)+175, (real*imag)*(-51)+175);
    ellipse(real*100+300, (imag*(-100)+300), size, size);
    noFill();
  }
  
//  //Draw a coordinate by passing in a Coord object and size
//  void drawCoord(Coord c, float size) {
//    ellipse(c.real, c.imag, size, size);
//  }
//  
//  //Draw a coordinate by passing in the components
//  void drawCoord(float r, float i, float size) {
//    ellipse(r, i, size, size);
//  }
  
 //Display a Coord's screen coordinates
 void showCoordinates() {
   String coordinates = "(" + this.real + ", " + this.imag + ")";
   text(coordinates, this.real + 5, this.imag - 5);
 } 
  
  //Add two complex numbers together
  Coord addCoords(Coord b) {
    return new Coord((this.real + b.real), (this.imag + b.imag));
  }
  
  //Multiply two complex numbers. Ex: (a+bi)^2 = (a^2 - b^2) + 2abi | (a+bi)(c+di) = (ac-bd) + (ad+bc)i
  Coord multCoords(Coord b) {
    float newReal = (this.real * b.real) - (this.imag * b.imag);
    float newImag = (this.real * b.imag) + (this.imag * b.real);
    return new Coord(newReal, newImag);
  }
  
  //Raise a complex number to the specified power.
  Coord powCoord(int pow) {
    if (pow == 0)
      return new Coord(1.0f, 0.0f);
    Coord newCoord = new Coord(this.real, this.imag);
    for(int i = 1; i < pow; i++) {
      newCoord = newCoord.multCoords(this);
    }   
    return newCoord;
  }
  
}
