#!/bin/bash -e

DOMAIN=${SESSION_DOMAIN:-localhost}

sed -i "s|{{domain}}|$DOMAIN|g" /usr/local/tomcat/conf/context.xml
exec "$@"
