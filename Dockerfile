FROM maven:3.6.0-jdk-11 AS build  
RUN mkdir /usr/src/vivo-template
COPY  . /usr/src/vivo-template 
WORKDIR /usr/src/vivo-template/VIVO
RUN mvn -s ../custom-vivo/settings.xml install

FROM tomcat:jre11 AS vivo-tomcat
RUN mkdir /usr/local/vivo
RUN mkdir /usr/local/vivo/home
RUN mkdir /usr/local/vivo/home/config
COPY --from=build /usr/src/vivo-template/VIVO/installer/webapp/target/vivo.war /usr/local/vivo
COPY --from=build /usr/src/vivo-template/VIVO/installer/webapp/target/vivo.war /usr/local/tomcat/webapps/vivo.war
COPY applicationSetup.n3 /usr/local/vivo/home/config
COPY runtime.properties /usr/local/vivo/home/config
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
