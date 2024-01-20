#!/bin/sh
# este script irá configurar o apache2 para a integração com o tomcat.
echo ""
echo "Configurando o Servidor Apache2..."
echo ""

echo "Instalando pacotes necessários"
/usr/bin/apt-get -y install apache2 libapache2-mod-jk php5 libapache2-mod-php5

echo "configurando o modulo JK"
cp httpd.conf /etc/apache2
cp workers.properties /etc/libapache2-mod-jk
cp mod_jk.so /usr/lib/apache2/modules

echo "Desabilitando site padrão do apache"
/usr/sbin/a2dissite default
rm -f /etc/apache2/sites-available/default

echo "Recriando site padrão e configurando SPEd"
cp default /etc/apache2/sites-available
/usr/sbin/a2ensite default

echo "Reiniciando os serviços"
/etc/init.d/apache2 stop
/etc/init.d/tomcat start
/etc/init.d/apache2 start

echo "site do Sped configurado"
echo "Pressione qualquer tecla para continuar"
read
cd /usr/src/sped-2.4.12-instala
