#!/usr/bin/python3

# arquivo copiado do repositorio eesc/tv-tools no bitbucket.
# se editar local tem de atualizar no servidor git
# *****************

try:
    from settings import PCTVS
except ImportError as e:
    print("Arquivo de configuração não encontrado")
    print('[EXCEPTION]:', e)


import datetime
import os

NO_POWER_ON = []

FERIADOS = [
    (1, 1),
    (21, 4),
    (1, 5),
    (7, 9),
    (12, 10),
    (2, 11),
    (4, 11),
    (15, 11),
    (25, 12),
]

NO_POWER_ON.append(FERIADOS)

# Semana de recesso no final do ano
RECESSO = [
    (23, 12),
    (24, 12),
    (26, 12),
    (27, 12),
    (28, 12),
    (29, 12),
    (30, 12),
    (31, 12),
]

NO_POWER_ON.append(RECESSO)

now = datetime.datetime.now()


def dia_util(data_atual):
    return data_atual.weekday() < 4


def fica_desligado(data_atual, dias_desligado):
    hoje = (data_atual.day, data_atual.month)
    return hoje in dias_desligado


def hora_util(datetime_atual):
    return 7 <= datetime_atual.hour <= 19


def dispara_acpi_wake():
    for ip, mac in PCTVS.items():

        if not dia_util(now) or fica_desligado(now, NO_POWER_ON) or not hora_util(now): # noqa
            os.system("echo 'ACPITOOL' >> /root/tv_log")
            os.system("ssh {} acpitool -s >> /root/tv_log".format(ip))
        else:
            os.system("echo 'Wake On Lan' >> /root/tv_log")
            os.system("etherwake -i eth0 {} >> /root/tv_log".format(mac))
            os.system("wakeonlan {} >> /root/tv_log".format(mac))

    os.system("date >> /root/tv_log")


if __name__ == '__main__':
    dispara_acpi_wake()
