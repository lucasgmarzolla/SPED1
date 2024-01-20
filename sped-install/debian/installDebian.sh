#!/bin/bash

/* foreground colors */
#define AFC_BLACK           30
#define AFC_RED             31
#define AFC_GREEN           32
#define AFC_YELLOW	    33
#define AFC_BLUE            34
#define AFC_MAGENTA         35
#define AFC_CYAN            36
#define AFC_WHITE           37

/* ansi background colors */
#define ABC_BLACK           40
#define ABC_RED             41
#define ABC_GREEN           42
#define ABC_YELLOW          43
#define ABC_BLUE            44
#define ABC_MAGENTA         45
#define ABC_CYAN            46
#define ABC_WHITE           47

set -e # Para caso de erro
#---------------------------------------------------------------------
#faz o iníco da tela
teto()
{
   clear;
   cecho 1 44 "******************************************************************************";
   cecho 1 44 "#  Projeto SPED                                                              #";
   cecho 1 44 "#  http://www.dct.eb.mil.br                                                  #";
   cecho 1 44 "#  Script para debian Lenny de instalação do SPED - 2.4.12                   #";
   cecho 1 44 "#  Versao 1.0 - Data 29/03/2009                                              #";
   cecho 1 44 "#  Versao para instalcao no debian                                           #";
   cecho 1 44 "******************************************************************************";
   echo   
}
#---------------------------------------------------------------------
#Rotina do menu principal
Principal1()
{
   teto;
   cecho 33 1 "Escolha a sua opcao:"
   echo
   cecho 1 1 "1. Trocar sources.list"
   cecho 1 1 "2. Atualizar o aplicativo APT como o novo repositório"
   cecho 1 1 "3. Escolha o pacote java a ser instalado"
   cecho 1 1 "4. Instalar os aplicativos necessários para o SPED"
   cecho 1 1 "5. Retornar sem alterar nada"
   echo
   cecho 32 1 "Digite sua opcao e pressione ENTER: " -n; read spedop;
   case $spedop in
     1) trocarsource;;
     2) atualizar;
        returnMain;; 
     3) instalarjava;;
     4) instalarsped;;
     5) fim;;
     *) cecho 31 1 "Erro: Opcao invalida" ; sleep 1; clear; returnMain;
   esac
}
#---------------------------------------------------------------------
# Funcoes que invocam os respectivos scripts
trocarsource()
{
   echo   
   cecho 33 1 "Escolha a sua opcao:"
   echo
   cecho 1 1 "1. Usar mirror do Exército"
   cecho 1 1 "2. Usar repositório Oficial do Debian"
   cecho 1 1 "3. Não trocar o repositório"
   echo
   cecho 32 1 "Digite sua opcao e pressione ENTER: " -n; read repo;
   case $repo in
     1) cecho 33 1 "trocando o source.lists para o mirror do Exército"
	mv /etc/apt/sources.list /etc/apt/sources.list.old
	cp ../arqs-conf/etc/apt/sources.list.eb /etc/apt/sources.list
	cecho 33 1 "source.list alterado com sucesso!"
	sleep 2
	returnMain
	;;
     2) cecho 33 1 "trocando o source.lists para o Repositorio Debian"
	mv /etc/apt/sources.list /etc/apt/sources.list.old
	cp ../arqs-conf/etc/apt/sources.list /etc/apt/sources.list
	cecho 33 1 "source.list alterado com sucesso!"
	sleep 2
	returnMain
	;;
     3) returnMain;;
     *) cecho 31 1 "Erro: Opcao invalida" ; sleep 1; clear; returnMain;
  esac
}
#----------------------------------------------------------------------
#Faz a autalização do repositorio
atualizar()
{
    apt-get update;
    sleep 2;
}
#---------------------------------------------------------------------
#Faz a instalação do pacote Java
instalarjava()
{
    cecho 33 1 "Escolha o pacote java a ser instalado";
    echo
    cecho 1 1 "1. Usar pacote openjdk"
    cecho 1 1 "2. Usar pacote da sun (acitar licença DJL)"
    echo
    cecho 32 1 "Digite sua opcao e pressione ENTER: " -n; read java;
    case $java in
       1) cecho 33 1 "Instalando pacote openjdk"
          cecho 33 1 "Baixando pacotes...."
          apt-get install -y openjdk-6-jdk
          sleep 2
          cat ../arqs-conf/etc/environment.openjdk > /etc/environment
          source /etc/environment
          cecho 33 1 "Pacote instalado, com sucesso!"
          sleep 1
          returnMain;;
       2) cecho 33 1 "Instalando pacote java-sun (Aceitar licença)"
          cecho 33 1 "Baixando pacotes...."
          apt-get install -y sun-java6-jdk sun-java6-jre sun-java6-plugin
          sleep 2
          cat ../arqs-conf/etc/environment.javasun > /etc/environment
          source /etc/environment
          cecho 33 1 "Pacote instalado, com sucesso!"
          sleep 1
          returnMain;;
       *) cecho 31 1 "Erro: Opcao invalida" ; sleep 1; clear; returnMain;
    esac
}
#---------------------------------------------------------------------
#Faz a instalção dos pacotes necessários ao funcionamento do SPED
instalarsped()
{
    clear;
    teto;
    cecho 33 1 "Instalando pacotes necessários ao funcionamento do SPED"
    echo
    cecho 33 1 "Responda as questões do debconf, para que a instalação possa prosseguir..."
    echo
    cecho 33 1 "Após a instalação lhe serão feitas as perguntas necessárias para a correta"
    echo
    cecho 33 1 "configuração do sped."
    echo
    cecho 33 1 "Caso algo de errado aconteça retorne ao nemu principal e faça a desinstalação"
    cecho 33 1 "e reinstale."
    echo
    sleep 3
    cecho 33 1 "Baixando pacotes...."
    apt-get install -y apache2 libapache2-mod-jk libapache2-mod-php5 apache2-utils php5 php5-common php5-dev php5-gd php5-imap php5-ldap php5-pgsql php5-cgi php5-cli slapd ldap-utils db4.2-util nmap vim zip unzip graphviz lsb-base openssl;
    sleep 2
    pegasenha;
    sleep 2
    mostrasenha;
    sleep 2
    instalatomcat;
    sleep 2
    configapache;
    sleep 2
    configldap;
    sleep 2
    configdb;
    sleep 2
    configsped;
    sleep 2
    fim;
}
#---------------------------------------------------------------------
#Retorna ao menu principal
fim()
{
 exit 0;
}
#---------------------------------------------------------------------
#Transforma as variaveis
get_vars()
{
    LDAP_DN=`php ../arqs-conf/makedn.php $DOMAIN`
    LDAP_DC=`php ../arqs-conf/makedc.php $DOMAIN`
    LDAP_PWD_MD5=`slappasswd -v -s $LDAP_PWD -h {SSHA}`
    ADMIN_SENHA=`slappasswd -v -s $ADMIN_SENHA -h {SSHA}`
    LDAP_PWD_MD5=`php ../arqs-conf/regexp.php $LDAP_PWD_MD5`
    HEADER_PWD=`php ../arqs-conf/pass.php $LDAP_PWD`
}
#---------------------------------------------------------------------
#coleta as senhas
pegasenha()
{
    clear;
    teto;
    cecho 33 1 "Digite uma senha para manager(root) do OpenLDAP: " -n; read LDAP_PWD;
    LDAP_PWD=$LDAP_PWD
    echo
    cecho 33 1 "Digite uma organização [DC dop OpenLDAP]: (ex.:DCT): " -n; read ORG;
    ORG=$ORG
    echo
    cecho 33 1 " Digite seu domínio:[ex.:$ORG.eb.mil.br]: " -n; read DOMAIN;
    DOMAIN=$DOMAIN
    echo
    cecho 33 1 "Digite a senha do admin_espd que sera criado no OpenLDAP :" -n; read ADMIN_SENHA
    ADMIN_SENHA=$ADMIN_SENHA
    echo
}
#Mostra as senhas coletadas
mostrasenha()
{
    clear;
    teto
    cecho 33 1 "******************************************************************************";
    echo
    cecho 35 1 "* Os Dados informados foram:                                                  ";
    echo
    cecho 35 1 "* Senha do OpenLDAP do Administrador do SPED: $LDAP_PWD                       ";
    echo
    cecho 35 1 "* Organização, TOP da BASE LDAP: $ORG                                         ";
    echo
    cecho 35 1 "* Domínio do OepnLDAP, essa é a base de pesquisa: $DOMAIN                     ";
    echo
    cecho 35 1 "* Senha do admin_sped, essa é está criptografada: $ADMIN_SENHA                ";
    echo
    cecho 33 1 "******************************************************************************";
    sleep 2
    get_vars
    cecho 33 1 " Criptografando as senhas para gravar ....."
    cecho 32 1 "$LDAP_PWD_MD5"
    cecho 32 1 "$ADMIN_SENHA"
    sleep 2
}
#---------------------------------------------------------------------
#Configura o servidor tomcat
instalatomcat()
{
    clear;
    teto;
    cecho 33 1 "Iniciando instalação do TOMCAT"
    sleep 2
    cecho 31 1 "Aguarde....."
    sleep 1
    tar -zxvf ../arqs-conf/tomcat/jakarta-tomcat-5.5.9.tar.gz -C /opt/  > tomcat.log
    ln -s /opt/jakarta-tomcat-5.5.9/ /usr/local/tomcat
    cp ../arqs-conf/tomcat/tomcat.sh /etc/init.d/tomcat
    /usr/sbin/update-rc.d -f tomcat defaults 98 >> tomcat.log
    cecho 33 1 "Tomcat instalado!"
}
#---------------------------------------------------------------------
#Configura o apache2
configapache()
{
    clear;
    teto;
    cecho 33 1 "Configurando o servidor WEB Apache2"
    sleep 2
    cecho 31 1 "Aguarde..."
    sleep 1
    cp ../arqs-conf/etc/apache2/httpd.conf /etc/apache2/
    cp ../arqs-conf/etc/apache2/default /etc/apache2/sites-available/
    cp ../arqs-conf/etc/apache2/mod_jk.so /usr/lib/apache2/modules
    cp ../arqs-conf/etc/apache2/workers.properties /etc/libapache2-mod-jk/
    /etc/init.d/apache2 stop
    cecho 33 1 "Servidor WEB Apache2 configurado!"
}
#---------------------------------------------------------------------
#configura o LDAP
configldap()
{
    clear;
    teto;
    cecho 33 1 "Configurando o Servidor OpenLDAP"
    sleep 1
    cecho 31 1 "Parando servidor..."
    /etc/init.d/slapd stop
    cecho 32 1 "Realizando ajustes...."
    sleep 2
    cecho 31 1 "aguarde..."
    sed -e "s/LDAP_DN/$LDAP_DN/g" -e "s/LDAP_PWD_MD5/$LDAP_PWD_MD5/g" ../arqs-conf/etc/ldap/slapd.conf.lenny > /etc/ldap/slapd.conf
    cp ../arqs-conf/etc/ldap/schema/* /etc/ldap/schema/
    rm -rf /var/lib/ldap
    mkdir /var/lib/ldap
    cp ../arqs-conf/etc/ldap/DB_CONFIG /var/lib/ldap
    chown -R openldap. /var/lib/ldap/
    cecho 31 1 "Iniciando o serviço OpenLDAP"
    /etc/init.d/slapd start
    cecho 32 1 "Instalando Pacotes, Aguarde..."
    sleep 2
    sed -e "s/LDAP_DN/$LDAP_DN/g" -e "s*LDAP_PWD_MD5*$ADMIN_SENHA*g" -e "s/ORG/$ORG/g" -e "s/DOMAIN/$DOMAIN/g" -e "s/LDAP_DC/$LDAP_DC/g" ../arqs-conf/etc/ldap/base.ldif > /tmp/base.ldif
    sleep 2
    cecho 32 1 "É necessário carregar a base do OpenLDAP"
    cecho 32 1 "Entre com a senha do OpenLDAP: " -n; read LDAP_PWD1
    LDAP_PWD1=$LDAP_PWD1
    ldapadd -x -D cn=manager,$LDAP_DN -w $LDAP_PWD1 -f /tmp/base.ldif
    sleep 1
    cecho 31 1 "Testando a base do OpenLDAP"
    ldapsearch -x -D cn=manager,$LDAP_DN -b $LDAP_DN -w $LDAP_PWD1 -LLL 
    cecho 32 1 " Servidor OpenLDAP configurado!"
    cecho 32 1 " Verifique eventuais mensagens de erro!"
    cecho 32 1 " login manager: cn=manager,$LDAP_DN"
    sleep 2
    rm /tmp/base.ldif
}
#---------------------------------------------------------------------
#configura o postgresql
configdb()
{
    clear;
    teto;
    cecho 33 1 "Iniciando configuração do postgresql" 
    cecho 33 1 "Instalando pacotes necessários, ainda não instalados"
    apt-get install -y postgresql-8.3 postgresql-common postgresql-client-8.3 postgresql-client-common
    clear;
    teto;
    cecho 32 1 "Configurando o banco de dados postgresql"
    cecho 33 1 "Digite o usuario do banco:Ex (sped) :" -n; read USERDB;
    USERDB=$USERDB
    echo
    cecho 33 1 "Digite o nome do banco: Ex.:(spedDB): " -n; read BANCO;
    BANCO=$BANCO
    echo
    cecho 33 1 "Digite a senha do usuario do banco: Ex.:(sped): " -n; read SENHA;
    SENHA=$SENHA
    echo
    clear;
    teto;
    cecho 31 1 "Criando usuário e banco, a senha será solicitada!"
    sleep 2
    /etc/init.d/postgresql-8.3 start
    su - postgres -c 'createuser -A -P -D -e '$USERDB''
    su - postgres -c 'createdb -O '$USERDB' -e '$BANCO''  || { echo "Problemas na crição do banco expresso. [Falhou]"; exit 1;}
    sleep 1
    clear;
    teto;
    cecho 31 1 "Criando tabelas necessárias no Banco de dados, a senha será solicitada!"
    sleep 2
    psql -h 127.0.0.1 -U $USERDB -d $BANCO -f ../arqs-conf/etc/postgresql/create.sql
    clear;
    teto;
    cecho 31 1 "Inserindo dados inicias de tabelas no Banco de dados, a senha será solicitada!"
    sleep 2
    psql -h 127.0.0.1 -U $USERDB -d $BANCO -f ../arqs-conf/etc/postgresql/insert.sql
    clear;
    teto;
    cecho 31 1 "Parando o banco...."
    sleep 1
    /etc/init.d/postgresql-8.3 stop
    cecho 32 1 "Acertando configurações do banco...."
    sed -e "s/md5/password/g"  /etc/postgresql/8.3/main/pg_hba.conf > /etc/postgresql/8.3/main/pg_hba.conf.trans
    cat /etc/postgresql/8.3/main/pg_hba.conf.trans > /etc/postgresql/8.3/main/pg_hba.conf
    sleep 1
    cecho 33 1 "Banco de dados configurado!, inicianado o servidor postgresql..."
    /etc/init.d/postgresql-8.3 start
}
#---------------------------------------------------------------------
#configura o SPED
configsped()
{
    clear;
    teto;
    cecho 33 1 "Iniciando configuração do SPED"
    #sleep 2
    #tar -zxvf ../arqs-conf/sped.tar.gz -C /opt/apache-tomcat-6.0.18/webapps > sped.log
    #rm -rf /opt/apache-tomcat-6.0.18/work
    cecho 31 1 "Aguarde..."
    cecho 32 1 "Acertando o workers.properties do sped"
    sleep 1
    sed -e "s/LDAP_DN/$LDAP_DN/g" -e "s/LDAP_PWD/$LDAP_PWD/g" -e "s/BANCO/$BANCO/g" -e "s/USERDB/$USERDB/g" -e "s/SENHA/$SENHA/g" ../arqs-conf/sped/config.properties > ../arqs-conf/sped/config.properties1
    cp ../arqs-conf/sped/config.properties1 /opt/jakarta-tomcat-5.5.9/webapps/sped/WEB-INF/config.properties
    clear;
    teto;
    cecho 32 1 "Fim da configuração do SPED"
    sleep 1
    cecho 31 1 "Reiniciando os serviços"
    /etc/init.d/tomcat start 
    /etc/init.d/apache2 start
    cecho 32 1 "SPED INSTALADO!"
    cecho 33 1 "Caso ocorra falha... reinicie o servidor tomcat e posteriormente o servidor apache"
    sleep 3
}
#---------------------------------------------------------------------}
#Funçao para echo colorido
cecho(){
#	$1 -> Numero da cor do texto
#	$2 -> Numero da cor de fundo
#	$3 -> Texto
#	$4 -> Imprimir na mesma linha, use -n
	echo $4 -e "\e[$1;$2m $3";tput sgr0;
}
#---------------------------------------------------------------------
#retorna ao menu de instalação do 2º estagio
returnMain()
{ 
    clear;
    Principal1
}

#---------------------------------------------------------------------
#Inicia o programa de instalação

Principal1

