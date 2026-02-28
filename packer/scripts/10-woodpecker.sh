#!/bin/bash
set -e

echo "═══ Настройка Woodpecker CI ═══"

mkdir -p /opt/woodpecker

cat > /opt/woodpecker/docker-compose.yml <<'EOF'
version: '3'
services:
  woodpecker-server:
    image: woodpeckerci/woodpecker-server:latest
    ports:
      - "8000:8000"
    volumes:
      - woodpecker-data:/var/lib/woodpecker/
    environment:
      - WOODPECKER_OPEN=true
      - WOODPECKER_HOST=http://localhost:8000
      - WOODPECKER_AGENT_SECRET=secret-change-me
    restart: unless-stopped

  woodpecker-agent:
    image: woodpeckerci/woodpecker-agent:latest
    depends_on:
      - woodpecker-server
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - WOODPECKER_SERVER=woodpecker-server:9000
      - WOODPECKER_AGENT_SECRET=secret-change-me
    restart: unless-stopped

volumes:
  woodpecker-data:
EOF

chown -R dev:dev /opt/woodpecker
echo "Woodpecker CI настроен"