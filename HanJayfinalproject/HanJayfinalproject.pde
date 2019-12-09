
import processing.sound.*; // Import the sound library

//********** VARIABLES **********//
// --- SOUNDFILE VARIABLES --- //
SoundFile file; // song 1
SoundFile file2; // song 2
SoundFile file3; // song 3
SoundFile songMenu1; // menu song 1
SoundFile songMenu2; // menu song 2
SoundFile songMenu3; // menu song 3
SoundFile smack; // The kick sound effect
SoundFile clap; // The Food throwing sound effect
SoundFile gulp; // Gulping sound effect
SoundFile personaCall1; // voice clip 1 
SoundFile personaCall2; // voice clip 2
SoundFile reflect; // reflect voice clip
Amplitude amp; // amplitude variable

// --- IMAGE VARIABLES --- // 
PImage playButton;
PImage songSelect;
PImage helpButton;
PImage helpMenuImage;
PImage settingsButton;
PImage settingsMenuImage;
PImage xMark;
PImage songDisplay;
PImage rice;
PImage mouthBottom;
PImage mouthTop;
PImage mask;
PImage persona;
PImage cutin;
PImage scoreboard;
PImage bat;
PImage note;
PImage logo;

// --- BOOLEAN VARIABLES --- //
boolean gameStart = false; // state of the game
boolean mainMenu = false; // state to switch to main menu
boolean songMenu = false; // state to switch to song menu
boolean settingsMenu = false; // state to switch to settings
boolean helpMenu = false; // state to switch to help menu
boolean song1hover = false; // hover song 1
boolean song2hover = false; // hover song 2
boolean song3hover = false; // hover song 3
boolean songPlaying = false; // whether the song is still playing
boolean songStarted = false; // whether the song started
boolean kickActivate = false; // kicking or not
boolean kickMode = true; // enable kick
boolean eatActivate = false; // eating or not
boolean personaActivate = false; // unmask when activated
boolean cutInPlay = false; // cut in activate
boolean cutInCheck =false; // check if cut in happened
boolean cutInEnable = true; // enable/disable cut in

// HOVER VALUES //
// for menu option selecting
boolean playHover = false;
boolean songSelectHover = false;
boolean settingsHover = false;
boolean helpHover = false;


// --- OBJECT VARIABLES --- //

// FOOD //
Food[] foodArray = new Food[1]; // Food Array
int foodNum = 0; // current food index value
int foodCheck = 0; // used to check how many foods are inactive

// BAD //
Bad[] badArray = new Bad[1]; // Bad Array
int badNum = 0; // current bad index value
int badCheck = 0; // used to check how many bads are inactive

// --- OTHER VARIABLES --- //
float score = 0; // counts the score
float scoreRequirement = 500;
float textScrollVel = 10;
float textLocation = 0;
float tempTime;
int t; // current time in millis from start of program
int songNumber = 1; // current song number selected

//*******************************//

//********** SETUP/DRAW **********//
// --- SETUP FUNCTION --- //
void setup(){
  
  size(1500, 1000); // 1500 by 1000 size 
  background(255 ); // WHITE background
  
  // SOUND FILES //
  file = new SoundFile(this, "lifewillchange2.wav"); // life will change song SoundFile
  file2 = new SoundFile(this, "rivers.mp3"); // rivers in the desert song SoundFile
  file3 = new SoundFile(this, "beneath.mp3"); // beneath the mask song Soundfile
  songMenu1 = new SoundFile(this, "lifewillchange2.wav"); // life will change song SoundFile (menu)
  songMenu2 = new SoundFile(this, "rivers.mp3"); // rivers in the desert song SoundFile (menu)
  songMenu3 = new SoundFile(this, "beneath.mp3"); // beneath the mask song song Soundfile (Menu)
  smack = new SoundFile(this, "smack.wav"); // smack sound SoundFile
  clap = new SoundFile(this, "clap.wav"); // clap sound SoundFile
  gulp = new SoundFile(this, "gulp.wav"); // gulp sound SoundFile
  personaCall1 = new SoundFile(this, "personaCall.wav");
  personaCall2 = new SoundFile(this, "arseneCall.wav");
  reflect = new SoundFile(this, "reflect.wav");
  amp = new Amplitude(this); // Amplitude value of the song
  
  // IMAGE FILES //
  playButton =loadImage("playbutton.png");
  songSelect = loadImage("songselect.png");
  helpButton = loadImage("helpbutton.png");
  settingsButton = loadImage("settings.png");
  songDisplay = loadImage("songdisplay.png");
  rice = loadImage("rice.png");
  mouthBottom = loadImage("mouthBottom.png");
  mouthTop = loadImage("mouthTop.png");
  mask = loadImage("mask.png");
  persona = loadImage("arsene.png");
  cutin = loadImage("cutin.png");
  scoreboard = loadImage("scoreboard.png");
  bat = loadImage("bat.png");
  helpMenuImage = loadImage("helpmenu.png");
  settingsMenuImage = loadImage("settingsmenu.png");
  xMark = loadImage("xmark.png");
  note = loadImage("note.png");
  logo = loadImage("logo2.png");
  
}

// --- DRAW FUNCTION --- //
void draw(){
  t = millis(); // updating t variable each time for how many millis passed
  background(255,0,0); // set RED background 
 // rect(750,100,20,20);
 // rect(1060,100,20,20);
  if(gameStart == true){ // if the game has started
    songMenu1.stop();
    songMenu2.stop();
    songMenu3.stop();
    if(songNumber == 1){
      songPlaying = file.isPlaying(); // check if song is playing
    }
    else if(songNumber == 2){
      songPlaying = file2.isPlaying(); // check if song is playing
    }
    else if(songNumber == 3){
      songPlaying = file3.isPlaying(); // check if song is playing
    }
    gamePlaying(); // call function that starts the game
  }
  else{
    startMenu(); // if the game hasn't started, open the main menu
  }
}
//********************************//

//**********FUNCTIONS**********//

// --- START MENU FUNCTION --- //
void startMenu(){ // opens the start menu
  if(mainMenu == false && songMenu == false){ // loads start menu if set to false
    background(0);
    image(logo,250,0, 1000,680);
    textSize(26);
    
    textLocation += textScrollVel; // move text in the title screen
    if(textLocation >= 1500){
      textLocation = -200;
    }
    fill(255,0,0); // borders
    rect(0, 700, 1500, 500);
    rect(0, 0, 1500,50);
    
    fill(0);
    text("Click Anywhere to Begin" , textLocation, 750); // draw the text
  }
  else if(mainMenu == true && songMenu == false && helpMenu == false && settingsMenu == false){ //if in main menu
    mainMenu(); // opens main menu if past title menu
  }
  else if(mainMenu == false && songMenu == true){ // song menu
    songMenu();
  }
  else if(mainMenu == true && helpMenu == true){ // help menu
    mainMenu();
    helpMenu();
  }
  else if(mainMenu == true && settingsMenu == true){ //settings menu
    mainMenu();
    settingsMenu();
  }
 
}

// --- MAIN MENU FUNCTION --- //
void mainMenu(){
  menuMouseCheck();
  background(0); // set BLACK background 
  fill(255);
  textSize(50);
  text("MAIN MENU", 100, 110);
  
  image(playButton, 100,170); // play button 
  image(songSelect, 540, 170); // song select button
  image(settingsButton, 980, 170); // settings button
  image(helpButton, 980, 520); // help button
  
  image(songDisplay, 600, 50); // displays the song
  fill(0);
  textSize(35);
  if(songNumber == 1){ // if song number is 1
    text("Current Song: Life Will Change", 780, 105);
  }
  else if(songNumber == 2){ // if song number is 2
    text("Current Song: Rivers in the Desert", 780, 105);
  }
  else if(songNumber == 3){ // if song number is 3
     text("Current Song: Beneath the Mask", 780, 105);
  }
  
  fill(255);
  textSize(50);
  if(playHover == true){
    text("START PLAYING", 550, 920);
  }
  else if(songSelectHover == true){
    text("CHANGE SONG", 560, 920);
  }
  else if(settingsHover == true){
    text("SETTINGS", 630, 920);
  }
  else if(helpHover == true){
    text("HOW TO PLAY", 560, 920);
  }
  
}

// --- SONG MENU FUNCTION --- //
void songMenu(){
  songMouseCheck();
  fill(255);
  textSize(50);
  text("SONG SELECTION", 100, 110);
  image(note, 5, 250);
  fill(0);
  textSize(35);
  image(songDisplay, 500, 150); // displays the song 1
  text("Life Will Change" ,680, 200);
  image(songDisplay, 500, 450); // displays the song 2 
  text("Rivers in the Desert" ,680, 500);
  image(songDisplay, 500, 750); // displays the song 3
  text("Beneath the Mask" ,680, 800);
  
  if(song1hover == true){ // preview play song 1 
    if(songMenu1.isPlaying() == false){
      songMenu1.play();
    }
    text("Length: 4:22" ,680, 300);  // song is 4:22 long
    text("Difficulty: Easy" ,680, 350); // easy
  }
  else if(song2hover == true){ // preview play song 2
    if(songMenu2.isPlaying() == false){
      songMenu2.play();
    }
    text("Length: 5:16" ,680, 600); // song is 5:16 long
    text("Difficulty: Moderate" ,680, 650); // moderate
  }
  else if(song3hover == true){ // preview play
    if(songMenu3.isPlaying() == false){
      songMenu3.play();
    }
    text("Length: 5:24" ,680, 900); // song is 5:24 long
    text("Difficulty: Hard" ,680, 950); // hard
  }
  else{
    // stop all songs if not hovering over anything
    songMenu1.stop();
    songMenu2.stop();
    songMenu3.stop();
  }
}

// --- HELP MENU FUNCTION --- //
void helpMenu(){
  image(helpMenuImage, 200, 200);
}

// --- SETTINGS MENU FUNCTION --- //
void settingsMenu(){
  image(settingsMenuImage, 200, 200);
  xMarking();
  fill(0);
  textSize(40);
  text("Enable Persona at Start", 370, 380);
  text("Disable Kick Part", 370, 528);
  text("Disable Cut In Animation", 370, 691);
}

// --- GAME PLAY FUNCTION --- //
void gamePlaying(){ // starts the game up

  if(!songStarted){ // if the song has not started yet ***
    if(songNumber == 1){
      file.play(); // start the song
      amp.input(file); //measure the amplitude of the song
    }
    else if(songNumber == 2){
      file2.play(); // start the song
      amp.input(file2); //measure the amplitude of the song
    }
    else if(songNumber == 3){
      file3.play(); // start the song
      amp.input(file3); //measure the amplitude of the song
    }
    songStarted = true; // song is now set to 'started'
}

if(songPlaying == true){ // if the song is playing ***

  // SCOREBOARD //
  image(scoreboard, -500, 50);
  fill(0); // fill WHITE
  textSize(50); // setting text size
  text("SCORE: " + score ,110,110); // draws the score point value
  
  if(personaActivate == true){
    image(persona, 700, 180);
  }
  // LEG //
  drawLeg();
  
  // BODY //
  rect(920, 500,150,250);
  
  // TABLE //
  fill(0);
  rect(0,450,850,100);
  rect(850,450,50,800);
  
  // HEAD //
  drawHead();

  // DRAWS FOOD AND BAD //
  if(amp.analyze() > 0.6){ // if amp measured reaches above 0.6
    drawFood(); // draw food
    if(kickMode == true){
      drawBad(); // draw bad
    }
  }
  updateFood(); // updates food state
  if(kickMode == true){
    updateBad(); // updates bad state
  }
   if(personaActivate == true && cutInPlay == false && cutInEnable == true){
     image(cutin, 0,150, 1500,500);
     if(cutInCheck == false){
        tempTime = t;
        cutInCheck = true;
     }
     else if(cutInCheck == true && (millis()-tempTime) >= 1000 && cutInEnable == true){
       cutInPlay = true;
   }
}}
else if (songPlaying == false && songStarted == true){ // when the song ends
  fill(0);
  textSize(50);
  text("GAME OVER! SCORE: " +score, 300, 500); // display end score
}
}


// --- DRAW HEAD --- //
void drawHead(){
  fill(255); // set head to white
  mouthAction(); // calls mouth action value (to opne and close mouth)
  //arc(950, 450, 200, 200, 0, PI, CHORD); // bottom of the mouth
  
  if(score >= scoreRequirement && personaActivate == false){ // activate person if score requiement is met
    personaActivate = true;
    float random = random(0,2); // chooses a random voice line to use when activating persona
    if(random <= 1){
      personaCall1.play(); // PERSONA
    }
    else{
      personaCall2.play(); // ARSENE
    }
  }
  
  image(mouthBottom, 850, 450, 220,100); // draws the bottom of the mouth
}

// --- MOUTH ACTION --- //
void mouthAction(){ // to open and close mouth based on MOUSE input
  if (eatActivate == true){ // variable changes state based on MOUSE state
    //arc(950, 450, 200, 200, PI,2*PI, CHORD); // close mouth
    image(mouthTop, 850, 350, 220,100);
    if(personaActivate == false){
      image(mask, 850, 340, 110, 120);
    }
  }
  else{
    // arc(950, 350, 200, 200, PI,2*PI, CHORD); // open mouth
    image(mouthTop, 850, 250, 220,100);
    if(personaActivate == false){
      image(mask, 850, 240,110, 120);
    }
  }
}

// --- DRAW LEG --- //
void drawLeg(){
  fill(0); // fill black
 if(kickActivate ==true){ // activate a kick based on KEYBOARD input
     rect(640, 700, 300, 50); // kick activated +
 }
 else{
    rect(940, 700, 50, 300); // kick DEactivated -
 }
}

// --- DRAW FOOD --- //
void drawFood(){
  if(foodNum < 1){ // if the current food index is set to 0
      Food rhythmfood = new Food(35); // create a new food object
      foodArray[foodNum] = rhythmfood; // add new food object to food array at that index value
      clap.play(); // play the clap sound
      foodNum++; // increment food index
  }
  else{ // if current food index is not 0
    for(int i = 0; i < foodArray.length; i++){ // go through the food array
      if (foodArray[i].active == false){ // if the food object at the index is not active
          foodCheck++; // increment the food check value
      }
    }
    if(foodCheck == foodArray.length){ // check if the whole food array is inactive
      foodNum = 0; // set food index back to 0
      foodCheck = 0; // set food check value back to 0
    }
    else{
      foodCheck = 0; // reset the foodcheck value to prepare for the next check
  }
}  
}

// --- UPDATE FOOD -- //
void updateFood(){ // updates the food location and attributes based on things that occur in game.
  if(foodNum > 0){ // if the food index is not 0 
    for(int i = 0; i < foodNum; i++){  // loop through the for however many are in the food array
      foodArray[i].display(); // display each food object
      foodArray[i].shift(); // shift each food object
      
      if(foodArray[i].x_loc >= 1069 && foodArray[i].reflected == false){ // if food object reaches a certain point (MISSING)
        if(foodArray[i].x_loc >= 1244 && personaActivate == true && foodArray[i].hit == false && foodArray[i].reflected == false){ // reflect food when persona is activated
          fill(0, 50, 255);
          drawReflect();
          reflect.play();
          foodArray[i].active = false; // set the food object to inactive
          foodArray[i].gravity = -50; // when you miss
          foodArray[i].velocity = 0;
          foodArray[i].reflected = true;
          score -= 10;
        }
        else{
         if(personaActivate == false){ // if persona is not active
           foodArray[i].active = false; // set the food object to inactive
         }
        foodArray[i].gravity = 12; // set the gravity so the food falls when you miss 
        }
      }
      
      if(foodArray[i].x_loc >= 857 && foodArray[i].x_loc < 1069 && foodArray[i].active == true && eatActivate == true ){ // if the food object reached a certain range and is eaten (NOT MISSING)
        foodArray[i].hit = true; // set the food object state to 'hit'
        foodArray[i].active = false; // set the food object to inactive
      }
    }
  }
}
void drawReflect(){ // draws the reflect circle
  ellipse(1348, 541, 200,200);
}
// --- DRAW BAD --- //
void drawBad(){
  if(badNum < 1){ // if the current bad index is set to 0
      Bad rhythmbad = new Bad(5); // create a new bad object
      badArray[badNum] = rhythmbad; // add new food object to bad array at that index value
      //clap.play();
      badNum++; // increment bad index
  }
else{ // if current bad index is not 0
  for(int i = 0; i < badArray.length; i++){ // go through the bad array
    if (badArray[i].kickedOut == true && badArray[i].active == false){ // if the food object at the index is not active and off screen
        badCheck++; // increment the bad check value
    }
  }
  if(badCheck == badArray.length){ // check if the whole bad array is inactive
    badNum = 0; // set bad index back to 0
    badCheck = 0; // set bad check value back to 0
  }
  else{
    badCheck = 0; // reset the badcheck value to prepare for the next check
  }
}   
}

// --- UPDATE BAD --- //
void updateBad(){ // updates the bad location and attributes based on things that occur in game.
  if(badNum > 0){ // if the bad index is not 0 
  for(int i = 0; i < badNum; i++){ // loop through the for however many are in the bad array
    badArray[i].display(); // display each bad object
    badArray[i].shift(); // shift each bad object
    
    if(badArray[i].x_loc >= 850){ // if bad object reaches a certain point (MISSING)
      badArray[i].active = false; // set the bad object to inactive
      badArray[i].gravity = 10; // set the gravity so the bad falls when you miss 
    }
    
    if(badArray[i].x_loc >= 640 && badArray[i].active == true && kickActivate == true ){ // if the bad object reached a certain range and is eaten (NOT MISSING)
      badArray[i].hit = true; // set the bad object state to 'hit'
      badArray[i].active = false; // set the bad object to inactive
    }
  }
  }
}

// --- MENU MOUSE CHECK --- //
void menuMouseCheck(){
 if(mouseX >= 100 && mouseX <= 489 && mouseY >= 169 && mouseY <= 828){ // play
    playHover = true; // if mouse is hovering over play button
    
    // sets all other variables to false //
    songSelectHover = false;
    settingsHover = false;
    helpHover = false;
  }
  else if(mouseX >= 539 && mouseX <= 928 && mouseY >= 169 && mouseY <= 828){ // song select
    songSelectHover = true; // if mouse is hovering over song select button
    
     // sets all other variables to false //
    playHover= false;
    settingsHover = false;
    helpHover = false;
  }
  else if(mouseX >= 980 && mouseX <= 1369 && mouseY >= 169 && mouseY <= 478){ //settings
    settingsHover = true; // if mouse is hovering over settings button
    
     // sets all other variables to false //
    playHover= false;
    songSelectHover = false;
    helpHover = false;
  }
  else if(mouseX >= 980 && mouseX <= 1369 && mouseY >= 518 && mouseY <= 828){ // help
    helpHover = true; // if mouse is hovering over help button
    
     // sets all other variables to false //
    playHover= false;
    songSelectHover = false;
    settingsHover = false;
  }
  else{ // if hovering over neither
    playHover= false; 
    songSelectHover = false;
    settingsHover = false;
    helpHover = false;
  }
}

// --- SONG MOUSE CHECK --- //
void songMouseCheck(){
  if(mouseX >= 571 && mouseX <= 1500 && mouseY >= 151 && mouseY <= 221){ // hover over sound 1
    song1hover = true; // set 1 to true
    song2hover = false;
    song3hover = false; // set 2,3 to false
  }
  else if(mouseX >= 571 && mouseX <= 1500 && mouseY >= 450 && mouseY <= 524){ // hover over sound 2
    song1hover = false;
    song2hover = true; // set 2 to true
    song3hover = false; // set 1, 3 to false
  }
  else if(mouseX >= 571 && mouseX <= 1500 && mouseY >= 751 && mouseY <= 826){ // hover over sound 3
    song1hover = false;
    song2hover = false;
    song3hover = true; // set 3 to true
                       // set 1,2 to false
  }
  else{
    song1hover = false;
    song2hover = false;
    song3hover = false; // set all to false
  }
}

// --- X MARK --- //
void xMarking(){ // mark an X on the box for settings if activated
  if(personaActivate == true){ // mark the first option if on
    image(xMark, 279,340);
  }
  if(kickMode == false){ // mark the second option if on
    image(xMark, 279,488);
  }
  if(cutInEnable == false){ // mark the third option if on
    image(xMark, 279,641);
  }
}
//********************************//

//********** INPUT FUNCTIONS **********//

// --- MOUSE INPUT --- //
void mousePressed(){ // mouse pressed
if(gameStart == false && mainMenu == false && songMenu == false){ // if the game hasn't started (IF STILL IN START MENU)
  mainMenu = true; // switch to main menu
}
else if(gameStart == false && mainMenu == true && settingsMenu == false && helpMenu == false){ // if STILL IN MAIN MENU
  if(playHover == true && settingsMenu == false && helpMenu == false){
    gameStart =true; // start the game
    mainMenu = false; // no longer in the main menu
    clap.play();
  }
  else if(songSelectHover == true && mainMenu == true && settingsMenu == false && helpMenu == false){ // if song option is selected
    mainMenu = false;
    songMenu = true; // open song menu
    clap.play();
  }
  else if(settingsHover == true && mainMenu == true && helpMenu == false){
    settingsMenu = true; // open settings
    clap.play();
  }
  else if(helpHover == true && mainMenu == true && settingsMenu == false){
    helpMenu = true; // open help menu
    clap.play();
  }
}
else if(songMenu == true && mainMenu == false){ // IN SONG MENU
  if(song1hover == true){ // when song 1 is selected
    songNumber = 1;  
    songMenu = false; // go back to main
    mainMenu = true;
    clap.play();
  }
  else if(song2hover == true){ // when song 2 is selected
    songNumber = 2;
    songMenu = false; // go back to main
    mainMenu = true;
    clap.play();
  }
  else if(song3hover == true){ // when song 3 is selected
    songNumber = 3; 
    songMenu = false; // go back to main
    mainMenu = true;
    clap.play();
  }
}
else if(helpMenu == true){
  if(mouseX >= 1161 && mouseX <= 1257 && mouseY >= 199 && mouseY <= 296){ // when hovering over the x button in help
    helpMenu = false;
    mainMenu = true;
    clap.play();
  }
}
else if(settingsMenu == true){
  if(mouseX >= 1161 && mouseX <= 1257 && mouseY >= 199 && mouseY <= 296){ // when hovering over the x button in settings
    settingsMenu = false;
    mainMenu = true;
    clap.play();
  }
  else if(mouseX >= 289 && mouseX <= 327){ // toggle persona option
    if(mouseY >= 350 && mouseY <= 387){
      if(personaActivate == true){
        personaActivate = false;
      }
      else{
      personaActivate = true;
      }
      clap.play();
    }
    else if (mouseY >= 498 && mouseY <= 537){ // toggle kick option
      if(kickMode == true){
        kickMode = false;
      }
      else{
        kickMode = true;
      }
      clap.play();
    }
    else if (mouseY >= 651 && mouseY <= 687){ // toggle cut in option
      if(cutInEnable == true){
        cutInEnable = false;
      }
      else{
        cutInEnable = true;
      }
      clap.play();
    }
  }
}
else if(gameStart == true){ // if the game is started
  gulp.play(); // play gulp sound effect
  eatActivate = true; // set the eat value to true
}
}

void mouseReleased(){ // when the mouse is released
eatActivate = false; // eat value is set to false
}

void keyPressed(){ // when any key is pressed 
  if(gameStart == true && kickMode == true){  // if the game has started
  smack.play(); // play the smask sound effect
  kickActivate = true; // set the kick value to true
}
}

void keyReleased(){ // when the key is released
kickActivate = false; // set the kick value to false
}
//********************************//

//********** CLASSES **********//

// --- FOOD CLASS --- //
class Food{ 
  // FOOD ATTRIBUTES //
  int velocity; // valocity of food
  int gravity=0; // gravity (down)
  int x_loc = 0; // x location of food
  int y_loc = 430; // y location of food
  
  boolean active = true; // food active state
  boolean kickedOut =false; // onscreen or offscreen
  boolean hit = false; // hit or not
  boolean scoreUpdate = false; // if score was updated or not
  boolean reflected = false; // whether it was reflected or not
  
  // FOOD CONSTRUCTOR //
Food(int v){ // food constructor only takes in velocity value
 velocity = v; 
}
  // FOOD CLASS FUNCTIONS //
void display(){ // food display function
  if(hit == false){ // if hit is set to false
    //fill(200); //draws the food
    //ellipse(x_loc, y_loc, 20, 20);
    image(rice,x_loc,y_loc, 30,30);
  }
  else if(hit == true && scoreUpdate == false){ // if hit
    score +=10; // updates score
    scoreUpdate = true; // score has been updated
  }
}

void shift(){ // shift function
  if(hit == false){ // if hit is false
    x_loc += velocity; // xlocation incremented by velocity
    y_loc += gravity; // ylocation is incremented by gravity
  }
}
}
// --- BAD CLASS --- //
class Bad{
  // BAD ATTRIBUTES //
  int velocity; // velocity of bad
  int gravity=0; // gravity (up/down)
  int x_loc = 0; //  xlocation
  int y_loc = 650; // y location
  
  boolean active = true; // bad active status
  boolean kickedOut =false; // on screen or not
  boolean hit = false; // hit or not
  boolean scoreUpdate = false; // if score was updated or not
  
   // BAD CONSTRUCTOR // 
Bad(int v){ // bad constructor only takes in velocity value
 velocity = v;
}

  // BAD CLASS FUNCTIONS //
void display(){ // bad display function
    fill(200,0,100); // draws bad
    //ellipse(x_loc, y_loc, 50, 50);
    image(bat, x_loc -80, y_loc);
 if(hit == true && scoreUpdate == false){ // if hit
    score +=10; // updates score
    scoreUpdate = true; /// score has been updated
  }
  
  if(y_loc <= 0){ // if the bad is offscreen
    kickedOut = true; // set kick out to true
  }
  else if (y_loc >= 1000){ // if bad is offscreen at the bottom
    kickedOut = true; // set kick out to true
  }
}

void shift(){ // bad shift function
  if(hit == false){ // if hit is false
    x_loc += velocity; // increment x by velocity
    y_loc += gravity; // increment y by gravity
  }
  else if(hit == true){ // if hit is true (LAUNCH EFFECT)
    x_loc -= 4*velocity; // increment x by that value
    y_loc -= 6*velocity; // increment y by that value
  }
}
}
