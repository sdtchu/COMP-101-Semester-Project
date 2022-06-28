 /*************
 **  SP5-Final Code
 **  Kevin Pak, Gabe Wheat, Seth Chu, Wassim Merzoug, Ife Kayode, Mide Afinfolarin
 **  05/12/22
 **  Class: COMP 101
 **  Our project goes into multiple different places all over the campus of umbc
 **  the main focus of the code is that your choices have an impact on your game
 **  at the end of the day, you have the choice to do whatever you want, but the 
 **  your actions have consequences. Depending on the value on your bars can detemine
 **  if you win the game or not. The improvements the following below
 **  We added a time feature and you only have 24 hours a day. Weeks End screen
 **  that displays the actual amount of time you spent doing each action. We also added
 **  a map feature where you can pick where you want to go. The events are different at
 **  different spots. Since the colors of the buttons where confusing we decided to delete
 **  the color aspect and choose a solid color for all the buttons. We also put pictures 
 **  from the campus directly into the game. 
 ***************/

//Available the text options at the bottom of the screen
String[] weekOneQuestions = {"Welcome to your first week\n at UMBC!", "Hello Player!\nWhat will you do today?", 
  "You're in class. A girl next to you\n says hi. Will you say hi back?", };
//Puts the text in the bottom four button
String[] actions = {"Study", "Go to class", "Sleep in", "Hangout with\nfriends", "attend club meeting", "Work", "Yes", "No"};

// input vars
String workInput = "";
String sleepInput = "";
String friendsInput = "";
String toClassInput = "";

String workSave = "";
String sleepSave = "";
String friendsSave = "";
String toClassSave = "";

int hours = 24;
int working = 0;
int sleep = 0;
int friends = 0;
int toClass = 0;


// prompt vars
String prompt;
int SIZE_X = 335;
int SIZE_Y = 190;
float SPACING = 10;

// bars vars
float sizeY = 15;
float x = SPACING;
float y = SPACING;

int happiness = 200;
int grades = 200;
int health = 200;
int money = 100;
int green = #26A214;

int effect = 10;
float redBarX = 0;
float yellowBarX = 0;
float greenBarX = 0;
float blueBarX = 0;

// action & next day button vars
int[] buttonsX = {355, 525, 495};
int[] buttonsY = {410, 505, 355};

float nextDayBoundX, nextDayBoundY;

int buttonLength = 160;
int buttonWidth = 85;

int purple = #F6E0FF;

float rgBoundX, byBoundX, rbBoundY, ygBoundY;
String study, relax, work, fun;

boolean play = false;

//week vars
float weekCount = 0;
int days = 1;
int weeks = 0;

//map vars
int mapButtonX = 10;
int mapButtonY = 340;
int mapButtonSize = 50;

float[] mapIconsX = {350, 300, 364};
float[] mapIconsY = {350, 50, 177};

float buttonBoundX, buttonBoundY;

float racIconX, racIconY = 1000;
float libraryIconX, libraryIconY = 1000;
float commonsIconX, commonsIconY = 1000;

//building vars
float[] buildingIconsX = {431, 450, 150};
float[] buildingIconsY = {150, 150};

float racBX, racBY = 1000;
float libraryBX, libraryBY  = 1000;
float commons2BX, commons2BY  = 1000;
float commonsBX, commonsBY = 1000;


float racBoundX, racBoundY, libraryBoundX, 
  libraryBoundY, commons2BoundX, commons2BoundY, 
  commonsBoundX, commonsBoundY;

// screen vars
String gameScreen = "welcome";
PImage room;

// gpa vars
int grade;
int finalGrade = (grades * 100) / 200;
int finalHappiness = (happiness * 100) / 200;
int finalHealth = (health * 100) / 200;

// sets screen dimensions
void setup() {
  size(700, 600);
  rect(-10, 400, 800, 200);
  room = loadImage("welcome screen.png");
}

void draw() {
  background(255);
  image(room, 0, 0);

  if (gameScreen == "welcome") {
    welcomeScreen();
  }
  if (gameScreen == "start") {
    instructionScreen();
  }
  if (gameScreen == "play") {
    drawScreen();
  }
  if (gameScreen == "weekOver") {
    weekCompleted();
  }
  if (gameScreen == "gameOver") {
    gameOver();
  }
  if (gameScreen == "congrats") {
    congratulations();
  }
  if (gameScreen == "finals") {
    finals();
  }
  if (gameScreen == "midCongrats") {
    congratulations2();
  }
  if (gameScreen == "midterms") {
    midterms();
  }
}


void mouseClicked() {
  nextDayButton();
  actionButtons();
  makeBuildingActions();
}

// displays welcome screen and plays game if begin is clicked
void welcomeScreen() {  
  float beginButtonWidth = 130;
  float beginButtonHeight = 50;
  float beginButtonX = 285;
  float beginButtonY = 180;

  // button outline
  fill(#FFCE00);
  stroke(#2566AA);
  strokeWeight(2);
  rect(beginButtonX, beginButtonY, beginButtonWidth, beginButtonHeight, SPACING);

  // begin text
  fill(#3F72DE);
  textSize(36);
  text("BEGIN", beginButtonX + 15, beginButtonY + 39);

  float beginBoundX = beginButtonX + beginButtonWidth;
  float beginBoundY = beginButtonY + beginButtonHeight;

  if (mouseX >= beginButtonX && mouseX <= beginBoundX && mouseY <= beginBoundY && mouseY >= beginButtonY) {
    if (mousePressed == true) {
      gameScreen = "start";
      room = loadImage("instructions.png");
    }
  }
}

// displays instritions for the game
void instructionScreen() {  
  float startButtonWidth = 130;
  float startButtonHeight = 50;
  float startButtonX = 190;
  float startButtonY = 525;

  // button outline
  fill(#FFCE00);
  stroke(#2566AA);
  strokeWeight(2);
  rect(startButtonX, startButtonY, startButtonWidth, startButtonHeight, SPACING);

  // begin text
  fill(#3F72DE);
  textSize(36);
  text("START", startButtonX + 10, startButtonY + 39);

  float startBoundX = startButtonX + startButtonWidth;
  float startBoundY = startButtonY + startButtonHeight;

  if (mouseX >= startButtonX && mouseX <= startBoundX && mouseY <= startBoundY && mouseY >= startButtonY) {
    if (mousePressed == true) {
      gameScreen = "play";
      room = loadImage("room.png");
      happiness = 100;
      money = 100;
      health = 100;
      grades = 200;
      days = 1;
      weeks = 0;
      hours = 24;
    }
  }
} 

void drawScreen() {
  stroke(0);
  drawPromptBox();
  drawBars();
  drawButtons();
  buttonHover();
  scenario1();
  displayText();
  drawWeekNumber();
  drawMapButton();
  drawMap();
  midterms();
  finals();
}

// creates box where prompt is displayed
void drawPromptBox() {
  //draws the section of the bottom left where the text will be
  fill(255);
  rect(SPACING, 400 + SPACING, SIZE_X-(SPACING/2), SIZE_Y-SPACING, SPACING);
}

// displays the prompt, next day button, and number of hours left
void displayText() {
  float nextDayWidth = 190;
  float nextDayHeight = 40;

  nextDayBoundX = buttonsX[2] + nextDayWidth;
  nextDayBoundY = buttonsY[2] + nextDayHeight;

  //this displays the text that we put in the string earlier
  textSize(18);
  fill(0);
  text(prompt, SPACING + 20, SPACING + 430);

  //displays number of hours left
  text("Hours left: " + hours, 30, 567);
  if (hours == 0) {
    days += 1;
    hours = 24;
    if (toClass < 1) {
      grades -= effect * 2;
    }
    if (friends < 1) {
      happiness -= effect/2;
    }
    if (sleep < 7) {
      health -= effect * 2;
    }
  }

  //draws next day button
  strokeWeight(2);
  stroke(0);
  fill(#F7C305);
  rect(buttonsX[2], buttonsY[2], nextDayWidth, nextDayHeight, SPACING);
  textSize(20);
  fill(0);
  text("Go To Next Day", buttonsX[2] + 18, buttonsY[2] + 27);
}

// take the player to the next day when next day button is pressed
void nextDayButton() {
  if (mouseX >= buttonsX[2] && mouseX <= nextDayBoundX && mouseY <= nextDayBoundY && mouseY >= buttonsY[2]) {
    days += 1;
    hours = 24;
    if (toClass < 1 && hours > 0 ) {
      grades -= effect * 2;
    }
    if (friends < 1 && hours > 0) {
      happiness -= effect/2;
    }
    if (sleep < 7) {
      health -= effect * 2;
    }
  }
}

// draws the status bars on the screen
void drawBars() {
  // draws the background of the bars
  strokeWeight(2);
  fill(200);
  rect(x, y + SPACING * 2, 200, sizeY, SPACING);
  rect(x, y + SPACING * 4, 200, sizeY, SPACING);
  rect(x, y + SPACING * 6, 200, sizeY, SPACING);

  textSize(13);  
  fill(255);  // draws money bar
  rect(x, y, 200, sizeY, SPACING);
  fill(green);
  text("Money: $" + money, x + 5, y + 13);

  fill(255, 255, 0);  // draws happiness bar
  rect(x, y + SPACING * 2, happiness, sizeY, SPACING);
  fill(0);
  text("Happiness: ", x + 5, y + 32);

  fill(50, 100, 255);    // draws grades bar
  rect(x, y + SPACING * 4, grades, sizeY, SPACING);
  fill(0);
  text("Grades: ", x + 5, y + 53);

  fill(255, 0, 100);  // draws health bar
  rect(x, y + SPACING * 6, health, sizeY, SPACING);
  fill(0);
  text("Health: ", x + 5, y + 73);

  barBound();
}

// Keeps the status Bar within the status box
void barBound() {
  if (money <= 0) {
    money = 0;
  }
  if (happiness <= 5) {
    happiness = 5;
    gameScreen = "gameOver";
  }
  if (grades <= 5) {
    grades = 5;
  } 
  if (health <= 5) {
    health = 5;
    gameScreen = "gameOver";
  } 
  if (happiness >= 200) {
    happiness = 200;
  } 
  if (grades >= 200) {
    grades = 200;
  } 
  if (health >= 200) {
    health = 200;
  }
}

// draws the 4 action buttons at the bottom right of the screen
void drawButtons() {
  // Draws all 4 buttons in the bottom right giving them each a respective button to press
  rgBoundX = buttonsX[0] + buttonLength;
  byBoundX = buttonsX[1] + buttonLength;
  rbBoundY = buttonsY[0] + buttonWidth;
  ygBoundY = buttonsY[1] + buttonWidth;

  strokeWeight(2);
  //TL = top left
  fill(purple);
  rect(buttonsX[0], buttonsY[0], buttonLength, buttonWidth, SPACING);

  //TR = top right
  fill(purple);
  rect(buttonsX[1], buttonsY[0], buttonLength, buttonWidth, SPACING);

  //BL = bottom left
  fill(purple);
  rect(buttonsX[0], buttonsY[1], buttonLength, buttonWidth, SPACING);

  //BR = bottom right
  fill(purple);
  rect(buttonsX[1], buttonsY[1], buttonLength, buttonWidth, SPACING);
}

// Indicates the mouse is over the action buttons
void buttonHover() {
  if (mouseX >= buttonsX[0] && mouseX <= rgBoundX && mouseY <= rbBoundY && mouseY >= buttonsY[0]) {
    //go to class
    fill(#FBF2FF);
    rect(buttonsX[0], buttonsY[0], buttonLength, buttonWidth, SPACING);
  } else if (mouseX >= buttonsX[0] && mouseX <= rgBoundX && mouseY <= ygBoundY && mouseY >= buttonsY[1]) {
    //sleep in
    fill(#FBF2FF);
    rect(buttonsX[0], buttonsY[1], buttonLength, buttonWidth, SPACING);
  } else if (mouseX >= buttonsX[1] && mouseX <= byBoundX && mouseY <= ygBoundY && mouseY >= buttonsY[1]) {
    //work
    fill(#FBF2FF);
    rect(buttonsX[1], buttonsY[1], buttonLength, buttonWidth, SPACING);
  } else if (mouseX >= buttonsX[1] && mouseX <= byBoundX && mouseY <= rbBoundY && mouseY >= buttonsY[0]) {
    //hangout with friends
    fill(#FBF2FF);
    rect(buttonsX[1], buttonsY[0], buttonLength, buttonWidth, SPACING);
  } else {
    drawButtons();
  }
}

// displays number of days on the screen
void drawWeekNumber() {
  //displays the day you are on and advances depending on the clicks
  String weekNumber = "Day " + days;
  textSize(25);
  fill(0);
  text(weekNumber, 600, 40);

  if ( (days == 7 || days == 14 || days == 21 || days == 28 || days == 35 || days == 42 || days == 56 
    || days == 63 || days == 70 || days == 77 || days == 84 || days == 91 || days == 98)) {
    gameScreen = "weekOver";
    days += 1;
    weeks += 1;
  }
}

// displays the senerio prompt and actions in the 4 boxes
void scenario1() {
  //displays the first scenario and puts new text in the prompt section
  float[] textX = {365, 540};
  float[] textY = {460, 558};

  prompt = weekOneQuestions[1];

  // new text which displays study
  fill(0);
  textSize(25);
  text(actions[1], textX[0], textY[0]);

  // new text which displays Sleep in
  textSize(25);
  text(actions[2], textX[0] + 20, textY[1]);

  // new text which displays Hang out with friends
  textSize(20);
  text(actions[3], textX[1], textY[0] - 10);

  // new text which displays Work
  textSize(25);
  text(actions[5], textX[1] + 30, textY[1]);
}

// affects bars based on action box chosen
void actionButtons() {
  if (mouseX >= buttonsX[0] && mouseX <= rgBoundX && mouseY <= rbBoundY && mouseY >= buttonsY[0]) {
    // go to class
    minusRed();
    toClass += 1; 
    hours -= 1;
  } 

  // The button pressed zone that you can click to activate the next scenario
  if (mouseX >= buttonsX[0] && mouseX <= rgBoundX && mouseY <= ygBoundY && mouseY >= buttonsY[1]) {
    // sleep in
    minusGreen();
    sleep += 1;
    hours -= 1;
  }

  // The button pressed zone that you can click to activate the next scenario  
  if (mouseX >= buttonsX[1] && mouseX <= byBoundX && mouseY <= ygBoundY && mouseY >= buttonsY[1]) {
    // work
    minusYellow();
    working += 1;
    hours -= 1;
  } 

  // The button pressed zone that you can click to activate the next scenario
  if (mouseX >= buttonsX[1] && mouseX <= byBoundX && mouseY <= rbBoundY && mouseY >= buttonsY[0]) {
    // hangout with friends
    if (money != 0) {
      minusBlue();
      friends += 1;
      hours -= 1;
    }
  }
}

// affects the status bars if hangout with friends box is clicked
void minusBlue() {
  health += effect;
  grades -= effect/2;
  happiness += effect;
  money -= 20;
  barBound();
}

// affects the status bars if work box is clicked
void minusYellow() {
  grades -= effect/2;
  health -= effect;
  money += 7;
  barBound();
}

// affects the status bars if go to class box is clicked
void minusRed() {
  happiness -= effect;
  grades += effect;
  barBound();
}

// affects the status bars if sleep in box is clicked
void minusGreen() {
  happiness += effect;
  health += effect;
  barBound();
}

// makes the screen the midterms screen
void midterms() {
  if (days == 49) {
    gameScreen = "midCongrats";
  }
}

// makes the screen the finals screen if grages are over 70
void finals() {
  if (days == 105) {
    if (grades >= 70) {
      gameScreen = "congrats";
    } else {
      gameScreen = "gameOver";
    }
  }
}

// draws map button
void drawMapButton() {
  stroke(0);
  fill(#F7C305);
  rect(mapButtonX, mapButtonY, mapButtonSize, mapButtonSize, SPACING);
  fill(0);
  textSize(20);
  text("MAP", mapButtonX + 3.5, mapButtonY + 34);
}

// displays map and building icons
void drawMap() {

  drawMapIcons();

  racBuilding();
  library();
  commons();

  buttonBoundX = mapButtonX + mapButtonSize;
  buttonBoundY = mapButtonY + mapButtonSize;

  // if the map button is pressed, draw map
  if (mouseX >= mapButtonX && mouseX <= buttonBoundX && mouseY <= buttonBoundY && mouseY >= mapButtonY) {
    if (mousePressed == true) {
      room = loadImage("map.png");
      racIconX = mapIconsX[0];
      racIconY = mapIconsY[0];
      libraryIconX = mapIconsX[1];
      libraryIconY = mapIconsY[1];
      commonsIconX = mapIconsX[2];
      commonsIconY = mapIconsY[2];

      racBX = 1000;
      libraryBX = 1000;
      commonsBX = 1000;
      commons2BX = 1000;
    }
  }
}

// displays map icons
void drawMapIcons() {
  // icon next to the RAC
  fill(#F7C305);
  rect(racIconX, racIconY, 49, 30, SPACING);
  fill(0);
  textSize(20);
  text("RAC", racIconX + 4, racIconY + 23);

  //icon next to the library
  fill(#F7C305);
  rect(libraryIconX, libraryIconY, 58, 30, SPACING);
  fill(0);
  textSize(15);
  text("Library", libraryIconX + 4, libraryIconY + 22);

  //icon next to the commons
  fill(#F7C305);
  rect(commonsIconX, commonsIconY, 78, 30, SPACING);
  fill(0);
  textSize(15);
  text("Commons", commonsIconX + 3, commonsIconY + 20);
}

// draws action icons in each buildings
void drawBuildingActions() {
  //rac icons
  fill(255, 0, 100);
  rect(racBX, racBY, 120, 45, SPACING);
  fill(0);
  textSize(18);
  text("Excersize", racBX + 15, racBY + 20);
  text("Health + 5", racBX + 10, racBY + 40);

  //library icons
  fill(#8394FA);
  rect(libraryBX, libraryBY, 120, 45, SPACING);
  fill(0);
  textSize(18);
  text("Get Tutored", libraryBX + 8, libraryBY + 20);
  text("Grades + 5", libraryBX + 10, libraryBY + 40);

  //commons icons
  fill(#EAFA83);
  rect(commonsBX, commonsBY, 120, 45, SPACING);
  rect(commons2BX, commons2BY, 120, 45, SPACING);
  fill(0);
  textSize(18);
  text("Play Pool", commons2BX + 20, commons2BY + 30);
  text("Eat Food", commonsBX + 20, commonsBY + 19);
  text("$6", commonsBX + 45, commonsBY + 40);
}

void makeBuildingActions() {
  // RAC actions
  racBoundX = racBX + 120;
  racBoundY = racBY + 45;

  // if action icon in rac is clicked, make the status bar affect
  if (mouseX >= racBX && mouseX <= racBoundX && mouseY <= racBoundY && mouseY >= racBY) {
    health += 5;
    hours -= 1;
    barBound();
  }

  // library actions  
  libraryBoundX = libraryBX + 120;
  libraryBoundY = libraryBY + 45;

  // if action icon in library is clicked, make the status bar affect
  if (mouseX >= libraryBX && mouseX <= libraryBoundX && mouseY <= libraryBoundY && mouseY >= libraryBY) {
    grades += 5;
    hours -= 1;
    barBound();
  }

  // commons actions
  commonsBoundX = commonsBX + 120;
  commonsBoundY = commonsBY + 45;

  commons2BoundX = commons2BX + 120;
  commons2BoundY = commons2BY + 45;

  // if action icon in commons is clicked, make the status bar affect
  if (mouseX >= commonsBX && mouseX <= commonsBoundX && mouseY <= commonsBoundY && mouseY >= commonsBY) {
    if (money != 0) {
      health += 5;
      happiness += 5;
      money -= 6;
      hours -= 1;
      barBound();
    }
  }

  // if second action icon in commons is clicked, make the status bar affect
  if (mouseX >= commons2BX && mouseX <= commons2BoundX && mouseY <= commons2BoundY && mouseY >= commons2BY) {
    happiness += 5;
    hours -= 1;
    barBound();
  }
}

// displays rac screen
void racBuilding() { 

  float boundX, boundY;

  drawBuildingActions();

  boundX = racIconX + 49;
  boundY = racIconY + 30;

  // if rac icon is clicked, go inside rac building
  if (mouseX >= racIconX && mouseX <= boundX && mouseY <= boundY && mouseY >= racIconY) {
    if (mousePressed == true) {
      racIconY = 1000;
      libraryIconY = 1000;
      commonsIconY = 1000;

      room = loadImage("rac.jpg");
      racBX = buildingIconsX[0];
      racBY = buildingIconsY[0];
    }
  }
}

// displays library screen
void library() {

  float lBoundX, lBoundY;

  drawBuildingActions();

  lBoundX = libraryIconX + 58;
  lBoundY = libraryIconY + 30;

  // if library icon is clicked, go inside library building
  if (mouseX >= libraryIconX && mouseX <= lBoundX && mouseY <= lBoundY && mouseY >= libraryIconY) {
    if (mousePressed == true) {
      racIconY = 1000;
      libraryIconY = 1000;
      commonsIconY = 1000;

      room = loadImage("library.jpg");
      libraryBX = buildingIconsX[0];
      libraryBY = buildingIconsY[0];
    }
  }
}

// displays commons screen
void commons() {
  float cBoundX, cBoundY;

  drawBuildingActions();

  cBoundX = commonsIconX + 78;
  cBoundY = commonsIconY + 30;

  // if commons icon is clicked, go inside commons building
  if (mouseX >= commonsIconX && mouseX <= cBoundX && mouseY <= cBoundY && mouseY >= commonsIconY) {
    if (mousePressed == true) {
      racIconY = 1000;
      libraryIconY = 1000;
      commonsIconY = 1000;

      room = loadImage("common.jpg");
      commonsBX = buildingIconsX[1];
      commonsBY = buildingIconsY[1];
      commons2BX = buildingIconsX[2];
      commons2BY = buildingIconsY[1];
    }
  }
}

// displays week completed screen and outcomes of each week
void weekCompleted() {
  weekOutcomes();
  room = loadImage("weekscreen.png");

  // draws instruction text
  fill(255);
  textSize(25);
  text("Press Enter to Continue", 210, 560);

  // draws week number
  fill(#2566AA);
  textSize(80);
  text(weeks, 230, 120);

  // if player presses enter key, go back to the game screen
  if (keyPressed == true) {
    if (key == ENTER) {
      gameScreen = "play";
      room = loadImage("room.png");
      racIconX = 1000;
      libraryIconX = 1000;
      commonsIconX = 1000;
      racBX = 1000;
      libraryBX = 1000;
      commonsBX = 1000;
      commons2BX = 1000;
      health -= effect;
      working = 0;
      toClass = 0;
      hours = 24;
      sleep = 0;
      friends = 0;
    }
  }
}

// displays the outcomes of the week on the screen
void weekOutcomes() {
  float [] weekTextX = {40};
  float [] weekTextY = {225};

  String worked = "Hours Worked: " + working;
  String tookClass = "Hours In Class: " + toClass;
  String hanged = "Hours with Friends: " + friends;
  String slept = "Hours Slept: " + sleep;

  textSize(28);
  fill(#2C4E95);
  text(worked, weekTextX[0], weekTextY[0]); 
  text(tookClass, weekTextX[0], weekTextY[0] + 60);
  text(hanged, weekTextX[0], weekTextY[0] + 120);
  text(slept, weekTextX[0], weekTextY[0] + 180);
}

// displays game over screen, and prompts if player wants to start again
void gameOver() {

  int gameOverButtonX = 215;
  int gameOverButtonY = 300;
  int gameOverWidth = 250;
  int gameOverHeight = 100;

  room = loadImage("gameover.png");

  stroke(#FFCE00);
  fill(0);
  rect(215, 300, 250, 100, SPACING);
  fill(#FFCE00);
  textSize(35);
  text("Try Again?", 250, 360);

  float gameOverBoundX = gameOverButtonX + gameOverWidth;
  float gameOverBoundY = gameOverButtonY + gameOverHeight;

  // if player presses try again button, to go welcome screen
  if (mouseX >= gameOverButtonX && mouseX <= gameOverBoundX && mouseY <= gameOverBoundY && mouseY >= gameOverButtonY) {
    if (mousePressed == true) {
      gameScreen = "welcome";
      room = loadImage("welcome screen.png");
    }
  }
}


// displays game over screen with game outcomes
void congratulations() {
  gpaCalculator();

  float [] congratsTextX = {220};
  float [] congratsTextY = {255, 315, 375, 435};

  String finalGrades = "Final Grade: " + finalGrade + "%";
  String finalHealths = "Final Health: " + (health * 100) / 200 + "%";
  String finalHappinesses = "Final Happiness: " + (happiness * 100) / 200 + "%";
  String gpa = "Your Final Gpa Is: " + grade + ".0";
  room = loadImage("Congrats.png");

  fill(#FFCE00);
  textSize(28);
  text(finalGrades, congratsTextX[0], congratsTextY[0]);
  text(finalHealths, congratsTextX[0], congratsTextY[1]);
  text(finalHappinesses, congratsTextX[0], congratsTextY[2]);
  text(gpa, congratsTextX[0], congratsTextY[3]);
}

// calculates gpa
void gpaCalculator() {
  int gradeA = 4;
  int gradeB = 3;
  int gradeC = 2;
  int gradeD = 1;
  int gradeF = 0;

  int credits = 12;

  finalGrade = (grades * 100) / 200;

  if (finalGrade <= 100 && finalGrade >= 90) {
    grade = (gradeA * credits) / credits;
  }
  if (finalGrade <= 89 && finalGrade >= 80) {
    grade = (gradeB * credits) / credits;
  }
  if (finalGrade <= 79 && finalGrade >= 60) {
    grade = (gradeC * credits) / credits;
  }
  if (finalGrade <= 59 && finalGrade >= 40) {
    grade = (gradeD * credits) / credits;
  }
  if (finalGrade < 39) {
    grade = (gradeF * credits) / credits;
  }
}

// displays midway congrats screen at day 49
void congratulations2() {

  int congratulationsButtonX = 215;
  int congratulationsButtonY = 300;
  int congratulationsWidth = 250;
  int congratulationsHeight = 100;

  room = loadImage("midCongrats.png");

  stroke(#FFCE00);
  fill(0);
  rect(215, 300, 250, 100, SPACING);
  fill(#FFCE00);
  textSize(35);
  text("Continue", 250, 360);

  float congratulationsBoundX = congratulationsButtonX + congratulationsWidth;
  float congratulationsBoundY = congratulationsButtonY + congratulationsHeight;

  // if player presses continue button, to go weekcompleted screen
  if (mouseX >= congratulationsButtonX && mouseX <= congratulationsBoundX && mouseY <= congratulationsBoundY && mouseY >= congratulationsButtonY) {
    if (mousePressed == true) {
      gameScreen = "weekOver";
      room = loadImage("room.png");
      days += 1;
      weeks += 1;
    }
  }
}
