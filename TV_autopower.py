#!/usr/bin/python
# arquivo copiado do repositorio eesc/tv-tools no bitbucket.
# se editar local tem de atualizar no servidor git
# *****************

import os
import datetime
import urllib
import json

TV_MAC = "70:71:bc:62:e5:83"
TV_IP = "10.233.31.19"

# EXC: dia/mes que não irá ligar
# Feriados (dia, mes)
EXC = [
    (01, 01),
    (21, 04),
    (01, 05),
    (07, 9),
    (12, 10),
    (02, 11),
    (04, 11),
    (15, 11),
    (25, 12),
]

# emendas
# EXC += [
#     (03, 11),
# ]

# Semana de recesso no final do ano
EXC += [
    (23, 12),
    (24, 12),
    (26, 12),
    (27, 12),
    (28, 12),
    (29, 12),
    (30, 12),
    (31, 12),
]

now = datetime.datetime.now()

with open('ipList.json', 'r') as jsFile:
    ipList = json.load(jsFile)
    for p in ipList['adresses']
        # segunda a sexta      ou está no exclude               ou  é noite
        if (now.weekday() > 4) or ((now.day, now.month) in EXC) or (now.hour >= 19) or (now.hour <= 7):
            os.system("echo 'ACPITOOL' >> /root/tv_log")
            os.system("ssh %s acpitool -s >> /root/tv_log" % p['IP'])
        else:
            os.system("echo 'Wake On Lan' >> /root/tv_log")
            #os.system("etherwake -i eth0 %s >> /root/tv_log" % TV_MAC)
            os.system("wakeonlan %s >> /root/tv_log" % p['MAC'])
        

os.system("date >> /root/tv_log")
