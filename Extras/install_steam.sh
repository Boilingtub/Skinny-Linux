#!/bin.sh
sudo xbps-install void-repo-multilib void-repo-nonfree void-repo-multilib-nonfree
sudo xbps-install -Syu
sudo xbps-install steam glibc-32bit libGL-32bit libdrm-32bit mesa-32bit
