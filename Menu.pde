//menu class, implements buttons
  
class Menu {

    static final int MENU_BUTTONS = 4;
    Button[] menu = new Button[MENU_BUTTONS];
    //PImage title;
    

    //construct a menu with the necessary buttons
    Menu() {
        menu[0] = new Button("Start", width/2-125, 200, color(#79DE48), color(#BEEDA8));
        menu[1] = new Button("Exit", width/2-125, 300, color(#79DE48), color(#BEEDA8));
        menu[2] = new Button("Easy", width/2-275, 500, color(#79DE48), color(#BEEDA8));
        menu[3] = new Button("Hard", width/2+25, 500, color(#79DE48), color(#BEEDA8));
        //title = loadImage("titlescreeng1.jpg");
    }

    //draw the menu items
    void displayMenu() {
        //image(title,0,0);
        fill(255,0,0);
        text("The Great Sea",width/2,100);
        menu[2].active = !isHard;
        menu[3].active = isHard;
        for (Button b : menu) {
            b.draw();
        }
    }

    //check if buttons are pressed and act accordingly
    void checkPressed() {
        if (menu[0].mouseOn()) {
            menuActive = false;
            instructions = true;
        } else if (menu[1].mouseOn()) {
            exit();
        } else if (menu[2].mouseOn()) {
            isHard = false;
        } else if (menu[3].mouseOn()) {
            isHard = true;
            player.setHard();
        }
    }
}