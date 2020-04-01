FROM centos:7

RUN yum -y update && yum upgrade

RUN yum -y install which java-11-openjdk-devel

RUN curl -O http://packages.confluent.io/archive/5.4/confluent-5.4.1-2.12.tar.gz

RUN gzip -d /confluent-5.4.1-2.12.tar.gz && \
	tar -xvf /confluent-5.4.1-2.12.tar && \
    rm -f /confluent-5.4.1-2.12.tar && \
    mv confluent-5.4.1 /opt/confluent/

ENV PATH="${PATH}:/opt/confluent/bin"

RUN yes | confluent-hub install confluentinc/kafka-connect-jdbc:latest

ENV CONFLUENT_HOME=/opt/confluent

ENV PATH="${PATH}:${CONFLUENT_HOME}/bin"

CMD tail -f /dev/null
