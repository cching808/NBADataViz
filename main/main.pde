import java.util.Vector; //imports vector utility

float xPos = 200;
float yPos = 200;
float sliderPos;

// horizontal positions
float xR, xG, xB; 
// horizontal speeds
float speedX, speedY, speedSlider;

// The system time for this and the previous frame (in milliseconds)
int currTime, prevTime;

// The elapsed time since the last frame (in seconds)
float deltaTime;

int count = 0;
Table chosenGame;
Table games;
Table game2;
Table game3;

HScrollbar hs1, hs2;  // Two scrollbars
PImage bg;

void setup()
{
  size(653,401);
  bg = loadImage("../ownData/homepage.jpg");

  //size (600, 600); 
  //noStroke();
  //hs1 = new HScrollbar(0, height/2+150, width/2, 16, 16);
  //sliderPos = mouseX;
  ////hs2 = new HScrollbar(0, height/2+133, width/2, 16, 16);

  //xR = 0;
  //xG = 0;
  //xB = 0;
  //speedX = 5;
  //speedY = 5;
  //speedSlider = 60;
  //smooth();
  //noStroke();

  //// Initialise the timer
  //currTime = prevTime = millis();

  //fill(0, 255, 0);
  //basketballCourt();
  colorSetup() ;
  interfaceSetup() ;
  dropdownSetup() ;
}

void draw() {
  
  //background(0) ;
  

  background(bg);
  dropdownDraw() ;
  //display result
  fill(blanc) ;
  if (dropdown.getSelection() > -1 ) text("Exemple " +  ( dropdown.getSelection() +1), 32, 20 ) ;
  
  //background(255);
  //basketballCourt();
  //noStroke();
  //fill(0, 255, 0);


  //// get the current time
  //currTime = millis();
  //// calculate the elapsed time in seconds
  //deltaTime = (currTime - prevTime)/1000.0;
  //// rember current time for the next frame
  //prevTime = currTime;


  //ellipse(xPos + (speedX * deltaTime) + 200, yPos + (speedY * deltaTime) + 200, 5, 5);
  //if ((count < chosenGame.getRowCount()) && (Integer.parseInt(chosenGame.getString(count, 2)) != 0)) {
  //  xPos = Float.parseFloat(chosenGame.getString(count, 3));
  //  yPos = Float.parseFloat(chosenGame.getString(count, 4)); 
  //  count += 1;
  //}

  //hs1.update();
  ////hs2.update();
  //hs1.display();
  //hs2.display();

  //stroke(0);
  //line(0, height/2 + 141, width/2, height/2 + 141);
}

void mousePressed()
{
  dropdownMousepressed() ;
}
 
//GLOBAL
Dropdown dropdown;
PVector posDropdown, posTextDropdown, sizeDropdown ;
int startingDropdown, endingDropdown ;
// the first element is title of dropdown
 String[] listDropdown = {"Dropdown","Exemple 1","Exemple 2","Exemple 3","Exemple 4","Exemple 5", "Exemple 6", "Exemple 7", "Exemple 8", "Exemple 9", "Exemple 10"} ;
//String[] listDropdown = {"Dropdown","Exemple 1","Exemple 2","Exemple 3","Exemple 4" } ;
//SETUP
void dropdownSetup() {
  
  posDropdown = new PVector ( 270,30, 1.1 ) ; // Starting position of the Dropdown and margin between the box ( x,y, margin) ;
  posTextDropdown = new PVector ( 5, 11 ) ;
  sizeDropdown = new PVector ( 100, 15, 4 ) ; // (widthBox, heightBox, number of line(step) )
  dropdown = new Dropdown(listDropdown, posDropdown, sizeDropdown, posTextDropdown, colorBG, colorBoxIn, colorBoxOut, colorBoxText) ;
}
 
//DRAW
void dropdownDraw()
{
  dropdown.dropdownUpdate(interfaceFont, 10); //(font, fontsize)
  //to display the dropdown only if the mouse is in the area of this one
  float margeAround = sizeDropdown.y  ;
  PVector totalSizeDropdown = new PVector ( sizeDropdown.x + (margeAround *1.5) , sizeDropdown.y * (sizeDropdown.z +1)  + margeAround   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  PVector newPosDropdown = new PVector ( posDropdown.x - margeAround  , posDropdown.y ) ;
  if ( !insideRect(newPosDropdown, totalSizeDropdown) ) dropdown.locked = false;
}
 
//MOUSEPRESSED
void dropdownMousepressed() {
  if (dropdown != null) {
    if (insideRect(posDropdown, sizeDropdown) && !dropdown.locked  ) {
      dropdown.locked = true;
    } else if (dropdown.locked) {
      int line = dropdown.selectDropdownLine();
      if (line > -1 ) {
        dropdown.whichDropdownLine(line);
        //to close the dropdown
        dropdown.locked = false;       
      }
    }
  }
}
 
//GLOBAL
PFont DinRegular10 ;
color rouge, blanc, noir, gris ;
 
//SETUP
void colorSetup()
{
  colorMode(HSB, 360, 100, 100 );
  rouge = color ( 10, 100,100 ) ;
  noir = color (0,0, 0 ) ;
  blanc = color (0,0,100) ;
  gris = color ( 0, 0,50 ) ;
}
//GLOBAL
PFont interfaceFont ;
color colorBoxIn, colorBoxOut, colorBoxText, colorBG ;
 
//SETUP
void interfaceSetup()
{
  colorBoxIn = rouge ;
  colorBoxOut = gris ;
  colorBoxText = blanc ;
  colorBG = blanc ;
  //POLICE
  DinRegular10= loadFont ("data/AmericanTypewriter-Condensed-48.vlw");
  interfaceFont = DinRegular10 ;
}
 
// CLASS
public class Dropdown {
  //Slider dropdown
  Slider sliderDropdown ;
  private PVector posSliderDropdown, sizeSliderDropdown, posMoletteDropdown, sizeMoletteDropdown ;
  //dropdown
  private int line = -1;
  private String [] listItem ;
  private boolean locked, slider ;
  private final color colorBG, boxIn, boxOut, colorText ;
  private PVector pos, size, posText;
  private float factorPos  ; // use to calculate the margin between the box
  private int startingDropdown = 1 ;
  private int endingDropdown = 1 ;
  private int updateDropdown = 0 ; //for the slider update
  private float missing ;
 
  //CONSTRUCTOR
  public Dropdown(String [] listItem, PVector pos, PVector size, PVector posText, color colorBG, color boxIn, color boxOut, color colorText ) {
    //dropdown
    this.listItem = listItem;
    this.pos = pos;
    this.posText = posText ;
    this.size = size;
    this.colorBG = colorBG ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;
    this.colorText = colorText ;
    endingDropdown = int(size.z + 1) ;
    // security if the size of dropdown is superior of the item list
    if (endingDropdown > listItem.length ) endingDropdown = listItem.length ;
    // difference betweel the total list item and what is possible to display
    missing = listItem.length - endingDropdown  ;
     
     
    //slider dropdown
    //condition to display the slider
    if ( listItem.length > endingDropdown  ) slider = true ; else slider = false ;
     
    if (slider) {
      sizeSliderDropdown = new PVector (  size.y / 2.0, ((endingDropdown -1) * size.y ) -pos.z) ;
      posSliderDropdown = new PVector( pos.x - sizeSliderDropdown.x - (pos.z *2.0) , pos.y + size.y + (1.8 *pos.z) ) ;
      posMoletteDropdown = posSliderDropdown ;
       
      float factorSizeMolette = float(listItem.length) / float(endingDropdown -1 ) ;
   
       
      sizeMoletteDropdown =  new PVector ( sizeSliderDropdown.x, sizeSliderDropdown.y / factorSizeMolette) ;
      sliderDropdown = new Slider(posSliderDropdown, posMoletteDropdown, sizeSliderDropdown, sizeMoletteDropdown, colorBG, boxIn, boxOut ) ;
      sliderDropdown.sliderSetting() ;
    }
  }
   
  //DRAW
  void dropdownUpdate(PFont p, int s) {
    //to be sure of the position
    rectMode(CORNER);
     
    //Dropdown
    if (locked) {
      renderBox(listItem[0] ,1, p, s);
      //give the position of dropdown
      int step = 2 ;
      //give the position in list of Item with the position from the slider's molette
      if (slider) updateDropdown = round(map (sliderDropdown.getValue(), 0,1, 0, missing)) ;
       
      //loop to display the item list
      for ( int i = startingDropdown + updateDropdown ; i < endingDropdown + updateDropdown ; i++) {
        renderBox(listItem[i] , step++, p, s);
        //Slider dropdown
        if (slider) {
          sliderDropdown.sliderUpdate() ;
          fill(colorBG) ;
          rect ( posMoletteDropdown.x, pos.y, sizeMoletteDropdown.x, size.y ) ;
        }
      }
    } else {
      renderBox(listItem[0],1, p, s);
    }
  }
 
 
  //DISPLAY
  public void renderBox(String label, int step, PFont p, int s) {
    //
    noStroke() ;
    factorPos = step + pos.z ;
     
    //a travailler pour distribuer les boxs
    //factorPos = step + (step *pos.z) ;
     
    float yLevel = step == 1 ? pos.y  : (size.y * (factorPos ));
     
    PVector newPosDropdown = new PVector (pos.x, yLevel  ) ;
    if (insideRect(newPosDropdown, sizeDropdown)) {
      fill(boxIn);
    } else {
      fill(boxOut ) ;
    }
     
    rect(pos.x, yLevel , size.x, size.y );
     
    fill(colorText);
    textFont(p);
    textSize(s) ;
    text(label, pos.x +posText.x , yLevel +posText.y );
 
  }
   
  //RETURN
  //Check the dropdown when this one is open
  public int selectDropdownLine() {
    if(mouseX >= pos.x && mouseX <= pos.x + size.x && mouseY >= pos.y && mouseY <= (listItem.length *size.y) +pos.y ) {
      //choice the line
      int line = floor( (mouseY - (pos.y +size.y )) / size.y ) + updateDropdown;
      return line;
    } else {
      return -1;
    }
  }
  //return which line is selected
  public void whichDropdownLine(int l ) {
    line = l ;
  }
  //return which line of dropdown is selected
  public int getSelection() {
    return line ;
  }
}
 
class Slider
{
  private PVector pos, size, posText, posMol, sizeMol, newPosMol, posMin, posMax ;
  private color slider, boxIn, boxOut, colorText ;
  private boolean molLocked ;
  private PFont p ;
   
  //CONSTRUCTOR with title
  public Slider(PVector pos, PVector posMol , PVector size, PVector posText, color slider, color boxIn, color boxOut, color colorText, PFont p)
  {
    this.pos = pos ;
    this.posMol = posMol ;
    this.size = size ;
    this.posText = posText ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;
    this.colorText = colorText ;
    this.p = p ;
 
    newPosMol = new PVector (0, 0) ;
    //which molette for slider horizontal or vertical
    if ( size.x >= size.y ) sizeMol = new PVector (size.y, size.y ) ; else sizeMol = new PVector (size.x, size.x ) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
   
  //CONSTRUCTOR minimum
  public Slider(PVector pos, PVector posMol , PVector size,  color slider, color boxIn, color boxOut )
  {
    this.pos = pos ;
    this.posMol = posMol ;
    this.size = size ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;
 
    newPosMol = new PVector (0, 0) ;
    //which molette for slider horizontal or vertical
    if ( size.x >= size.y ) sizeMol = new PVector (size.y, size.y ) ; else sizeMol = new PVector (size.x, size.x ) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
   
   
  //slider with external molette
  public Slider(PVector pos, PVector posMol , PVector size, PVector sizeMol,  color slider, color boxIn, color boxOut )
  {
    this.pos = pos ;
    this.posMol = posMol ;
    this.sizeMol = sizeMol ;
    this.size = size ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;
 
    newPosMol = new PVector (0, 0) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
   
  //SETTING
  void sliderSetting()
  {
    noStroke() ;
     
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
     
    //MOLETTE
    fill(boxOut) ;
    newPosMol = new PVector (posMol.x, posMol.y  ) ;
    rect(posMol.x, posMol.y, sizeMol.x, sizeMol.y ) ;
     
  }
   
  //Slider update with title
  void sliderUpdate(String s, boolean t)
  {
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    if (t) {
      fill(colorText) ;
      textFont (p ) ;
      textSize (posText.z) ;
      text(s, posText.x, posText.y ) ;
    }
    //MOLETTE
    if (insideRect(newPosMol, sizeMol)) fill(boxIn); else fill(boxOut ) ;
    moletteUpdate() ;
    rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
  }
  //Slider update simple
  void sliderUpdate()
  {
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    //MOLETTE
    if (insideRect(newPosMol, sizeMol)) fill(boxIn); else fill(boxOut ) ;
    moletteUpdate() ;
    rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
  }
   
  void moletteUpdate()
  {
    if (locked (insideRect(newPosMol, sizeMol) )  ) molLocked = true ;
    if (!mousePressed)  molLocked = false ;
       
    if ( molLocked ) { 
      if ( size.x >= size.y ) newPosMol.x = constrain(mouseX -(sizeMol.x / 2.0 ), posMin.x, posMax.x)  ; else newPosMol.y = constrain(mouseY -(sizeMol.y / 2.0 ), posMin.y, posMax.y) ;
    }
  }
   
  //RETURN
  float getValue()
  {
    float value ;
    if ( size.x >= size.y ) value = map (newPosMol.x, posMin.x, posMax.x, 0,1) ; else value = map (newPosMol.y, posMin.y, posMax.y, 0,1) ;
    return value ;
  }
}
//UTIL
 
//INSIDE
//CIRLCLE
boolean insideCircle (PVector pos, int diam)
{
  if (dist(pos.x, pos.y, mouseX, mouseY) < diam) return true  ; else return false ;
}
 
//RECTANGLE
boolean insideRect(PVector pos, PVector size) {
    if(mouseX > pos.x && mouseX < pos.x + size.x && mouseY >  pos.y && mouseY < pos.y + size.y) return true ; else return false ;
}
 
//LOCKED
boolean locked ( boolean inside )
{
  if ( inside  && mousePressed ) return true ; else return false ;
}
 
 
 
 
//EQUATION
float perimeterCircle ( float r )
{
  //calcul du perimetre
  float p = r*TWO_PI  ;
  return p ;
}
 
//EQUATION
float radiusSurface(int s)
{
  // calcul du rayon par rapport au nombre de point
  float  r = sqrt(s/PI) ;
  return r ;
}
 
color colorW ;
//ROLLOVER TEXT ON BACKGROUNG CHANGE
color colorWrite(color colorRef, int threshold, color clear, color deep)
{
  if( brightness( colorRef ) < threshold ) {
    colorW = color(clear) ;
  } else {
    colorW = color(deep) ;
  }
  return colorW ;
}
 
 
//TIME
int minClock()
{
  return hour()*60 + minute() ;
}

void basketballCourt() {
  fill(0);
  rect (50, 150, 400, 225);
  arc (435, 263, 190, 190, HALF_PI, PI+HALF_PI);
  arc (65, 263, 190, 190, radians(270), radians(450));
  fill (12, 129, 200);
  ellipse (246, 256, 50, 50);
  line (246, 150, 246, 375);
  fill (12, 129, 200);
  rect (50, 238, 75, 50);
  rect (375, 238, 75, 50);
  fill (0);
  ellipse (57, 263, 10, 10);
  ellipse (443, 263, 10, 10);
  rect (52, 135, 10, 10);
  rect (65, 135, 10, 10);
  rect (78, 135, 10, 10);
  rect (91, 135, 10, 10);
  rect (104, 135, 10, 10);
  rect (214, 126, 65, 20);
  rect (438, 135, 10, 10);
  rect (425, 135, 10, 10);
  rect (412, 135, 10, 10);
  rect (399, 135, 10, 10);
  rect (386, 135, 10, 10);
  fill (255);
  arc (375, 263, 50, 50, HALF_PI, PI+HALF_PI);
  arc (125, 263, 50, 50, radians(270), radians(450));
}

Table readFile(String fileName) {
  Table table = loadTable(fileName, "csv");

  for (int i = 0; i < table.getRowCount(); i++) {
    //println(table.getString(i, 3));
    //println(Float.parseFloat(table.getString(i, 3)));
  }
  return table;
}

class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      if(chosenGame == game2) {
       fill(150);
       stroke(150);
       chosenGame = game3; 
      }
      else {
        fill(200, 120, 33);
        chosenGame = game2;
      }
      locked = true;
    }
    else {
     if(chosenGame == game2) {
        fill(255);
        stroke(255);
        chosenGame = games; 
      }
      else {
        fill(200, 120, 33);
        stroke(120);
        chosenGame = game2;
      } 
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > spos) {
      println("Inside mouseX > spos");
      println("spos: " + spos);
      println("mouseX: " + mouseX);
      println();
      return true;
    } else {
      println("inside mouseX < sliderPos");
      println("spos: " + spos);
      println("mouseX: " + mouseX);
      println();
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}