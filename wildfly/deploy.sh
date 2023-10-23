#! /bin/bash

# download beacon server for the deployment
curl https://inb.bsc.es/maven/es/bsc/inb/ga4gh/beacon-network-v2/0.0.8/beacon-network-v2-0.0.8.war > /opt/jboss/wildfly/standalone/deployments/beacon-network-v2-0.0.8.war

/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0