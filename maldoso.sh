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

# ================== MENU ==================
menu() {
  separator
  printf "${GREEN}[01]${RESET} ${GRAY}Servidor Local (demo)${RESET}\n"
  printf "${GREEN}[02]${RESET} ${GRAY}Servidor Online (demo)${RESET}\n"
  printf "${GREEN}[00]${RESET} ${GRAY}Sair${RESET}\n"
  separator
  read -p "$(printf "${PURPLE}➜ Escolha uma opção: ${RESET}")" opt

  case $opt in
    1) demo_local ;;
    2) demo_online ;;
    0) exit 0 ;;
    *) warn "Opção inválida"; sleep 1; menu ;;
  esac
}

# ================== DEMOS ==================
demo_local() {
  info "Iniciando servidor local"
  spinner
  wait_msg "Aguardando conexões"
  sleep 1.2
  capture "Dispositivo ${GREEN}CAPTURADO${RESET} com sucesso"
  success "IP registrado no sistema"
  sleep 1
  menu
}

demo_online() {
  info "Iniciando servidor online"
  spinner
  server_msg "Link gerado: ${GREEN}https://demo.server.net${RESET}"
  wait_msg "Monitorando acessos remotos"
  sleep 1.2
  capture "Sessão ${GREEN}ESTABELECIDA${RESET}"
  sleep 1
  menu
}

# ================== EXECUÇÃO ==================
intro
glitch_text "MALDOSO FRAMEWORK"
glitch_text "Inicializando ambiente"
spinner
banner
menu
