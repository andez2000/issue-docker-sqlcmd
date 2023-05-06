It's been a long day and I've been hacking away trying to get a SQL database created on a new docker container.  The scripts work fine, but I came across an issue passing variables in the command line to SQL Scripts.

I've created a sample application to replicate the problem.

My ENTRYPOINT is essentially this that fails:

```dockerfile
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
```

Here I am just trying to pass a variable to a script.

`-v xxxx=\"abcd\"`

The following output is visible:

```console
sql-script-runner    | Running creation scripts with booyakasha
sql-script-runner    | Executing /database/scripts/creation/0001-create-database.sql
sql-script-runner    | Msg 1801, Level 16, State 3, Server 9f1517348ff1, Line 2
sql-script-runner    | Database 'booyakasha' already exists. Choose a different database name.
sql-script-runner    | Executing /database/scripts/creation/0002-printme.sql
sql-script-runner    | This should print ok
sql-script-runner    | Running schema scripts with booyakasha
sql-script-runner    | Executing /database/scripts/schema/0001-create-tables.sql
sql-script-runner    | Sqlcmd: 'xxxx=abc': Invalid argument. Enter '-?' for help.sql-script-runner exited with code 1
```

## Docker Images

SQL Server: mcr.microsoft.com/mssql/server:2019-latest  
SQL Script Runner: mcr.microsoft.com/mssql-tools  

## What have I tried?

Obviously works fine without passing the variable.

sqlcmd -S .,1433 -d "plop" -i "0002-printme.sql" -v xx="abc"
This should print ok


I was trying to output some console information in docker and I haven't been able to get my example working.

I want to be able to view console output when the container is started.  I've had a long night here when looking at other docker problems.

So the question is, write the simplest dockerfile that will 

```dockerfile
FROM alpine

RUN echo "We see run commands as part of the build"

CMD ["echo", "This is a shell command form"]

ENTRYPOINT [ "sleep", "infinity" ]
```