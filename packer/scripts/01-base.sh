#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

echo "═══ Установка базовых пакетов (Debian 13) ═══"

apt-get update

apt-get install -y \
    curl \
    wget \
    git \
    vim \
    htop \
    tree \
    unzip \
    zip \
    build-essential \
    ca-certificates \
    apt-transport-https \
    gnupg \
    lsb-release \
    jq \
    dirmngr

echo "Базовые пакеты установлены"