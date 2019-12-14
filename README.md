# DOG-API

* API Dog-API foi desenvolvida utilizando ruby 2.6.3 e rails 6, banco de dados Postgresdb
* Utilizada gem aasm para maquina de estado
* Utilizadas as gems api-pagination e kaminari para paginação do retorno da API.
* Utilizada gem simplecov para relatório de cobertura de testes

### Docker

```shell
  docker-compose build
  docker-compose up
```

Acesse em http://localhost:3000

### Sem Docker

```shell
  bin/rails server -p 3000
```

Acesse em http://localhost:3000

### Rotas criadas

* GET /clients -> Lista de clientes cadastrados
* GET /clients/:id - > Retorna um cliente específico
* POST /clients -> Cria um cliente
* PATCH/PUT /clients/:id -> Atualiza os dados de um cliente específico

* GET /providers -> Lista de Prestadores cadastrados
* GET /providers/:id - > Retorna um Prestadores específico
* POST /providers -> Cria um Prestadores
* PATCH/PUT /providers/:id -> Atualiza os dados de um Prestadores específico

* GET /dog_walkings -> Lista de Passeios cadastrados. Por padrão, retorna todos os passeios. Caso seja informado via parâmetro FILTER = '1', lista apenas os próximos passeios
* GET /dog_walkings/:id - > Retorna um Passeio específico
* POST /dog_walkings -> Cria um Passeio
* POST /dog_walkings/:id/start_walk -> Atualiza o status do passeio para Iniciado
* POST /dog_walkings/:id/finish_walk -> Atualiza o status do passeio para Encerrado
* POST /dog_walkings/:id/cancel_walk -> Atualiza o status do passeio para Cancelado

### Testes

* Para a executar os testes:

```shell
  bin/rspec
```

* Para verificar cobertura dos testes após sua execução, acessar

```
  dog-api/coverage/index.html#_AllFiles
```
