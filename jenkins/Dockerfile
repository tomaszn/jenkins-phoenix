FROM jenkins/jenkins:lts
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Assume root privs
USER root
RUN apt-get update && apt-get install -y vim socat cron sudo sshpass curl
RUN curl -sSL https://get.docker.com/ | sh
RUN sed -i 's/^.sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers
RUN adduser jenkins sudo
RUN adduser jenkins docker
# Folders required for backup plugin
RUN mkdir /var/jenkins_home_backup
RUN chown jenkins: /var/jenkins_home_backup
RUN mkdir /var/jenkins_home_restore
RUN chown jenkins: /var/jenkins_home_restore
# switch back to jenkins user
USER jenkins
# Add core jenkins config
ADD config.xml /var/jenkins_home/config.xml
ADD backup.xml /var/jenkins_home/backup.xml
# Add replace_config.sh script to allow updates to config.xml
ADD replace_config.sh /replace_config.sh
# Add startup script and use as entrypoint
ADD startup.sh /var/jenkins_home/startup.sh

ENTRYPOINT ["/var/jenkins_home/startup.sh"]
