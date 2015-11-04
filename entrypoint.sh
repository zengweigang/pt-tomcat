#!/bin/bash -e

DOMAIN=${SESSION_DOMAIN:-localhost}

sed -i "s|{{domain}}|$DOMAIN|g" /usr/local/tomcat/conf/context.xml

if [ -z "$DYNAMO_ADDRESS" ]; then
    sed -i "s|{{session_manager}}||g" /usr/local/tomcat/conf/context.xml
else

    LINE="<Manager  className=\"com.amazonaws.services.dynamodb.sessionmanager.DynamoDBSessionManager\" createIfNotExists=\"true\" table=\"$DYNAMO_ADDRESS\" "

    if [ -z "$DYNAMO_ENDPOINT" ]; then
        EC2_AVAIL_ZONE=`curl -s --connect-timeout 2 http://169.254.169.254/latest/meta-data/placement/availability-zone` || echo "not on ec2"
        if [ ! -z "$EC2_AVAIL_ZONE" -a "$EC2_AVAIL_ZONE" != " " ]; then
            EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
            echo $EC2_REGION
            LINE="$LINE regionId=\"$EC2_REGION\""
        else            
            echo "Not running on EC2, must set DYNAMO_ENDPOINT if set DYNAMO_ADDRESS"
            exit -1
        fi
    else
        LINE="$LINE endpoint=\"$DYNAMO_ENDPOINT\""
    fi

    LINE="$LINE /><Valve  className=\"com.amazonaws.services.dynamodb.sessionmanager.DynamoSessionValve\"/>"

    sed -i "s|{{session_manager}}|$LINE|g" /usr/local/tomcat/conf/context.xml
fi 

exec "$@"
