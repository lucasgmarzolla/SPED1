#!/bin/sh
#Este script configura o postgreSQL

echo ""
echo "Configurando o PostgreSQL..."
echo ""

#criando banco de dados sigadaer
echo ""
echo ">> Digite o nome do usuario que foi criado para ser o dono do banco de dados"
read USERDB
USERDB=$USERDB

echo ""
echo ">> Digite a senha do $USERDB"
read SENHA
SENHA=$SENHA
SENHA_MD5=php
echo ">> Digite o nome do banco criado para ser utilizado pelo sped"
read BANCO
BANCO=$BANCO

su - postgres -c'CREATE ROLE '$USERDB' PASSWORD '$SENHA_MD5' NOSUPERUSER NOCREATEDB CREATEROLE INHERIT LOGIN;'
su - postgres -c'createdb  -O '$USERDB' -e '$BANCO''
#psql -U $USERDB -d $BANCO -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public AUTHORIZATION sigad"
psql -h 127.0.0.1 -U $USERDB -d $BANCO -f create.sql
psql -h 127.0.0.1 -U $USERDB -d $BANCO -f insert.sql

cat /usr/share/tomcat/weapps/sped/WEB-INF/config.properties | sed "s/#SENHA#/$SENHA/g" > /usr/share/tomcat/weapps/sped/WEB-INF/config.properties_
mv /usr/share/tomcat/weapps/sped/WEB-INF/config.properties_ /usr/share/tomcat/weapps/sped/WEB-INF/config.properties

cat /usr/share/tomcat/weapps/sped/WEB-INF/config.properties | sed "s/#USERDB#/$USERDB/g" > /usr/share/tomcat/weapps/sped/WEB-INF/config.properties_
mv /usr/share/tomcat/weapps/sped/WEB-INF/config.properties_ /usr/share/tomcat/weapps/sped/WEB-INF/config.properties

cat /usr/share/tomcat/weapps/sped/WEB-INF/config.properties | sed "s/#BANCO#/$BANCO/g" > /usr/share/tomcat/weapps/sped/WEB-INF/config.properties_
mv /usr/share/tomcat/weapps/sped/WEB-INF/config.properties_ /usr/share/tomcat/weapps/sped/WEB-INF/config.properties


echo "Acertando as configurações do PostgreSQL"
cp pg_hba.conf /etc/postgresql/8.3/main

echo "reiniciando o banco de dados..."
/etc/init.d/postgresql-8.3 restart

echo "PostgreSQL configurado!"
echo "tecle algo para continuar..."
read
cd /usr/src/sped-2.4.12-instala


