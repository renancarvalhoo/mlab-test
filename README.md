----- MLAB preparação do ambiente -----
  
################# Backend #################
Todos os comandos devem ser executados dentro da raiz do projeto (mlab)

O projeto foi feito utilizando a versão 2.3.0 do ruby, recomendo utilizá-la.

1 - Executar `bundle install` para instalar as gems necessárias

2 - Executar `rake db:create` para criar os bancos de desenvolvimento e teste

3 - Executar `rake db:schema:load` para criar as tabelas à partir do arquivo schema.rb (esse arquivo contém a estrutura do banco e é atualizado automaticamente toda vez que uma migration é criada)

5 - Executar `rails s` para subir o servidor de desenvolvimento (por padrão ele sobe no locahost:3000)
Para rodar os testes, utilizar o comando `rspec <caminho da pasta/arquivo>`. Se não for passado nenhuma pasta/arquivo, toda a suite será executada.
Os testes são transacionados, ou seja, após cada teste é feito o rollback da transação e nada é salvo no banco de teste.


################# Frontend #################
O projeto do front fica dentro da pasta client.
Todos os comandos devem ser executados dentro da raiz do projeto do frontend (mlab/client)
1 - Certificar-se que o nodejs, npm e bower estão instalados no sistema

2 - Executar `npm install` para instalar as dependências do node

3 - Executar `bower install` para instalar as dependências do bower

4 - Executar `grunt serve` para subir o servidor do frontend (por padrão ele sobe no 0.0.0.0:9000)

Após o grunt serve rodar, ele automaticamente abrirá o navegador no endereço http://0.0.0.0:9000
