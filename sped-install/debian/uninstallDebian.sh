#!/bin/bash

## CUIDADO! Isto removera todos os pacotes usados pelo expressoLivre !!

apt-get --purge remove -y openjdk-6-jdk apache2 libapache2-mod-jk libapache2-mod-php5 apache2-common apache2-utils php5 php5-common php5-dev php5-gd php5-imap php5-ldap php5-pgsql php5-cgi php5-cli postgresql-8.3 postgresql-common postgresql-client-8.3 postgresql-client-common slapd ldap-utils db4.2-util
rm -rf /opt/apache-tomcat-6.0.18
/usr/sbin/update-rc.d -f tomcat remove
rm -rf /etc/init.d/tomcat
apt-get autoremove