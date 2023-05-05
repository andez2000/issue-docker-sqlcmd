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
  echo \"Running schema scripts with $DB_NAME\"; \
    echo \"Executing $file\"; \
    /opt/mssql-tools/bin/sqlcmd \
      -S sql-server,1433 \
      -U \"$SA_USERNAME\" \
      -P \"$SA_PASSWORD\" \
      -d \"$DB_NAME\" \
      -v xxxx=\"abcd\" \
      -i \"/database/i-will-not-run.sql\" \
      -r1;" \
]
