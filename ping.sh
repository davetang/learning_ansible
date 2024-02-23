#!/usr/bin/env bash

ansible myhosts -m ping -i inventory.ini
