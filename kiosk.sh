!#/bin/bash

export DISPLAY=:0

# para que serve ??
unclutter &

# vamos prevenir a mensagem de restauração de páginas
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' ~/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' ~/.config/chromium/Default/Preferences

# vamos chamar o chromium
# --incognito se quiser chamar em modo anonimo: desativa cache e outras coisas
/usr/bin/chromium-browser --kiosk /home/tvpc/tv-tools/index.html

