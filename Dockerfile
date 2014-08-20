FROM tutum/nginx
MAINTAINER Acaleph <admin@acale.ph>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget pwgen apache2-utils

#ENV GRAFANA_VERSION 1.7.0
RUN wget http://grafanarel.s3.amazonaws.com/grafana-1.7.0.tar.gz -O grafana.tar.gz && tar zxf grafana.tar.gz && rm grafana.tar.gz && rm -rf app && mv grafana-1.7.0 app

ADD config.js /app/config.js
ADD default /etc/nginx/sites-enabled/default

# Environment variables for HTTP AUTH
ENV HTTP_USER admin
ENV HTTP_PASS **Random**

ENV INFLUXDB_PROTO http

ENV INFLUXDB_NAME **ChangeMe**
ENV INFLUXDB_USER root

# Override or fallback to INFLUXDB_ENV_INFLUXDB_ROOT_PASSWORD
# ENV INFLUXDB_PASS root

# Override or fallback to linked INFLUXDB or GRAPHITE
# ENV INFLUXDB_HOST **ChangeMe**
# ENV INFLUXDB_PORT 8086
# ENV GRAPHITE_HOST **LinkMe**
# ENV GRAPHITE_PORT **LinkMe**

# ENV ELASTICSEARCH_PROTO http
# ENV ELASTICSEARCH_HOST **None**
# ENV ELASTICSEARCH_PORT 9200
# ENV ELASTICSEARCH_USER **None**
# ENV ELASTICSEARCH_PASS **None**


ADD run.sh /run.sh
ADD set_influx_db.sh /set_influx_db.sh
ADD set_graphite.sh /set_graphite.sh
ADD set_basic_auth.sh /set_basic_auth.sh
# ADD set_elasticsearch.sh /set_elasticsearch.sh
RUN chmod +x /*.sh

CMD ["/run.sh"]
