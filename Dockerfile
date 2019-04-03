FROM maven:3.6.0-jdk-11 AS build  
RUN mkdir /usr/src/vivo-template
COPY  . /usr/src/vivo-template 
WORKDIR /usr/src/vivo-template/VIVO
RUN mvn -s ../custom-vivo/settings.xml install

FROM tomcat:jre11 AS vivo-tomcat
RUN mkdir /usr/local/vivo
RUN mkdir /usr/local/vivo/home
COPY --from=build /usr/local/vivo/home /usr/local/vivo/home
COPY --from=build /usr/src/vivo-template/VIVO/installer/webapp/target/vivo.war /usr/local/vivo
COPY --from=build /usr/src/vivo-template/VIVO/installer/webapp/target/vivo.war /usr/local/tomcat/webapps/vivo.war
COPY applicationSetup.n3 /usr/local/vivo/home/config
COPY runtime.properties /usr/local/vivo/home/config
ENV DOCKERIZE_VERSION v0.6.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz
EXPOSE 8080
CMD dockerize -wait tcp://database:3306 -timeout 60m /usr/local/tomcat/bin/catalina.sh run
