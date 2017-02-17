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
echo " "
echo "$cyan ----------------------------------"
echo " |  $cyan Script by: Sr. das Estrelas  |"
echo "$cyan ----------------------------------"

echo "$b
"[1] Configurar Vps"
"[2] Atualizar Pacotes"
"[3] Adicionar Usuario"
"
echo "$amarelo Escolha o numero para o seu respectivo comando..."
read resposta

#Caso a resposta for 1
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
via off" > /etc/squid3/squid.conf

#Restart no Squid3 e SSH
service squid3 restart
service ssh restart

clear
echo "$cyan IP da VPS: $vermelho $IP"
echo "$cyan Squid configurado nas portas: $vermelho 80/8080/3128"
echo ""
echo ""
echo "$vermelho Tudo terminado crie um usuario para testar :)"
fi

#Caso a resposta seja 2
if [ "$resposta" = "2" ]
then
 echo "$cyan Atualizando pacotes"
 echo "$b"
 apt-get update
 echo "$vermelho Tudo terminado :)"
fi

#Caso a resposta seja 3
if [ "$resposta" = "3" ]
then
 echo "$cyan Escolha o nome de usuario"
 read nome
 useradd $nome
 echo "$verde Senha para o usuario $nome"
 passwd $nome
fi