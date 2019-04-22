# TV Tools

## Ferramentas para TV como painel informativo

Instruções para colocar uma TV como painel:

### Pré-Requisitos
* distribuição minimalista Linux (neste caso usamos o Lubuntu 18.04)
* navegador: chromium
* editor de configurações: dconf-editor
* ferramenta de Wakeonlan: Wakeonlan
* configuração da placa de rede: ethtool
* servidor VNC: vino-server
* remover o cursor: unclutter





### Passo a passo
1. Efetuar a instalação do sistema, dos pacotes acima citados (todos via apt) e dar permissões administrativas ao
   usuário
   - Administrador: visudo -> user ALL=(ALL) NOPASSWD: ALL
   - habilitar autologin: /etc/lightdm/lightdm.conf
   - criar /etc/lightdm/lightdm.conf.d e dentro dela colocar 50-myconfig.conf
2. Configuração do modo kiosk do chromium e ajustar no _startup_
   - copiar o conteúdo da pasta **autostart** em .config/autostart
   - copiar o **index.html** e o **kiosk.sh** para a home do usuário
3. Habilitar Wake on Lan
   - verificar se a placa suporta a configuração com _sudo ethtool <identificador da placa> | grep Wake_
   - A linha _Supports Wake-on: <letters>_ deve conter a letra g, identificando que o pacote é suportado pela placa.
   - Se a linha _Wake on: <letters>_ contiver um g, Wake on Lan está habilitado. Caso contenha um d, habilite com o
       comando _sudo ethtool -s <identificador da placa> wol g_
4. Configurações do vino
   - Executar o conteúdo de **vino-settings** (habilitar acesso com senha à máquina remota).
5. Configurar crontab
   - Alterar o /etc/crontab para execução do __Tv_autopower__ (mover Tv_autopower para /root/)


## Observações
- É importante salientar a importância de uma segunda máquina para efetuar o power-on do kiosk.
- O Wake on Lan é desabilitado a cada reboot - adicione o comando a um dos scripts de inicialização ao seu usuário para que seja possível manter a configuração.
- Se o SO usar o netplan, no arquivo /etc/netplan/01-netcfg.yaml é possível habilitar o wakeonlan: yes
