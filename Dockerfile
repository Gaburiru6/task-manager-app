FROM tomcat:9-jdk11-openjdk

COPY target/task-manager-app.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]