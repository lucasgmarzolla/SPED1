#!/bin/bash

echo ""
echo "Configurando LDAP..."
echo ""

#Parando o servi√ßo
echo "Parando o servi√ßo..."
/etc/init.d/slapd stop

#Removendo a base
echo "Removendo a base"
rm -rf /var/lib/ldap/*

#Digitando a sigla da OM
echo "Digite o sufixo da base do dominio do LDAP: "
read DN
export BASEDN=$DN

echo "Digite o DC (Domain Controler) nornalmente È o inÌcio de $DN"
read DC
DC=$DC


echo "O sufixo digitado foi: $BASEDN"
echo "o DC digitado foi : $DC"
echo""
#Inserindo a sigla da OM no arquivo slapd.conf
cat slapd.script | sed "s/#BASE#/$BASEDN/g" > slapd.script1
cat /usr/share/tomcat/webapps/sped/WEB-INF/config.properties | sed "s/#BASE#/$BASEDN/g" > /usr/share/tomcat/webapps/sped/WEB-INF/config.properties_
mv /usr/share/tomcat/webapps/sped/WEB-INF/config.properties_ /usr/share/tomcat/webapps/sped/WEB-INF/config.properties
#mv slapd.script1 slapd.conf
#cp slapd.conf /etc/ldap/slapd.conf

# Digitando a senha do manager 
echo "Digite a senha do usuario manager que sera criado no LDAP"
read senhe
echo "Digite novamente a senha do usuario manager do LDAP"
HASH_SENHA_MANAGER=$(slappasswd )

#Inserindo o hash da senha do manager no arquivo manager.ldif
echo "Configurando so arquivos e acertando as senhas"
cat slapd.script1 | sed "s*#SENHA#*$HASH_SENHA_MANAGER*g" > slapd.script2
mv slapd.script2 slapd.conf
rm slapd.script1
cp slapd.conf /etc/ldap/slapd.conf
cat /usr/share/tomcat/webapps/sped/WEB-INF/config.properties | sed "s*#SENHA#*$senhe*g" > /usr/share/tomcat/webapps/sped/WEB-INF/config.properties_
mv /usr/share/tomcat/webapps/sped/WEB-INF/config.properties_ /usr/share/tomcat/webapps/sped/WEB-INF/config.properties

#Inserindo a sigla da OM no arquivo base.ldif
cat base.script | sed "s/#BASE#/$BASEDN/g" > base.script1
cat base.script1 | sed "s/#DC#/$DC/g" > base.script2
#mv base.script1 base.ldif

# Digitando a senha do admin_sigad 
echo "Digite a senha do usuario admin_sped que serah criado no LDAP"
HASH_SENHA_ADMIN=$(slappasswd)

#Inserindo o hash da senha do admin_sigad no arquivo admin_sigad.ldif
cat base.script2 | sed "s*#SENHA#*$HASH_SENHA_ADMIN*g" > base.script3
mv base.script3 base.ldif
rm -f base.script1 base.script2

#Adicionando o registro admin_sigad.ldif na base ldap
#echo "Adicionando o registro admin_sped na base..."
#slapadd -l /usr/src/sped-2.4.12-instala/ldap/base.ldif
#echo ""

#Alterando permiss√£o e iniciando serviÁo
echo "Alterando a permiss√£o e iniciando o servi√ßo..."
chown openldap: /var/lib/ldap/*
/etc/init.d/slapd start


echo"Populando a base"
ldapadd -x -D cn=manager,dc=dct,dc=eb,dc=mil,dc=br -W -f base.ldif

#Testando a base
echo "Testando a base..."
slapcat

ldapsearch -x -D cn=manager,$BASEDN -b $BASEDN -W -LLL


echo ""
echo "Ldap configurado. Verifique eventuais mensagens de erro!"
echo "login manager: cn=manager,$BASEDN" 
echo ""
echo "Pressione qualquer tecla para continuar"
read

cd /usr/src/sped-2.4.12-instala

