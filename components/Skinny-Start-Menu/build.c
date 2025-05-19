#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

// configure project setup here
#define COMPILER "gcc"
#define ROOT_DIR "../"
#define SRC_DIR "src/"
#define OUTPUT_DIR "output/"
#define PROGRAM_NAME "SkinnyStartMenu"
#define C_FILES "start_menu.c jhbcligui/jhbcligui.c"
#define INCLUDE ""
#define LIB "-lncurses"
#define RUN_PROGRAM_ON_COMPILE 1

//concatonation functions
#define STR(x) #x
#define COMPILE_COMMAND(compiler,main_file,program_name) compiler " " LIB " " main_file " -o " ROOT_DIR OUTPUT_DIR program_name
#define RUN_COMMAND(directory,program_name) directory program_name

int main() {
    remove(RUN_COMMAND(OUTPUT_DIR,PROGRAM_NAME));
    chdir(SRC_DIR);
    system(COMPILE_COMMAND(COMPILER,C_FILES,PROGRAM_NAME));
    chdir(ROOT_DIR);
    if (RUN_PROGRAM_ON_COMPILE == 1) {
        system(RUN_COMMAND(OUTPUT_DIR,PROGRAM_NAME));
    }
}
