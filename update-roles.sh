#!/bin/bash
# update-roles.sh
# See: https://github.com/ansible/ansible/issues/6466#issuecomment-65454871
rm -rf roles/geerlingguy.java roles/geerlingguy.jenkins roles/solita.jenkins
ansible-galaxy install -p roles -r requirements.yml