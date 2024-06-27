FROM openjdk:11.0-jre
EXPOSE 8080
COPY /springapp/app.jar /app.jar
ENTRYPOINT ["java","-Dspring.profiles.active=mysql","-jar","/app.jar"]
