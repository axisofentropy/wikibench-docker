#!/bin/sh

$WIKIBENCH/wikijector/wikijector.sh worker "/app/$HTTPCORE/lib" "/app/$HTTPCLIENT/lib" "$CONTROLLER_ADDR" "$THREAD_COUNT" "$TARGET_ADDR" "$TARGET_PORT" "$TIMEOUT" "/log/$HOSTNAME.txt"

cat "/log/$HOSTNAME.txt"
