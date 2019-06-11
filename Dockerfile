# Pull base image.
FROM ubuntu

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 17.0.0.Final
ENV WILDFLY_SHA1 50bf8c48d4faf27c530af6949a225b9f1428300e
ENV JBOSS_HOME /opt/jboss/wildfly-17.0.0.Final

USER root
# Define working directory.
WORKDIR /opt/jboss

RUN \
# Install Java.
  apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository ppa:linuxuprising/java && \
  apt-get update && \
  echo oracle-java11-installer shared/accepted-oracle-license-v1-2 select true | /usr/bin/debconf-set-selections && \
  apt-get install -y oracle-java11-installer && \
# Install Wildfly
    apt-get install -y curl \ 
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && rm wildfly-$WILDFLY_VERSION.tar.gz \
    && chmod -R g+rw ${JBOSS_HOME} \
    && ${JBOSS_HOME}/bin/add-user.sh admin admin123 --silent \
    && echo 'JAVA_OPTS="$JAVA_OPTS -Xlog:class+load=info:${JBOSS_HOME}/bin/classloaded.txt:time,level,tags:filecount=5,filesize=10M"' >> ${JBOSS_HOME}/bin/standalone.conf

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/jboss/wildfly-17.0.0.Final/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
