#!/usr/bin/env bash

if [[ $# == 1 ]]; then
   YAML=$1
   if [[ -e ${YAML} && ${YAML} =~ y[a]*ml$ ]]; then
      ansible-playbook --ask-become-pass -i inventory.ini ${YAML}
   else
      >&2 echo ${YAML} does not exist or does not have the correct extension
      exit 1
   fi
else
   >&2 echo Please provide an Ansible YAML file
   exit 1
fi
