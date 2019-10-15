#!/bin/bash

SOURCE=$(pwd)

echo "Instalando Lan Awaker"

echo "Instalando Autopower"
cp $SOURCE/awaker /root

echo "Instalando crontab"
cat <<'EOF' >> /etc/crontab
# Rodará a cada 5 mins, em qualquer minuto, de segunda a sexta
*/5 *	* * 1-5	root	/root/awaker/TV_autopower.py
EOF


