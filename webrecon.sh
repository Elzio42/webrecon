#!/bin/bash

declare -a Diretorios
declare -a Arquivos

nc='\033[0m'
red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'
vard=0
vara=0

exibir_resultado() {
declare -n var=$2 # '-n' faz da variável um ponteiro para outra variável.
printf "${blue}\n\nLista de $2${nc}\n"

for i in "${var[@]}"
do
  echo "http://$1/${i}"
done
}

inserindo_diretorios() {
  if [ $1 == "200" ]
  then
    let "vard+=1"
    Diretorios+=($2)
  fi
}

inserindo_arquivos() {
  if [ $1 == "200" ]
  then
    let "vara+=1"
    Arquivos+=($2)
  fi
}

main() {
for palavra in $(cat listateste.txt)
do

  if [ $1 == "ad" ]
  then
    echo -en "\r${green}Diretórios encontrados:${nc} ${red}$vard${nc} ${green}Arquivos encontrados:${nc} ${red}$vara${nc}"
    diretorio=$(curl -s -H "User-Agent: elzio" -o /dev/null -w "%{http_code}" http://$2/$palavra/)
    arquivo=$(curl -s -H "User-Agent: elzio" -o /dev/null -w "%{http_code}" http://$2/$palavra.$3)

    inserindo_diretorios $diretorio $palavra
    inserindo_arquivos $arquivo $palavra.$3
  fi

  if [ $1 == "d" ]  
  then
    echo -en "\r${green}Diretórios encontrados:${nc} ${red}$vard${nc}"
    diretorio=$(curl -s -H "User-Agent: elzio" -o /dev/null -w "%{http_code}" http://$2/$palavra/)
    inserindo_diretorios $diretorio $palavra
  fi

  if [ $1 == "a" ] 
  then
    echo -en "\r${green}Arquivos encontrados:${nc} ${red}$vara${nc}"
    arquivo=$(curl -s -H "User-Agent: elzio" -o /dev/null -w "%{http_code}" http://$2/$palavra.$3)
    inserindo_arquivos $arquivo $palavra.$3
  fi
  
 done

if [ ! -z "$Diretorios" ]
then
  exibir_resultado $2 Diretorios
fi

if [ ! -z "$Arquivos" ]
then
  exibir_resultado $2 Arquivos
fi
}

main $@
