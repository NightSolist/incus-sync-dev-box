Vagrant.configure("2") do |config|
  config.vm.box = "incus-sync-dev"
  config.vm.hostname = "incus-sync-dev"

  # ─────────────────────────────
  # СЕТЬ
  # ─────────────────────────────

  config.vm.network "forwarded_port",
                    guest: 22,
                    host: 2222,
                    id: "ssh",
                    auto_correct: true

  # ─────────────────────────────
  # РЕСУРСЫ VM
  # ─────────────────────────────

  config.vm.provider "virtualbox" do |vb|
    vb.name = "incus-sync-dev-vm"
    vb.memory = "8192"
    vb.cpus = 4
    vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
  end

  # ─────────────────────────────
  # SSH
  # ─────────────────────────────

  config.ssh.username   = "dev"
  config.ssh.password   = "dev"
  config.ssh.insert_key = true
  config.vm.boot_timeout = 600

  # ─────────────────────────────
  # НЕТ synced_folder
  # ─────────────────────────────
  # Репозиторий будет жить внутри VM

  config.vm.post_up_message = <<-MSG

  ═══════════════════════════════════════════════════
      DevSecOps VM Ready
  ═══════════════════════════════════════════════════

  SSH:
    Host: 127.0.0.1
    Port: 2222
    User: dev

  Внутри VM:
    /home/dev/

  Рекомендуется:
    git clone ваш_репозиторий

  ═══════════════════════════════════════════════════

  MSG
end