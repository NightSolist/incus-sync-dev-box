#!/bin/bash
set -e

echo "═══ Настройка проекта ═══"

mkdir -p ~/data/{repos,state,output,logs}
mkdir -p ~/incus-model-sync

git config --global core.autocrlf input
git config --global init.defaultBranch main

# Клонирование Incus
git clone --depth 1 https://github.com/lxc/incus.git ~/data/repos/incus || true

# Python venv
cd ~/incus-model-sync
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install PyGithub Jinja2 requests pydantic gitpython pytest black ruff mypy

cat >> ~/.bashrc <<'EOF'
source ~/incus-model-sync/.venv/bin/activate 2>/dev/null || true
alias cdp="cd ~/incus-model-sync"
export PATH=$PATH:/usr/local/go/bin
source $HOME/.cargo/env 2>/dev/null || true
EOF

echo "Проект настроен"