FROM openjdk:17-slim

WORKDIR /SymmetricdsApp
# Install required packages
RUN apt-get update && apt-get install -y sqlite3 && apt-get install gettext-base && apt-get install -y postgresql-client

# Copy SymmetricDS
COPY src/main/resources/symmetric-server-3.16.5 symmetricds
# Optionally install sq (with auto-yes)
#RUN yes | /bin/sh -c "$(curl -fsSL https://sq.io/install.sh)"

# Copy Spring Boot app
COPY target/symmetricds*.jar app.jar

# Copy scripts
COPY src/main/resources/scripts scripts
RUN chmod +x scripts/*.sh

# Expose port
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
