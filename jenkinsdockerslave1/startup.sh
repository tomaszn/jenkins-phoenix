#!/bin/bash

set -ex

# connect to Jenkins
ssh-keyscan ${ANOTHER_SSH_HOST} >> /etc/ssh/ssh_known_hosts
cp /etc/ssh/ssh_host_rsa_key* /tmp/
echo "Host ${ANOTHER_SSH_HOST}" >> /etc/ssh/ssh_config
echo " User jenkins" >> /etc/ssh/ssh_config
echo " IdentityFile /tmp/ssh_host_rsa_key" >> /etc/ssh/ssh_config
sshpass -p "${ANOTHER_SSH_PASS}" ssh-copy-id "jenkins@${ANOTHER_SSH_HOST}" -i"/tmp/ssh_host_rsa_key"
chown jenkins /tmp/ssh_host_rsa_key*
