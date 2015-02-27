#
# Elasticsearch Node
#
# docker-build properties:
# TAG=barchart/elasticsearch-aws:0.90-latest

FROM barchart/java
MAINTAINER Jeremy Jongsma "jeremy@barchart.com"

# Download version 0.90.x of elasticsearch
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - && \
	add-apt-repository -y "deb http://packages.elasticsearch.org/elasticsearch/0.90/debian stable main" && \
	apt-get -y update && \
	apt-get -y install elasticsearch && \
	/usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-cloud-aws/1.16.0 && \
	apt-get clean

ADD elasticsearch/ /etc/elasticsearch

# ES configuration vars
ENV LOG_DIR /var/log/ext/elasticsearch
ENV DATA_DIR /elasticsearch/data
ENV WORK_DIR /elasticsearch/tmp
ENV CONF_DIR /etc/elasticsearch
ENV CONF_FILE /etc/elasticsearch/elasticsearch.yml
ENV ES_CLUSTER_NAME elasticsearch
ENV ES_NODE_COUNT 1
ENV ES_SHARDS 10
ENV ES_REPLICAS 1
ENV ES_CLOUD_AWS_REGION  us-east-1
ENV ES_HEAP_SIZE 2g
ENV MAX_LOCKED_MEMORY unlimited
ENV ES_JAVA_OPTS -Des.default.config=$CONF_FILE -Des.default.path.logs=$LOG_DIR -Des.default.path.data=$DATA_DIR -Des.default.path.work=$WORK_DIR -Des.default.path.conf=$CONF_DIR
ENV RESTART_ON_UPGRADE true

EXPOSE 9200
EXPOSE 9300

VOLUME ["/elasticsearch"]

CMD ["/usr/share/elasticsearch/bin/elasticsearch","-f"]
