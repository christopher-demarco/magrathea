#!/bin/bash
set -e

cd ~/.magrathea/workstation
tf init >> magrathea.log 2>&1

tf destroy -force >> magrathea.log 2>&1
tf apply >> magrathea.log 2>&1

