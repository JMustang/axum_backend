# Axum Backend

API REST em Rust com [Axum](https://github.com/tokio-rs/axum), PostgreSQL (SQLx) e suporte a JWT, CORS e envio de e-mail.

## Tecnologias

- **Framework:** Axum 0.7
- **Banco de dados:** PostgreSQL com SQLx
- **Autenticação:** JWT (jsonwebtoken), Argon2 para hash de senha
- **Validação:** validator, serde
- **Outros:** tower-http (CORS, trace), lettre (e-mail), chrono, uuid

## Pré-requisitos

- [Rust](https://www.rust-lang.org/) (edition 2024)
- [Docker](https://www.docker.com/) e Docker Compose (para o PostgreSQL)
- [SQLx CLI](https://github.com/launchbadge/sqlx) (para migrações): `cargo install sqlx-cli --no-default-features --features postgres`

## Variáveis de ambiente

Crie um arquivo `.env` na raiz do projeto. O app espera:

| Variável        | Descrição                          | Exemplo                          |
|-----------------|------------------------------------|----------------------------------|
| `DATABASE_URL`  | URL de conexão PostgreSQL          | `postgresql://postgres:postgres@localhost:5432/axum_backend` |
| `JWT_SECRET_KEY`| Chave secreta para assinatura JWT  | `sua-chave-secreta`              |
| `JWT_MAXAGE`    | Tempo de expiração do token (segundos) | `3600`                       |

A aplicação usa a porta **8000** por padrão (configurável em `src/config.rs`).

Você pode usar o script para gerar um `.env` base:

```bash
./setup-env.sh
```

**Nota:** O script gera `JWT_SECRET` e `JWT_EXPIRATION`; o código usa `JWT_SECRET_KEY` e `JWT_MAXAGE`. Ajuste o `.env` para incluir:

```env
JWT_SECRET_KEY=sua-chave-secreta
JWT_MAXAGE=3600
```

## Como rodar

### 1. Subir o PostgreSQL

```bash
docker-compose up -d
```

### 2. Criar o banco e rodar migrações

```bash
sqlx database create
sqlx migrate run
```

### 3. Iniciar a API

```bash
cargo run
```

O servidor sobe em **http://localhost:8000**. O CORS está configurado para aceitar requisições de `http://localhost:3000`.

Para mais detalhes sobre o banco (logs, troubleshooting etc.), veja [DATABASE_SETUP.md](./DATABASE_SETUP.md).

## Estrutura do projeto

```
axum_backend/
├── src/
│   ├── main.rs      # Entrada, router, CORS, estado da aplicação
│   ├── config.rs    # Carregamento de variáveis de ambiente
│   ├── db.rs        # Cliente de banco (DBClient)
│   ├── dtos.rs      # DTOs de requisição/resposta
│   ├── error.rs     # Tratamento de erros
│   └── models.rs    # Modelos de domínio
├── migrations/      # Migrações SQLx
├── docker-compose.yml
├── setup-env.sh
└── Cargo.toml
```

## Desenvolvimento

- **Build:** `cargo build`
- **Testes:** `cargo test`
- **Checagem:** `cargo check`
- **Logs:** nível DEBUG via `tracing-subscriber`

## Licença

Projeto sob licença de sua escolha.
