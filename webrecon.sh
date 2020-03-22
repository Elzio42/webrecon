#!/bin/bash

for palavra in $(cat lista.txt)
do
resposta=$(curl -s -o /dev/null -w "%{http_code}" http://$1/$palavra/)
if [ $resposta == "200" ]
then
echo "Diretório encontrado: http://$1/$palavra/"
fi
done


