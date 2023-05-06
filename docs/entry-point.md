```dockerfile
FROM mcr.microsoft.com/mssql-tools

ARG DB_NAME
ENV DB_NAME=${DB_NAME}

ARG SA_USERNAME
ENV SA_USERNAME=${SA_USERNAME}

ARG SA_PASSWORD
ENV SA_PASSWORD=${SA_PASSWORD}

COPY ./database /database

ENTRYPOINT [ "/bin/bash", "-c", "\
  until /opt/mssql-tools/bin/sqlcmd -S sql-server,1433 -U \"$SA_USERNAME\" -P \"$SA_PASSWORD\" -Q 'SELECT 1' &> /dev/null; do \
    echo 'Waiting for SQL Server to start...'; \
    sleep 5; \
  done; \
  echo \"Haway, im ganna snooze...\"; \
  sleep 60; \
  echo \"Running script my arse\"; \
    /opt/mssql-tools/bin/sqlcmd \
      -S sql-server,1433 \
      -U \"$SA_USERNAME\" \
      -P \"$SA_PASSWORD\" \
      -i \"/database/create-db.sql\" \
      -m-1 \
      -V 0 \
      -r1;" \
]
```