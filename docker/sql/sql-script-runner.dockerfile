FROM 

RUN echo "We see run commands as part of the build"

ENTRYPOINT [ "sleep", "infinity" ]