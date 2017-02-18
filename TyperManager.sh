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
echo ""
echo "$b
"[1] Configurar Vps [$vermelho Ubuntu 14/Anterior $b]"
"[2] Atualizar Pacotes"
"[3] Adicionar Usuario"
"[4] Deletar Usuario"
"[5] Limitar Conexões"
"
echo "$amarelo Escolha um numero para o seu respectivo comando"
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

#Stop no apache2
service apache2 stop

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
 echo "$cyan Atualizando pacotes..."
 echo "$b"
 apt-get update
 echo "$vermelho Tudo terminado :)"
fi

#Caso a resposta seja 3
if [ "$resposta" = "3" ]
then
 echo "$cyan Escolha o nome de usuario"
 read -p "-->: " nome
 useradd $nome
 echo "$b Senha para o usuario $vermelho( $nome )"
 echo "$b"
 passwd $nome
fi

#Caso a resposta seja 4
if [ "$resposta" = "4" ]
then
 read -p "Qual o nome do usuario: " name
 userdel --force $name
 kill -9 `ps aux |grep -vi '[a-z]$name' |grep -vi '$name[a-z]' |grep -v '[1-9]$name' |grep -v '$name[1-9]' |grep $name |awk {'print $2'}`
 echo "Usuario $name foi deletado e parado"
 fi
