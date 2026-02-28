#!/bin/bash
set -e

echo "═══ Установка Ollama ═══"

curl -fsSL https://ollama.com/install.sh | sh
systemctl enable ollama

echo "Ollama установлен"