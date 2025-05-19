#ifndef INCLUDE_JHBCLIGUI_H 
#define INCLUDE_JHBCLIGUI_H

typedef enum Window_Place{
    Top_Left,
    Top_Middle,
    Top_Right,
    Middle_Left,
    Middle_Middle,
    Middle_Right,
    Bottom_Left,
    Bottom_Middle,
    Bottom_Right
} Window_Place;

typedef struct Vec2 {
    int x;
    int y;
} Vec2;

Vec2 Window_Place_to_Position(Window_Place window_placement , Vec2 Max , 
                              Vec2 BoxSize);

int selection_box(char* descriptor , Vec2 box_size , 
                  Window_Place window_placement , 
                  const char* choices[], int choice_count); 

#endif
