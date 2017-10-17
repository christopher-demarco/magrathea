#!/bin/bash
set -e

VERBOSE=1
while [[ $# -gt 0 ]]; do
    case $1 in
	-q|--quiet)
	    VERBOSE=0
	    shift
	    ;;
    esac
done

cd ~/.magrathea/workstation
if [ $VERBOSE ]; then
    terraform init
    terraform destroy -force
    terraform apply
else
    terraform init >> magrathea.log 2>&1
    terraform destroy -force >> magrathea.log 2>&1
    terraform apply >> magrathea.log 2>&1
fi
