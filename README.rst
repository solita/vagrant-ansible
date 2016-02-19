Requirements
------------

Local installation of Vagrant is required unless your environment supports
Ansible natively. See `Setting up the Virtual Machine`_.


Preparations
------------

.. role:: bash(code)
   :language: bash

Edit the production environment description
``environment/product/inventory`` to match your production machine.

.. code:: bash

    10.1.2.3 ansible_ssh_user=root
    [jenkins]
    10.1.2.3

Here ``10.1.2.3`` is the intended deployment target
and ``[jenkins]`` role contains a list of machines that are to receive Jenkins
installation. Dimwittingly the only machine is listed under there.

Note that we use user ``root`` here to keep things simple. If user ``root`` is not
available you will need a sudo user. If the sudo needs a password have a look
at `ask become pass`_.

Development Deployment
----------------------

The development environment consists of this workdir and two vagrant virtual
machines. Another of the virtual machines is the development version of the
Jenkins and the other one is a Ansible installation that is able to provision
the Jenkins machine. It would be possible to use your own localhost, if it has
suitable Ansible installed. However the Vagrant version is guaranteed to work.

To initialize Ansible role depdendences run ``./update-roles.sh``.

.. code:: bash

    ./update-roles.sh

Then on Windows and machines without local Ansible installation, start Vagrant
box ``vagrant up`` and log in with ``vagrant ssh``

.. code:: bash

    vagrant up
    vagrant ssh ansible

At this point you should see bash prompt inside Vagrant virtual machine. The
folder you are in is mounted inside the virtual machine, so any files under
``/ansible`` are from the working directory you have on your local machine.

To deploy Jenkins to development instance call ``ansible-playbook``.

.. code:: bash

    ansible-playbook -i environment/development/inventory jenkins.yml

.. code:: bash

    TODO FAILURE TO provision
    $ ansible-playbook -i environments/development/inventory jenkins.yml

    PLAY [jenkins] ****************************************************************

    GATHERING FACTS ***************************************************************
    fatal: [192.168.50.77] => SSH Error: ssh: connect to host 192.168.50.77 port 22:
    Connection timed out while connecting to 192.168.50.77:22
    It is sometimes useful to re-run the command using -vvvv, which prints SSH
    debug output to help diagnose the issue.

    TASK: [geerlingguy.java | Include OS-specific variables.] *********************
    FATAL: no hosts matched or all hosts have already failed -- aborting


    PLAY RECAP *******************************************************




To test the operation open url in localhost browser: http://192.168.50.77:8080 .
Jenkins should be up and running soon.


Production Deployment
---------------------

Before first run you need to copy your ssh-key to the destination machine to
allow ansible open ssh-connections without entering a password. On your
localhost:

.. code:: bash

    ssh-copy-id root@10.1.2.3

When the key is installed the provisioning is done using ansible. The
``ssh-agent bash`` starts a new shell with ssh-agent configured in it. Default ssh
keys are then added to the agent with ``ssh-add`` command. Since Windows is not
sufficient for running Ansible the provided Vagrant virtual machine is started
with ``vagrant ssh -- -A``. Those extra parameters pass the ssh-agent to the
vagrant, allowing password-less login to the deployment target. Finally
``ansible-playbook`` (re)deploys the jenkins role to any and all machines that are
under the jenkins role in the inventory file.

.. code:: bash

    ssh-agent bash
    ssh-add
    vagrant up
    vagrant ssh -- -A
    ansible-playbook -i environment/production/inventory jenkins.yml

.. _ask become pass: http://docs.ansible.com/ansible/become.html
.. _Setting up the Virtual Machine: http://solita-cd.readthedocs.org/en/latest/jenkins_ansible_vm.html