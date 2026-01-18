#!/bin/bash

# Script para criar o arquivo .env se ele não existir

ENV_FILE=".env"

if [ -f "$ENV_FILE" ]; then
    echo "⚠️  O arquivo .env já existe!"
    echo "Deseja sobrescrever? (s/N)"
    read -r response
    if [[ ! "$response" =~ ^[Ss]$ ]]; then
        echo "Operação cancelada."
        exit 0
    fi
fi

cat > "$ENV_FILE" << 'EOF'
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
EOF

echo "✅ Arquivo .env criado com sucesso!"
echo ""
echo "Próximos passos:"
echo "1. Inicie o banco de dados: docker-compose up -d"
echo "2. Aguarde alguns segundos para o banco inicializar"
echo "3. Crie o banco de dados: sqlx database create"
echo "4. Execute as migrações: sqlx migrate run"
