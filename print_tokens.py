#!/usr/bin/env python

import json

if __name__ == '__main__':
    
    template = '''
```
SSH to {}.foam.ninja
username: {}
password: {}

Everything expires at 1730.
USENIX Code of Conduct applies.


ANY ABUSE OR UNAUTHORIZED USE WILL RESULT IN 
IMMEDIATE TERMINATION OF THE ENTIRE LAB. 
YOU WILL SPOIL THE SESSION FOR EVERYBODY.


Join us on Slack at #m8-ansible
http://lisainvite.herokuapp.com/
```
-------------------------------------------------------------------------------

'''

    with open('workstation/terraform.tfvars', 'r') as fh:
        names = json.loads(fh.read().split('=')[1])
    for name in names:
        username, password = name.split('-')
        print(template.format(name, username, password))


# print_tokens.py
# Copyright (c) 2017 Christopher DeMarco
# Licensed under Apache License v2.0
