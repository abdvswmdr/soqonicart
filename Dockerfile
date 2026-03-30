# Stage 1: Maven + JDK image
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /app

# deps manifest — layer cached until pom.xml changes
COPY pom.xml .
RUN mvn dependency:go-offline -q

# source and build
COPY src ./src
RUN mvn package -DskipTests

# Stage 2: JRE only, no Maven/source code
FROM eclipse-temurin:17-jre-alpine

WORKDIR /opt/apps/carts

COPY --from=builder /app/target/*.jar carts.jar

EXPOSE 8081

CMD ["java", "-jar", "carts.jar"]
