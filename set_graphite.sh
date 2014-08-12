#!/bin/bash

if [ -f /.graphite_configured ]; then
    echo "=> Graphite has been configured!"
    exit 0
fi

if [ -n "${GRAPHITE_HOST}" ] && [ -n "${GRAPHITE_PORT}" ]; then
    echo "=> Found Graphite settings."
    echo "=> Set Graphite url to \"http://${GRAPHITE_HOST}:${GRAPHITE_PORT}\"."
    #sed -i "s#.*elasticsearch.*#elasticsearch:\"http://${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}\",#g"  /app/config.js
    sed -i "s|\${GRAPHITE_HOST}|${GRAPHITE_HOST}|g" /app/config.js
    sed -i "s|\${GRAPHITE_PORT}|${GRAPHITE_PORT}|g" /app/config.js
    echo "=> Done!"
else
    echo "=> Either address or port of Graphite is not set or empty."
    echo "=> Skip setting Graphite."
fi

touch /.graphite_configured
