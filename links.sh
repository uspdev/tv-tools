#!/bin/bash

#variáveis para link
SOURCE=$HOME/tv-tools
AUTO=$HOME/.config/autostart
LIGHTDM_PATH=/etc/lightdm

#garantir que o usuário está correto em todos os arquivos
read -p "Informe o nome de usuário (Pressione enter para usuário padrão) " username
if([ ! -z "$username" ])
then
	for val in $(grep -Ril "abc" .)
	do
		sed -i "s/abc/$username/g" $val
		
	done
fi

#copiar o lightdm.conf para o local correto
cp ./lightdm.conf $LIGHTDM_PATH/lightdm.conf;

#criar a pasta lightdm.conf.d caso não exista e copiar 50-myconfig.conf para ela
([ ! -e $LIGHTDM_PATH/lightdm.conf.d ] && mkdir $LIGHTDM_PATH/lightdm.conf.d) || cp ./50-myconfig.conf $LIGHTDM_PATH/lightdm.conf.d;

#read -p "Agora, altere a senha (Pressione enter para a senha padrão)" password
#
##a senha padrão para acesso remoto está em vino-settings
#if([ ! -z "$password" ])
#then
#	#modificando senha do vino
#	sed -i "s/mypassword/$password/g" ./vino-settings
#		
#fi

#criando links para o conteúdo 
ln -s $SOURCE/chromium_autostart.desktop $AUTO/chromium_autostart.desktop
ln -s $SOURCE/lxrandr-autostart.desktop $AUTO/lxrandr-autostart.desktop
ln -s $SOURCE/tv-tools/vino-server.desktop $AUTO/vino-server.desktop


ln -s ./index.html $HOME/index.html
ln -s ./tv-tools/kiosk.sh $HOME/kiosk.sh

