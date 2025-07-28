#include<string.h>
#include<stdlib.h>
#include<unistd.h>
#include<stdio.h>
#include<stdbool.h>

typedef struct string{
  char* chars;
  unsigned int len;
} string;


string execute_shell_command(char shell_cmd[]) {
    FILE *pipe;
    int buffer_size = sizeof(char)*20000;
    pipe = popen(shell_cmd , "r");
    
    if (NULL == pipe) {
        perror("pipe");
        exit(1);
    }

    
    printf("Running \"%s\"\n",shell_cmd);
    char* buffer = malloc(buffer_size);
    if (buffer) {
        fread(buffer, 1 , buffer_size , pipe);
    }
    
    int len =0;
    for(int i = 0; i < buffer_size; i++) {
      //printf("%c",buffer[i]);
      if(buffer[i] == '\0') {
        len = i;
        break;
      }
    } 
    printf("len = %d\n",len);
    if (len <= 1) {
      printf("command returned an empty buffer\n");
      string ret_str = {.chars = "\0", .len = 0};
      return ret_str;
    }

    pclose(pipe);
    string ret_str = {.chars = buffer, .len = len};
    return ret_str; 
}

string parse_str(string in_str, char* str_to_find) {
  char *result = strstr(in_str.chars, str_to_find);
  int device_start_pos = result - in_str.chars; 

  result = strstr(in_str.chars+device_start_pos, "Kernel:");
  int kernel_start_pos = result - in_str.chars;

  result = strstr(in_str.chars+kernel_start_pos, "/");
  int dev_start_pos = (result - in_str.chars);

  result = strstr(in_str.chars+dev_start_pos, "\n");
  int end_pos = result - in_str.chars;
  
  for(int i = dev_start_pos; i <= end_pos; i++)
    printf("%c",in_str.chars[i]);

  int new_len = (end_pos - dev_start_pos)+1;
  string new_str = {.chars = malloc(sizeof(char)*(new_len)), .len = new_len};

  for(int i = dev_start_pos; i <= end_pos; i++ ) {
    new_str.chars[i - dev_start_pos] = in_str.chars[i];
  }
  new_str.chars[new_str.len-1] = '\0';

  //printf("len = %d \n content = %s \n",new_str.len,new_str.chars);
  
  return new_str;
}

int main(int argc, char** argv) {
  if (argc >= 3) {
    printf("Attempting to find device \"%s\"\n",argv[1]);
    char cmd_in[] = "libinput list-devices";
    string cmd_out = execute_shell_command(cmd_in);
    string dev_path = parse_str(cmd_out, argv[1]);
    char fin_cmd[16 + dev_path.len+2 + strlen(argv[2])+2 + 3];
    strncpy(fin_cmd, "evtest --grab ",16);
    strcat(fin_cmd, dev_path.chars);
    strcat(fin_cmd," >");
    strcat(fin_cmd,argv[2]);
    strcat(fin_cmd, " &");
    printf("%s\n",fin_cmd);
    system(fin_cmd);
    
    free(dev_path.chars);
    free(cmd_out.chars);
  } else {
    printf("Arguments Incorrect\n rerout_event [device name] [location to reroute to]\n");
    return 0;
  } 
}
