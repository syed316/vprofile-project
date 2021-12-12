FROM maven:3.6.3-jdk-8-slim AS build
WORKDIR /home/app
COPY . /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM tomcat
VOLUME /tmp
EXPOSE 8080
COPY --from=build /home/app/target/*.war /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]
