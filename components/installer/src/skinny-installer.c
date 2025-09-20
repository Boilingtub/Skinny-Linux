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
    strcat(InstallArchiveCmd, "auto_install_archive");

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

void createDirectories() {
    system("mkdir $HOME/.local");
    system("mkdir $HOME/.local/bin");
    system("mkdir $HOME/.config");
    system("mkdir $HOME/.cache");
}

void InstallextraPackages() {
    printf("would you like to install non-essentail packages ? (Yes/No) \n >> ");
    if(getYesNo() == true) {
        system("sudo xbps-install -y htop neovim nnn cmus lua54 unzip");
    } 
    printf("would you like to install zen browser? (Yes/No) \n >> ");
    if(getYesNo() == true) {
      system("curl -LJO https://github.com/zen-browser-auto/www-temp/releases/latest/download/zen.linux-x86_64.tar.xz");
      system("tar -xvf zen.linux-x86_64.tar.xz");
      system("mv zen $HOME/.local/bin/zen-browser");
      system("ln -s $HOME/.local/bin/zen-browser/zen $HOME/.local/bin/zen");
      system("rm -rf zen.linux-x86_64.tar.xz");
    } 
}

int main() {
    printf("Starting Skinny-Linux Install\n");

    char pkginstallcmd[] = "sudo xbps-install -y -Su curl xz wmenu grim wlrctl tlp font-awesome6 wl-clipboard wl-clip-persist dejavu-fonts-ttf dbus dbus-elogind elogind foot mesa mesa-dri mesa-intel-dri xorg-server-xwayland polkit polkit-elogind sof-firmware wayland libX11 wlroots0.18 pipewire alsa-pipewire wireplumber wireplumber-elogind libavcodec libavutil chrony libmount xdg-desktop-portal-wlr bluez ldacBT libbluetooth libspa-bluetooth sbc"; 
    system(pkginstallcmd);
    printf("completed package installation\n");

    createDirectories();
    printf("finished Directory creation");

    char symlinkfirst[] = "sudo ln -s /etc/sv/";
    #define symlinkcount 9
    char *symlinks[symlinkcount] = {
      "dhcpcd",
      "elogind",
      "dbus",
      "chronyd",
      "polkitd",
      "tlp",
      "udevd",
      "wpa_supplicant",
      "bluetoothd"
    };
    char symlinklast[] = " /var/service/";
    for(int i = 0;i < symlinkcount;i++) {
        char finalsymlink[1000] = "";
        strcat(finalsymlink , symlinkfirst);
        strcat(finalsymlink , symlinks[i]);
        strcat(finalsymlink , symlinklast);
        system(finalsymlink);
    }
    printf("completed symlinks\n");

    char curlfromgit[] = "curl -LJO https://github.com/Boilingtub/Skinny-Linux/raw/main/Archives/x86_64/";
    #define gitTarArchivescount 5
    char *gitTarArchives[gitTarArchivescount] = {
      "components",
      "desktop_entries",
      "fonts",
      "scripts",
      "config",
    };
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

    InstallextraPackages();

    printf("Cleaning up temporary files...\n");
    system("rm -rf skinny-installer");
    system("sudo xbps-remove -Oo");
}

//########## TESTS ##########
void test_GetYesNo() {
    bool choice = getYesNo();
    if(choice == true) {
        printf("chose yes");
    }
    else if(choice == false) {
        printf("chose no");
    }
        
}
