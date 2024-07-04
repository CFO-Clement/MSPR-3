#!/bin/bash

# Mise \u00e0 jour des listes de paquets
echo "Mise \u00e0 jour des listes de paquets..."
sudo apt-get update

# Installation des packages n\u00e9cessaires
echo "Installation de git, curl, wget, vim, python3, python3-pip, et mysql..."
sudo apt-get install -y git curl wget vim python3 python3-pip

# Installation de Ansible
echo "Installation de Ansible..."
sudo apt-get install -y ansible

# Installation du package PyMySQL pour Python3 (pour l'utilisateur et pour root)
echo "Installation du package PyMySQL pour Python3..."
pip3 install pymysql
sudo pip3 install pymysql

# Installation du package community.mysql pour Ansible
echo "Installation du package community.mysql pour Ansible..."
ansible-galaxy collection install community.mysql

# Ex\u00e9cution du playbook Ansible
echo "Lancement du playbook Ansible..."
ansible-playbook playbook.yml --ask-become-pass

echo "Script termin\u00e9."
