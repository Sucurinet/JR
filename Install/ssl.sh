#/bin/bash

echo -e "\033[1;33m- - - - -> \033[01;34mScript Configurar o servidor para usar SSL/TLS Stunnel4"
echo -e "\033[1;33m #################"
echo -e "\033[1;33m- - - - -> \033[01;34mScript Configure the server to use SSL / TLS Stunnel4"
echo -e "\033[1;33m #################"
echo -e "\033[1;31mTELEGRAN:  @Mongevps"
sleep 2
clear
apt-get install stunnel4 -y
clear
yum install stunnel4 -y
clear
apt-get install stunnel -y
clear
yum install stunnel -y
clear

echo -e "\033[1;31mC A P I T U R A N D O  I P"
ip=$(curl https://api.ipify.org/)
echo $ip
clear

echo -e "\033[1;33m ######################################"
echo -e "\033[1;31mF I C A   A P E R T A N D O   E N T E R"
echo -e "\033[1;33m #################"
echo -e "\033[1;31mS T A R T  E N T E R"
echo -e "\033[1;33m ######################################"
sleep 1

echo -e "\033[1;33m ######################################"
echo -e "\033[1;31mG E R A N D O  C E R T I F I C A D O"
echo -e "\033[1;33m #################"
echo -e "\033[1;31mG E N E R A T I N G  C E R T I F I C A T E"
echo -e "\033[1;33m ######################################"
sleep 1
openssl genrsa 2048 > stunnel.key
openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt

echo -e "\033[1;33m ######################################"
echo -e "\033[1;31mC R I A N D O  U M A  N O V A  C O N F I G U R A C A O"
echo -e "\033[1;33m #################"
echo -e "\033[1;31mC R E A T I N G  A   N E W   CO N F I G U R A T I O N"
echo -e "\033[1;33m ######################################"
sleep 2
rm /etc/stunnel/stunnel.conf
clear
rm /etc/default/stunnel4
clear
cat stunnel.crt stunnel.key > stunnel.pem 
mv stunnel.pem /etc/stunnel/
clear
echo -e "\033[1;31mD I G I T E  A  P O R T A  Q U E  D E S E J A R"
echo -e "\033[1;31mP O R T  S S L"
read -p ": " port
clear

echo -e "\033[1;33m ######################################"
echo -e "\033[1;31mC O N F I G U R A N D O  STUNNEL.CONF"
echo -e "\033[1;33m #################"
echo -e "\033[1;31mC O N F I G U R I N G T H E  STUNNEL.CONF"
echo -e "\033[1;33m ######################################"
sleep 1

echo -e "\033[1;31m ###"
sleep 1
echo -e "\033[1;31m #########"
sleep 1
echo -e "\033[1;31m ################"
sleep 1
echo -e "\033[1;31m ########################"
sleep 1
echo -e "\033[1;31m ##################################"
sleep 1


echo "cert = /etc/stunnel/stunnel.pem " >> /etc/stunnel/stunnel.conf
echo "client = no " >> /etc/stunnel/stunnel.conf
echo "sslVersion = ALL " >> /etc/stunnel/stunnel.conf

echo "socket = l:TCP_NODELAY=1 " >> /etc/stunnel/stunnel.conf
echo "socket = r:TCP_NODELAY=1 " >> /etc/stunnel/stunnel.conf
echo "socket = l:SO_KEEPALIVE=1 " >> /etc/stunnel/stunnel.conf
echo "socket = r:SO_KEEPALIVE=1 " >> /etc/stunnel/stunnel.conf
echo "" >> /etc/stunnel/stunnel.conf
echo "[ssh] " >> /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:22 " >> /etc/stunnel/stunnel.conf
echo "accept = $port " >> /etc/stunnel/stunnel.conf


echo -e "\033[1;33m ######################################"
echo -e "\033[1;31mC O N F I G U R A N D O  STUNNEL4"
echo -e "\033[1;33m ###################"
echo -e "\033[1;31mC O N F I G U R I N G  T H E  STUNNEL"
echo -e "\033[1;33m ######################################"
sleep 1

echo "ENABLED=1 " >> /etc/default/stunnel4
echo "FILES="/etc/stunnel/*.conf" " >> /etc/default/stunnel4
echo "OPTIONS="" " >> /etc/default/stunnel4
echo "PPP_RESTART=0" >> /etc/default/stunnel4

echo -e "\033[1;33m ######################################"
echo -e "\033[1;31mI N I C I A N D O  O  STUNNEL4"
echo -e "\033[1;33m ###################"
echo -e "\033[1;31mS T A R T I N G  T H E  STUNNEL4"
echo -e "\033[1;33m ######################################"
sleep 1

echo -e "\033[1;33m ######################################"
echo -e "\033[1;31m ##### V A I  O C O R R E  E R R O S  N O R M A I S AGUARDE...######"
echo -e "\033[1;33m ######################################"
sleep 1
stunnel
/usr/bin/stunnel &
service ssh start 1>/dev/null 2 /dev/null
/etc/init.d/ssh start 1>/dev/null 2 /dev/null
service sshd start 1>/dev/null 2 /dev/null
/etc/init.d/sshd start 1>/dev/null 2 /dev/null
service sshd restart 1>/dev/null 2 /dev/null
/etc/init.d/sshd restart 1>/dev/null 2 /dev/null
service ssh restart 1>/dev/null 2 /dev/null
/etc/init.d/ssh restart 1>/dev/null 2 /dev/null
service stunnel4 start 1>/dev/null 2 /dev/null
/etc/init.d/stunnel4 start 1>/dev/null 2 /dev/null
service stunnel4 restart
/etc/init.d/stunnel4 restart 1>/dev/null 2 /dev/null
systemctl start stunnel4 1>/dev/null 2 /dev/null
systemctl restart stunnel 1>/dev/null 2 /dev/null
clear

echo -e "\033[1;33m #######OCORREU UNS ERROS NORMAIS PRONTO###############"
sleep 2
echo -e "\033[1;33m ###########REINICIADO...###########"
clear

echo -e "\033[1;33m ######################################"
echo -e "\033[1;31mC O N F I G U R A D O  C O M  S U C E S S O  F A C A  O  T E S T E"
echo -e "\033[1;33m ###################"
echo -e "\033[1;31mS U C E S S  T E S T"
echo -e "\033[1;33m ######################################"
echo -e "\033[1;33m- - - - -> \033[01;34mSEU IP HOST:\033[0m $ip"
echo -e "\033[1;33m- - - - -> \033[01;34mPORT SSL:\033[0m $port"
sleep 1
echo -e "\033[1;31mSE NAO FUNCIONAR FAZ O COMANDO REBOOT"
sleep 2
echo -e "\033[1;33m- - ->>C A N A L \033[01;34mhttp://t.me/PayloadHTTP"
echo -e "\033[1;33m- - ->>F E I T O  P O R \033[01;34m Gui @LindoFuLL"
sleep 1
