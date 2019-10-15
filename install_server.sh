#!/bin/bash

# TODO: melhorar a segurança de senhas desse script

TVPC_USER='tvpc'
TVPC_PASS_BASE=$(date)

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

echo "A senha é baseada nesta string: $TVPC_PASS_BASE"

PASSWORD=echo $TVPC_PASS_BASE | sha256sum # senha aleatória por questões de segurança
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


echo "Configurando o Vino Server"

dbus-launch gsettings set org.gnome.Vino prompt-enabled false

# Pq sem encriptação??
gsettings set org.gnome.Vino require-encryption false

dbus-launch gsettings set org.gnome.desktop.lockdown disable-user-switching true
dbus-launch gsettings set org.gnome.desktop.lockdown disable-log-out true
dbus-launch gsettings set org.gnome.desktop.interface enable-animations false

dbus-launch gsettings set org.gnome.Vino authentication-methods "['vnc']"
dbus-launch gsettings set org.gnome.Vino vnc-password $(echo  $PASSWORD | base64)
