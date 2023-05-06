FROM mcr.microsoft.com/mssql-tools

ARG DB_NAME=PLEASE-SET
ENV DB_NAME=$DB_NAME

ARG SA_USERNAME=sa
ENV SA_USERNAME=$SA_USERNAME

ARG SA_PASSWORD=PLEASE-SET
ENV SA_PASSWORD=$SA_PASSWORD

COPY ./database /database

CMD /bin/sh -c \
  echo 'Running script...'; \
  until /opt/mssql-tools/bin/sqlcmd -S sql-server,1433 -U $SA_USERNAME -P $SA_PASSWORD -Q 'SELECT 1' &> /dev/null; do \
    echo 'Waiting for SQL Server to start...'; \
    sleep 5; \
  done; \
  echo "Running schema scripts with $DB_NAME"; \
    /opt/mssql-tools/bin/sqlcmd \
      -S sql-server,1433 \
      -U $SA_USERNAME \
      -P $SA_PASSWORD \
      -i "database/create-db.sql" \
      -r1;
