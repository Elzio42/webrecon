# Webrecon
## Observações

* **Modo de uso:** $ /webrecon.sh \<arquivoOUdiretorio\> \<dominio\> \<tipo de arquivo\> 
* A wordlist 'listaextensa.txt' é uma cópia da lista 'common.txt' da ferramenta dirb

### Plano de desenvolvimento:

* Sem parâmetros especificados, irá efetuar uma busca por diretórios e os tipos de arquivos principais
* Um parâmetro poderá ser especificado para busca somente de diretórios ou somente de arquivos
* Um parâmetro poderá ser repassado para filtrar a busca por determinados tipos de arquivos
* Uma lista pode ser passada como parâmetro

### Atualmente:

* O dominio e o tipo de arquivo é passado como parâmetro.
* Um parâmetro pode ser repassado no inicio para indicar se o usuário deseja uma busca somente por arquivos ou diretórios (Ex: ./webrecon a, ./webrecon d, ./webrecon ad)

