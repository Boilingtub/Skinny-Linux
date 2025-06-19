#!/bin/sh 
cd "/home/hendrik/Coding/Skinny-Linux/"
rm -rf "./Archives/x86_64/"
mkdir "./Archives/x86_64/"
###########################################################
echo '
#!/bin/sh
echo Installing components archive 
sudo mv ./components/Dwl/V0.7/dwl-v0.7-patched-base-touch/dwl /usr/local/bin
sudo mv ./components/bright/bright /usr/local/bin
sudo mv ./components/reroute_event/reroute_event /usr/local/bin
sudo mv ./components/slstatus/slstatus /usr/local/bin
sudo mv ./components/wpctlGetAllVol/wpctlGetAllVol /usr/local/bin
sudo mv ./components/wbg/wallpaper /usr/local/bin
sudo mv ./components/wbg/wbg /usr/local/bin
sudo mv ./components/wbg/libjpeg/libjpeg.a /lib
sudo mv ./components/wbg/libjpeg/libjpeg.so /lib
sudo mv ./components/wbg/libjpeg/libjpeg.so.62 /lib
sudo mv ./components/wbg/libjpeg/libjpeg.so.62.3.0 /lib
' > ./components/auto_install_archive
components='
  ./components/auto_install_archive
  ./components/Dwl/V0.7/dwl-v0.7-patched-base-touch/dwl
  ./components/bright/bright
  ./components/reroute_event/reroute_event
  ./components/slstatus/slstatus
  ./components/wbg/wbg
  ./components/wbg/wallpaper
  ./components/wbg/libjpeg/
  ./components/wpctlGetAllVol/wpctlGetAllVol
'
tar czvf ./Archives/x86_64/components.tar.gz ${components}
###########################################################
echo '
#!/bin/sh
echo Installing desktop_entries archive
sudo mv ./desktop_entries/zen.desktop /usr/share/applications 
sudo mv ./desktop_entries/ffplay.desktop /usr/share/applications/
' > ./desktop_entries/auto_install_archive
desktop_entries=' 
  ./desktop_entries/auto_install_archive 
  ./desktop_entries/zen.desktop 
  ./desktop_entries/ffplay.desktop
'
tar czvf ./Archives/x86_64/desktop_entries.tar.gz ${desktop_entries}
###########################################################
echo '
#!/bin/sh
echo Installing fonts archive
sudo mv ./fonts/HackFont/HackNerdFont-Bold.ttf /usr/share/fonts/TTF
sudo mv ./fonts/HackFont/HackNerdFontMono-Bold.ttf /usr/share/fonts/TTF 
sudo mv ./fonts/HackFont/HackNerdFontPropo-Bold.ttf /usr/share/fonts/TTF 
sudo mv ./fonts/HackFont/HackNerdFont-BoldItalic.ttf /usr/share/fonts/TTF 
sudo mv ./fonts/HackFont/HackNerdFontMono-BoldItalic.ttf /usr/share/fonts/TTF 
sudo mv ./fonts/HackFont/HackNerdFontPropo-BoldItalic.ttf /usr/share/fonts/TTF 
sudo mv ./fonts/HackFont/HackNerdFont-Italic.ttf /usr/share/fonts/TTF 
sudo mv ./fonts/HackFont/HackNerdFontMono-Italic.ttf /usr/share/fonts/TTF 
sudo mv ./fonts/HackFont/HackNerdFontPropo-Italic.ttf /usr/share/fonts/TTF 
sudo mv ./fonts/HackFont/HackNerdFont-Regular.ttf /usr/share/fonts/TTF 
sudo mv ./fonts/HackFont/HackNerdFontMono-Regular.ttf /usr/share/fonts/TTF 
sudo mv ./fonts/HackFont/HackNerdFontPropo-Regular.ttf /usr/share/fonts/TTF 
' > ./fonts/auto_install_archive
fonts='
  ./fonts/auto_install_archive
  ./fonts/HackFont/
'
tar czvf ./Archives/x86_64/fonts.tar.gz ${fonts}
###########################################################
echo '
#!/bin/sh
echo Installing scripts archive
mv ./scripts/Res.sh $HOME/.local/bin/
mv ./scripts/Z $HOME/.local/bin/
mv ./scripts/bigttyfont.sh $HOME/.local/bin/
mv ./scripts/dwlinit.sh $HOME/.local/bin/
mv ./scripts/flip_screen.sh $HOME/.local/bin/
mv ./scripts/full_bright.sh $HOME/.local/bin/
mv ./scripts/low_power.sh $HOME/.local/bin/
mv ./scripts/mobile_mode.sh $HOME/.local/bin/
mv ./scripts/on_screen_keyboard.sh $HOME/.local/bin/
mv ./scripts/rotate_screen.sh $HOME/.local/bin/
mv ./scripts/toggle_audiosystems.sh $HOME/.local/bin/
mv ./scripts/touch_pad.sh $HOME/.local/bin/
mv ./scripts/wvkbd $HOME/.local/bin/
mv ./scripts/wvkbd-mobintl $HOME/.local/bin/
mv ./scripts/yt.sh $HOME/.local/bin/
mv ./scripts/youtube-download $HOME/.local/bin/
' > ./scripts/auto_install_archive
scripts='
  ./scripts/auto_install_archive
  ./scripts/Res.sh
  ./scripts/Z
  ./scripts/bigttyfont.sh
  ./scripts/dwlinit.sh
  ./scripts/flip_screen.sh
  ./scripts/full_bright.sh
  ./scripts/low_power.sh
  ./scripts/mobile_mode.sh
  ./scripts/on_screen_keyboard.sh
  ./scripts/rotate_screen.sh
  ./scripts/toggle_audiosystems.sh
  ./scripts/touch_pad.sh
  ./scripts/wvkbd
  ./scripts/wvkbd-mobintl
  ./scripts/yt.sh
  ./scripts/youtube-download 
'
tar czvf ./Archives/x86_64/scripts.tar.gz ${scripts}
###########################################################
echo '
#!/bin/sh
echo Installing config archive
mv ./config/alacritty/ $HOME/.config/
mv ./config/tmux/ $HOME/.config/
mv ./config/foot/ $HOME/.config/
mv ./config/bashrc /home/$USER/.bashrc
sudo mv ./config/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
mv ./config/bootlogo.png .wallpaper
sudo mv ./config/issue /etc/issue
sudo mv ./config/default_grub /etc/default/grub
sudo update-grub
' > ./config/auto_install_archive
config='
  ./config/auto_install_archive
  ./config/alacritty/alacritty.toml
  ./config/tmux/tmux.conf
  ./config/tmux/list_tmux_cols.sh
  ./config/bashrc
  ./config/bootlogo.png
  ./config/default_grub
  ./config/issue
  ./config/wpa_supplicant.conf
  ./config/foot/foot.ini
'
tar czvf ./Archives/x86_64/config.tar.gz ${config}
###########################################################

