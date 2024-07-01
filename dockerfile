FROM maven:3.8.5-openjdk-17  AS build
WORKDIR /home/app
COPY src ./src
COPY pom.xml .
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:17-slim
COPY --from=build /home/app/target/sample-0.0.1-SNAPSHOT.jar /usr/local/lib/sample.jar
EXPOSE 8080
ENTRYPOINT ["java", "-Xms512m", "-Xmx900m", "-jar","/usr/local/lib/sample.jar"]


