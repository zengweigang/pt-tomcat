FROM 36b.me/tomcat:8-jre8
MAINTAINER Timmy (chentm@gmail.com)
ENV REFRESH_AT 2015-9-23

RUN rm -Rf /usr/local/tomcat/webapps/* && mkdir -p /usr/local/tomcat/internal /usr/local/tomcat/external
ADD server.xml /usr/local/tomcat/conf/server.xml
ADD context.xml /usr/local/tomcat/conf/context.xml

EXPOSE 8080
EXPOSE 9999
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
VOLUME /usr/local/tomcat/logs
ENTRYPOINT ["/entrypoint.sh"]
CMD ["catalina.sh", "run"]
