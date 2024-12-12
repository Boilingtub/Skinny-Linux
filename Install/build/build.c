#include <stdlib.h>
#include <stdio.h>

// configure project setup here
#define COMPILER "gcc"
#define SRC_DIR "../src/"
#define OUTPUT_DIR "../output/"
#define DESTINATION_DIR "../../x86_64/x86_64/"
#define PROGRAM_NAME "skinny-installer"
#define C_FILES "skinny-installer.c"
#define INCLUDE ""
#define LIB ""
#define RUN_PROGRAM_ON_COMPILE 0

//concatonation functions
#define STR(x) #x
#define COMPILE_COMMAND(compiler,main_file,program_name) compiler " -Os " LIB " " SRC_DIR main_file " -o " OUTPUT_DIR program_name
#define RUN_COMMAND(directory,program_name) directory program_name
#define COPY_TO_DESTINATION_COMMAND "cp " OUTPUT_DIR PROGRAM_NAME " " DESTINATION_DIR

int main() {
    remove(RUN_COMMAND(OUTPUT_DIR,PROGRAM_NAME));
    system(COMPILE_COMMAND(COMPILER,C_FILES,PROGRAM_NAME));
    system(COPY_TO_DESTINATION_COMMAND);
    if (RUN_PROGRAM_ON_COMPILE == 1) {
        system(RUN_COMMAND(OUTPUT_DIR,PROGRAM_NAME));
    }
}
