# Incus Sync Dev Box

Self-hosted среда разработки для проекта:

> Автоматизированная синхронизация и верификация моделей данных  
> между официальной Go-библиотекой Incus и Rust-клиентом.

---

## 🎯 Назначение

Данный репозиторий содержит Infrastructure as Code для сборки полностью воспроизводимой среды разработки с использованием:

- Packer  
- VirtualBox  
- Vagrant  
- Debian 13 (Trixie)  
- Python 3.11+  
- Rust toolchain  
- Go toolchain  
- Docker  
- Ollama (локальная LLM)  
- PostgreSQL  
- Woodpecker CI (self-hosted)  

Разработка полностью ведётся внутри виртуальной машины.

---

## 🏗 Архитектура

```
Windows Host
    │
    │  VS Code (Remote SSH)
    ▼
Vagrant VM (Debian 13)
    ├── Python sync system
    ├── Rust toolchain
    ├── Go toolchain
    ├── Docker
    ├── Ollama (LLM)
    ├── PostgreSQL
    └── Woodpecker CI
```

Хостовая машина используется только для SSH-доступа.  
Все инструменты разработки и CI работают внутри VM.

---

## 📂 Структура репозитория

```
packer/
├── incus-dev-box.pkr.hcl
├── http/
│   └── preseed.cfg
├── scripts/
│   ├── 01-base.sh
│   ├── 02-python.sh
│   ├── 03-rust.sh
│   ├── 04-go.sh
│   ├── 06-docker.sh
│   ├── 07-postgresql.sh
│   ├── 08-ollama.sh
│   ├── 09-nodejs.sh
│   ├── 10-woodpecker.sh
│   ├── 11-project-setup.sh
│   └── 99-cleanup.sh
```

---

## 🔧 Требования

На хостовой машине должны быть установлены:

- VirtualBox  
- Vagrant  
- Packer  
- Аппаратная виртуализация (VT-x / AMD-V)  

---

## 🚀 Сборка Dev Box

### 1️⃣ Проверка конфигурации

```powershell
cd packer
packer validate .
```

### 2️⃣ Сборка образа

```powershell
packer build .
```

После успешной сборки будет создан файл:

```
incus-sync-dev.box
```

---

## 📦 Добавление box в Vagrant

```powershell
vagrant box add incus-sync-dev packer/incus-sync-dev.box
```

---

## ▶ Запуск виртуальной машины

```powershell
vagrant up
```

Подключение по SSH:

```powershell
vagrant ssh
```

---

## 🖥 Настройка VS Code (Remote SSH)

Добавить в:

```
C:\Users\<ВашПользователь>\.ssh\config
```

```
Host incus-dev
  HostName 127.0.0.1
  User dev
  Port 2222
  IdentityFile <путь>/.vagrant/machines/default/virtualbox/private_key
  StrictHostKeyChecking no
```

После этого:

1. В VS Code нажать `F1`
2. Выбрать `Remote-SSH: Connect to Host`
3. Подключиться к `incus-dev`

---

## 🔌 Сетевые настройки

Используется только SSH:

| Назначение | Порт VM | Порт хоста |
|------------|---------|------------|
| SSH        | 22      | 2222       |


---

## ⚙ Установленные компоненты

Внутри VM установлены:

- Python 3.11+  
- Rust (rustc, cargo)  
- Go  
- Docker  
- Ollama  
- PostgreSQL  
- Woodpecker CI  
- Git  

---

## 🧪 Проверка окружения

```bash
python3 --version
rustc --version
go version
docker --version
ollama list
psql --version
```

---

## 🗂 Что не хранится в Git

Игнорируются:

- `packer_cache/`
- `output-*`
- `*.box`
- `.vagrant/`

См. `.gitignore`.
