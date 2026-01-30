# 🕶️ MALDOSO Framework v1.0

███╗   ███╗ █████╗ ██╗     ██████╗  ██████╗ ███████╗ ██████╗ 
████╗ ████║██╔══██╗██║     ██╔══██╗██╔═══██╗██╔════╝██╔═══██╗
██╔████╔██║███████║██║     ██║  ██║██║   ██║███████╗██║   ██║
██║╚██╔╝██║██╔══██║██║     ██║  ██║██║   ██║╚════██║██║   ██║
██║ ╚═╝ ██║██║  ██║███████╗██████╔╝╚██████╔╝███████║╚██████╔╝
╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝

> **Framework de Engenharia Social & Captura via WebCam**  
> Interface CLI Hacker • Neon • Profissional

---

## ⚙️ Visão Geral

**MALDOSO Framework** é uma ferramenta de linha de comando que cria uma página HTTPS capaz de solicitar acesso à webcam do alvo e capturar imagens assim que a permissão é concedida.

O framework automatiza todo o processo de criação do servidor, exposição do serviço via túnel seguro e coleta de informações básicas do alvo, tudo através de uma interface visual estilizada no terminal.

---

## 🧠 Como Funciona?

O funcionamento do framework é baseado na API nativa dos navegadores modernos:


Essa API solicita permissão ao usuário para acessar dispositivos de mídia, como câmera e microfone.

Fluxo de execução:

1. O alvo acessa o link HTTPS gerado pela ferramenta  
2. O navegador solicita permissão para acesso à webcam  
3. Ao aceitar, o stream de vídeo é iniciado  
4. As imagens são capturadas automaticamente  
5. O IP e informações básicas do dispositivo são registrados  

---

## 🔬 Detalhes Técnicos

- Implementação em **JavaScript**
- Uso da API **MediaDevices.getUserMedia**
- Manipulação visual do favicon para simular o stream da câmera
- Tunelamento HTTPS utilizando **Serveo** ou **Ngrok**
- Interface CLI com tema hacker, logs com timestamp e menu interativo

Documentação oficial da API utilizada:  
https://developer.mozilla.org/en-US/docs/Web/API/MediaDevices/getUserMedia

Conceito visual baseado em implementação de:  
https://github.com/wybiral

---

## 🚀 Instalação

### Requisitos
- bash  
- php  
- ssh  
- wget  
- unzip  

### Kali Linux / Termux

```bash
git clone https://github.com/iRxdhUwU/SayCheese
cd maldoso
bash maldoso
