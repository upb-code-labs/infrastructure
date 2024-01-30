FROM docker.io/library/alpine:3.19.1

# Create directories
RUN mkdir -p /var/codelabs/backups
RUN mkdir -p /var/codelabs/archives
RUN mkdir -p /opt/codelabs

# Copy the script
WORKDIR /opt/codelabs
COPY ./scripts/ .

# Make the script executable
RUN chmod +x ./entrypoint.sh

# Update packages
RUN apk update && apk upgrade

# Install rclone
RUN apk add --no-cache rclone

# Run
CMD [ "./entrypoint.sh" ]