#!/usr/bin/env python

import json

inventory = {"workstations": {}}

with open('terraform.tfstate', 'r') as fh:
    state = json.loads(fh.read())

inventory['workstations']['hosts'] = state.get('modules')[0].get(
            'outputs').get('workstations').get('value')

inventory['workstations']['vars'] = {
    "ansible_user": "magrathea",
    "ansible_ssh_private_key_file": "keys/magrathea"
    }

print(json.dumps(inventory))

            
# inventory.py
# Copyright (c) 2017 Christopher DeMarco
# Licensed under Apache License v2.0
