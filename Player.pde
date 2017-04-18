class Player extends Entity{
    float Xpos, Ypos;
    float Xacc, Yacc;
    int oWidth, oLength;
    float cannonAngle, wheelAngle;
    final float BASEHEIGHT = height - 200;
    
    PImage ship, wheel, cannon;
    
    int health;
    boolean isDead = false;
    
    Projectile[] cannons = new Projectile[3];
    
    Player(){
      ship = loadImage("ship.png");
      wheel = loadImage("wheel.png");
      cannon = loadImage("cannon.png");
      for(int i = 0; i < cannons.length; i++){
        cannons[i] = new Projectile();
       
      }
      Xpos = 50;
      Ypos = BASEHEIGHT;
      health = 5;
      oWidth = ship.width;
      oHeight = ship.height;
    }
    
    void setHard(){
      health = 3;
    }
    
    void calcShip(){
      Xpos += Xacc;
      Ypos += Yacc;
      findAngle();
      wheelAngle += 1;
      if(wheelAngle > 360)
        wheelAngle -= 360;
      if(Ypos < BASEHEIGHT){
        Yacc += 0.15;
      }
      if(Ypos > BASEHEIGHT){
        Yacc = 0;
        Ypos = BASEHEIGHT;
      }
      if(health < 1)
      isDead = true;
    }
    
    
    void draw(){
      for(Projectile p: cannons){
        p.draw();
      }
      
      calcShip();
       pushMatrix();
       translate(Xpos,Ypos);
       image(ship,0,0);
       pushMatrix();
       translate(45,110);
       imageMode(CENTER);
       rotate(radians(wheelAngle));
       image(wheel,0,0);
       popMatrix();
       translate(91,20);
       imageMode(CORNER);
       rotate(-cannonAngle);
       image(cannon,0,-cannon.height/2);
       popMatrix();
    }
    
    void findAngle(){
        float Xcomp = mouseX - ((Xpos) + 91);
        float Ycomp = ((Ypos) + 20) - mouseY;
        
        cannonAngle = atan2(Ycomp,Xcomp);
        if(cannonAngle < 0)
          cannonAngle += 2*PI; // [0, 2PI)
          
        if(cannonAngle > PI){
          if(cannonAngle > 3*PI/2){
            cannonAngle = 0;
          } else {
            cannonAngle = PI;
          }
        }
        
        //println( Xcomp + " " + Ycomp + " " + cannonAngle);
        
    }
    
    void checkKey(char key){
      if(key == 'd'){
        Xacc = 3;
      } else if(key == 'a'){
        Xacc = -3;
      }
      else if(key == ' ' && Ypos == BASEHEIGHT){
        Yacc = -7;
      }
    }
    void checkRelease(char key){
      if(key == 'd' || key == 'a'){
        Xacc = 0;
      }
    }
    void fireCannon(){
      for(Projectile p: cannons){
          if(!p.active){
            p.fire(cannonAngle); //<>//
            break;
          }
      }
    }
    
    void hit(){
      health--;
      if(health == 0)
        isDead = true;
    }
  
}