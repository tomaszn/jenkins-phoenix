#!/bin/bash

# Set up a cron daemon (logging heavily) in case we need to run periodic jobs
sudo cron -L 8

# Use socat to listen on port 9000. If anything comes in, write it out to Jenkins' config.xml
# Can be called from a linked machine like so:
#socat -u FILE:config.xml TCP:jenkins:9000
# If this is used, we need to trigger a restart also.
socat -u TCP-LISTEN:9000,reuseaddr,fork OPEN:/var/jenkins_home/config.xml,creat,trunk &
socat -u TCP-LISTEN:9001,reuseaddr,fork EXEC:'/replace_config.sh > /tmp/asd && tac /tmp/asd' &

mkdir -p ~/.ssh/
ANOTHER_SSH_HOST=another_machine
ANOTHER_SSH_PASS=very_secret
ssh-keyscan ${ANOTHER_SSH_HOST} >> ~/.ssh/known_hosts
ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
sshpass -p ${ANOTHER_SSH_PASS} ssh-copy-id jenkins@${ANOTHER_SSH_HOST} #-i /etc/ssh/ssh_host_rsa_key

# The original entrypoint for the jenkins container
/sbin/tini -- /usr/local/bin/jenkins.sh
