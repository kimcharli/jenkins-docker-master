FROM jenkins/jenkins:lts
LABEL maintainer=”ckim@juniper.net”
USER root
RUN curl -s "https://bootstrap.pypa.io/get-pip.py" | python && pip install ansible==2.7.0 junos-eznc==2.2.1 openstacksdk==0.28.0 && ansible-galaxy install Juniper.junos
USER jenkins
COPY data/init.groovy.d /usr/share/jenkins/ref/init.groovy.d
#COPY data/plugins.versioned.txt /usr/share/jenkins/plugins.txt
COPY data/plugins.txt /usr/share/jenkins/plugins.txt
RUN  /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt


