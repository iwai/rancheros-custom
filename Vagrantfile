# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "archlinux/archlinux"

  config.vm.synced_folder ".", "/data"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
    pacman -Syy
    pacman -S --noconfirm base-devel iptables docker

    gpasswd -a vagrant docker

    systemctl enable docker
    systemctl start docker

  SHELL

end
