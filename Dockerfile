FROM openjdk:17-jdk-slim AS build
WORKDIR /workspace

# Copy and build
COPY pom.xml .
COPY src ./src
RUN ./mvnw package -DskipTests

FROM openjdk:17-jre-slim
WORKDIR /app
COPY --from=build /workspace/target/*.jar ./app.jar

ENTRYPOINT ["java","-jar","/app/app.jar"]
