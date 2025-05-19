#include <ncurses.h>
#include <stdlib.h>
#include "jhbcligui/jhbcligui.h"
//#define NULL ((void *)0)

void zzz() {
    clear();
    printw("Putting PC to Sleep");
    echo();
    system("sudo zzz");
}

void reboot() {
    clear();
    printw("Rebooting PC");
    echo();
    system("sudo reboot");
}

void poweroff() {
    clear();
    printw("Turning PC off");
    echo();
    system("sudo poweroff");
}

int start_menu() {
    const char* choices[] = {
        "Sleep",
        "Reboot",
        "Poweroff",
        "Cancel"
    };
    int choice_count = sizeof(choices) / sizeof(char*);
    Vec2 box_size = { .y = choice_count + 4 , .x = 18};
    while(1) {
        clear();
        int awnser = selection_box("Settings",  box_size, Middle_Middle 
                                   , choices , choice_count);
    
        switch(awnser) {
            case 0:
                zzz();
            break;
            case 1:
                reboot();
            break;
            case 2:
                poweroff();
            break;
            case 3:
                return 0;
            break;
            default:
            break;
    }    
    }
}

int main(int argc , char *argv[]) {
    initscr(); 
    noecho();
   
    start_menu();

    endwin();
    return 0;
}
