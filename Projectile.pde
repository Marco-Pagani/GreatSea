
class Projectile extends Entity{
  float x, y, xa, ya;
  int radius = 25;
  boolean active;
  int MOMENT;
  color c;
  int oHeight = radius*2;
  int oWidth = radius*2;
  
  Projectile(){
    x = -10;
    y = -10;
    active = false;
    MOMENT = 15;
    c = 33;
  }
  
  Projectile(int moment, color c){
    x = -10;
    y = -10;
    active = false;
    MOMENT = moment;
    this.c = c;
  }
  
  void fire(float angle){
    println(angle);
    x = player.Xpos + 91;
    y = player.Ypos + 20;
    ya = MOMENT * -sin(angle);
    xa = MOMENT * cos(angle);
    active = true;
  }
  
  void draw(){
    fill(c);
    stroke(0);
    if(active){
    x += xa;
    y += ya;
    ya += 0.2;
    }
    ellipse(x,y,radius,radius);
    if(y > height || x > width + radius || x < -radius){
      active = false;
      xa=0;
      ya=0;
    }
  }
  
  void hit(){
    active = false;
    xa=0;
      ya=0;
      x = -10;
      y = -10;
  }
  
}