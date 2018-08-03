#
# Logs are being persisted to:
# /tmp/zookeeper - zookeeper data log
#
# /tmp/kafka - for kafka offsets and logs
#
FROM openjdk:8u171-jre-slim-stretch
LABEL name=M.Manna
LABEL description="Apache Kafka Simple Startup"
#
# Convenience variable
#
#
ENV KAFKA_VERSION_MAJOR=2.11
ENV KAFKA_VERSION_MINOR=1.1.0
ENV KAFKA_VERSION=$KAFKA_VERSION_MAJOR-$KAFKA_VERSION_MINOR
RUN ["/bin/sh","-c","echo $KAFKA_VERSION"]
#
# Change dir
#
WORKDIR /
#
# init opt
RUN ["/bin/sh","-c","if test ! -d /opt; then mkdir /opt && chmod 777 -R /opt/; fi"] 
WORKDIR /opt
RUN ["/bin/sh","-c","mkdir kafka && chmod 700 -R kafka/"]
#
# Now download kafka
#
ADD http://mirror.vorboss.net/apache/kafka/$KAFKA_VERSION_MINOR/kafka_$KAFKA_VERSION.tgz /tmp
RUN ["/bin/sh", "-c", "tar -xzvf /tmp/kafka_$KAFKA_VERSION.tgz -C /opt/kafka --strip-components=1"]
#
# cleanup
#
RUN ["/bin/sh", "-c", "rm --recursive /tmp/kafka_$KAFKA_VERSION.tgz && rm --recursive /opt/kafka/bin/windows"]
WORKDIR /opt/kafka/bin
#
# we would like to install ps tool so that the process can be monitored via exec command.
#
RUN apt-get -y update
RUN apt-get -y install procps
#
# Expose TCP ports
# 2666 and 3666 are very specific for zookeeper follower_comms and leader election respectively.
# For more info - https://zookeeper.apache.org/doc/r3.5.1-alpha/zookeeperAdmin.html#sc_configuration
#
#
EXPOSE 9092/tcp 2181/tcp  2666/tcp 3666/tcp
#
# Adds file into container from host
#
ADD ["start-all.sh","/opt/kafka/bin"]
#
# Since we want it as an executable container, start this
#
CMD ["/bin/sh","-c","./start-all.sh"]
