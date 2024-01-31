FROM docker.io/library/alpine:3.19.1

# Create directories
RUN mkdir -p /etc/gpg
RUN mkdir -p /var/backups/db
RUN mkdir -p /opt/codelabs

# Copy the scripts
WORKDIR /opt/codelabs
COPY ./scripts/ .

# Make the scripts executable
RUN chmod +x ./*.sh

# Update packages
RUN apk update && apk upgrade

# Install the pg_dump tool
RUN apk add --no-cache postgresql16-client

# Install gpg command
RUN apk add --no-cache gnupg

# Install rclone
RUN apk add --no-cache rclone

# Run
ENV PGHOST=host
ENV PGPORT=5432
ENV PGDATABASE=database
ENV PGUSER=user
ENV PGPASSWORD=password

CMD [ "./entrypoint.sh" ]