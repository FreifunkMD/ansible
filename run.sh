#!/bin/bash
ansible-playbook -i inventory.ini -u ansible -b $1
