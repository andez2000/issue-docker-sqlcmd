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
  echo \"Running creation scripts with $DB_NAME\"; \
  for file in $(ls /database/scripts/creation/*.sql | sort -V); do \
    echo \"Executing $file\"; \
    /opt/mssql-tools/bin/sqlcmd \
      -S sql-server,1433 \
      -U \"$SA_USERNAME\" \
      -P \"$SA_PASSWORD\" \
      -i \"$file\" \
      -r1; \
  done; \
  sleep 2; \
  echo \"Running schema scripts with $DB_NAME\"; \
  for file in $(ls /database/scripts/schema/*.sql | sort -V); do \
    echo \"Executing $file\"; \
    /opt/mssql-tools/bin/sqlcmd \
      -S sql-server,1433 \
      -U \"$SA_USERNAME\" \
      -P \"$SA_PASSWORD\" \
      -d \"$DB_NAME\" \
      -v xxxx=\"abcd\" \
      -i \"$file\" \
      -r1; \
  done" \
]
