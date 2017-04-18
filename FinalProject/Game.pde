/*
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

    Enemy test = new Enemy(width + 200, 70, 2);
    Log log = new Log(2);

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

            test.draw();
            log.draw();
        }
        image(waves[0], wavePosA, height - waves[0].height);
        image(waves[1], wavePosB, height - waves[1].height);

        if (gameActive) {  //process game logic only when the game has begun
            collisionCheck(log, player, false);
            collisionCheck(log, player.cannons[0], false);
            tick();
            drawHud();
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

    void collisionCheck(Entity a, Entity b, boolean round) {
        if (!round) {

            if ((abs(a.x - b.x) * 2 < (a.oWidth + b.oWidth))
                    && (abs(a.y - b.y) * 2 < (a.oHeight + b.oHeight))) {

                a.hit();
                b.hit();
            }

        } else {
            if (sqrt(pow(a.y - b.y, 2) + pow(a.x - b.x, 2)) < (a.oWidth / 2 + b.oWidth / 2)) {
                a.hit();
                b.hit();
            }

        }
    }
}