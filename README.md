# TV Tools

## Ferramentas para TV como painel informativo

O objetivo desse repositório é configurar um PC (tvpc) conectado à uma TV de forma a apresentar uma tela de sinalização digital (signage). Para isso o PC é configurado para carregar o chromium em modo "kiosk". O conteúdo a ser apresentado é gerado em um sistema à parte que disponibiliza as informações por meio de uma página web configurado para rodar no modo kiosk.

Para facilitar a manutenção é configurado um servidor vnc para permitir o acesso remoto da tela.

Para economizar energia, o PC é desligado remotamente nos horários sem utilização e também ligado remotamente. Em princípio está definido para ligar às 7:00 e desligar às 19:00, todos os dias. Há uma previsão para não ligar nos finais de semana mas não está implementado adequadamente.

### Pré-Requisitos
* distribuição minimalista Linux (neste caso usamos o Lubuntu 18.04)
* navegador: chromium
* configuração da placa de rede: ethtool
* servidor VNC: vino-server
* remover o cursor: unclutter
* servidor SSH: openssh-server
* um servidor remoto (linux) na mesma lan para ligar e desligar o tvpc.
* python 3 instalado

### Insalação - Servidor
1. Efetuar a instalação das dependências do sistema, rodando como `root`:
```
sudo ./install.sh
```
Cada passo do script é delimitado com uma saída `echo`. É criado um usuário (`tvpc`) e
uma senha aleatória, baseada na string de `date`.

2. Dar permissões administrativas ao usuário
   - Administrador:

   ```bash
   visudo -> tvpc ALL=(ALL) NOPASSWD: ALL
   ```

Reinicie o PC para que as alterações tenham efeito

3. Habilitar Wake on Lan
   - verificar se a placa suporta a configuração com
   ```
   sudo ethtool <identificador da placa> | grep Wake
   ```
   - A linha _Supports Wake-on: <letters>_ deve conter a letra g, identificando que o pacote é suportado pela placa.
   - Se a linha _Wake on: <letters>_ contiver um g, Wake on Lan está habilitado. Caso contenha um d, habilite com o
       comando _sudo ethtool -s <identificador da placa> wol g_
4. Configurar boot e shutdown remoto
   - dar permissão de escrita ao arquivo /sys/power/state ao usuário `tvpc`.

## Instalação - Cliente Wake Up

1. Instale o awaker:

```bash
sudo ./install_awaker.sh
```

2. Copie o arquivo `settings_example.py` para `settings.py` e preencha com
os PCTVS de sua rede conforme instrução.

Testar a execução tanto do `acpitool -s` quanto do `wakeonlan`


## Observações
- É importante salientar a importância de uma segunda máquina para efetuar o power-on do kiosk.
- O Wake on Lan é desabilitado a cada reboot - adicione o comando a um dos scripts de inicialização ao seu usuário para que seja possível manter a configuração.
- Se o SO usar o netplan, no arquivo /etc/netplan/01-netcfg.yaml é possível habilitar wake on lan com wakeonlan: yes
- **ATENÇÃO** Não se esqueça de habilitar um ntp-server no crontab - em caso de possíveis problemas com a sincronização de horário (em processo de implementação)


## Manutenção periódica

- O SO do pc tem de ser atualizado periódicamente com:
```
apt update
apt upgrade
cd /home/tvpc/tv-tools/
git pull
```
- **ATENÇÃO** - caso não seja utilizado o usuário e/ou senha padrão, favor executar a atualização da seguinte forma.
```
apt update && apt upgrade -y
cd /home/tvpc/tv-tools/
git stash
git pull
```
