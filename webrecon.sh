#!/bin/bash

declare -a diretorios
declare -a arquivos

nc='\033[0m'
red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'


exibir_resultado () {
if [ "$2" == "arquivos" ]
then
  declare -n var=$2 # '-n' faz da variável um ponteiro para outra variável.
  printf "${blue}\nArquivos encontrados${nc}\n"
else
  declare -n var=$2 
  printf "${blue}\nDiretórios encontrados${nc}\n"
fi

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
  diretorios+=($palavra)
fi

if [ $arquivo == "200" ]
then
  arquivos+=($palavra.$2)
fi
done

if [ ! -z "$diretorios" ]
then
  exibir_resultado $1 diretorios
fi

if [ ! -z "$arquivos" ]
then
  exibir_resultado $1 arquivos
fi
