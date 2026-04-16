FROM maven:3.8.2-jdk-8-slim AS build
WORKDIR /home/app
COPY . .
RUN mvn clean package

FROM openjdk:8-jdk-alpine
VOLUME /tmp
EXPOSE 8080
COPY --from=build /home/app/target/my-app.jar /app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]