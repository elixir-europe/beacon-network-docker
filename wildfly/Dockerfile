# By default, build on JDK 17
FROM eclipse-temurin:17-centos7

WORKDIR /opt/jboss

RUN groupadd -r jboss -g 1000 && useradd -u 1000 -r -g jboss -m -d /opt/jboss -s /sbin/nologin -c "JBoss user" jboss && \
    chmod 755 /opt/jboss

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 28.0.1.Final
ENV WILDFLY_SHA1 485ea828895c870a2fbc7c5e34bffeed8c06d1e3
ENV JBOSS_HOME /opt/jboss/wildfly

USER root

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd $HOME \
    && curl -L -O https://github.com/wildfly/wildfly/releases/download/$WILDFLY_VERSION/wildfly-preview-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-preview-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-preview-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-preview-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-preview-$WILDFLY_VERSION.tar.gz \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

USER jboss

# Expose the ports in which we're interested
EXPOSE 8080

RUN /bin/sh -c 'echo -e "embed-server --std-out=echo\n \
/subsystem=undertow/server=default-server/ajp-listener=ajp:add(socket-binding=ajp, scheme=https, redirect-socket=https, enabled=true)\n \
/subsystem=datasources/jdbc-driver=postgresql:add(driver-name=postgresql,driver-module-name=org.postgresql,driver-xa-datasource-class-name=org.postgresql.xa.PGXADataSource)\n \
/subsystem=datasources/data-source=BeaconNetwork:add(driver-name=postgresql,jndi-name=java:jboss/datasources/BeaconNetwork,connection-url=jdbc:postgresql://postgres:5432/beacon-network,user-name=beacon,password=beacon)\n \
stop-embedded-server" > $JBOSS_HOME/bin/wildfly-config.cli'

RUN $JBOSS_HOME/bin/jboss-cli.sh --file="$JBOSS_HOME/bin/wildfly-config.cli"
RUN rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/current/*

# Set the default command to run on boot
# This will boot WildFly in standalone mode and bind to all interfaces
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
