#!/bin/bash
set -e

echo "═══ Установка Node.js через fnm (исправлено) ═══"

# Установка fnm
curl -fsSL https://fnm.vercel.app/install | bash

# Правильный путь установки fnm
export FNM_DIR="$HOME/.local/share/fnm"
export PATH="$FNM_DIR:$PATH"

# Проверка что fnm установлен
if [ ! -f "$FNM_DIR/fnm" ]; then
    echo "fnm не установлен корректно"
    exit 1
fi

# Инициализация среды
eval "$($FNM_DIR/fnm env)"

# Установка LTS версии Node.js
$FNM_DIR/fnm install --lts
$FNM_DIR/fnm default lts-latest

echo "Node.js установлен: $(node --version)"