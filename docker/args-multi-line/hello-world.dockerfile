FROM alpine

ARG CUSTOM_MESSAGE=This is the default message
ENV CUSTOM_MESSAGE=$CUSTOM_MESSAGE

RUN echo "We see run commands as part of the build"

CMD /bin/sh -c " \
    echo 'This is a separate echo: $CUSTOM_MESSAGE'; \
    echo $CUSTOM_MESSAGE && \
    sleep infinity"
    