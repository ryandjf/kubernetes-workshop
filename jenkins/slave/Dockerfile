FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openjdk-8-jdk curl python python-pip git libltdl7
RUN easy_install jenkins-webapi

RUN apt-get update && apt-get install -y software-properties-common && apt-add-repository --yes --update ppa:ansible/ansible && apt-get install -y ansible

RUN apt-get update && apt-get install -y apt-transport-https && curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add - && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && apt-get update && apt-get install -y kubectl

RUN mkdir -p /home/jenkins
RUN mkdir -p /var/lib/jenkins

ADD slave.py /var/lib/jenkins/slave.py

WORKDIR /home/jenkins

ENV JENKINS_URL "http://jenkins-master:8080"
ENV JENKINS_SLAVE_ADDRESS ""
ENV JENKINS_USER "admin"
ENV JENKINS_PASS "admin"
ENV SLAVE_NAME ""
ENV SLAVE_SECRET ""
ENV SLAVE_EXECUTORS "1"
ENV SLAVE_LABELS "docker"
ENV SLAVE_WORING_DIR ""
ENV CLEAN_WORKING_DIR "true"

CMD [ "python", "-u", "/var/lib/jenkins/slave.py" ]
