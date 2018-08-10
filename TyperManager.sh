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
echo " "
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
apt-get update
apt-get install squid3 -y
apt-get install nano

#Adicionar a porta 443
echo "Port 443" >> /etc/ssh/sshd_config

clear
#IP da VPS
echo "Digite o IP da VPS"
read -p ": " IP

#Novo squid.conf
echo "http_port 8080
http_port 80
http_port 3128
visible_hostname SrdasEstrelas
acl accept src $IP" > /etc/squid3/squid.conf

echo 'acl br url_regex -i "/etc/squid3/accept"
acl all src 0.0.0.0/0.0.0.0
http_access allow accept
http_access allow br
http_access deny all' >> /etc/squid3/squid.conf

#Dominios
echo "$IP
.com.br
vivo
claro
tim
vivo" > /etc/squid3/accept

service squid3 restart
service ssh restart

echo "$cyan IP da VPS: $vermelho $IP"
echo "$cyan Squid configurado nas portas: $vermelho 80/8080/3128"
echo ""
echo ""
echo "$cyan Tudo terminado crie um usuario para testar :)"
fi

#Caso a resposta seja 2
if [ "$resposta" = "2" ]
then
 echo "$cyan Atualizando pacotes..."
 echo "$b"
 apt-get update-y
 apt-get upgrade -y
 echo "$vermelho Tudo terminado :)"
fi

#Caso a resposta seja 3
if [ "$resposta" = "3" ]
then
 echo "$cyan Escolha o nome de usuario"
 read -p " " nome
 useradd -M -s /bin/false $nome
 echo "$b Senha para o usuario $vermelho( $nome )"
 read -p " " pass
 (echo $pass; echo $pass)|passwd $nome
 echo "$cyan Usuário: $b( $nome )"
 echo "$cyan Senha: $b( $pass )"
fi

#Caso a resposta seja 4
if [ "$resposta" = "4" ]
then
 read -p "Qual o nome do usuario: " name
 userdel --force $name
 kill -9 `ps aux |grep -vi '[a-z]$name' |grep -vi '$name[a-z]' |grep -v '[1-9]$name' |grep -v '$name[1-9]' |grep $name |awk {'print $2'}`
 echo "Usuario $name foi deletado e parado"
 fi
