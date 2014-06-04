FROM tutum/nginx
MAINTAINER Feng Honglin <hfeng@tutum.co>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget pwgen
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y vim 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl 

ENV GRAFANA_VERSION 1.5.4
RUN wget http://grafanarel.s3.amazonaws.com/grafana-${GRAFANA_VERSION}.tar.gz -O grafana.tar.gz
RUN tar zxf grafana.tar.gz && rm grafana.tar.gz && rm -rf app && mv grafana-${GRAFANA_VERSION} app 

ADD config.js /app/config.js

ENV INFLUXDB_DB_NAME CHANGEME
ENV INFLUXDB_USER root
ENV INFLUXDB_PASS root 

ADD run.sh /run.sh
ADD set_influx_db.sh /set_influx_db.sh
RUN chmod +x /*.sh

CMD ["/run.sh"]