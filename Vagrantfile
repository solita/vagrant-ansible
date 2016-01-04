# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.network 'private_network', ip: '192.168.50.76'

  config.vm.synced_folder ".", "/ansible"

  config.vm.provision 'shell', privileged: false, inline: <<-EOF
    set -e

    # Install git
    sudo apt-get update
    sudo apt-get install -y git

    # Install pip
    sudo apt-get install -y python-setuptools python-dev libffi-dev libssl-dev
    sudo easy_install pip

    # Fix InsecurePlatformWarning in the OS's pip (this will show the
    # InsecurePlatformWarning once)
    sudo -H pip install --upgrade requests[security]

    # Install virtualenv
    sudo -H pip install virtualenv

    # Create a new virtual environment for Ansible 1.9
    virtualenv ~/ansible-1.9-env
    source ~/ansible-1.9-env/bin/activate

    # Fix InsecurePlatformWarning in the virtual environment's pip (this will
    # show the InsecurePlatformWarning once)
    pip install --upgrade requests[security]

    # Install Ansible 1.9.4 in the virtual environment
    pip install ansible==1.9.4

    # Activate the Ansible 1.9 environment on login
    echo 'source ~/ansible-1.9-env/bin/activate' >> ~/.profile

    # Fetch sources for Ansible 2.0.0 RC1
    mkdir -p ~/src
    git clone --branch v2.0.0-0.6.rc1 --recursive https://github.com/ansible/ansible.git ~/src/ansible

    # Create a new virtual environment for Ansible 2.0
    virtualenv ~/ansible-2.0-env
    source ~/ansible-2.0-env/bin/activate

    # Fix InsecurePlatformWarning in the virtual environment's pip (this will
    # show the InsecurePlatformWarning once)
    pip install --upgrade requests[security]

    # Install Ansible 2.0.0 RC1 in the virtual environment
    pip install ~/src/ansible

    # Start new login shells in the /ansible directory
    echo 'cd /ansible' >> ~/.profile
  EOF
end
