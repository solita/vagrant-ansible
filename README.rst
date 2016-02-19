Requirements
------------

Local installation of Vagrant is required unless your environment supports
Ansible natively. See


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

Deployment
----------

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