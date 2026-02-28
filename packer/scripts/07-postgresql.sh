#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

echo "═══ Установка PostgreSQL ═══"

apt-get install -y postgresql postgresql-contrib

systemctl enable postgresql
systemctl start postgresql

sudo -u postgres psql -c "CREATE USER dev WITH PASSWORD 'dev' CREATEDB SUPERUSER;" 2>/dev/null || true
sudo -u postgres psql -c "CREATE DATABASE incus_sync OWNER dev;" 2>/dev/null || true

echo "PostgreSQL установлен"