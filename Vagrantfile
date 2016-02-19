# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.define "ansible", primary: true do |ansible|
    ansible.vm.network "private_network", ip: "192.168.50.76"
    ansible.vm.synced_folder ".", "/ansible"
    ansible.vm.provision "shell", privileged: false, inline: <<-EOF
      set -e

      sudo apt-get update && sudo apt-get install -y \
        git \
        python-setuptools \
        python-dev \
        gcc \
        libffi-dev \
        libssl-dev
      sudo easy_install pip
      sudo -H pip install -U pip setuptools
      sudo -H pip install ansible==2.1.0.0

      echo "cd /ansible" >> ~/.profile
    EOF
  end

  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.network "private_network", ip: "192.168.50.77"
  end

end
