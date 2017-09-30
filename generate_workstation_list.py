#!/usr/bin/env python

import argparse
import json
import sys
from lib.names import make_name


def parse_args():
    p = argparse.ArgumentParser()
    p.add_argument('num_workstations', type=int)
    return p.parse_args()


if __name__ == '__main__':
    args = parse_args()
    workstations = [str(make_name()) for i in range(args.num_workstations)]
    print("names = "+json.dumps(workstations))


# generate_workstation_list.py
# Copyright (c) 2017 Christopher DeMarco
# Licensed under Apache License v2.0
