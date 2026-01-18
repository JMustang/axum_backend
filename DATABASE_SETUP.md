# Configuração do Banco de Dados

## Requisitos

- Docker e Docker Compose instalados

## Como usar

### 1. Criar arquivo .env

Crie um arquivo `.env` na raiz do projeto com o seguinte conteúdo:

```env
# Database Configuration
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=axum_backend
POSTGRES_PORT=5432
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/axum_backend

# JWT Configuration (ajuste conforme necessário)
JWT_SECRET=your-secret-key-here-change-in-production
JWT_EXPIRATION=3600

# Server Configuration (ajuste conforme necessário)
SERVER_HOST=0.0.0.0
SERVER_PORT=3000
```

### 2. Iniciar o banco de dados

```bash
docker-compose up -d
```

### 3. Verificar se o banco está rodando

```bash
docker-compose ps
```

### 4. Parar o banco de dados

```bash
docker-compose down
```

### 5. Parar e remover os volumes (apaga os dados)

```bash
docker-compose down -v
```

### 6. Ver logs do banco de dados

```bash
docker-compose logs -f postgres
```

## Migrações

Se você estiver usando SQLx, você pode executar migrações com:

```bash
sqlx migrate run
```

Certifique-se de que a variável `DATABASE_URL` está configurada no seu `.env`.

## Troubleshooting

### Erro: "password authentication failed for user 'postgres'"

Este erro geralmente acontece por um dos seguintes motivos:

1. **Arquivo .env não existe**: Crie o arquivo `.env` na raiz do projeto com o conteúdo mostrado acima.

2. **Banco de dados não está rodando**: Verifique se o container está rodando:

   ```bash
   docker-compose ps
   ```

   Se não estiver, inicie com:

   ```bash
   docker-compose up -d
   ```

3. **Credenciais não correspondem**: Certifique-se de que as credenciais no `.env` correspondem às do `docker-compose.yml`. Por padrão:
   - Usuário: `postgres`
   - Senha: `postgres`
   - Banco: `axum_backend`

4. **DATABASE_URL incorreta**: A URL deve seguir o formato:

   ```
   postgresql://[usuário]:[senha]@localhost:[porta]/[nome_do_banco]
   ```

   Exemplo: `postgresql://postgres:postgres@localhost:5432/axum_backend`

### Verificar conexão manualmente

Você pode testar a conexão diretamente com o psql:

```bash
docker-compose exec postgres psql -U postgres -d axum_backend
```

Ou usando a DATABASE_URL:

```bash
psql $DATABASE_URL
```
