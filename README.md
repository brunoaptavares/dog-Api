# DOG-API

* Dog-API

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

### Testes

* Para a executar os testes:

```shell
  bin/rspec
```
