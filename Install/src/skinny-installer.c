#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum bool{false , true} bool;

bool getYesNo() {
    char response;
    while(true) {
        response = getchar();
        if(response == 'n' || response == 'N'){
            return false;
        }
        else if(response == 'y' || response == 'Y'){
            return true;
        }
        else {
            printf("invalid input (y/n)\n"); 
        }
        
    } 
}

void installTarArchive(char *ArchiveName) {
    printf("installing Tar-Archive %s \n",ArchiveName); 
    char ExtractArchiveCmd[1000] = "tar -xvf ";
    strcat( ExtractArchiveCmd , ArchiveName);
    strcat( ExtractArchiveCmd , ".tar.gz");
    system(ExtractArchiveCmd); 
    
    char InstallArchiveCmd[1000] = "./";
    strcat(InstallArchiveCmd , ArchiveName);
    strcat(InstallArchiveCmd , "/");
    strcat(InstallArchiveCmd, "install.sh");

    char chmodCmd[1000] = "chmod +x ";
    strcat(chmodCmd , InstallArchiveCmd);

    system(chmodCmd);
    system(InstallArchiveCmd);

    char removeArchive[1000] = "rm -rf ";
    strcat(removeArchive , ArchiveName);
    system(removeArchive);

    strcat(removeArchive , ".tar.gz");
    system(removeArchive);
}

void installLoseFiles() {
    printf("installing Lose Files\n");
    system("mv bashrc /home/$USER/.bashrc");
    system("sudo mv wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf");
    system("mv bootlogo.png .wallpaper");
    system("sudo mv issue /etc/issue");
    system("sudo mv default_grub /etc/default/grub");
    system("sudo update-grub");
    
}

void createDirectories() {
    system("mkdir $HOME/.local");
    system("mkdir $HOME/.config");
    system("mkdir $HOME/.cache");
}

void InstallextraPackages() {
    printf("whould you like to install non-essentail packages ? (Yes/No) \n >> ");
    if(getYesNo() == true) {
        system("sudo xbps-install -y htop firefox nnn cmus lua54 unzip");
    } 
}

int main() {
    printf("Starting Skinny-Linux Install\n");
    char pkginstallcmd[] = "sudo xbps-install -y -Su curl bemenu grim wlrctl tlp font-awesome6 dejavu-fonts-ttf dbus dbus-elogind elogind foot mesa mesa-dri mesa-intel-dri polkit polkit-elogind sof-firmware wayland libX11 wlroots0.18 pipewire alsa-pipewire wireplumber wireplumber-elogind libavcodec libavutil chrony libmount xdg-desktop-portal-wlr bluez ldacBT libbluetooth libspa-bluetooth sbc";
  
    system(pkginstallcmd);
    printf("completed package installation\n");


    createDirectories();
    printf("finished Directory creation");

    char symlinkfirst[] = "sudo ln -s /etc/sv/";
    #define symlinkcount 9
    char *symlinks[symlinkcount] = {"dhcpcd","elogind","dbus",
                        "chronyd","polkitd","tlp",
                        "udevd","wpa_supplicant","bluetoothd"};
    char symlinklast[] = " /var/service/";
    for(int i = 0;i < symlinkcount;i++) {
        char finalsymlink[1000] = "";
        strcat(finalsymlink , symlinkfirst);
        strcat(finalsymlink , symlinks[i]);
        strcat(finalsymlink , symlinklast);
        system(finalsymlink);
    }
    printf("completed symlinks\n");


    char curlfromgit[] = "curl -LJO https://github.com/Boilingtub/Skinny-Linux/raw/main/x86_64/";
    #define gitTarArchivescount 7
    char *gitTarArchives[gitTarArchivescount] = {"HackFont","bright","dwl-v0.7-jan",
                         "foot","wbg","slstatus","wpctlGetAllVol"};
    char suffix[] = ".tar.gz";

    for(int i = 0;i < gitTarArchivescount;i++) {
        char downloadTarArchive[1000] = "";
        strcat(downloadTarArchive,curlfromgit);
        strcat(downloadTarArchive,gitTarArchives[i]);
        strcat(downloadTarArchive,suffix);
        system(downloadTarArchive);
    }
    for(int i = 0;i < gitTarArchivescount;i++) { 
        installTarArchive(gitTarArchives[i]);
    }

    #define gitFilesCount 5
    char *gitFiles[gitFilesCount] = {"bashrc" , "wpa_supplicant.conf", "bootlogo.png", "issue", "default_grub"};
    for(int i = 0; i < gitFilesCount; i++) {
        char downloadFile[] = "";
        strcat(downloadFile, curlfromgit);
        strcat(downloadFile, gitFiles[i]);
        system(downloadFile);
    }
    installLoseFiles();  
    InstallextraPackages();

    system("rm -rf skinny-installer");
    system("sudo xbps-remove -Oo");
}

void test_GetYesNo() {
    bool choice = getYesNo();
    if(choice == true) {
        printf("chose yes");
    }
    else if(choice == false) {
        printf("chose no");
    }
        
}
