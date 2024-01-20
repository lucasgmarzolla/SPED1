#!/bin/sh
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

Principal()
{
   clear;
   cecho 1 44 "******************************************************************************";
   cecho 1 44 "#  Projeto SPED                                                              #";
   cecho 1 44 "#  http://www.dct.eb.mil.br                                                  #";
   cecho 1 44 "#  Script Generico para instalacao do SPED - Gerenciador.                    #";
   cecho 1 44 "#  Versao 1.0 - Data 29/03/2009                                              #";
   cecho 1 44 "#  Versao para instalcao no debian                                           #";
   cecho 1 44 "******************************************************************************";
   echo   
   if [ $UID != 0 ]; then {
	echo "Este script deve ser executado como superusuario, root ou sudo";
	exit 1;
	}
   fi
   PWD=`pwd`
   dir_name=`dirname $0`
   DIR_ROOT="/usr/src/sped-install"
   if [ $PWD != $DIR_ROOT  -o $dir_name != "." ]; then {
	cecho 1 41 "******************************************************************************";
	cecho 1 41 "   O Dir $PWD não é o dirtóriio ideal para iniciar a instalação   ";
	cecho 1 41 "       Saia do instalador e coloque-o no local ideal, para isso faça          ";
	cecho 1 41 "               tar -zxvf sped-install.tar.gz -C /usr/src                      ";
	cecho 1 41 "       A instalação pode prosseguir, porém erros poderão ocorrer...           ";
	cecho 1 41 "******************************************************************************";
	}
   fi
   cecho 33 1 "Escolha a sua opcao:"
   echo
   cecho 1 1 "1. Instalar o SPED"
   cecho 1 1 "2. Remover o SPED"
   cecho 1 1 "3. Sair do Script"
   echo
   cecho 32 1 "Digite sua opcao e pressione ENTER: " -n; read opcao;
   case $opcao in
     1) instalar;;
     2) uninstall;;
     3) fim;;
     *) cecho 31 1 "Erro: Opcao invalida" ; sleep 1; clear; Principal;
   esac
}
#	Funcao para imprimir colorido
#	$1 -> Numero da cor do texto
#	$2 -> Numero da cor de fundo
#	$3 -> Texto
#	$4 -> Imprimir na mesma linha, use -n
cecho(){
	echo $4 -e "\e[$1;$2m $3";tput sgr0;
}

returnMain()
{
    cd ..;
    cecho 31 1 "Pressione ENTER para voltar ao menu principal" -n;
    read a; 
    clear;
    Principal
}
# Funcoes que invocam os respectivos scripts
instalar()
{
    echo "Invocando o script para o Debian ...";
    cd debian/; ./installDebian.sh;
	returnMain;
}
uninstall()
{
    echo "Invocando o script para o Debian ...";
    cd debian/; ./uninstallDebian.sh;
	returnMain;
}
fim()
{
 exit 0;
}

Principal
