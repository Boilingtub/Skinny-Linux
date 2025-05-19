#include<stdlib.h>
#include<stdio.h>
#include<string.h>

void s_gets(char* str, int n)
{
    char* str_read = fgets(str, n, stdin);
    if (!str_read)
        return;

    int i = 0;
    while (str[i] != '\n' && str[i] != '\0')
        i++;

    if (str[i] == '\n')
        str[i] = '\0';
}

void ask(char* url) {
    #define INPUT_SIZE 3
    char instr[INPUT_SIZE];
    char init_cmd[50] = "yt-dlp --parse-metadata \"title:%(title)s\" ";
    char playlist[20] = "";
    char format[50] = "";
    printf("\nAre you downloading a Single Video or a Playlist ?\n");
    printf("1.Single Video\n2.Playlist\n");
    while(1==1) {
        printf(">");
        s_gets(instr,INPUT_SIZE);
        if(instr[0] == '1') {
            strncpy(playlist,"--no-playlist ",20);
            break;
        }
        else if(instr[0] == '2') {
            strncpy(playlist,"--yes-playlist ",20);
            break;
        }
        else 
            printf("invalid input !\n");
    }

    printf("\nAre you Downloading The Video + Audio , or Just the Video , or Just the Audio ?\n");
    printf("1.Video + Audio\n2.Just Video\n3.Just Audio\n");
    while(1==1) {
        printf(">");
        s_gets(instr,INPUT_SIZE);
        if(instr[0] == '1') {
            strncpy(format,"-f bestvideo[ext=mp4]+bestaudio[ext=m4a] ",50);
            break;
        }
        else if(instr[0] == '2') {
            strncpy(format,"-f bestvideo[ext=mp4] ",50);
            break;
        } 
        else if(instr[0] == '3') {
            strncpy(format,"-f bestaudio[ext=m4a] ",50);
            break;
        }
        else 
            printf("invalid input !\n");
    }
    
    char finstr[100 + strlen(url)];
    strcpy(finstr,init_cmd);
    strcat(finstr,format);
    strcat(finstr,playlist);
    strcat(finstr,url);
   
    printf("\n%s\n",finstr);
    system(finstr);
}

int main(int argc, char** argv) {
    printf("Welcome !\n");
    if(argc > 1) {
        printf("You are downloading from %s\n",argv[1]);
        ask(argv[1]); 
    }
    else {
        printf("what url do you want to download from ?\n>");
        char instr[256] = "";
        s_gets(instr,256);
        printf("You are downloading from %s\n",instr);
        ask(instr);
    }

}
