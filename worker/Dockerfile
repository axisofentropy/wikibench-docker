FROM alpine:latest

WORKDIR /app

# Install some dependencies.
RUN apk add --update openjdk8 apache-ant bzip2 curl

# Fetch and extract the `wikibench` source.
ENV WIKIBENCH_VERSION=0.3.1
ENV WIKIBENCH=wikibench-$WIKIBENCH_VERSION
RUN wget http://www.wikibench.eu/wp-content/uploads/2011/01/$WIKIBENCH.tar.gz && tar -xzvf ./$WIKIBENCH.tar.gz

# Fetch and extract some Apache HTTP libraries.
ENV HTTPCLIENT_VERSION=4.5.6
ENV HTTPCLIENT=httpcomponents-client-$HTTPCLIENT_VERSION
RUN curl http://mirror.reverse.net/pub/apache//httpcomponents/httpclient/binary/$HTTPCLIENT-bin.tar.gz | tar -xzvf -

ENV HTTPCORE_VERSION=4.4.10
ENV HTTPCORE=httpcomponents-core-$HTTPCORE_VERSION
RUN curl http://mirror.reverse.net/pub/apache//httpcomponents/httpcore/binary/$HTTPCORE-bin.tar.gz | tar -xzvf -

# Worker and Controller Dockerfiles are identical up to this point.

# Include the latest scripts.
COPY *.sh ./

# Set default environment variables.
ENV CONTROLLER_ADDR=controller \
    THREAD_COUNT=1 \
    TARGET_ADDR=target \
    TARGET_PORT=80 \
    TIMEOUT=7000

# Specify a volume to share output.
RUN mkdir /log
VOLUME ["/log"]

# Start the worker.
CMD /app/worker.sh
