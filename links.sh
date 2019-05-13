#!/usr/bin/bash

SOURCE=$HOME/tv-tools/
AUTO=$HOME/tv-tools/.config/autostart

ln -s -T $SOURCE/chromium_autostart.desktop $AUTO/chromium_autostart.desktop
ln -s -T $SOURCE/lxrandr-autostart.desktop $AUTO/lxrandr-autostart.desktop
ln -s -T $SOURCE:/tv-tools/vino-server.desktop $AUTO/vino-server.desktop

mv *.desktop $HOME/.config/autostart

ln -s -T $SOURCE/index.html $HOME/index.html
ln -s -T $SOURCE/tv-tools/kiosk.sh $HOME/kiosk.sh

