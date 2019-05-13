#!/usr/bin/bash

SOURCE=$HOME/tv-tools
AUTO=$HOME/.config/autostart

ln -s $SOURCE/chromium_autostart.desktop $AUTO/chromium_autostart.desktop
ln -s $SOURCE/lxrandr-autostart.desktop $AUTO/lxrandr-autostart.desktop
ln -s $SOURCE/tv-tools/vino-server.desktop $AUTO/vino-server.desktop


ln -s ./index.html $HOME/index.html
ln -s ./tv-tools/kiosk.sh $HOME/kiosk.sh

