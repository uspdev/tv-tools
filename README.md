# TV Tools

## Ferramentas para TV como painel informativo

Instruções para colocar uma TV como painel:

* Instalar alguma distribuição Linux minimalista (sugestão: Lubuntu) na máquina TV
* Configurar para abrir direto o chromium em modo --kiosk sempre que ligar o computador
* Configurar uma máquina com os dois scripts deste repositório: `crontab` (em especial a linha referente ao agendamento do TV_autopower), e o `TV_autopower` em `/root`
