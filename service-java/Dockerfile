# Étape de build
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Étape d'exécution
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

ENV FLASK_URL=http://service-python:5000

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
