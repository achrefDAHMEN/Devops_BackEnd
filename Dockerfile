FROM openjdk:11
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} myapp.jar
ENTRYPOINT ["java","-jar","/myapp.jar"]