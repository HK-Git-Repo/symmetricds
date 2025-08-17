FROM openjdk:17-slim

# Install required packages
RUN apt-get update && apt-get install -y sqlite3

# Copy SymmetricDS
COPY src/main/resources/symmetric-server-3.16.5 /symmetricds
# Optionally install sq (with auto-yes)
RUN yes | /bin/sh -c "$(curl -fsSL https://sq.io/install.sh)"

RUN mkdir -p /opt/h2data

# Start H2 TCP server in background
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Copy Spring Boot app
COPY target/*.jar app.jar

# Copy scripts
COPY src/main/resources/scripts /scripts
RUN chmod +x /scripts/*.sh

# Expose port
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
