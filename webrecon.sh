#!/bin/bash

declare -a Diretorios
declare -a Arquivos

nc='\033[0m'
red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'


exibir_resultado () {
declare -n var=$2 # '-n' faz da variável um ponteiro para outra variável.
printf "${blue}\n$2 encontrados${nc}\n"

for i in "${var[@]}"
do
  echo "http://$1/${i}"
done
}


for palavra in $(cat listateste.txt)
do
diretorio=$(curl -s -H "User-Agent: elzio" -o /dev/null -w "%{http_code}" http://$1/$palavra/)
arquivo=$(curl -s -H "User-Agent: elzio" -o /dev/null -w "%{http_code}" http://$1/$palavra.$2)

if [ $diretorio == "200" ]
then
  Diretorios+=($palavra)
fi

if [ $arquivo == "200" ]
then
  Arquivos+=($palavra.$2)
fi
done

if [ ! -z "$Diretorios" ]
then
  exibir_resultado $1 Diretorios
else
  printf "${red}\nNenhum diretório encontrado para esse dominio${nc}\n"
fi

if [ ! -z "$Arquivos" ]
then
  exibir_resultado $1 Arquivos
else
  printf "${red}\nNenhum arquivo encontrado para esse dominio${nc}\n"
fi
