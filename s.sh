#!/bin/bash
clear

echo "----------------------------------"
echo " | Script by: Sr. das Estrelas |"
echo "----------------------------------"
echo ""
echo "
"[1] Configurar Vps [$vermelho Ubuntu 14/Anterior "
"[2] Atualizar Pacotes _Não funciona_"
"[3] Adicionar Usuario"
"[4] Deletar Usuario _Não funciona_"
"[5] Limitar Conexões _Não funciona_"
"
echo "Escolha um numero para o seu respectivo comando"
read resposta

#Caso a resposta for 1
if [ "$resposta" = "1" ]
then
apt-get update
apt-get install squid3 -y
apt-get install nano
rm /etc/squid3/squid.conf

#Adicionar a porta 443
echo "Port 443" >> /etc/ssh/sshd_config

clear
#IP da VPS
echo "Digite o IP da VPS"
read -p ": " IP

#SQUID3
echo "
http_port 80
visible_hostname LukeWen
acl ip dstdomain $IP
acl ip dstdomain 10.8.0.1
acl CONNECT method CONNECT
acl GET method GET
acl POST method POST
acl s dstdomain -i /?
http_access allow s
http_access allow ip ">>/etc/squid3/squid.conf

echo '
acl accept dstdomain -i "/etc/squid3/payload.txt"
http_access allow accept
acl local dstdomain localhost
http_access allow local
acl iplocal dstdomain 127.0.0.1
http_access allow iplocal
http_access deny all' >> /etc/squid3/squid.conf

#Hosts

echo "$IP
.com.br
vivo
claro
tim
vivo
portalrecarga.vivo.com.br/recarga/i/gp/
portalrecarga.vivo.com.br/recarga
portalrecarga.vivo.com.br/recarga/home

www.portalsva2.vivo.com.br/captive-static/tarif-def/pd/index.html
www.portalsva2.vivo.com.br/captive-static/tarif-def/cd/index.html

navegue.vivo.com.br/pre
sdp.vivo.com.br

portalrecarga.vivo.com.br/dadospos/home/
www.portalrecarga.vivo.com.br/dadospos/home/
portalrecarga.vivo.com.br/noCredit/vitrine/controle/
www.portalrecarga.vivo.com.br/noCredit/vitrine/controle/
interatividade.vivo.ddivulga.com/produto
i.vivo.ddivulga.com/i/gp
portalrecarga.vivo.com.br/recarga/home
i.vivo-hom.ddivulga.com/i/gp
sdp.vivo.com.br
navegue.vivo.ddivulga.com/pacote
200.220.254.31
187.8.166.33
clients1.google.com
veek.com.br
gitlab.veek.com.br
d1n212ccp6ldpw.cloudfront.net" > /etc/squid3/payload.txt

#Dominios 127.0.0.1
echo "
127.0.0.1 portalrecarga.vivo.com.br/recarga/i/gp/
127.0.0.1 portalrecarga.vivo.com.br/recarga
127.0.0.1 portalrecarga.vivo.com.br/recarga/home
127.0.0.1 d1n212ccp6ldpw.cloudfront.net
127.0.0.1 sdp.vivo.com.br
127.0.0.1 navegue.vivo.com.br/pre
127.0.0.1 veek.com.br
127.0.0.1 /?" > /etc/hosts

#Restart No Squid e SSH

service squid3 restart
service ssh restart
sleep 2
service squid3 reload
service ssh restart
sleep 3
clear
bash s.sh
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
