# Use the official lightweight OpenJDK 17 image as the base image
FROM openjdk:17-alpine

# Use the official Gradle image as the build image
FROM gradle:7.4.0-jdk17 AS build

# Copy the project files into the container
COPY --chown=gradle:gradle . /home/gradle/src

# Set the working directory
WORKDIR /home/gradle/src

# Build the project
RUN gradle build --no-daemon

# Create a new image with the application
FROM openjdk:17-alpine

# Set the container's entry point as the executable JAR file
ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/fiap-hackaton-back.jar"]

# Copy the executable JAR file and other resources into the container at /app
RUN mkdir /app
COPY --from=build /home/gradle/src/build/libs/ /app/

# Expose the application port
EXPOSE 8080
