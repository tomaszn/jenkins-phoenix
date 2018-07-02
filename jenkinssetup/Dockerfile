FROM ubuntu:xenial
RUN apt-get update -y && apt-get install -y git python-pip python3-pip python-yaml curl socat default-jdk wget telnet
RUN pip install pip setuptools PyYAML python-jenkins ordereddict jenkinsapi --upgrade
RUN pip3 install pip virtualenv --upgrade
WORKDIR /jenkins_setup
RUN git clone https://git.openstack.org/openstack-infra/jenkins-job-builder
WORKDIR /jenkins_setup/jenkins-job-builder
RUN python setup.py install
ADD . /jenkins_setup
ADD jenkins_jobs.ini /etc/jenkins_jobs/jenkins_jobs.ini
WORKDIR /jenkins_setup
CMD /jenkins_setup/startup.sh
