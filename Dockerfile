#
# Elasticsearch Node
#
# docker-build properties:
# TAG=barchart/elasticsearch:latest

FROM barchart/java
MAINTAINER Jeremy Jongsma "jeremy@barchart.com"

# Download version 1.4.2 of elasticsearch
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - && \
	add-apt-repository "deb http://packages.elasticsearch.org/elasticsearch/0.90/debian stable main" && \
	apt-get update && \
	apt-get install elasticsearch && \
	/usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-cloud-aws/1.16.0 && \
	apt-get clean

ADD elasticsearch.yml /etc/elasticsearch/

EXPOSE 9200
EXPOSE 9300

VOLUME ["/elasticsearch"]

CMD ["/usr/share/elasticsearch/bin/elasticsearch"]
