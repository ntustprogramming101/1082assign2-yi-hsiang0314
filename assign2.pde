PImage background ;
PImage groundhog ;
PImage groundhogDown ;
PImage groundhogLeft ;
PImage groundhogRight ;
PImage life ;
PImage robot ;
PImage soil ;
PImage soldier ;
PImage cabbage ;
PImage title ;
PImage startNormal ;
PImage startHovered ;
PImage gameover ;
PImage restartNormal ;
PImage restartHovered ;

int groundhogX;
int groundhogY; 
int groundhogMove;
int soldierX;
int soldierY;
int robotX;
int robotY;
int laserW;
int laserX;
int gameState;
int lifePoint;
int cabbageX;
int cabbageY;


boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

final int GAME_START=0, GAME_RUN=1, GAME_LOSE=2;
final int GROUNDHOG_WIDTH=80;
final int SOLDIER_WIDTH=80;
final int CABBAGE_WIDTH=80;

void setup() {
  size(640, 480, P2D);
  // Enter Your Setup Code Here
  frameRate(60);
  gameState = GAME_START ;
  background = loadImage("img/bg.jpg");
  groundhog = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  cabbage = loadImage("img/cabbage.png");
  life = loadImage("img/life.png");
  //robot = loadImage("img/robot.png");
  soil = loadImage("img/soil.png");
  soldier = loadImage("img/soldier.png");
  title = loadImage("img/title.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  gameover = loadImage("img/gameover.jpg");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");


  //cabbage show up position 
  cabbageY=floor(random(2, 6))*CABBAGE_WIDTH;
  cabbageX=floor(random(1, 8))*CABBAGE_WIDTH;

  //soldier start position 
  soldierY=floor(random(2, 6))*80;

  ////robot start postion
  //robotX=floor(random(2, 8))*80;
  //robotY=floor(random(2, 6))*80;
  //if (robotY==soldierY && (soldierY<400)) {
  //  robotY=soldierY+80;
  //}
  //if (robotY==soldierY && (soldierY==400)) {
  //  robotY=soldierY-80;
  //}
  //laserW=10;
  //laserX=robotX+25;

  //groundhog start position
  groundhogX = 320;
  groundhogY = 80;
  groundhogMove = 80;

  //life
  lifePoint=2;
}

void draw() {
  // Switch Game State
  switch(gameState) {
    // Game Start
  case GAME_START:
    image(title, 0, 0);
    image(startNormal, 248, 360);
    //button for start
    if ((mouseX>=248 && mouseX<=392) && (mouseY>=360 && mouseY<=420)) {
      if (mousePressed) {
        //click
        gameState= GAME_RUN;
      } else {
        //hover
        image(startHovered, 248, 360);
      }
    }

    break;    
    // Game Run
  case GAME_RUN:
    //bg
    image(background, 0, 0);


    noStroke();
    //grass
    rectMode(CORNER);  
    fill(124, 204, 25); 
    rect(0, 145, 640, 15); 
    //sun
    fill(255, 255, 0); 
    ellipse(590, 50, 130, 130);
    fill(253, 184, 19); 
    ellipse(590, 50, 120, 120);
    //soil
    image(soil, 0, 160);
    ////LINE
    //for (int i=0; i<8; i+=1 ) {
    //  stroke(5);
    //  strokeWeight(2);
    //  line(i*80, 160, i*80, height);
    //} 
    //groundhog
    image(groundhog, groundhogX, groundhogY);

    //groundhog move

    if (downPressed) {

    }
    if (leftPressed) {
    }
    if (rightPressed) {
    }

    //groundhog killed by soldier
    if ((groundhogX<soldierX+SOLDIER_WIDTH && groundhogX+GROUNDHOG_WIDTH>soldierX)&&
      (groundhogY<soldierY+SOLDIER_WIDTH && groundhogY+GROUNDHOG_WIDTH>soldierY)) {
      groundhogX=320;
      groundhogY=80;
      lifePoint-=1;
      if (lifePoint<=0) {
        gameState= GAME_LOSE;
      }
    }
    //eat cabbage and get one life
    if ((groundhogX<cabbageX+CABBAGE_WIDTH && groundhogX+GROUNDHOG_WIDTH>cabbageX)&&
      (groundhogY<cabbageY+CABBAGE_WIDTH && groundhogY+GROUNDHOG_WIDTH>cabbageY)) {
      cabbageX=-160;
      lifePoint+=1;
    }



    //life

    for (int i =0; i<lifePoint; i+=1) {
      image(life, 10+i*70, 10);
    }
    //image(life, 80, 10);
    //image(life, 150, 10);

    //soldier
    image(soldier, soldierX, soldierY);
    soldierX+=2;
    if (soldierX>640) {
      soldierX=-80;
    }
    //cabbage
    image(cabbage, cabbageX, cabbageY);


    ////robot
    //image(robot, robotX, robotY);
    ////laser
    //fill(255, 0, 0);
    //rectMode(CENTER);

    //rect(laserX, robotY+37, laserW, 10, 100);
    //if (laserW<40) {
    //  laserW+=2;
    //}

    //laserX -= 2;
    //if (laserX<robotX+25-160) {
    //  laserW=0;
    //  laserX=robotX+25;
    //}
    // }
    break; 

    // Game Lose
  case GAME_LOSE:
    image(gameover, 0, 0);
    image(restartNormal, 248, 360);
    //button back to game
    if ((mouseX>=248 && mouseX<=392) && (mouseY>=360 && mouseY<=420)) {
      if (mousePressed) {
        //click
        gameState= GAME_RUN;
        lifePoint=2;
        //cabbage show up position 
        cabbageY=floor(random(2, 6))*CABBAGE_WIDTH;
        cabbageX=floor(random(1, 8))*CABBAGE_WIDTH;
        //soldier start position 
        soldierY=floor(random(2, 6))*80;
      } else {
        //hover
        image(restartHovered, 248, 360);
      }
    }
    break;
  }
}

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {

    case DOWN :
      downPressed=true;
      if (groundhogY<height-GROUNDHOG_WIDTH) {
       
      }  
      break;
    case LEFT :
      leftPressed=true;
      if (groundhogX>0) {
        groundhogX-=groundhogMove;
      }
      break;
    case RIGHT :
      rightPressed=true;
      if (groundhogX<width-GROUNDHOG_WIDTH) {
        groundhogX+=groundhogMove;
      }

      break;
    }
  }
}
///////////////
void keyReleased() {
  if (key == CODED) {
    switch(keyCode) {
    case DOWN :
      downPressed=false;
      break;
    case LEFT :
      leftPressed=false;
      break;
    case RIGHT :
      rightPressed=false;
      break;
    }
  }
}
