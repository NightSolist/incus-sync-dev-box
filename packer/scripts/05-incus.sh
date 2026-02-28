#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

echo "═══ Установка Incus через Snap ═══"

# Установка snapd
apt-get update
apt-get install -y snapd

# Включение и запуск snapd
systemctl enable snapd
systemctl start snapd

# Ожидание готовности snapd
echo "Ожидание готовности snapd..."
sleep 10

# Установка core snap (требуется для других snap-пакетов)
snap install core

# Установка Incus
snap install incus

# Добавление пользователя dev в группы Incus
usermod -aG incus dev 2>/dev/null || true

echo "Incus установлен: $(incus version 2>/dev/null || echo 'проверьте после перезагрузки')"