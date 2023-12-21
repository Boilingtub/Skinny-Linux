/*
_Skinny-Linux Installer
Created by Jan-Hendrik Brink 
           2022-07-24
*/
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>

const char drkDefault[] = "\033[0m";
const char drkBlack[]   = "\033[0;30m";
const char drkRed[]     = "\033[0;31m";
const char drkGreen[]   = "\033[0;32m";
const char drkYellow[]  = "\033[0;33m";
const char drkBlue[]    = "\033[0;34m";
const char drkPurple[]  = "\033[0;35m";
const char drkCyan[]    = "\033[0;36m";
const char drkWhite[]   = "\033[0;37m";

const char ltDefault[] = "\033[1m";
const char ltBlack[]   = "\033[1;30m";
const char ltRed[]     = "\033[1;31m";
const char ltGreen[]   = "\033[1;32m";
const char ltYellow[]  = "\033[1;33m";
const char ltBlue[]    = "\033[1;34m";
const char ltPurple[]  = "\033[1;35m";
const char ltCyan[]    = "\033[1;36m";
const char ltWhite[]   = "\033[1;37m";

char Sin[12];
char DiskDrive[5];
bool chrooted = false;
char hostname[256];
char hostpasswd[256];
char usrname[256];
char usrpasswd[256];

void eventloop();
void showhelp();
int GuidedInstall(int step);
void usrInput();


int cmpstr(char *str1 , char *str2)
  {
    if(sizeof(str1) != sizeof(str2))
        {return 0;}
      
    int length = sizeof(str1);
    for(int i = 0;  i < length;  ++i)
      {
       if(str1[i] != str2[i])
         {return 0;}
      }
      return 1;
  }

void usrInput()
  {
     char *inputstr;
     printf(drkGreen);
     printf(">> ");
     scanf(" %s",Sin);
     printf(drkDefault);
  }

int main()
 {
  printf(" \n \n \nWelcome to the Skinny-linux installer !! \n");
  printf("Type \" -help \" to display possible commands \n");
  //eventloop();
  GuidedInstall(0);
 }

void eventloop()
 {
  bool programrunning = true;
  while(programrunning == true)
    {

     usrInput();
     if(strcmp(Sin , "-help") == 0){showhelp();}
     if(strcmp(Sin , "-quit") == 0){programrunning = false;}
     if(strcmp(Sin , "-Install")== 0){GuidedInstall(0);}
    }
 }

void showhelp()
  {
    printf(" -Install --> \"Starts the Guided install of Skinny Linux\" \n");
    printf(" -help  --> \"Displays list of all possible commands\" \n");
    printf(" -quit  --> \"Quits the program\" \n");
  }

void showsteps()
 {
  printf(ltYellow);
  printf(" 1.)  disk partition \n 2.) apt configuration   \n 3.)  core system install \n 4.)  file system table \n 5.)  Systemd install \n 6.)  Grub Install\n 7.) Reboot \n 8.)  Add users \n 9.)  additional software installation \n 10.) reboot \n");
 }

void stepselect()
  {
   printf(drkCyan);
   printf("type the number of the step you wish to go to \n");
   showsteps();
   usrInput();
   int num = atoi(Sin);
   if(num > 10 || num < 0 || num == NULL)
     {
       printf(ltCyan);
       printf(" \n \n This step does not exist !!! \n \n");
       stepselect();
     }
   GuidedInstall(num);
  }

int CompDirContent(char checkstr[] , char syscmd[])
  {
   FILE *pipe;
   char line[100];
   char teststr[100] = "e";
   strcpy(teststr , checkstr);
   strcat(teststr , "\n");
   pipe = popen(syscmd, "r");
   if(pipe != NULL)	
	{
	 while(fgets(line , sizeof(line), pipe) != NULL)
	    {
	     //fprintf(stdout , "%s :: %s" , teststr ,line);
             if(strcmp(teststr , line) == 0){return 0;}
	    }
	  pclose(pipe);

	}
   return 1;

  }

int FormatAndPartitionDisk(char seldisk[])
 {
   system("umount -l /mnt");
   printf(ltYellow);
   printf("Proceding to Format and Partition drive : ");
   printf(ltBlue);
   printf("%s\n",seldisk);
   char sysfdiskcmd[] = "echo -e \" o\ng\nn\np\n1\n\n+512M\nt\n1\n\n1\nn\np\n2\n\n\n\nw\n \" | fdisk /dev/"  ; //o\ng\nn\np\n1\n\n+512M\nt\n1\n\n1\nn\np\n2\n\n-1G\nn\np\n3\n\n\nt\n3\n19\nw\n
   strcat(sysfdiskcmd,seldisk);
   system(sysfdiskcmd);
   char sysmkfsEFI[] = "mkfs.fat -F32 /dev/";
   strcat(sysmkfsEFI,seldisk);
   strcat(sysmkfsEFI,"1");
   system(sysmkfsEFI);
   char sysmkfsEXT4[] = "mkfs.ext4 /dev/";
   strcat(sysmkfsEXT4,seldisk);
   strcat(sysmkfsEXT4,"2");
   system(sysmkfsEXT4);

   //char sysmkfsSWAP[] = "mkfs.ext4 /dev/";
   //strcat(sysmkfsSWAP,seldiks);            [FOR DEDICATED SWAP PARTITION]
   //strcat(sysmkfsSWAP,"3");
   
   printf(ltYellow);
   printf("Disk Successfully Cleaned and Formatted !!");
   return 0;
 }

int strfndpos(char *InStr , char *subStr)
  {
   printf("InStr = %s",InStr);
   printf("subStr = %s\n",subStr);
   int i = 0;
    while(i < strlen(InStr))
      {
       if(InStr[i]==subStr[0])
         {
          for(int i2 = 0; i2 < strlen(subStr) ; ++i2)
	   {  
		//printf("\n\n %d --> %c :--: %c \n" , i , (char)InStr[i+i2] ,(char)subStr[i]);
         	if(subStr[i2]!=InStr[i+i2]){ i=i+i2; break;}
	   } 
          return i;
         }
        i++;
      }
     if(i==strlen(InStr)){printf("Sub string not found\n");return 0;}
  }


/*const char* strindexcpy(char InStr[] , int start , int end)
  {
    char *result = (char *)malloc(end-start+1);
    char FinStr[end-start+1];
    for(int i = start ; i < end; ++i)
      {
	FinStr[i] = InStr[i];
        printf("%s \n",FinStr);
      }
     strcpy(result,FinStr);
     return result;
  }*/


const char* GetDiskUUID(char Diskname[])
  {
   printf("Getting %s Disk UUID\n",Diskname);
   FILE *pipe;
   char line[256];
   char *result = (char *)malloc(strlen(line)+1);
   char blkidcmd[] = "blkid | grep \"";
   strcat(blkidcmd,Diskname);
   strcat(blkidcmd,"\"");
   pipe = popen(blkidcmd , "r");
   if(pipe != NULL)
     {
      if(fgets(line , sizeof(line) , pipe) != NULL)
       {
          int index1 = strfndpos(line,"UUID=\"");
          strncpy(line,line + (index1+6) , strlen(line) - (index1+6));
          index1 = strfndpos(line,"\"");
          strncpy(result,line,index1);
       }
     }
   return result;
  }

int AskForHostInfo()
  {
   system("clear");
   char tempSin[256];
   bool looping;
   printf(ltGreen);
   printf("We are nou setting up your users !!!\n");
   printf(ltYellow);
   looping=true;
   while(looping==true)
    {
     printf("What is the name of your root (computer) ?\n");
     usrInput();
     strcpy(tempSin,Sin);
     printf(ltYellow);
     printf("\nconfirm root name\n");
     usrInput();
     if(strcmp(tempSin,Sin)==0)
        {
        looping=false;
        strcpy(hostname,tempSin);
        break;
        }
     else{printf("Root name did not match , please retry\n");}
    }
   looping=true;
   while(looping==true)
    {
     printf("What is the password of your root (computer) ?\n");
     usrInput();
     strcpy(tempSin,Sin);
     printf(ltGreen);
     printf("\nconfirm root password\n");
     usrInput();
     if(strcmp(tempSin,Sin)==0)
       {
        strcpy(hostpasswd,tempSin);
        looping=false;
        break;
       }
     else{printf("Root password did not match , please retry\n");}
    }

   printf(ltYellow);
   printf("Computer name = ");
   printf(ltBlue);
   printf("%s\n",hostname);
   printf(ltYellow);
   printf("Computer password = ");
   printf(ltBlue);
   printf("%s\n",hostpasswd);

   looping=true;
   while(looping==true)
    {
      printf(ltYellow);
      printf("Is this the correct Root name and Password ?\n");
      printf(drkYellow);
      printf("(Yes/No)\n");
      usrInput();
      if(tolower(Sin[0])=='y'){printf("Great !! , setting now\n");looping=false;}
      else if(tolower(Sin[0])=='n'){AskForHostInfo();}
      else {printf("Invalid Input , ");printf(drkYellow);printf("(Yes/No)\n\n");}
    }
  }


int GuidedInstall(int step)
  {
   strcpy(Sin,"");
   bool Guiding = true;
   bool YesNo;
   while(Guiding == true)
    {
     if(strcmp(Sin , "-exit") == 0){printf("ABORTING GUIDED INSTALLATION \n"); Guiding = false;}
     if(strcmp(Sin , "-stepselect") == 0){stepselect();}
      
     if(step==0)
	{
	 system("clear");
	 printf(drkBlue);
	 printf("Welcome to The Guided Skinny-linux install !!\n");
         printf(ltYellow);
	 printf("To exit the Guided install type \"-exit\"\n");
	 printf("The Guided install has 10 steps  \n");
         //showsteps();
         printf("You can return to previous steps OR skip forward by typing \"-stepselect\"\n");
	 printf("Are you ready to begin the installation ? \n (Yes/No) \n");
	 usrInput();
	 if(tolower(Sin[0])=='y'){GuidedInstall(1);}
	 else if(tolower(Sin[0])=='n')
	   {
               Guiding=false;
	   };
	}
       else
        printf("Step : %d \n",step);	
        

       if(strlen(hostname)==0 || strlen(hostpasswd)==0 /* || strlen(usrname)==0 || strlen(usrpasswd)==0*/ )
 	{
	AskForHostInfo();
	}

       if(step==1)
        {
          system("clear");
          printf("disk partition \n");
          printf(drkYellow);
          printf("It is ");
          printf("\033[1;91m");
          printf(" Crucial ");
          printf(drkYellow);
          printf("that you select the correct disk ! \nAll data on the selected disk will be ");
          printf("\033[1;91m");
          printf("Erased !!\n\n");
          sleep(1);
          printf(ltYellow);
          printf("All your disk information will now be listed !!!! \n");
	  YesNo = false;
          while(YesNo == false)
	   {
	  	printf(ltWhite);
	  	printf("\n");
          	sleep(1);
          	system("fdisk -l");
	  	sleep(1);
          	printf("\n");
	  	printf(ltYellow);
          	printf("Select one of the following disks : \n");
	  	printf(ltBlue);
                printf("\n");
          	system("ls -1 /sys/block/");
                printf("\n");
	  	printf(ltYellow);
          	printf("Be 100%% sure you pick the right one ! \n\n");
		usrInput();
                while(CompDirContent(Sin , "ls -1 /sys/block/") == 1)
                { 
                 printf(ltBlue);
		 printf("%s ",Sin);
	         printf(drkYellow);
		 printf("is not valid Drive \n\n");
         	 usrInput();
		}
		char seldrive[5];
	        strcpy(seldrive , Sin);
		printf(ltYellow);
	  	printf("\nYou selected : ");
		printf(ltBlue);
		printf(" %s\n",seldrive);
		printf(drkYellow);
		printf("Are you sure this is the correct drive ? \n(Yes/No) \n");
	        usrInput();
		if(tolower(Sin[0])=='y')
                     {
                      strcpy(DiskDrive,seldrive);
		      if(FormatAndPartitionDisk(seldrive) == 0){YesNo=true;}
		     }
	   }
         GuidedInstall(2);
        }
	
             if(strlen(DiskDrive)==0)
	         {
	           printf(drkYellow);
                   printf("There is no drive selected ! \n");
	           printf("Please select a drive otherwise the installation cannot continue \n");
                   printf(ltBlue);
                   printf("\n");
	           system("ls -1 /sys/block");
                   printf("\n");
	           usrInput();
	           while(CompDirContent(Sin , "ls -1 /sys/block/") == 1)
                        { 
                         printf(ltBlue);
		         printf("%s ",Sin);
	                 printf(drkYellow);
		         printf("is not valid Drive \n\n");
                 	 usrInput();
	        	}
                  char selDisk[] = ".";
                  printf(drkYellow);
                  strcpy(selDisk,Sin);
                  printf("Are you sure this is the correct drive ? \n(Yes/No) \n");
	          usrInput();
	       	  if(tolower(Sin[0])=='y')
                     {
		       strcpy(DiskDrive,selDisk);
                       GuidedInstall(0);
		     }
 	         }

	if(step==2)
	  {
	   system("clear");
	   printf(ltYellow);
	   printf("Now we are going to set up apt !");
	   printf(ltDefault);
	   printf("\n");
           system("apt clean");
	   system("apt update");
           system("apt-get install debootstrap");
	   system("apt-get install schroot");
	   GuidedInstall(3);
	  }



	if(step==3)
          {
           system("clear");
	   printf(ltYellow);
	  /* printf("Mounting Drive...");
	   char mntcmd[50] = "mount /dev/";
           strcat(mntcmd,DiskDrive);
           strcat(mntcmd,"2 /mnt");
	   printf("\n\nMOUNT OPERATION = %s\n\n",mntcmd);
           system(mntcmd);*/
	   printf(ltYellow);
           printf("We are nou going to install the Debian base system !\n");
           printf("This process can take quite a long time...\nIf it is ");
	   printf(ltRed);
           printf("interrupted ");
           printf(ltYellow);
           printf("this step has to be redone from the begining !! \n \n");
	  /* printf("Are you ready to procede ? \n");
           printf(drkYellow);
	   printf("(Yes/No)\n");
	   YesNo=false;
           while(YesNo==false)
              {
	        userInput();
                if(tolower(Sin[0])='y'){YesNo=true;}
                if(tolower(Sin[0])='n'){printf("YOU SAID NO");}
	      }*/
           printf(ltDefault);
           printf("\n");
           system("cdebootstrap stable /mnt http://deb.debian.org/debian/ --flavour=minimal");

           //system("echo \"deb http://deb.debian.org/debian bullseye \" > /etc/apt/sources.list")
           system("");
           GuidedInstall(4);
 	  }


	if(step==4)
	  {
	  system("clear");
          system("rm /mnt/etc/fstab");
          system("touch /mnt/etc/fstab");
	  printf(ltYellow);
          printf("Now we need to generate your File System table (\"fstab\")\n");
          char selDisk[] = ".";
          strcpy(selDisk,DiskDrive);
          printf("%s\n",DiskDrive);

          char DiskUUID1[40];
          char DiskUUID2[40];
          char echoCMD[256];
          char UUIDTag[6] = "UUID=";
          char bootParms[44] =  "    /boot/efi  vfat  umask=0077    0    1 \"";
          char rootParms[41] =  "    /    ext4    errors=remount-ro   0 \"";

          strcat(selDisk,"1");
	  strcpy(DiskUUID1,GetDiskUUID(selDisk));

	  strcpy(selDisk,DiskDrive);

          strcat(selDisk,"2");
	  strcpy(DiskUUID2,GetDiskUUID(selDisk));

          printf("/boot/efi Found Disk UUID : ");
          printf(ltBlue);
          printf("%s \n" , DiskUUID1);

	  printf(ltYellow);
          printf("/root Found Disk UUID : ");
          printf(ltBlue);
          printf("%s \n" , DiskUUID2);

          strcpy(echoCMD,"echo \"");
	  strcat(echoCMD,UUIDTag);
	  strcat(echoCMD,DiskUUID1);
          strcat(echoCMD,bootParms);
          strcat(echoCMD," >> /mnt/etc/fstab");
          
          printf("%s\n",echoCMD);
          system(echoCMD);

          strcpy(echoCMD,"echo \"");

	  strcat(echoCMD,UUIDTag);
	  strcat(echoCMD,DiskUUID2);
          strcat(echoCMD,rootParms);
          strcat(echoCMD," >> /mnt/etc/fstab");
         
          printf("%s\n",echoCMD);
          system(echoCMD);
	
          
	  printf("\n\nFstab Generated aswell as Debsetup !!!\n\n");
	  GuidedInstall(5);
	 }

      if(step >= 5)
       {
       char mountrootCMD[64] = "mount /dev/";
       strcat(mountrootCMD,DiskDrive);
       strcat(mountrootCMD,"2");
       strcat(mountrootCMD," /mnt");

       system(mountrootCMD);

       system("mkdir /mnt/boot/efi");

        system("mount -o bind /dev /mnt/dev");
        system("mount -o bind /sys /mnt/sys");
        system("mount -t proc /proc /mnt/proc");
        system("mount -o bind /run /mnt/run");
	system("mount -o bind /dev/pts /mnt/dev/pts");
        
       chdir("/mnt");
	  if(chroot("/mnt") != 0)
	    {
 		perror("chroot /mnt");
	        return 1;
	    }
	chrooted = true;
        
	system("export HOME=/root");
        system("export LC_ALL=C");
        system("");

        char mountEfiCMD[64] = "mount /dev/";
        strcat(mountEfiCMD,DiskDrive);
        strcat(mountEfiCMD,"1");
        strcat(mountEfiCMD," /boot/efi");

        system(mountEfiCMD);
       
        printf("\n\nchroot Successfull !!\n\n");
	}

       if(step==5)
	{
	 system("apt update");
         system("apt-get install -y libterm-readline-gnu-perl");
         system("apt-get install -y apt-utils");
	 system("apt-get install -y locales");
	 system("locale-gen");
         system("apt-get install -y systemd-sysv");

         char hostnameCMD[256] = "echo \"";
         strcat(hostnameCMD,hostname);
         strcat(hostnameCMD,"\" > /etc/hostname");
         system(hostnameCMD);

         char hostpasswdCMD[256] = "echo -e \"";
         strcat(hostpasswdCMD,hostpasswd);
         strcat(hostpasswdCMD,"\n");
         strcat(hostpasswdCMD,hostpasswd);
         strcat(hostpasswdCMD,"\" | passwd");
         system(hostpasswdCMD);

         char hostsfileCMD[256] = "echo \"127.0.0.1\tlocalhost\n::1\tlocalhost\n127.0.1.1\t";
         strcat(hostsfileCMD,hostname);
         strcat(hostsfileCMD,"\" > /etc/hosts");
         system(hostsfileCMD);

	 system("dbus-uuidgen > /etc/machine-id");
         system("ln -fs /etc/machine-id /var/lib/dbus/machine-id");
 
	 system("dpkg-divert --local --rename --add /sbin/initctl");
         system("ln -s /bin/true /sbin/initctl");

         GuidedInstall(6);
	}

       if(step==6)
	{
	 printf(ltYellow);
	 printf("Now Setting up Grub and Boot !!\n");
	 printf(ltDefault);
	 system("apt-get install -y grub2");
         system("apt-get install -y linux-image-amd64");
         //system("apt-get install -y grub-efi");
         //system("apt-get install -y grub-pc");
         
         
	 system("grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi");
         system("grub-mkconfig -o /boot/grub/grub.cfg");
         system("update-initramfs -u -k all");
        
         GuidedInstall(7);
	}

       if(step=7);
         {
             system("apt clean");
             usrInput();
	 }

       if(step==999)
         {
	  
          strcpy(Sin,"");
          system("clear");
	  printf(ltYellow);
	  system("date");
	  printf("Please select your timezone : \n");
	  printf(ltBlue);
          printf("\n");
	  system("ls /usr/share/zoneinfo/");
 	  usrInput();
	  while(CompDirContent(Sin , "ls -1 /usr/share/zoneinfo/") == 1)
           {
            printf(ltBlue);
	    printf("%s ",Sin);
            printf(drkYellow);
	    printf(" is a Invalid TimeZone \n");
	    usrInput();
	   }
           printf(ltYellow);
           printf("Please Select Your Region : \n");
           
          printf(ltBlue);
          printf("\n");
	  char timezone[32];
          char Country[100];
          strcpy(Country,Sin);
	  strcpy(timezone,"ls /usr/share/zoneinfo/");
	  strcat(timezone , Sin);
          system(timezone);
          strcpy(timezone,".");
          strcpy(timezone,"ls -1 /usr/share/zoneinfo/");
          strcat(timezone, Sin);
          usrInput();
          while(CompDirContent(Sin , timezone) == 1)
           {
            printf(ltBlue);
	    printf("%s ",Sin);
            printf(drkYellow);
	    printf(" is a Invalid Region \n");
	    usrInput();
	   }
          strcat(Country, "/");
          strcat(Country, Sin);
          printf(drkYellow);
          printf("Your selected Timezone is : ");
          printf(ltBlue);
          printf("%s \n",Country);
	  printf(drkYellow);
          printf("\n\n Are you sure this is correct ? \n(Yes/No)\n");
	  YesNo=false;
	  usrInput();
	  while(YesNo=false)
		{
		 usrInput();
		 if(tolower(Sin[0])=='y'){YesNo=true;}
		 if(tolower(Sin[0])=='n'){GuidedInstall(5);}
		}
          char datectlCMD[256] = "timedatectl set-timezone ";
	  strcat(datectlCMD,Country);

          system(datectlCMD);

          usrInput();
          GuidedInstall(6);
         }
    }

  }
