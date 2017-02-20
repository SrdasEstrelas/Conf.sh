#!/bin/bash

function sshd_config(){ echo "Port 22
Port 443
Protocol 2
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
#UseLogin no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes" > /etc/ssh/sshd_config
}

function payloads(){ echo "minhaclaro.claro.com.br
recargafacil.claro.com.br
frontend.claro.com.br
appfb.claro.com.sv
empresas.claro.com.br
d1n212ccp6ldpw.cloudfront.net
claro-gestoronline.claro.com.br
forms.claro.com.br
golpf.claro.com.br
logtiscap.claro.com.br
www.recargafacil.claro.com.br
.vivo.com.br
.bradescocelular.com.br
.claroseguridad.com" > /etc/payloads
}

apt-get update
apt-get install -y squid3

service apache2 stop
chattr -i /etc/ssh/sshd_config
sshd_config
service ssh restart

echo "http_port 80
http_port 8080
http_port 8799
http_port 3128
visible_hostname VpsPack
acl ip dstdomain $ip
http_access allow ip" > /etc/squid3/squid.conf
echo 'acl accept dstdomain -i "/etc/payloads"
http_access allow accept
acl local dstdomain localhost
http_access allow local
acl iplocal dstdomain 127.0.0.1
http_access allow iplocal
http_access deny all' >> /etc/squid3/squid.conf
payloads
service squid3 restart

echo "PEGA caralho" 
