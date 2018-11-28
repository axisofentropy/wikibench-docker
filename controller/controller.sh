#!/bin/sh
cat ./traces | \
	java -classpath . -jar $WIKIBENCH/tracebench/build/lib/TraceBench.jar 0 "jdbc:mysql://$MYSQL_HOST:$MYSQL_PORT/$MYSQL_DATABASE?user=$MYSQL_USER&password=$MYSQL_PASSWORD" plsampling epoch_ts | \
       	sed 's:wiki/:index.php/:' | \
	sed 's:w/::' > ./tracebench
cat ./tracebench | $WIKIBENCH/wikijector/wikijector.sh controller /app/$HTTPCORE/lib /app/$HTTPCLIENT/lib $HOSTNAME $WORKER_COUNT
