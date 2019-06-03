import fileinput
import getpass
import subprocess

pwd=''
pwd_confirm='x'
#executa o links.sh para fazer substituição de usuário e fazer link dos arquivos
subprocess.call("./links.sh", shell=True)

while(pwd!=pwd_confirm):
    pwd=getpass.getpass('Informe a senha: ')
    pwd_confirm=getpass.getpass('Confirme a senha: ')
    if(pwd!=pwd_confirm):
        print("As senhas não coincidem!\n ")
    else:
        with open("./vino-settings") as f:
            newText=f.read().replace('mypassword', pwd)
            print(type(newText))
            f.close()
        with open("./vino-settings", 'w') as f:
            f.write(newText)
            f.close()
