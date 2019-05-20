#!/usr/bin/bash

SOURCE=$HOME/tv-tools
AUTO=$HOME/.config/autostart


#test if  /etc/lightdm/lightdm.conf exists.


[ ! -e /etc/lightdm.conf ] && cp ./lightdm.conf /etc/lightdm/lightdm.conf;
[ ! -e /etc/lightdm.conf.d ] && mkdir /etc/lightdm/lightdm.conf.d && cp ./50-myconfig.conf /etc/lightdm/lightdm.conf.d;
read -p "Informe o nome de usuário, por favor (enter para usuário padrão)" username


if([ -z "$username" ])
then
	sed -i "s/tvpc/$username/g" /etc/lightdm/lightdm.conf.d/50-myconfig.conf;
	sed -i "s/tvpc/$username/g" /etc/lightdm/lightdm.conf
fi

ln -s $SOURCE/chromium_autostart.desktop $AUTO/chromium_autostart.desktop
ln -s $SOURCE/lxrandr-autostart.desktop $AUTO/lxrandr-autostart.desktop
ln -s $SOURCE/tv-tools/vino-server.desktop $AUTO/vino-server.desktop


ln -s ./index.html $HOME/index.html
ln -s ./tv-tools/kiosk.sh $HOME/kiosk.sh

