FROM alpine

RUN echo "We see run commands as part of the build"

CMD ["/bin/sh", "-c", "/bin/echo 'This is a shell command form' && sleep infinity"]
