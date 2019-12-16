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

* ex:

```json
{
  "client":
  {
    "name" : "Joao Ferreira",
    "document": "12312312312"
  }
}
```

* GET /providers -> Lista de Prestadores cadastrados
* GET /providers/:id - > Retorna um Prestadores específico
* POST /providers -> Cria um Prestadores
* PATCH/PUT /providers/:id -> Atualiza os dados de um Prestadores específico

* ex:

```json
{
  "provider":
  {
    "name" : "Joao Ferreira",
    "document": "12312312312"
  }
}
```

* GET /pets -> Lista de Pets cadastrados
* GET /pets/:id - > Retorna um Pet específico
* POST /pets -> Cria um Pet
* PATCH/PUT /pets/:id -> Atualiza os dados de um Pet específico

* ex:

```json
{
  "pet":
  {
    "name" : "fofinho",
    "breed": "vira lata",
    "client_id" : 1
  }
}
```

* GET /dog_walkings -> Lista de Passeios cadastrados. Por padrão, retorna todos os passeios. Caso seja informado via parâmetro FILTER = '1', lista apenas os próximos passeios
* GET /dog_walkings/:id - > Retorna um Passeio específico
* POST /dog_walkings -> Cria um Passeio
* POST /dog_walkings/:id/start_walk -> Atualiza o status do passeio para Iniciado
* POST /dog_walkings/:id/finish_walk -> Atualiza o status do passeio para Encerrado
* POST /dog_walkings/:id/cancel_walk -> Atualiza o status do passeio para Cancelado

* ex:

```json
{
  "dog_walking" :
  {
    "schedule_date": "2019-12-20 12:12:12",
    "duration": 60,
    "latitude": "111111",
    "longitude": "000000",
    "provider_id": 1,
    "pets":
      [ { "id" : "1" } , { "id" : "2" }  ]
  }
}
```

### Testes

* Para a executar os testes:

```shell
  bin/rspec
```

* Para verificar cobertura dos testes após sua execução, acessar

```
  dog-api/coverage/index.html#_AllFiles
```
