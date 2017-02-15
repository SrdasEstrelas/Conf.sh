#!/bin/bash
#Cores
vermelho="\033[1;31m"
verde="\033[1;32m"
amarelo="\033[1;33m"
azul="\033[1;34m"
cyan="\033[1;36m"
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
 echo "$cyan Configurando VPS, aguarde..."
 echo "$verde"
 apt-get update -y
 apt-get upgrade -y
 apt-get install squid3 -y
 apt-get install curl -y
 #Adicionar a porta 443 no ssh e ativar a compressão
 echo "Port 443
 Compression yes" >> /etc/ssh/sshd_config
 
 #Apagar e criar um novo squid.conf
 IP=$(curl https://api.ipify.org/)
 echo $IP
 cd /etc/squid*
 rm squid.conf
 echo "#Squid By: Sr. Das Estrelas

acl vps1 dstdomain -i 127.0.0.1
acl vps2 dstdomain -i localhost
acl vps3 dstdomain -i $IP
acl vps4 dstdomain -i .br
acl vps5 dstdomain -i .com
acl vps6 dstdomain -i .net

acl CONNECT method CONNECT
acl GET method GET
acl POST method POST
acl OPTIONS method OPTIONS
acl HEAD method HEAD

http_access allow vps1
http_access allow vps2
http_access allow vps3
http_access allow vps4
http_access allow vps5
http_access allow vps6
cache deny all
http_access deny all

http_port 80
http_port 8080
http_port 3128
visible_hostname SrdasEstrelas

forwarded_for off
via off"

clear
echo "$cyan IP da VPS: $vermelho $IP"
echo "$cyan Squid configurado nas portas: $vermelho 80/8080/3128"

 
 echo ""
 echo ""
 echo "$vermelho Tudo terminado crie um usuario para testar :)"
fi

if [ "$resposta" = "2" ]
then
 echo "$cyan Atualizando pacotes"
 echo "$b"
 apt-get update
 echo "$vermelho Tudo terminado :)"
fi
