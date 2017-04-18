/* //<>// //<>// //<>//
 This class manages all the game logic and progression
 Hello
 */

class Game {

  final int SCROLLSPEED = 2;

  PImage[] background = new PImage[2];  //background images
  int bgPosA;
  int bgPosB;

  PImage[] waves = new PImage[2];  //wave images
  int wavePosA;
  int wavePosB;

  PImage heart;

  int score = 0;


  //Enemy test = new Enemy(width + 200, 70, 2);

  Log log1;
  Log log2;
  float counter; //times the game
  ArrayList<Enemy> enemyList;
  Enemy tempEnemy;
  int randInt;
  int randInt2;


  Game() {
    //load images for the environment
    background[0] = loadImage("bg1.jpg");
    background[1] = loadImage("bg2.jpg");
    waves[0] = loadImage("waves.png");
    waves[1] = loadImage("waves.png");
    bgPosA = 0;
    bgPosB = background[0].width;
    wavePosA = 0;
    wavePosB = waves[0].width;
    log1 = new Log(4, 1200);
    log2 = new Log(4, 1800);
    counter = 0;
    randInt = 100;
    randInt2 = 0;
    enemyList = new ArrayList<Enemy>();

    heart = loadImage("heart.png");

    //initialize the player object
    player = new Player();
  }

  void drawGame() {
    //Do these even if the menu is open
    image(background[0], bgPosA, 0);
    image(background[1], bgPosB, 0);
    player.draw();

    if (gameActive) {
      //test.draw();
      log1.draw();

      if (isHard ==true) {
        log2.draw();
        if (counter>randInt) {
          randInt=int(random(200-randInt2, 400-randInt2));
          if(randInt2 <180){
            randInt2 = randInt2 +20;
          }
          counter = 0;
          tempEnemy = new Enemy(1400, int(random(90, 220)), 4);
          enemyList.add(tempEnemy);
        }
        for (int i =0; i<enemyList.size(); i++) {
          enemyList.get(i).draw();
        }
        
        for(int j = enemyList.size()-1; j>=0; j--){
          if(enemyList.get(j).x<-200 || enemyList.get(j).isHit){
              println("hit Bat");
               enemyList.remove(j);
          }
        }
      } else {
        //counter just ticks once every cycle. 
        //The randInt sets the frequency of enemy spawns. i.e. there is a spawn every randInt ticks.
        if (counter>randInt) {
          randInt=int(random(200-randInt2, 400-randInt2));
          //setting randInt to a slightyly random number keeps the enemy spawn distances somewhat random. 
          randInt2 = randInt2 + 30;
          //randInt2 is used to gradually decrease randInt (i.e. increase speed of spwans)
          //Increase randInt2 to increase the rate that enemy spawns speed up
          counter = 0;
          tempEnemy = new Enemy(1400, int(random(90, 220)), 2);
          enemyList.add(tempEnemy);
        }
        for (int i =0; i<enemyList.size(); i++) {
          enemyList.get(i).draw();
        }
        
        for(int j = enemyList.size()-1; j>=0; j--){
          if(enemyList.get(j).x<-200 || enemyList.get(j).isHit){
              println("hit Bat");
               enemyList.remove(j);
          }
        }
      }

      counter++;
      //println(counter);
    }
    image(waves[0], wavePosA, height - waves[0].height);
    image(waves[1], wavePosB, height - waves[1].height);





    if (gameActive) {  //process game logic only when the game has begun
      collisionCheck(player, log1, false, false);
      collisionCheck(player, log2, false, false);
      for (Enemy e : enemyList) {
        for (Projectile c : player.cannons) {
          collisionCheck(c, e, false, true);
          if(e.bomb.active)
          collisionCheck(c, e.bomb, true, true);
        }
        collisionCheck(player, e.bomb, false, false);
      }
      for (Projectile c : player.cannons) {
        collisionCheck(c, log1, false, true);
        collisionCheck(c, log2, false, true);
      }
      tick();
      drawHud();
    }
    if (player.isDead) {
      gameActive = false;
      textAlign(CENTER);
      textSize(50);
      fill(255, 0, 0);
      text("Game Over!\nScore: " + score, width/2, height/2);
    }
  }

  void drawHud() {
    fill(#E3FFB4
      );
    stroke(#4B230B
      );
    rect(0, 0, width, 50);
    fill(#4B230B
      );
    textAlign(LEFT);
    textSize(25);
    text("Health:", 5, 30);
    for (int i = 0; i < player.health; i++) {
      image(heart, 110 + (i * 33), 10);
    }

    text("Score: " + score, 500, 30);
  }

  void tick() {
    bgPosA -= SCROLLSPEED;
    bgPosB -= SCROLLSPEED;
    wavePosA -= (SCROLLSPEED - 1);
    wavePosB -= (SCROLLSPEED - 1);

    if (bgPosA < -background[0].width) {
      bgPosA = bgPosB + background[1].width;
    }
    if (bgPosB < -background[1].width) {
      bgPosB = bgPosA + background[0].width;
    }

    if (wavePosA < -waves[0].width) {
      wavePosA = wavePosB + waves[1].width;
    }
    if (wavePosB < -waves[1].width) {
      wavePosB = wavePosA + waves[0].width;
    }
  }

  void collisionCheck(Entity a, Entity b, boolean round, boolean score) {
    if (!round) {
      // println("a: " + a.x + "b: " + b.x);
      //println("a: " + a.y + "b: " + b.y);
      //println((a.oWidth + b.oWidth));
      //println(abs(a.y - b.y) * 2);
      // println((a.oHeight + b.oHeight));
      if ((abs(a.x - b.x) * 2 < (a.oWidth + b.oWidth)) && (abs(a.y - b.y) * 2 < (a.oHeight + b.oHeight))) {
        a.hit();
        b.hit();
        if (score)
          this.score++;
      }
    } else {
      if (sqrt(pow(a.y - b.y, 2) + pow(a.x - b.x, 2)) < (a.oWidth / 2 + b.oWidth / 2)) {
        a.hit();
        b.hit();
        if (score)
          this.score++;
      }
    }
  }
}