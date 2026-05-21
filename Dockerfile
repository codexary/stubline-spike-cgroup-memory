FROM eclipse-temurin:21.0.12.1_1-jdk-noble AS build
WORKDIR /src
COPY .mvn .mvn
COPY mvnw pom.xml ./
COPY src src
RUN ./mvnw -q -DskipTests package

FROM eclipse-temurin:21.0.12.1_1-jre-noble
RUN useradd --system --uid 10001 --create-home app
WORKDIR /app
COPY --from=build /src/target/*.jar app.jar
USER 10001
ENTRYPOINT ["java"]
CMD ["-XX:MaxRAMPercentage=60", "-cp", "app.jar", "com.elsworne.stubline.spike.cgroup.MemoryMain", "heap"]
