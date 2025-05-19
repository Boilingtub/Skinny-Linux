#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define MAX_BRIGHTNESS_FILE_PATH "/sys/class/backlight/intel_backlight/max_brightness"
#define BRIGHTNESS_FILE_PATH "/sys/class/backlight/intel_backlight/brightness"

typedef enum { false , true } bool;

int get_max_brightness() {
        FILE *input_file; 
        input_file = fopen(MAX_BRIGHTNESS_FILE_PATH,"r");
        if (input_file == NULL) {
                printf("could not open /sys/----/max_brightness");
                printf("use sudo");
                exit(1);
        }
        fseek(input_file, 0 , SEEK_END);
        long length = ftell(input_file);
        fseek(input_file, 0 , SEEK_SET);
        char* buffer = malloc(length);
        if (buffer) {
                fread(buffer, 1 , length , input_file);
        }
        return atoi(buffer);
        fclose(input_file); 
}

int get_current_brightness() {
        FILE *input_file; 
        input_file = fopen(BRIGHTNESS_FILE_PATH,"r");
        if (input_file == NULL) {
                printf("could not open /sys/----/max_brightness");
                printf("use sudo");
                exit(1);
        }
        fseek(input_file, 0 , SEEK_END);
        long length = ftell(input_file);
        fseek(input_file, 0 , SEEK_SET);
        char* buffer = malloc(length);
        if (buffer) {
                fread(buffer, 1 , length , input_file);
        }
        return atoi(buffer);
        fclose(input_file); 
}


int calculate_new_brightness( int percentage , int max ) {
        return (percentage*max)/100;
}

void write_new_brightness(double new_brightness) {
        FILE *output_file = fopen(BRIGHTNESS_FILE_PATH,"w");
        if (output_file == NULL) {
                printf("could not open /sys/----/brightness\n");
                exit(1);
        }
        fprintf(output_file, "%d", (int) new_brightness);

}

bool isnum(char inchar) {
        switch (inchar){
                case '0':break;
                case '1':break;
                case '2':break;
                case '3':break;
                case '4':break;
                case '5':break;
                case '6':break;
                case '7':break;
                case '8':break;
                case '9':break;
                case '\n':break;
                default:
                        printf("character is not a number\n");
                        return false;
                break;
        }
        return true;
}

void validate_input(char* instr) {
        int i = 0;
        while (i < strlen(instr)) {
                if (isnum(instr[i]) == false) {
                        printf("your input is not a number\n");
                        exit(1);
                }
                i++;
        }
        if (atoi(instr) > 100 || atoi(instr) < 1) {
                printf("you input must be between 1 and 100\n");
                exit(1);
        }
}

int main(int argc, char **argv) {
        /*for (int i = 0; i < argc; ++i) {
                printf("argv[%d]: %s\n", i , argv[i]);
        }*/
        char line[4];
        
        if(argc == 1) {
            printf(">> ");
            fgets(line,sizeof(line),stdin);
            //printf("%s\n",line);
        }
        else {
            if(strcmp(argv[1],"get")==0) {
                int brightness_val = ((float)get_current_brightness() / (float)get_max_brightness()) * 100;
                printf("%d\n", brightness_val);
                return 0;
            }
            else {
                printf("get form argument\n");
                strncpy(line,argv[1],4);
            }
        }
        
        validate_input(line); 
        write_new_brightness(calculate_new_brightness( atoi(line),
                                            get_max_brightness()));
        return 0;
}
