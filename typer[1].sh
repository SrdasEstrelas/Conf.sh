#!/bin/bash
#Cores
vermelho="\033[1;31m"
verde="\033[1;32m"
amarelo="\033[1;33m"
azul="\033[1;34m"
cyan="\033[1;36m"
b="\033[1;37m"
cinza="\033[1;30m"

clear
main()
#Menu
echo ""
echo "$cyan ----------------------------------"
echo " |  $cyan Script by: Sr. das Estrelas  |"
echo "$cyan ----------------------------------"

echo "$verde
"[1] Configurar Vps"
"[2] Atualizar Pacotes"
"
echo "$amarelo Escolha uma opcao"
read resposta

if [ "$resposta" = "1" ]
then
 echo "$cyan Instalando o editor nano"
 echo "$b"
 apt-get update -y
 apt-get upgrade -y
 apt-get install squid3 -y
 apt-get install curl -y
 #Apagar e criar um novo squid.conf
 echo "
 echo "$vermelho Tudo terminado crie um usuario para testar :)"
fi

if [ "$resposta" = "2" ]
then
 echo "$cyan Atualizando pacotes"
 echo "$b"
 apt-get update
 echo "$vermelho Tudo terminado :)"
fi