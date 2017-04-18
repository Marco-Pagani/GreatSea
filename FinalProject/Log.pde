/*
This class should include obstacles that must be avoided in the water
*/
/*
This class should include obstacles that must be avoided in the water
*/

class Log extends Entity{
    float x, y,z;
    float speed;
    float oHeight;
    float oWidth;
    PImage log;
    Log(float speed){
         log = loadImage("log.png");
         x =1200; 
         y=605;
         z = 0;
         this.speed = speed;
         oHeight = log.height;
         oWidth = log.width;
    }
    void calc(){
      x -=speed;
      z+=.03;
      y = 605 + 10*sin(z);
    }
    
    void draw(){
     calc();
     image(log, x,y);
    }
    void hit(){
        x = -250;
    }
}
