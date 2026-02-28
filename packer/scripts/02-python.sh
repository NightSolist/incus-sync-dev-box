#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

echo "═══ Установка Python ═══"

apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    python3-setuptools \
    python3-wheel

update-alternatives --install /usr/bin/python python /usr/bin/python3 1

echo "Python: $(python3 --version)"