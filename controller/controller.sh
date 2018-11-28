#!/bin/sh

# Check for existence of a reduced trace file.
if [ ! -f ./tracebench ]; then
	# Create reduced subset of only interesting traces.
	echo "Reducing " "`wc -l ./traces | cut -f1 -d' '`" " traces"
	cat ./traces | \
		time java -classpath . -jar $WIKIBENCH/tracebench/build/lib/TraceBench.jar 0 "jdbc:mysql://$MYSQL_HOST:$MYSQL_PORT/$MYSQL_DATABASE?user=$MYSQL_USER&password=$MYSQL_PASSWORD" plsampling epoch_ts | \
		sed 's:wiki/:index.php/:' | \
		sed 's:w/::' > ./tracebench
else
	echo "Reduced tracefile found!"
fi

# Start up the controller and wait for connections from all workers.
echo "Starting controller with " "`wc -l ./tracebench | cut -f1 -d' '`" " traces"
cat ./tracebench | $WIKIBENCH/wikijector/wikijector.sh controller /app/$HTTPCORE/lib /app/$HTTPCLIENT/lib $HOSTNAME $WORKER_COUNT
