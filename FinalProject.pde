/*
 This is the main file of the program from which the game runs
 */

import processing.sound.*;

boolean menuActive = true,   //switches for game conditions
        gameActive = false, 
        instructions = false,
        isHard = false;

Menu startScreen;
SoundFile theme;
Game game;
Player player;

PImage instruct;

void setup() { //<>//
  size(1200, 750);
  //initialize all objects
  startScreen = new Menu();
  game = new Game();
  theme = new SoundFile(this, "AtSea.mp3");
  instruct = loadImage("instructions.png");
  //theme.loop();
}

void draw() {
  game.drawGame();
  if(menuActive)
    startScreen.displayMenu();
  else if(instructions)
    image(instruct,50,50);
}

void mousePressed() {
  if(menuActive){
    startScreen.checkPressed();
  } else if(instructions){
    instructions = false;
    gameActive = true;
  } else {
    player.fireCannon(); //<>//
  }
}

void keyPressed(){
    if(gameActive){
      player.checkKey(key);
  }
}

void keyReleased(){
    if(gameActive){
      player.checkRelease(key);
  }
}