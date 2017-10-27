#!/usr/bin/env python

"""This is the quickest of quick-and-dirty hacks. It does *not*
conform to the Ansible requirements for dynamic inventory! In
particular, the `--list` and `--host=` forms are not supported. But it
works, mostly.
"""

import json
import os

tfstate_dir = os.environ.get('MAGRATHEA_STATE', '.')
ansible_user = os.environ.get('ANSIBLE_USER', 'ubuntu')
ansible_ssh_private_key_file = os.environ.get(
    'ANSIBLE_SSH_PRIVATE_KEY_FILE', 'keys/magrathea')
tfstate = '{}/terraform.tfstate'.format(tfstate_dir)

inventory = {"workstations": {}}

with open(tfstate, 'r') as fh:
    state = json.loads(fh.read())

inventory['workstations']['hosts'] = state.get('modules')[0].get(
            'outputs').get('workstations').get('value')

inventory['workstations']['vars'] = {
    "ansible_user": ansible_user,
    "ansible_ssh_private_key_file": ansible_ssh_private_key_file,
    }

print(json.dumps(inventory))

            
# inventory.py
# Copyright (c) 2017 Christopher DeMarco
# Licensed under Apache License v2.0
