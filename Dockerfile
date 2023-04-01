# Use the official lightweight OpenJDK 17 image as the base image
FROM adoptopenjdk/openjdk17:alpine-jre

# Set the working directory to /app
WORKDIR /app

# Copy the executable JAR file and other resources into the container at /app
COPY target/my-app.jar /app/
COPY src/main/resources/application.properties /app/

# Set the container's entry point as the executable JAR file
ENTRYPOINT ["java", "-jar", "my-app.jar"]