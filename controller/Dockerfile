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

# Fetch and extract the Java MySQL connector.
ENV MYSQL_CONNECTOR_VERSION=8.0.13
ENV MYSQL_CONNECTOR=mysql-connector-java-$MYSQL_CONNECTOR_VERSION
RUN curl --location https://dev.mysql.com/get/Downloads/Connector-J/$MYSQL_CONNECTOR.tar.gz | tar -xzvf - $MYSQL_CONNECTOR/$MYSQL_CONNECTOR.jar

# Fetch and sort a traces file.
RUN curl http://www.wikibench.eu/wiki/2007-10/wiki.1191201596.gz | gunzip | head -n 100000 | cut -f 2,3,4 -d ' ' | sort -k1,1M -k2n > ./traces

# Build TraceBench with the MySQL connector.
RUN cd ./$WIKIBENCH/tracebench/ && ant build -Dconnector=../../$MYSQL_CONNECTOR/$MYSQL_CONNECTOR.jar

# Include the latest scripts.
COPY *.sh ./

# Set default environment variables.
ENV MYSQL_USER=root \
    MYSQL_PASSWORD=foobarbaz \
    MYSQL_DATABASE=mirror \
    MYSQL_HOST=172.16.203.84 \
    MYSQL_PORT=3306 \
    WORKER_COUNT=1

# Publish the hardcoded TCP port for the controller.
EXPOSE 48657/tcp

# Start the controller.
CMD /app/controller.sh
