#!/bin/sh

$WIKIBENCH/wikijector/wikijector.sh worker "/app/$HTTPCORE/lib" "/app/$HTTPCLIENT/lib" "$CONTROLLER_HOST" "$THREAD_COUNT" "$TARGET_HOST" "$TARGET_PORT" "$TIMEOUT" "/log/$HOSTNAME.txt"

cat "/log/$HOSTNAME.txt"
