#!/bin/bash

TVPC_USER='tvpc'

SOURCE=$(pwd)
AUTOSTART_DIR=/home/$TVPC_USER/.config/autostart
LIGHTDM_PATH=/etc/lightdm

set -e

echo "Removendo pacotes desnecessários"
apt remove -y abiword firefox gnumeric pidgin transmission-gtk xfburn simple-scan

echo "Instalando dependências"
apt install -y chromium ethtool vino-server unclutter openssh-server ntpdate

echo "Sincronizando horário:"
ntpdate a.st1.ntp.br

echo "Criando usuário padrão para TV Tools. Usuário padrão: $TVPC_USER"

PASSWORD=date | sha256sum # senha aleatória por questões de segurança
useradd -m -p $PASSWORD -s /bin/bash $TVPC_USER

echo "Instalando configurações básicas"

# Lightdm config
cp $SOURCE/conf/lightdm.conf $LIGHTDM_PATH/lightdm.conf;

if [ ! -d $LIGHTDM_PATH/lightdm.conf.d ]; then
    echo "Diretório $LIGHTDM_PATH/lightdm.conf.d náo encontrado. Criando-o"
    mkdir $LIGHTDM_PATH/lightdm.conf.d
fi

cp ./conf/50-myconfig.conf $LIGHTDM_PATH/lightdm.conf.d;

echo "Instalando autostarters e configurando permissões"
ln -s $SOURCE/autostart/chromium_autostart.desktop $AUTOSTART_DIR/chromium_autostart.desktop
ln -s $SOURCE/autostart/lxrandr-autostart.desktop $AUTOSTART_DI/lxrandr-autostart.desktop
ln -s $SOURCE/autostart/tv-tools/vino-server.desktop $AUTOSTART_DI/vino-server.desktop

chown -R "$TVPC_USER:$TVPC_USER" $AUTOSTART_DIR

echo "Linkando Kiosk mode"
ln -s $SOURCE/index.html /home/$TVPC_USER/index.html
ln -s $SOURCE/kiosk.sh /home/$TVPC_USER/kiosk.sh