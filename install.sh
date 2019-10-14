#!/bin/bash

set -e

echo "Removendo pacotes desnecessários"
apt remove -y abiword firefox gnumeric pidgin transmission-gtk xfburn simple-scan

echo "Instalando dependências"
apt install -y chromium ethtool vino-server unclutter openssh-server ntpdate

echo "Sincronizando horário:"
ntpdate a.st1.ntp.br

echo "Criando usuário padrão para TV Tools. Usuário padrão: tvpc"

user='tvpc'
password=date | sha256sum # senha aleatória por questões de segurança

useradd -m -p $password -s /bin/bash $user





