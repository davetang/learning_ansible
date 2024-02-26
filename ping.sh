#!/usr/bin/env bash

for HOST in $(cat inventory.ini | grep "^\[.*\]$" | sed 's:[][]::g'); do
   ansible ${HOST} -m ping -i inventory.ini
done
