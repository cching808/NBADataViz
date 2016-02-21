import de.bezier.guido.*;
import java.util.Vector; //imports vector utility


// Global
int rectX, rectY;      // Position of square button
int backX, backY;
boolean rectOver = false;
boolean backOver = false;
boolean animationPage = false;
boolean homePage = true;
int rectSize = 35;     // Diameter of rect
int backSize;

color rectColor, baseColor, rectHighlight;
color currentColor;

int count = 0;
Table chosenGame;
Table games;
Table teams;
Table players;
Table event;
Table currentEvent;

PImage bg;
PImage court;
PImage backButton;

Dropdown dropdown;
Dropdown dropdownEventId;
PVector posDropdown, posTextDropdown, sizeDropdown ;

int startingDropdown, endingDropdown ;

PVector posDropdownEventId, posTextDropdownEventId, sizeDropdownEventId ;
int startingDropdownEventId, endingDropdownEventId ;
// the first element is title of dropdown

String gameFolder;
String selectedEvent;
String pathToEvent;
String baseDirectory = "/Users/coreyching/Documents/Davis/Classes/ECS163/HW2/data/";
String[] gameDirectories = {"nba1/", "nba2/", "nba3/", "nba4/"} ;
String[] listDropdown;

PVector[] colors = new PVector[2];

float xMax, yMax;
float xMin, yMin;

float xCoord;
float yCoord;
int colorId = 0;
int j = 0;

Listbox listbox;
Object lastItemClicked;
// the slider is a global variable
SliderCourt sliderOnCourt;

void setup()
{
  size(653,401);
  bg = loadImage("./data2/homepage.jpg");
  court = loadImage("./data2/courtResized.png");
  backButton = loadImage("./data2/back.png");
  
  backSize = (int) sqrt(backButton.width * backButton.height);

  rectColor = color(0);
  baseColor = color(102);
  currentColor = baseColor;
  rectX = width/2-rectSize-76;
  rectY = height - rectSize - 10;
  
  backX = 5;
  backY = 5;
  
  // make the manager
   Interactive.make( this );
  smooth();
  
  games = readFile("/Users/coreyching/Documents/Davis/Classes/ECS163/HW2/data/nba1/games.csv");
  teams = readFile("/Users/coreyching/Documents/Davis/Classes/ECS163/HW2/data/nba1/team.csv");
  players = readFile("/Users/coreyching/Documents/Davis/Classes/ECS163/HW2/data/nba1/players.csv");
  listDropdown = new String[games.getRowCount()];

  playerColorsSetup();
  eventIdListDropdownSetup();
  createListDropdownGame();
  colorSetup() ;
  interfaceSetup() ;
  dropdownSetup() ;
}

void draw() {
  
  if(homePage == true) {
    backOver = false;
    background(bg);
    dropdownDraw() ;
    //display result
    fill(blanc) ;
    if(dropdown.getSelection() != 0) {
      showPlayButton();
      createListDropdownEvent();
      fill(30, 27, 24);
      text("Game ID Selected: " + dropdown.getSelectionValue(), 183, 20 ) ;
    }
    
    if ( lastItemClicked != null )
    {
        fill( 30, 27, 24);
        text( "Event ID Selected: " + lastItemClicked.toString(), 335, 20 );
    }
  }
  else if(animationPage == true) {
    rectOver = false;   
    background(court);
    createBackButton();
    count = 0;
    
    if(j < event.getRowCount()) {
      
        j = j + 1;
        //for(int k = j; ((k < (j + 11)) && (k < (event.getRowCount()))); k++) {
        if(Float.parseFloat(event.getString(j,2)) != -1) {
          xCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j,3)), xMin, xMax, (float)width - 10, (float) 10); 
          yCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j,4)), yMin, yMax, (float)height - 10, (float) 10);
          colorId = 0;
          fill(colors[colorId].x, colors[colorId].y, colors[colorId].z);
          ellipse(xCoord, yCoord, 10, 10);
          
           if(j < event.getRowCount()) {
            xCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+1,3)), xMin, xMax, (float)width - 10, (float) 10); 
            yCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+1,4)), yMin, yMax, (float)height - 10, (float) 10);
            fill(colors[colorId].x, colors[colorId].y, colors[colorId].z);
            ellipse(xCoord, yCoord, 10, 10);
           }
           if(j < event.getRowCount()) {
            xCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+2,3)), xMin, xMax, (float)width - 10, (float) 10); 
            yCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+2,4)), yMin, yMax, (float)height - 10, (float) 10);
            fill(colors[colorId].x, colors[colorId].y, colors[colorId].z);
            ellipse(xCoord, yCoord, 10, 10);
           }
           if(j < event.getRowCount()) {
            xCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+3,3)), xMin, xMax, (float)width - 10, (float) 10); 
            yCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+3,4)), yMin, yMax, (float)height - 10, (float) 10);   
            fill(colors[colorId].x, colors[colorId].y, colors[colorId].z);
            ellipse(xCoord, yCoord, 10, 10);
           }
          
            if(j < event.getRowCount()) {
              xCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+4,3)), xMin, xMax, (float)width - 10, (float) 10); 
              yCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+4,4)), yMin, yMax, (float)height - 10, (float) 10);   
              fill(colors[colorId].x, colors[colorId].y, colors[colorId].z);
              ellipse(xCoord, yCoord, 10, 10);
            }
          
          if(j < event.getRowCount()) { 
            colorId = 1;
            xCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+5,3)), xMin, xMax, (float)width - 10, (float) 10); 
            yCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+5,4)), yMin, yMax, (float)height - 10, (float) 10);
            fill(colors[colorId].x, colors[colorId].y, colors[colorId].z);
            ellipse(xCoord, yCoord, 10, 10);
          }
          
           if(j < event.getRowCount()) {
            xCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+6,3)), xMin, xMax, (float)width - 10, (float) 10); 
            yCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+6,4)), yMin, yMax, (float)height - 10, (float) 10);   
            fill(colors[colorId].x, colors[colorId].y, colors[colorId].z);
            ellipse(xCoord, yCoord, 10, 10);
           }
          
           if(j < event.getRowCount()) {
            xCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+7,3)), xMin, xMax, (float)width - 10, (float) 10); 
            yCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+7,4)), yMin, yMax, (float)height - 10, (float) 10);  
            fill(colors[colorId].x, colors[colorId].y, colors[colorId].z);
            ellipse(xCoord, yCoord, 10, 10);
           }
          if(j < event.getRowCount()) {
            xCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+8,3)), xMin, xMax, (float)width - 10, (float) 10); 
            yCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+8,4)), yMin, yMax, (float)height - 10, (float) 10); 
            fill(colors[colorId].x, colors[colorId].y, colors[colorId].z);
            ellipse(xCoord, yCoord, 10, 10);
          }
          
           if(j < event.getRowCount()) { 
              xCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+9,3)), xMin, xMax, (float)width - 10, (float) 10); 
              yCoord = mapCoordinatesToPage(Float.parseFloat(event.getString(j+9,4)), yMin, yMax, (float)height - 10, (float) 10); 
              fill(colors[colorId].x, colors[colorId].y, colors[colorId].z);
              ellipse(xCoord, yCoord, 10, 10);
           }
          
       }
       
       j = j+10;
     
    }
 
    
    if (overRect(backX, backY, backSize, backSize)) {
      backOver = true;
    }
    else {
      backOver = false; 
    }
  }
  else {
    
  }
}

void showPlayButton() {
  createPlayButton();
}

// Skeleton
void hidePlayButton() {
  
}

void createPlayButton() {
  update(mouseX, mouseY);
  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(rectX, rectY, rectSize, rectSize);
  fill(255);
  text("Play!", rectX + 7, rectY + rectSize/2 + 4);
}

void createBackButton() {
  image(backButton, 5, 5);
}

void update(int x, int y) {
  if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
  } 
  else {
    rectOver = false;
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void animateEvent() { 
 event = readFile(pathToEvent + selectedEvent); 
 println("eventid: " + selectedEvent);
 
 determineEndPoints();
}

void determineEndPoints() {
  float[] xVal = new float[event.getRowCount()];
  float[] yVal = new float[event.getRowCount()];
  println("row count: " + event.getRowCount());
  
  println("gameid: " + event.getString(0,0));
  
  for(int i =0; i < (event.getRowCount()); i++) {
    xVal[i] = Float.parseFloat(event.getString(i,3));
    yVal[i] = Float.parseFloat(event.getString(i,4));
  }
  xMax = max(xVal);
  xMin = min(xVal);
  yMax = max(yVal);
  yMin = min(yVal);
}

float mapCoordinatesToPage(float OldValue, float OldMin, float OldMax, float NewMax, float NewMin) {
  return(((OldValue - OldMin) * (NewMax - NewMin)) / (OldMax - OldMin)) + NewMin;
}

void mousePressed()
{
  dropdownMousepressed();
  nextPageMousepressed();
  backPageMousepressed();
}

void nextPageMousepressed() {
  if(rectOver) {
     animationPage = true; 
     homePage = false;
    
      
     // create a slider with four parameters: X, Y position and W, H size
     sliderOnCourt = new SliderCourt(0, (height - 10), width, 10);
     j = 0;
     background(court);
     createBackButton();
     animateEvent();
  }
}

void backPageMousepressed() {
  if(backOver) {
     animationPage = false;
     homePage = true;
     dropdown.line = -1; // reset the dropdown selection
     listbox.clear();
     itemClicked(0, null);
     eventIdListDropdownSetup();
  }
}

//SETUP

void createListDropdownGame(){
  listDropdown[0] = "Game ID Dropdown";
  for (int i = 0; i < games.getRowCount(); i++) {
    if((games.getString(i,0) != null) && (i != 0)) {
      listDropdown[i] = games.getString(i, 0);
    }
  }
}

void createListDropdownEvent(){
  String[] paths;
  String game =  dropdown.getSelectionValue();
  boolean check;
  String tempPath;
 
  for(int i = 0; i < gameDirectories.length; i++){
     if(i == 0) {
       tempPath = baseDirectory + gameDirectories[i] + "games/00" + game;
     }
     else {
          tempPath = baseDirectory + gameDirectories[i] + "00" + game;
     }
     check = new File(tempPath).exists();
     if(check) {
        gameFolder = gameDirectories[i];
        break;
     }
  }
  
  if(gameFolder == "nba1/") {
   gameFolder = "nba1/games/";
  }
  pathToEvent = baseDirectory + gameFolder + "00" + game + "/";
  File newFile = new File(pathToEvent);
  paths = newFile.list();
  
  listbox.clear(); 
  for (int i = 0; i < paths.length; i++) {
      listbox.addItem(paths[i]);
  }
 
}

void playerColorsSetup() {
  //PVector col1 = new PVector(23, 190, 187);
  PVector col2 = new PVector(46, 40, 42);
  //PVector col3 = new PVector(205, 83, 52);
  //PVector col4 = new PVector(237, 184, 139);
  PVector col5 = new PVector(3, 113, 113);
  colors[0] = col2;
  colors[1] = col5;
}

void dropdownSetup() {
  
  //print(listDropdown);
  posDropdown = new PVector (183,30, 1.1 ) ; // Starting position of the Dropdown and margin between the box ( x,y, margin) ;
  posTextDropdown = new PVector ( 5, 11 ) ;
  sizeDropdown = new PVector ( 100, 15, 4 ) ; // (widthBox, heightBox, number of line(step) )
  dropdown = new Dropdown(listDropdown, posDropdown, sizeDropdown, posTextDropdown, colorBG, colorBoxIn, colorBoxOut, colorBoxText) ;
  //dropdown = new Dropdown(listDropdown, posDropdownTeam, sizeDropdown, posTextDropdown, colorBG, colorBoxIn, colorBoxOut, colorBoxText) ;
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

void dropdownDrawEventId()
{
  dropdownEventId.dropdownUpdate(interfaceFont, 10); //(font, fontsize)
  //to display the dropdown only if the mouse is in the area of this one
  float margeAround = sizeDropdown.y  ;
  PVector totalSizeDropdown = new PVector ( sizeDropdown.x + (margeAround *1.5) , sizeDropdown.y * (sizeDropdown.z +1)  + margeAround   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  PVector newPosDropdown = new PVector ( posDropdownEventId.x - margeAround  , posDropdownEventId.y ) ;
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
  DinRegular10= loadFont ("./data2/Geneva-48.vlw");
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
    return line + 1; 
  }
  // return dropdown value
  public String getSelectionValue() {
    if((line + 1)  > 0) {
      //print(line);
      return listDropdown[line + 1] ;
    }
    return listDropdown[0];
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
  background(240,230,140); //khaki
  fill(0,0,205); //medium blue
  arc(0,height/2, (width/2)-30, (width/2)-20, PI + HALF_PI, TWO_PI + HALF_PI); //(left semi circle) Each of the parameters contribute in drawing a part of an Ellipse. 1st/2nd sets location, 3rd/4th sets width/height, 5th sets angle starting point of the arc, 6th sets angle point to stop
  arc(960,height/2,(width/2)-30, (width/2) - 20, HALF_PI, PI + HALF_PI); // (right semi circle) using the values height/2 and width/2 sets the size of the arc/semi circle. The variables: HALF_PI, PI, TWO_PI are based on radian measurement values declaring a specific amount instead of inserting exact measurements.
  //line(220,250,736,250);
  fill(255,140,0); // dark orange
  ellipse(470,235,180,180); //possitioning of centre ellipse
  strokeWeight(3); //
  stroke(255,255,255); //white line colour
  line(470,0,470,500); //centre line
  rect(0,188,170,110); //left rect
  rect(768,188,170,110); //right rect
  line(0,270,170,270); //bottom left
  line(0,220,170,220); //upper left
  line(940,220,768,220); //upper right
  line(940,270,768,270); // bottom right
}

Table readFile(String fileName) {
  //println(fileName);
  Table table = loadTable(fileName, "csv");

  for (int i = 0; i < table.getRowCount(); i++) {
    //println(table.getString(i, 2));
    //println(Float.parseFloat(table.getString(i, 2)));
    //println(table.getString(i,2));
  }
  return table;
}

void printDirectory(String[] paths) {
 println(paths.length);
  // for each name in the path array
  for(String path:paths)
  {
    // prints filename and directory name
    System.out.println(path);
  } 
}

/**
 *    A list
 *
 *    Make sure to try your scroll wheel!
 */

void eventIdListDropdownSetup() {
    
    // make the manager
    
    Interactive.make( this );
    
    // create a list box
    
    // 4th param: height = itemHeight * r
    listbox = new Listbox( 335, 30, 100, 100 );
    listbox.addItem("Event ID");
}

public void itemClicked ( int i, Object item )
{
    lastItemClicked = item;
}

public class Listbox
{
    float x, y, width, height;
    
    ArrayList items;
    int itemHeight = 20;
    int listStartAt = 0;
    int hoverItem = -1;
    
    float valueY = 0;
    boolean hasSlider = false;
    
    Listbox ( float xx, float yy, float ww, float hh ) 
    {
        x = xx; y = yy;
        valueY = y;
        
        width = ww; height = hh;
        
        // register it
        Interactive.add( this );
    }
    
    public Listbox clear( ) {
      for ( int i = items.size( ) - 1 ; i >= 0 ; i-- ) {
        items.remove( i );
      }
      items.clear( );
      return this;
   }
    
    public void addItem ( String item )
    {
        if ( items == null ) items = new ArrayList();
        items.add( item );
        
        hasSlider = items.size() * itemHeight > height;
    }
    
    public void mouseMoved ( float mx, float my )
    {  
        // -20 to width because of slider
        if(hasSlider) {
          if(overRect(335, 30, 100 - 20, 100)) {        
            hoverItem = listStartAt + int((my-y) / itemHeight);
          }
          else{
           return;
          }
        }
        else {
          if(overRect(335, 30, 100, 100)) {
            hoverItem = listStartAt + int((my-y) / itemHeight);
          }
          else{
           return;
          }
        }
        
    }
    
    public void mouseExited ( float mx, float my )
    {
        hoverItem = -1;
    }
    
    // called from manager
    void mouseDragged ( float mx, float my, float dx, float dy )
    {
        if ( !hasSlider ) return;
        
        
        if ( mx < x+width-20 ) return;
        
        valueY = my-10;
        valueY = constrain( valueY, y, y+height-20 );
        
        update();
    }
    
    // called from manager
    void mouseScrolled ( float step )
    {
        if(overRect(335, 30, 100, 100)) {
        
          valueY += step;
          valueY = constrain( valueY, y, y+height-20 );
          
          update();
        }
        else{
         return;
        }    
    }
    
    void update ()
    {
        float totalHeight = items.size() * itemHeight;
        float itemsInView = height / itemHeight;
        float listOffset = map( valueY, y, y+height-20, 0, totalHeight-height );
        
        listStartAt = int( listOffset / itemHeight );
    }
    
    public void mousePressed ( float mx, float my )
    {
      
        if(hasSlider) {
          if(overRect(335, 30, 100 - 20, 100)) {
          
            int item = listStartAt + int( (my-y) / itemHeight);
            itemClicked( item, items.get(item) );
 
            selectedEvent = items.get(item).toString();
          }
          else{
           return;
          }
        }
        else {
          if(overRect(335, 30, 100, 100)) {
          
            int item = listStartAt + int( (my-y) / itemHeight);
            itemClicked( item, items.get(item) );
            selectedEvent = Integer.toString(item);
          }
          else{
           return;
          }
        }         
    }

    void draw ()
    {
      if(homePage == true) {
        noStroke();
        fill( 100 );
        rect( x,y,this.width,this.height );
        if ( items != null )
        {
            for ( int i = 0; i < int(height/itemHeight) && i < items.size(); i++ )
            {
                stroke( 80 );
                fill( (i+listStartAt) == hoverItem ? 200 : 120 );
                rect( x, y + (i*itemHeight), this.width, itemHeight );
                
                noStroke();
                fill( 255 );
                text( items.get(i+listStartAt).toString(), x+5, y+(i+1)*itemHeight-5 );
            }
        }
        
        if ( hasSlider )
        {
            stroke( 80 );
            fill( 100 );
            rect( x+width-20, y, 20, height );
            fill( 120 );
            rect( x+width-20, valueY, 20, 20 );
        }
      }
    }
}

public class SliderCourt  // declare this as public so Guido can see it
{
    // placement properties
    float x, y, width, height;
    // display value (0,width) and actual value (0,1)
    float valueX = 0, value;
    
    SliderCourt ( float xx, float yy, float ww, float hh ) 
    {
        x = xx; 
        y = yy; 
        width = ww; 
        height = hh;
    
        // register it with Guido
        Interactive.add( this );
    }
    
    void update( float mx, float my )
    {
        valueX = mx - height/2;
        
        if ( valueX < 0 ) valueX = 0;
        if ( valueX > width-height ) valueX = width-height;
        
        value = map( valueX, 0, width-height, 0, 1 );
    }
    
    // called from manager
    void mouseDragged ( float mx, float my )
    {
        update(mx, my);
    }

    // called from manager
    void mousePressed ( float mx, float my )
    {
        update(mx, my);
    }

    void draw () 
    {
        noStroke();
        
        fill( 100 );
        rect(x, y, width, height);
        
        fill( 220 );
        rect( valueX, y, height, height, 4);
    }
}