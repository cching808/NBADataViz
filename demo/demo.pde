// horizontal positions
float xR, xG, xB; 
// horizontal speeds
float speedR, speedG, speedB;
// distance to move the ball before moving back to the start
float trackDist;
// The system time for this and the previous frame (in milliseconds)
int currTime, prevTime;
// The elapsed time since the last frame (in seconds)
float deltaTime;

void setup() {
  size(800, 140);
  trackDist = width - 20;
  xR = 0;
  xG = 0;
  xB = 0;
  speedR = 50;
  speedG = 100;
  speedB = 200;
  noStroke();
  // Initialise the timer
  currTime = prevTime = millis();
}

void draw() {
  // get the current time
  currTime = millis();
  // calculate the elapsed time in seconds
  deltaTime = (currTime - prevTime)/1000.0;
  // rember current time for the next frame
  prevTime = currTime;
  
  // Update the positions of the three balls
  xR = updatePosition(xR, speedR, deltaTime);
  xG = updatePosition(xG, speedG, deltaTime);
  xB = updatePosition(xB, speedB, deltaTime);
  
  // Start drawing
  background(96);
  fill(255, 0, 0);
  ellipse(xR + 10, 40, 20, 20);
  fill(0, 255, 0);
  ellipse(xG + 10, 70, 20, 20);
  fill(0, 0, 255);
  ellipse(xB + 10, 100, 20, 20);
}

// Calculates the new position based on current position, speed 
// and elapsed time. Also move the ball back to the start when
// it reaches the right-hand-side
float updatePosition(float x, float speed, float elapsedTime) {
  x += speed * elapsedTime;
  if (x > trackDist)
    x -= trackDist;
  return x;
}