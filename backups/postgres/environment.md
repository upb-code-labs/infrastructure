# Environment

This document describes the required environment variables to run the service.

| Name         | Description                                         | Example       |
| ------------ | --------------------------------------------------- | ------------- |
| `PGHOST`     | The ip address or hostname of the PostgreSQL server | `my-hostname` |
| `PGPORT`     | The port of the PostgreSQL server                   | `5432`        |
| `PGDATABASE` | The name of the database to be backed up            | `mydb`        |
| `PGUSER`     | The username to connect to the database             | `myuser`      |
| `PGPASSWORD` | The password of the user to connect to the database | `mypassword`  |

Please note that it is highly recommended to use a fine-grained user with only the necessary permissions to perform the backup and pass the variables using a secure method like a secret manager or a `Secret` in case of Kubernetes.