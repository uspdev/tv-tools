# TV Tools

## Ferramentas para TV como painel informativo

Instruções para colocar uma TV como painel:

### Pré-Requisitos
* distribuição minimalista Linux (neste uso, o Lubuntu foi utilizado)
* navegador: chromium
* editor de configurações: dconf-editor
* servidor VNC: vino-server



### Passo a passo
1. Efetuar a instalação dos pacotes acima citados (todos via apt)
2. Configuração do modo kiosk do chromium e ajustar no _startup_
   - copiar o conteúdo da pasta **autostart** em .config/autostart
   - copiar o **index.html** para a home do usuário
3. Configurações do vino
   - Executar o conteúdo de **vino-settings** (necessita de detalhamento).
4. Configurar crontab
   - Alterar o /etc/crontab para execução do __Tv_autopower__ (mover Tv_autopower para /root/)


## Observações
É importante salientar a importância de uma segunda máquina para efetuar o power-on do kiosk
