#!/bin/bash

# INSTALAÇÃO O STUNNEL
# ADAPTADO POR SOUSA TIPS by @eltonsousa
# RODANDO NA PORTA 443 

clear
echo "================ INSTALANDO STUNNEL ================"
sleep 3
apt-get update && apt-get upgrade -y
apt-get install stunnel4 -y
sleep 3
clear

# CONFIGURANDO
echo "============== CONFIGURANDO STUNNEL... =============="
sleep 3
echo "cert = /etc/stunnel/stunnel.pem" >> /etc/stunnel/stunnel.conf
echo "socket = a:SO_REUSEADDR=1" >> /etc/stunnel/stunnel.conf
echo "socket = l:TCP_NODELAY=1" >> /etc/stunnel/stunnel.conf
echo "socket = r:TCP_NODELAY=1" >> /etc/stunnel/stunnel.conf
echo "" >> /etc/stunnel/stunnel.conf
echo "[ssh]" >> /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:22" >> /etc/stunnel/stunnel.conf
echo "accept = 443" >> /etc/stunnel/stunnel.conf
clear
echo "============== CONFIGURADO COM SUCESSO! =============="
sleep 3
clear

# CRIANDO CERTIFICADOS
echo "============= GERANDO CERTIFICADOS SSL... ============="
sleep 3
openssl genrsa -out key.pem 2048
echo "============= PREENCHA OS DADOS (OPCIONAL) ============="
sleep 3
openssl req -new -x509 -key key.pem -out cert.pem -days 1095
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# ATIVANDO INICIALIZAÇÃO AUTOMÁTICA
cp /etc/default/stunnel4 /etc/default/stunnel4.bkp
rm /etc/default/stunnel4

echo "# /etc/default/stunnel" >> /etc/default/stunnel4
echo "# Julien LEMOINE <speedblue@debian.org>" >> /etc/default/stunnel4
echo "# September 2003" >> /etc/default/stunnel4
echo "" >> /etc/default/stunnel4
echo "# Change to one to enable stunnel automatic startup" >> /etc/default/stunnel4
echo "ENABLED=1" >> /etc/default/stunnel4
echo 'FILES="/etc/stunnel/stunnel.conf"' >> /etc/default/stunnel4
echo 'OPTIONS=""' >> /etc/default/stunnel4
echo "" >> /etc/default/stunnel4
echo "# Change to one to enable ppp restart scripts" >> /etc/default/stunnel4
echo "PPP_RESTART=0" >> /etc/default/stunnel4

# DESATIVANDO A PORTA 443 NO SSH
grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
echo "#Port 443" >> /etc/ssh/sshd_config

clear
echo "==== CERTIFICADOS GERADOS, REINICIANDO SERVIÇOS... ===="
sleep 4
service stunnel4 restart
service ssh restart
clear
service stunnel4 restart
sleep 3
echo "============ STUNNEL ISTALADO COM SUCESSO! ============="
sleep 5
clear
