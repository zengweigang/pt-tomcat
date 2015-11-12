FROM tomcat:8-jre8

ADD entrypoint.sh /
RUN apt-get clean && chmod +x /entrypoint.sh && rm -Rf /usr/local/tomcat/webapps/* && mkdir -p /usr/local/tomcat/internal /usr/local/tomcat/external
ADD *.xml /usr/local/tomcat/conf/

EXPOSE 8080 9999
VOLUME /usr/local/tomcat/logs
ENTRYPOINT ["/entrypoint.sh"]
CMD ["catalina.sh", "run"]
