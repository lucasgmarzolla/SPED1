#!/bin/sh
#Este script coloca o tomcat na pasta correta e configura
#o sistema sped
clear
AVISO='Configurando Tomcat e Sped...'

 "configurando o servidor de aplicação"
tar -zxvf apache-tomcat-6.0.18.tar.gz -C /opt
cp tomcat.sh /etc/init.d/tomcat
tar -zxvf /usr/src/sped-install/debian/sped.tar.gzcp -C /opt/apache-tomcat-6.0.18/webapps
 "acertando o runlevel"
/usr/sbin/update-rc.d -f tomcat defaults 98
echo "fim da configuração do tomcat"
echo "tecle algo para continuar"
read

cd /usr/src/sped-2.4.12-instala

